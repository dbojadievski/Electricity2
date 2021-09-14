#include "VRAMHandle.h"

#ifdef PAR_PLATFORM_PCD3D12
#include "D3D12Rendering.h"

#include "PlatformVRAMPool.h"
#include "VRAMPool.h"
#endif

// Class VRAMHandle
VRAMHandle::VRAMHandle() noexcept :
	  m_uHandleVal( 0 )
	, m_uOffsetInPool( 0 )
	, m_pPool( nullptr )
{
}

VRAMHandle::~VRAMHandle() noexcept
{
	m_pPool			= nullptr;
	m_uOffsetInPool = 0;
	m_uHandleVal	= 0;
}