
#include "RenderTarget.h"
#include "RenderTargetManager.h"

namespace Electricity::Rendering
{
	/* class RenderTarget. */
	RenderTarget::RenderTarget( const RenderTargetDescriptor& xDescriptor, const RenderTargetHandle& xHandle ) : 
		  m_uSize( 0 )
		, m_uNumFramesIdle( 0 )
		, m_xDescriptor( xDescriptor )
		, m_xHandle( xHandle )
	{
		CreatePlatformRenderTarget( );
	}

	RenderTarget::~RenderTarget()
	{
		DeletePlatformRenderTarget();

		m_uSize				= 0;
		m_uNumFramesIdle	= 0;
		m_xDescriptor		= {};
		m_xHandle			= RenderTargetManager::s_xInvalidRenderTargetHandle;

	}
}