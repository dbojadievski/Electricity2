#pragma once

#include "CoreTypes.h"

#include <Windows.h>
//#include <dxgi1_6.h>
//#include <d3dcompiler.h>
//#include <d3d12.h>
//#include <wrl.h>

#include "PAR.h"
//using namespace Microsoft::WRL;

namespace Platform::Rendering::PCD3D12
{
	class PCD3D12Rendering: public Electricity::Rendering::PAR
	{
	public:
		virtual bool Initialize() noexcept;
		virtual void Update( uint32 uFrameDelta ) noexcept;
		virtual bool ShutDown() noexcept;

	private:
		static const uint32 s_uNumFrames = 2;

		//ComPtr<ID3D12Device2> m_pDevice;
		//ComPtr<ID3D12CommandQueue> m_pCommandQueue;
		//ComPtr<IDXGISwapChain4> m_pSwapChain;
		//ComPtr<ID3D12Resource> m_pBackBuffers[ s_uNumFrames ];
		//ComPtr<ID3D12GraphicsCommandList> m_pCommandList;
		//ComPtr<ID3D12CommandAllocator> m_pCommandAllocators[ s_uNumFrames ];
		//ComPtr<ID3D12DescriptorHeap> m_pRTVDescriptorHeap;
		//ComPtr<ID3D12Debug> m_pDebugInterface;

		//UINT m_RTVDescriptorSize;
		//UINT m_CurrentBackBufferIndex;

		//// Sync.
		//ComPtr<ID3D12Fence> m_pFence;
		//uint64 m_uFenceVal = 0;
		//uint64 m_uFrameFenceValues[ s_uNumFrames ] = {};
		//HANDLE m_hFenceEvent;
	};

}
