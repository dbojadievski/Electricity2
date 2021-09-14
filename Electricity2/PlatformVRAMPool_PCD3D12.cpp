#ifdef PAR_PLATFORM_PCD3D12
#include "PlatformVRAMPool.h"

PlatformVRAMPool::PlatformVRAMPool( uint32 uAllocSize ) noexcept :
	m_uHeapSize( 0 )
	, m_pHeap( nullptr )
{
	uint32 uHeapPageSize	= 65535;
	uAllocSize				= ( uAllocSize + ( uHeapPageSize - 1 ) ) & ~( uHeapPageSize - 1 );
	m_pHeap					= PCD3D12Rendering::CreateHeap( D3D12_HEAP_TYPE_DEFAULT, uAllocSize );
	assert( m_pHeap );
	
	if ( m_pHeap )
	{
		m_uHeapSize			= uAllocSize;
	}
}

PlatformVRAMPool::~PlatformVRAMPool() noexcept
{
	m_pHeap			= nullptr;
	m_uHeapSize		= 0;
	m_pHeap			= nullptr;
}
#endif
