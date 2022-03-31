#include "VRAMManager.h"

#include <assert.h>
#include "VRAMHandle.h"
#include "VRAMPool.h"

// Class VRAMManager.
VRAMManager::VRAMManager() noexcept
{
}

VRAMManager::~VRAMManager() noexcept
{
	ShutDown();
}

bool
VRAMManager::Initialize() noexcept
{
	return true;
}

void
VRAMManager::ShutDown() noexcept
{
	while ( s_pVRAMPools )
	{
		VRAMPool* pPool = s_pVRAMPools;
		delete pPool;
		s_pVRAMPools	= s_pVRAMPools->m_pNext;
	}
}

VRAMHandle&
VRAMManager::AllocateVRAM( const uint32 uSize, const VRAMAllocType eType ) noexcept
{
	VRAMHandle* outHandle	= nullptr;

	VRAMPool* pPool		= s_pVRAMPools;
	bool bFoundPool		= false;
	while ( pPool )
	{
		if ( pPool->HasAvailable( uSize, eType ) )
		{
			bFoundPool	= true;
			break;
		}
		pPool			= pPool->m_pNext;
	}

	if ( !bFoundPool )
	{
		// TODO(Dino):
		// This allocation may well fail.
		// Think up a graceful exit.
		pPool			= CreatePreferredVRAMPoolForType( uSize, eType );
		pPool->m_pNext	= s_pVRAMPools;

		// NOTE(Dino):
		// Setting the 'first' pool to the new one makes for faster allocs in the future.
		// This is because it's likely the other pools are spent or overly fragmented.
		s_pVRAMPools	= pPool;
		bFoundPool		= true;
	}

	if ( bFoundPool )
	{
		// Alloc memory within pool.
		outHandle		= pPool->Allocate( uSize );
	}
	else
	{
		outHandle		= new VRAMHandle();
	}

	return *outHandle;
}

bool
VRAMManager::ReleaseVRAM( VRAMHandle& outHandle ) noexcept
{
	VRAMPool* pPool		= outHandle.m_pPool;
	bool bReleased		= pPool->Deallocate(outHandle);

	const VRAMPoolType ePoolType = pPool->GetPoolType();
	switch ( ePoolType )
	{
		case VRAMPoolType::SingleResourceVRAMPool:
		{
			// Delete this pool, as it was created for a single resource.
			// We'll assume the other pool types are reusable until metrics prove otherwise.
			VRAMPool* pPrevPool = FindPrevVRAMPoolInChain( pPool );
			if ( pPrevPool ) // Pool in the middle or at the end. Remove it from the list.
				pPrevPool->m_pNext = pPool->m_pNext;
			else if ( s_pVRAMPools == pPool ) // Pool is the first managed pool. Just set the whole list to nothing.
				s_pVRAMPools = nullptr;
			else // Pool not in list of managed pools. This cannot happen.
				assert( false );
			delete pPool;
		}
		break;
	}

	return bReleased;
}

VRAMPool*
VRAMManager::CreatePreferredVRAMPoolForType( const uint32 uSize, const VRAMAllocType eType ) noexcept
{
	VRAMPool* pPool		= nullptr;
	switch ( eType )
	{
		case VRAMAllocType::Buffer:
		{
			pPool		= new BlockStorageVRAMPool( uSize );
			break;
		}
		case VRAMAllocType::Default:
		{
			pPool		= new SingleResourceVRAMPool( uSize );
			break;
		}
	}

	return pPool;
}

VRAMPool*
VRAMManager::FindPrevVRAMPoolInChain( VRAMPool* pPool ) noexcept
{
	VRAMPool* pPrevPool		= ( s_pVRAMPools != pPool ? s_pVRAMPools : nullptr );

	if ( pPrevPool )
	{
		while ( pPrevPool )
		{
			if ( pPrevPool->m_pNext == pPool )
				break;

			pPrevPool		= pPrevPool->m_pNext;
		}

	}

	return pPrevPool;
}