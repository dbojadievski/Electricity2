#pragma once

#include "CoreTypes.h"
#include "d3d12.h"
#include <wrl.h>

class PCD3D12CPUHeap
{
	friend class PDCD3D12Rendering;
private:
	ID3D12Heap* m_pHeap;
};