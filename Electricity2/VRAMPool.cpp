#include "VRAMPool.h"

#include "PlatformVRAMPool.h"
#include "VRAMHandle.h"

#include "MemUtils.h"
#include "Math.h"

// Class VRAMPool.
VRAMPool::VRAMPool( uint32 uSize ) noexcept :
	m_uVRAMSize( uSize )
	, m_uVRAMGranularity( 0 )
	, m_pVRAMPool( nullptr )
	, m_pNext( nullptr )
{
	m_pVRAMPool			= new PlatformVRAMPool( uSize );
}

VRAMPool::~VRAMPool() noexcept
{
	if ( m_pVRAMPool )
		delete m_pVRAMPool;

	m_pVRAMPool			= nullptr;
	m_pNext				= nullptr;
	m_uVRAMGranularity	= 0;
	m_uVRAMSize			= 0;
}

// Class SingleResourceVRAMPool
SingleResourceVRAMPool::SingleResourceVRAMPool( uint32 uSize ) noexcept : 
	  VRAMPool( uSize )
	, m_bIsFilled( false ) {}

SingleResourceVRAMPool::~SingleResourceVRAMPool() noexcept 
{
	// Deallocation happens in the base pool class.
	// This one just cleans up book-keeping information.
	m_bIsFilled = false;
}

bool
SingleResourceVRAMPool::HasAvailable( const uint32 uSize, const VRAMAllocType eAllocType ) const noexcept
{
	const bool bHasAvailable	= ( m_bIsFilled && ( m_uVRAMSize >= uSize ) );
	return bHasAvailable;
}

VRAMHandle*
SingleResourceVRAMPool::Allocate( const uint32 uSize ) noexcept
{
	VRAMHandle* pHandle			= new VRAMHandle();
	pHandle->m_pPool			= this;
	pHandle->m_uHandleVal		= 1;
	pHandle->m_uOffsetInPool	= 0;

	m_bIsFilled					= true;
	return pHandle;
}

bool
SingleResourceVRAMPool::Deallocate( VRAMHandle& outHandle ) noexcept
{
	m_bIsFilled = false;
	return true;
}

// class BlockStorageVRAMPool
static constexpr uint32 s_uBlockSize = static_cast<uint32>( Electricity::Utils::Memory::ToMegabytes( 8 ) );

uint64 AlignBlockSize( uint64 uSize, uint64 uGranularity = s_uBlockSize )
{
	//TODO(Dino)
	return uSize;
}

BlockStorageVRAMPool::BlockStorageVRAMPool( uint32 uSize ) noexcept : 
	VRAMPool( uSize )
{
	// Platform VRAM pool allocation is handled by parent class.
	// All we have to do is organize the book-keeping.
	
	uint32 uAllocSize	= Electricity::Math::Min( uSize, s_uBlockSize );
	m_uVRAMSize			= uSize; // TODO(Dino): Align size?
	m_uVRAMGranularity	= s_uBlockSize;
}

BlockStorageVRAMPool::~BlockStorageVRAMPool() noexcept
{
	// Platform VRAM pool deallocation is handled by the parent class.
	// All we have to do is release our book-keeping data.

}

bool
BlockStorageVRAMPool::HasAvailable( const uint32 uSize, const VRAMAllocType eAllocType ) const noexcept
{
	return false;
}

VRAMHandle *
BlockStorageVRAMPool::Allocate( const uint32 uSize ) noexcept
{
	return nullptr;
}

bool
BlockStorageVRAMPool::Deallocate( VRAMHandle& outHandle ) noexcept
{
	return false;
}