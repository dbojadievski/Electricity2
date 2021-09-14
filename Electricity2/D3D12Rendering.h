#pragma once

#ifdef PAR_PLATFORM_PCD3D12
#include "CoreTypes.h"

#include <Windows.h>
#include <d3d12.h>

#include <dxgi1_6.h>
#include <d3dcompiler.h>
#include <wrl.h>

#include <chrono>
#include "PAR.h"

using namespace Microsoft::WRL;

class PCD3D12SwapChain;
class PlatformVRAMPool;

class PCD3D12Rendering
{
	friend class PlatformVRAMPool;
public:
	static bool Initialize() noexcept;
	static void Update( uint32 uFrameDelta ) noexcept;
	static bool ShutDown() noexcept;

	virtual ~PCD3D12Rendering() noexcept;
	static bool IsVariableRefreshRateSupported() noexcept;
	static ID3D12CommandQueue* GetImmediateQueue() noexcept;
	static ComPtr<ID3D12Fence1> CreateFence( uint64 uVal = 0 ) noexcept;
private:
	static const uint32 s_uNumFrames = 2;

	static bool InitializeDevice() noexcept;

	static bool InitAdapter( bool useWarp ) noexcept;
	static void InitDebugLayer() noexcept;
	static bool InitCommandQueue( ) noexcept;
		
	static ComPtr<ID3D12DescriptorHeap> CreateDescriptorHeap( D3D12_DESCRIPTOR_HEAP_TYPE type, uint32 uDescCount, bool bShaderVisible ) noexcept;
	static ComPtr<ID3D12Heap> CreateHeap( D3D12_HEAP_TYPE type, uint64 uSizeInBytes, const bool bContainsMSAAResources = false, D3D12_HEAP_FLAGS uFlags = D3D12_HEAP_FLAG_NONE );
	static ComPtr<ID3D12Resource1> CreateRenderTarget( const uint32 uWidth, const uint32 uHeight, const DXGI_FORMAT format, const D3D12_RESOURCE_DIMENSION dimension, const uint32 uSampleDesc, const uint32 uSampleQuality ) noexcept;
	static ComPtr<ID3D12CommandAllocator> CreateCommandAllocator( D3D12_COMMAND_LIST_TYPE listType = D3D12_COMMAND_LIST_TYPE_DIRECT ) noexcept;
	static ComPtr<ID3D12CommandList> CreateCommandList( ID3D12CommandAllocator* pAllocator, String name, D3D12_COMMAND_LIST_TYPE listType = D3D12_COMMAND_LIST_TYPE_DIRECT, uint32 uGPUNode = 0 ) noexcept;
		
	static HANDLE CreateEventHandle() noexcept;
	static uint64 Signal( ID3D12CommandQueue* pQueue, ID3D12Fence1* pFence, uint64 uVal ) noexcept;
	static void AwaitFenceValue( ID3D12Fence1* pFence, uint64 uVal, HANDLE event, uint64 uMilliseconds = 0xFFFFFFFFFFFFFFFF ) noexcept;
	static void FlushQueue( ID3D12CommandQueue* pQueue, ID3D12Fence1* pFence ) noexcept;

	static void UpdateRenderTargetViews( ComPtr<ID3D12Device2> pDevice, ComPtr<IDXGISwapChain4> pSwapChain, ComPtr<ID3D12DescriptorHeap> pHeap ) noexcept;

	static inline ComPtr<IDXGIAdapter4> s_pAdapter;
	static inline ComPtr<ID3D12Device2> s_pDevice;
	static inline ComPtr<ID3D12CommandQueue> s_pCommandQueue;
	static inline PCD3D12SwapChain* s_pSwapChain;
	static inline ComPtr<ID3D12Resource> s_pRenderTargets[ s_uNumFrames ];
	static inline ComPtr<ID3D12CommandAllocator> s_pCommandAllocators[ s_uNumFrames ];
	static inline ComPtr<ID3D12GraphicsCommandList> s_pCommandList;
	static inline ComPtr<ID3D12DescriptorHeap> s_pRTVDescriptorHeap;
	static inline ComPtr<ID3D12DescriptorHeap> s_pVertexBufferHeap;
	static inline ComPtr<ID3D12Debug> s_pDebugInterface;
	static inline ComPtr<IDXGIFactory7> s_pFactory;
	static inline ComPtr<ID3D12InfoQueue> s_pInfoQueue;
	static inline UINT s_RTVDescriptorSize;
	static inline UINT s_uFrameIndex;

	// Sync.
	static inline ComPtr<ID3D12Fence1> s_pFence;
	static inline uint64 s_uFrameFenceValues[ s_uNumFrames ] = {};
	static inline HANDLE s_hFenceEvent;

	static inline FLOAT s_aClearColor[4] = { 0.4f, 0.6f, 0.9f, 1.0f };
};
#endif