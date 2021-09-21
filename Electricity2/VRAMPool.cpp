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
	, m_uNumSlots( 0 )
	, m_uNumFreeSlots( 0 )
	, m_abSlots( nullptr )
	, m_uFirstFreeSlot( 0 )
{
	// Platform VRAM pool allocation is handled by parent class.
	// All we have to do is organize the book-keeping.
	
	uint32 uAllocSize	= Electricity::Math::Min( uSize, s_uBlockSize );
	m_uVRAMSize			= uSize; // TODO(Dino): Align size?
	m_uVRAMGranularity	= s_uBlockSize;

	m_uNumSlots			= ( m_uVRAMSize / m_uVRAMGranularity );
	m_uNumFreeSlots		= m_uNumSlots;
	
	m_abSlots			= new bool[ m_uNumSlots ];
	assert( m_abSlots );
	Electricity::Utils::Memory::Clear( m_abSlots, m_uNumSlots * sizeof( m_abSlots[ 0 ] ) );
}

BlockStorageVRAMPool::~BlockStorageVRAMPool() noexcept
{
	// Platform VRAM pool deallocation is handled by the parent class.
	// All we have to do is release our book-keeping data.
	m_uNumSlots			= 0;
	m_uNumFreeSlots		= 0;
	
	delete[] m_abSlots;
	m_abSlots			= nullptr;
	m_uFirstFreeSlot	= 0;
}

bool
BlockStorageVRAMPool::HasAvailable( const uint32 uSize, const VRAMAllocType eAllocType ) const noexcept
{
	bool bSupportsAllocType		= false;
	bool bHasSlotRange			= false;
	
	switch ( eAllocType )
	{
		case VRAMAllocType::Default:
			bSupportsAllocType	= true;
	}

	if ( bSupportsAllocType )
	{
		const uint16 uNumRequiredSlots	= ( uSize / m_uVRAMGranularity );
		if ( uNumRequiredSlots <= m_uNumFreeSlots )
		{
			// Walk slots and find one which may contain the resource.
			const uint16 uLastViableSlot	= ( m_uNumSlots - uNumRequiredSlots );
			for ( uint16 uSlotIdx			= m_uFirstFreeSlot; uSlotIdx < uLastViableSlot; uSlotIdx++ )
			{
				if ( !m_abSlots[ uSlotIdx ] ) // Is slot available?
				{
					bool bAllocPossible		= true;
					for ( uint16 uIdx		= 0; uIdx < uNumRequiredSlots; uIdx++ )
					{
						const uint16 uOffsetSlot		= ( uSlotIdx + uIdx );
						if ( m_abSlots[ uOffsetSlot ] )
						{
							// At least one slot in the range is taken. We can't place our allocation here.
							// Let's skip to the next slot.
							bAllocPossible				= false;
							const uint16 uNextSlotIdx	= ( uOffsetSlot + 1 );
							uSlotIdx					= Electricity::Math::Min( uLastViableSlot, uNextSlotIdx );
							break;
						}
					}

					// If we found a free slot-range, then we can allocate the memory.
					if ( bAllocPossible )
					{
						bHasSlotRange					= true;
						break;
					}
				}
			}
		}
		
	}

	const bool bCanAlloc = ( bSupportsAllocType && bHasSlotRange );
	return bCanAlloc;
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