#include "RenderTargetManager.h"

#include <assert.h>
#include <mutex>

using std::lock_guard;
using std::recursive_mutex;

namespace Electricity::Rendering
{
	/* Class RenderTargetManager. */
	static recursive_mutex s_Mutex;

	void
	RenderTargetManager::Initialize() noexcept
	{
		// Not much to do here for now.
		// Create a sample render target to validate this all works.
		RenderTargetDescriptor xDescriptor;
		xDescriptor.uHeight = 1440;
		xDescriptor.uWidth = 2560;
		xDescriptor.xFormat = RenderTargetFormat::R8G8B8A8_UNORM_SRGB;
		xDescriptor.uSampleCount = 1;
		xDescriptor.uSampleQuality = 0;
		xDescriptor.uMipLevels = 1;

		const RenderTargetHandle& xRenderTargetHandle = GetRenderTarget( xDescriptor );
	}

	void
	RenderTargetManager::Update() noexcept
	{
		lock_guard<recursive_mutex> xLock( s_Mutex );

		Array<RenderTarget*> xAliveTargets;
		for ( auto& pRenderTarget : s_xRenderTargets )
		{
			if ( pRenderTarget->m_uNumFramesIdle >= s_uMaxFramesUnusedCount )
			{
				DeregisterTarget( *pRenderTarget );
				delete pRenderTarget;
			}
			else
			{
				pRenderTarget->m_uNumFramesIdle++;
				xAliveTargets.push_back( pRenderTarget );
			}
		}


		// Watch this, it's real cool:
		s_xRenderTargets = std::move( xAliveTargets );
	}

	void
	RenderTargetManager::Deinitialize() noexcept
	{
		lock_guard<recursive_mutex> xLock( s_Mutex );
		for ( auto& pRenderTarget : s_xRenderTargets )
		{
			delete pRenderTarget;
		}

		s_xRenderTargets.clear();
		s_uTotalTargetsSize = 0;
	}



	bool
	RenderTargetManager::IsHandleValid( const RenderTargetHandle& xHandle ) noexcept
	{
		return ( xHandle != s_xInvalidRenderTargetHandle );
	}

	const RenderTargetHandle&
	RenderTargetManager::GetRenderTarget( const RenderTargetDescriptor& xDescriptor ) noexcept
	{
		RenderTarget* pTarget = nullptr;

		lock_guard<recursive_mutex> xLock( s_Mutex ); // Automatically releases mutex when out of scope.

		// First attempt to find a currently-unused target.
		for ( const auto& pRenderTarget : s_xRenderTargets )
		{
			if ( pRenderTarget->m_uNumFramesIdle )
			{
				if ( IsTargetMatch( xDescriptor, *pRenderTarget ) )
				{
					pTarget = pRenderTarget;
					pTarget->m_uNumFramesIdle = 0;
					break;
				}
			}
		}

		// If that fails, then create a bespoke one.
		if ( pTarget == nullptr )
		{
			pTarget = new RenderTarget( xDescriptor, CoreGUID::NewUUID( ) );
			s_xRenderTargets.push_back( pTarget );
			s_uTotalTargetsSize += pTarget->GetSize();
		}

		assert( pTarget != nullptr );
		return pTarget->GetHandle();
	}

	const RenderTarget*
	RenderTargetManager::GetRenderTarget( const RenderTargetHandle& xHandle ) noexcept
	{
		const RenderTarget* pTarget = nullptr;

		for ( const auto& pRenderTarget : s_xRenderTargets )
		{
			if ( pRenderTarget->GetHandle() == xHandle )
			{
				pTarget = pRenderTarget;
				break;
			}
		}

		return pTarget;
	}

	bool
	RenderTargetManager::IsTargetMatch( const RenderTargetDescriptor& xDescriptor, const RenderTarget& xRenderTarget ) noexcept
	{
		return ( xRenderTarget.m_xDescriptor.uHeight == xDescriptor.uHeight
				 && xRenderTarget.m_xDescriptor.uWidth == xDescriptor.uWidth
				 && xRenderTarget.m_xDescriptor.uSampleCount == xDescriptor.uSampleCount
				 && xRenderTarget.m_xDescriptor.uSampleQuality == xDescriptor.uSampleQuality
				 && xRenderTarget.m_xDescriptor.xFormat == xDescriptor.xFormat
		);
	}

	void
	RenderTargetManager::DeregisterTarget( const RenderTarget& xTarget ) noexcept
	{
		const uint64 uSize = xTarget.GetSize();
		const RenderTargetHandle& xHandle = xTarget.GetHandle();
		assert( xHandle != s_xInvalidRenderTargetHandle );
		
		for ( auto xIt = s_xRenderTargets.begin(); xIt != s_xRenderTargets.end(); xIt++ )
		{
			RenderTarget* pTarget = *xIt;
			if ( pTarget->GetHandle() == xHandle )
			{
				s_xRenderTargets.erase( xIt );
				s_uTotalTargetsSize -= uSize;

				break;
			}
		}
	}
}