#pragma once

#ifdef PAR_PLATFORM_PCD3D12

#define DEFAULT_VRAM_POOL_SIZE_PCD3D12 ( 1024 * 1024 * 4 )
#include "D3D12Rendering.h"
class PlatformVRAMPool
{
	friend class VRAMPool;
	friend class SingleResourceVRAfMPool;
	friend class PCD3D12Rendering;
public:
	PlatformVRAMPool(uint32 uAllocSize = DEFAULT_VRAM_POOL_SIZE_PCD3D12) noexcept;
	~PlatformVRAMPool() noexcept;
	uint32 GetSize() const noexcept { return m_uHeapSize; }
private:
	ComPtr<ID3D12Heap>	m_pHeap;
	uint32				m_uHeapSize;
};
#endif