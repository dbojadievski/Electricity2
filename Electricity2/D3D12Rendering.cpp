#ifdef PAR_PLATFORM_PCD3D12

#include "D3D12Rendering.h"

#include "App.h"
#include "ChronoHelper.h"
#include "MemUtils.h"
#include "PCD3D12SwapChain.h"
#include "PlatformVRAMPool_PCD3D12.h"
#include <stdio.h>
#include <iostream>
#include "d3dx12.h"

#pragma comment(lib, "windowscodecs.lib")
#pragma comment(lib, "dxgi.lib") 
#pragma comment(lib, "d3d12.lib")


void
Electricity::Rendering::PAR::Platform_Initialize() noexcept
{
	PCD3D12Rendering::Initialize();
}

void
Electricity::Rendering::PAR::Platform_Update( uint32 uFrameDelta ) noexcept
{
	PCD3D12Rendering::Update( uFrameDelta );
}


bool 
PCD3D12Rendering::Initialize() noexcept
{
	// First we need to retrieve a D3D12Device.
	InitDebugLayer();
	InitializeDevice();
	InitCommandQueue();
		
	s_pSwapChain = new PCD3D12SwapChain( s_uNumFrames, g_pApp->GetPlatformWindow(), 2560, 1440, "Main Swap Chain" );
	s_uFrameIndex = s_pSwapChain->GetCurrentIndex();
			
	s_pRTVDescriptorHeap = CreateDescriptorHeap( D3D12_DESCRIPTOR_HEAP_TYPE_RTV, s_uNumFrames, true );
	UpdateRenderTargetViews( s_pDevice, s_pSwapChain->GetRaw(), s_pRTVDescriptorHeap );

	s_pVertexBufferHeap = CreateDescriptorHeap( D3D12_DESCRIPTOR_HEAP_TYPE_CBV_SRV_UAV, 1024, true );
	ComPtr<ID3D12Resource1> pRenderTarget = CreateRenderTarget(2560, 1440, DXGI_FORMAT_R8G8B8A8_UNORM_SRGB, D3D12_RESOURCE_DIMENSION_TEXTURE2D, 1, 0);
	assert( pRenderTarget );

	ComPtr<ID3D12CommandAllocator> pAllocator1 = CreateCommandAllocator();
	s_pCommandAllocators[ 0 ] = pAllocator1;

	ComPtr<ID3D12CommandAllocator> pAllocator2 = CreateCommandAllocator();
	s_pCommandAllocators[ 1 ] = pAllocator2;
		
	ComPtr<ID3D12CommandList> pList = CreateCommandList( s_pCommandAllocators[ s_uFrameIndex ].Get(), "Command List 0" );
	pList.As( &s_pCommandList );
	s_pCommandList->Close();

	s_pFence = CreateFence( );
	s_uFrameFenceValues[ s_uFrameIndex ]++;

	FlushQueue( s_pCommandQueue.Get(), s_pFence.Get() );
	return true;
}

uint64
PCD3D12Rendering::Signal( ID3D12CommandQueue* pQueue, ID3D12Fence1* pFence, uint64 uVal ) noexcept
{
	uint64 uSignalVal = uVal;
	pQueue->Signal( pFence, uSignalVal );
		
	return uSignalVal;
}

void
PCD3D12Rendering::AwaitFenceValue( ID3D12Fence1* pFence, uint64 uVal, HANDLE event, uint64 uMilliseconds ) noexcept
{
	// Create an event
	const UINT64 uPrevVal = pFence->GetCompletedValue();
	if ( uPrevVal < uVal )
	{
		// Set the event to fire when the fence object reaches the fence point
		pFence->SetEventOnCompletion( uVal, event );

		// Wait for the event to be fired
		WaitForSingleObject( event, INFINITE );
	}
}

void
PCD3D12Rendering::FlushQueue( ID3D12CommandQueue* pQueue, ID3D12Fence1* pFence) noexcept
{
	const uint64 uFrameVal = s_uFrameFenceValues[ s_uFrameIndex ]++;
	uint64 uSignalVal = Signal( pQueue, pFence, uFrameVal );
	AwaitFenceValue( pFence, uSignalVal, s_hFenceEvent );
}

void
PCD3D12Rendering::Update( uint32 uFrameDelta ) noexcept
{
	s_uFrameIndex = s_pSwapChain->GetCurrentIndex();

	ComPtr<ID3D12CommandAllocator> pAllocator = s_pCommandAllocators[ s_uFrameIndex ];
	ComPtr<ID3D12GraphicsCommandList> pList = s_pCommandList;

	ComPtr<ID3D12Resource> pRenderTarget = s_pRenderTargets[ s_uFrameIndex ];
	HRESULT resultAlloc = pAllocator->Reset();
	assert( resultAlloc == S_OK );

	HRESULT resultList = pList->Reset( pAllocator.Get(), nullptr );
	assert( resultList == S_OK );
		
	D3D12_RESOURCE_BARRIER barrierRender = {};
	barrierRender.Transition.pResource = pRenderTarget.Get();
	barrierRender.Transition.StateBefore = D3D12_RESOURCE_STATE_PRESENT;
	barrierRender.Transition.StateAfter = D3D12_RESOURCE_STATE_RENDER_TARGET;
	barrierRender.Transition.Subresource = D3D12_RESOURCE_BARRIER_ALL_SUBRESOURCES;
	barrierRender.Type = D3D12_RESOURCE_BARRIER_TYPE_TRANSITION;
	pList->ResourceBarrier( 1, &barrierRender );

	pList->ClearState( nullptr );
	CD3DX12_CPU_DESCRIPTOR_HANDLE rtvHandle( s_pRTVDescriptorHeap->GetCPUDescriptorHandleForHeapStart(), s_uFrameIndex, s_RTVDescriptorSize );
	pList->OMSetRenderTargets( 1, &rtvHandle, FALSE, nullptr );

	const float afClearColour[] = { 0.0f, 0.2f, 0.4f, 1.0f };
	pList->ClearRenderTargetView( rtvHandle, afClearColour, 0, nullptr );
	pList->IASetPrimitiveTopology( D3D_PRIMITIVE_TOPOLOGY_TRIANGLELIST );
	pList->IASetIndexBuffer( nullptr );
	//pList->DrawIndexedInstanced( 0, 0, 0, 0, 0 );

	D3D12_RESOURCE_BARRIER barrierPresent = {};
	barrierPresent.Transition.pResource = pRenderTarget.Get();
	barrierPresent.Transition.StateBefore = D3D12_RESOURCE_STATE_RENDER_TARGET;
	barrierPresent.Transition.StateAfter = D3D12_RESOURCE_STATE_PRESENT;
	barrierPresent.Transition.Subresource = D3D12_RESOURCE_BARRIER_ALL_SUBRESOURCES;
	barrierPresent.Type = D3D12_RESOURCE_BARRIER_TYPE_TRANSITION;
	pList->ResourceBarrier( 1, &barrierPresent );

	pList->Close();
	ID3D12CommandList* pCmdList = pList.Get();

	const UINT uSyncInterval = 1;
	UINT uPresentFlags = IsVariableRefreshRateSupported() && !uSyncInterval ? DXGI_PRESENT_ALLOW_TEARING : 0;
	uPresentFlags |= DXGI_PRESENT_RESTART;

	s_pCommandQueue->ExecuteCommandLists( 1, &pCmdList );
	s_pSwapChain->GetRaw()->Present( 0, 0 );
	FlushQueue( s_pCommandQueue.Get(), s_pFence.Get() );
}

bool
PCD3D12Rendering::ShutDown() noexcept
{
	FlushQueue( s_pCommandQueue.Get(), s_pFence.Get() );
		
	CloseHandle( s_hFenceEvent );
	s_pFence->Release();
	s_pRTVDescriptorHeap->Release();
		
	s_pCommandList->Release();
	for ( uint32 uIdx = 0; uIdx < s_uNumFrames; uIdx++ )
	{
		s_pCommandAllocators[ uIdx ]->Release();
	}
	s_pCommandQueue->Release();
	delete s_pSwapChain;
	s_pSwapChain = nullptr;
		
	if ( s_pDebugInterface )
		s_pDebugInterface->Release();
		
	s_pDevice->Release();
	s_pFactory->Release();
		
	return true;
}


bool
PCD3D12Rendering::InitializeDevice() noexcept
{
	bool bInittedDevice			= false;
		
	const bool bInittedAdapter	= InitAdapter(false);
	assert( bInittedAdapter );
	if ( bInittedAdapter )
	{
		HRESULT hResult			= D3D12CreateDevice( s_pAdapter.Get(), D3D_FEATURE_LEVEL_12_0, IID_PPV_ARGS( &s_pDevice ) );
		bInittedDevice			= ( hResult == S_OK );
		assert( bInittedDevice );
	}

	return bInittedDevice;
}

void
PCD3D12Rendering::InitDebugLayer() noexcept
{

	if ( !g_pApp->GetCommandLineParser().HasToken( "--PARDebug" ) )
		return;

	// TODO(Dino): Skip if debug layers are not enabled in the console parameters.
	const HRESULT hGotDebug = D3D12GetDebugInterface( IID_PPV_ARGS( &s_pDebugInterface ) );
	if ( hGotDebug == S_OK )
	{
		s_pDebugInterface->EnableDebugLayer();
		ComPtr<ID3D12Debug1> pDebug1;
		HRESULT resCast = s_pDebugInterface->QueryInterface( IID_PPV_ARGS( &pDebug1 ) );
		if ( SUCCEEDED( resCast ) )
		{
			pDebug1->SetEnableGPUBasedValidation( true );
			pDebug1->SetEnableSynchronizedCommandQueueValidation( true );

			pDebug1->Release();
			pDebug1 = nullptr;
		}
	}
}

bool
PCD3D12Rendering::InitCommandQueue() noexcept
{
	bool bInitted = false;

	D3D12_COMMAND_QUEUE_DESC desc = {};
	desc.Type = D3D12_COMMAND_LIST_TYPE_DIRECT;
	desc.Priority = D3D12_COMMAND_QUEUE_PRIORITY_NORMAL;
		
	HRESULT hResult = s_pDevice->CreateCommandQueue( &desc, IID_PPV_ARGS( &s_pCommandQueue) );
	if ( hResult != S_OK )
	{
		HRESULT res = s_pDevice->GetDeviceRemovedReason();
		assert( res );
	}
		
	assert( hResult == S_OK );
	bInitted = ( hResult == S_OK );

	return bInitted;
}

ComPtr<ID3D12Heap>
PCD3D12Rendering::CreateHeap( D3D12_HEAP_TYPE type, uint64 uSizeInBytes, const bool bContainsMSAAResources /* = false */, D3D12_HEAP_FLAGS uFlags /* = D3D12_HEAP_FLAGS_NONE */ )
{
	assert( uSizeInBytes );

	const uint64 uAlignment = !bContainsMSAAResources ? Electricity::Utils::Memory::ToKilobytes(64) : Electricity::Utils::Memory::ToMegabytes(4);
	assert( ( ( uint64 ) uSizeInBytes ) % uAlignment == 0 ); // Less memory wasting if things are aligned. 
	ComPtr<ID3D12Heap> pHeap = nullptr;

	D3D12_HEAP_DESC desc = {};
	desc.SizeInBytes = uSizeInBytes;
	desc.Alignment = uAlignment;
	desc.Properties.Type = type;
		
	HRESULT result = s_pDevice->CreateHeap(&desc, IID_PPV_ARGS( &pHeap ) );
	assert( result == S_OK );
	assert( pHeap );
	return pHeap;
}

ComPtr<ID3D12DescriptorHeap>
PCD3D12Rendering::CreateDescriptorHeap( D3D12_DESCRIPTOR_HEAP_TYPE type, uint32 uDescCount, bool bShaderVisible ) noexcept
{
	ComPtr<ID3D12DescriptorHeap> pHeap = nullptr;

	D3D12_DESCRIPTOR_HEAP_DESC desc = {};
	desc.NumDescriptors = uDescCount;
	desc.Type = type;

	HRESULT hResult = s_pDevice->CreateDescriptorHeap( &desc, IID_PPV_ARGS( &pHeap ) );
	assert( hResult == S_OK );

	return pHeap;
}

void
PCD3D12Rendering::UpdateRenderTargetViews( ComPtr<ID3D12Device2> pDevice, ComPtr<IDXGISwapChain4> pSwapChain, ComPtr<ID3D12DescriptorHeap> pHeap ) noexcept
{
	const uint32 uRtvDescriptorSize = pDevice->GetDescriptorHandleIncrementSize( D3D12_DESCRIPTOR_HEAP_TYPE_RTV );
	s_RTVDescriptorSize = uRtvDescriptorSize;
	CD3DX12_CPU_DESCRIPTOR_HANDLE rtvHandle( pHeap->GetCPUDescriptorHandleForHeapStart() );

	for ( uint32 uIdx = 0; uIdx < s_uNumFrames; uIdx++ )
	{
		ComPtr<ID3D12Resource> pTarget;
		pSwapChain->GetBuffer( uIdx, IID_PPV_ARGS( &pTarget ) );
		pDevice->CreateRenderTargetView( pTarget.Get(), nullptr, rtvHandle );
		s_pRenderTargets[ uIdx ] = pTarget;
		rtvHandle.Offset( 1, uRtvDescriptorSize );
	}
}

ComPtr<ID3D12Resource1>
PCD3D12Rendering::CreateRenderTarget( const uint32 uWidth, const uint32 uHeight, const DXGI_FORMAT format, const D3D12_RESOURCE_DIMENSION dimension, const uint32 uSampleCount, const uint32 uSampleQuality ) noexcept
{
	ComPtr<ID3D12Resource1> pResource = nullptr;
		
	D3D12_HEAP_PROPERTIES heapProps = {};
	heapProps.Type = D3D12_HEAP_TYPE_DEFAULT;

	DXGI_SAMPLE_DESC sampleDesc = {};
	sampleDesc.Count = uSampleCount;
	sampleDesc.Quality = uSampleQuality;

	D3D12_RESOURCE_DESC resourceDesc = {};
	resourceDesc.Dimension = dimension;
	resourceDesc.Format = format;
	resourceDesc.Height = uWidth;
	resourceDesc.Width = uHeight;
	resourceDesc.Layout = D3D12_TEXTURE_LAYOUT_UNKNOWN;
	resourceDesc.MipLevels = 1;
	resourceDesc.Flags = D3D12_RESOURCE_FLAG_ALLOW_RENDER_TARGET;
	resourceDesc.SampleDesc = sampleDesc;
	resourceDesc.DepthOrArraySize = 1;
	D3D12_CLEAR_VALUE value = {};
	value.Format = format;
		
	HRESULT hResult = s_pDevice->CreateCommittedResource( &heapProps, D3D12_HEAP_FLAG_ALLOW_DISPLAY, &resourceDesc, D3D12_RESOURCE_STATE_RENDER_TARGET, &value, IID_PPV_ARGS( &pResource ) );
	assert( hResult == S_OK );

	return pResource;
}

ComPtr<ID3D12CommandAllocator>
PCD3D12Rendering::CreateCommandAllocator( D3D12_COMMAND_LIST_TYPE allocatorType  /* = D3D12_COMMAND_LIST_TYPE_DIRECT */) noexcept
{
	ComPtr<ID3D12CommandAllocator> pAllocator = nullptr;
		
	HRESULT hResult = s_pDevice->CreateCommandAllocator( allocatorType, IID_PPV_ARGS(&pAllocator) );
	assert( hResult == S_OK );

	return pAllocator;
}

ComPtr<ID3D12CommandList>
PCD3D12Rendering::CreateCommandList( ID3D12CommandAllocator* pAllocator, String name, D3D12_COMMAND_LIST_TYPE listType  /* = D3D12_COMMAND_LIST_TYPE_DIRECT */, uint32 uGPUNode /* = 0 */ ) noexcept
{
	ComPtr<ID3D12CommandList> pList = nullptr;

	HRESULT hResult = s_pDevice->CreateCommandList( uGPUNode, listType, pAllocator, nullptr, IID_PPV_ARGS( &pList ) );
	assert( hResult == S_OK );
	if ( hResult == S_OK )
	{
		std::wstring asWstring( name.begin(), name.end() );
		LPCWSTR pName = asWstring.c_str();
		pList->SetName( pName );
	}

	return pList;
}

ComPtr<ID3D12Fence1>
PCD3D12Rendering::CreateFence( uint64 uFenceVal /* = 0 */) noexcept
{
	ComPtr<ID3D12Fence1> pFence = nullptr;

	HRESULT hResult = s_pDevice->CreateFence( uFenceVal, D3D12_FENCE_FLAG_NONE, IID_PPV_ARGS( &pFence ) );
	assert( hResult == S_OK );

	return pFence;
}

HANDLE
PCD3D12Rendering::CreateEventHandle() noexcept
{
	HANDLE fenceEvent;

	fenceEvent = ::CreateEvent( NULL, FALSE, FALSE, L"Main Render Event" );
	assert( fenceEvent && "Failed to create fence event " );
		
	return fenceEvent;
}

bool
PCD3D12Rendering::InitAdapter( bool bUseWarp ) noexcept
{
	ComPtr<IDXGIFactory7> pFactory;
	UINT createFactoryFlags = DXGI_CREATE_FACTORY_DEBUG; // TODO(Dino): Set based on command line.
	HRESULT hResult			= CreateDXGIFactory2( createFactoryFlags, IID_PPV_ARGS( &pFactory ) );
	assert( hResult == S_OK );
	s_pFactory = pFactory;

	ComPtr<IDXGIAdapter4> pAdapter = nullptr;

	ComPtr<IDXGIAdapter1> pAdapter1;
	ComPtr<IDXGIAdapter4> pAdapter4;
	if ( bUseWarp )
	{
		hResult = pFactory->EnumWarpAdapter( IID_PPV_ARGS( &pAdapter1 ) );
		assert( hResult == S_OK );
		hResult = pAdapter1.As( &pAdapter4 );
		assert( hResult == S_OK );
	}
	else
	{
		SIZE_T uMaxVRAM = 0;
		for ( UINT uIdx = 0; pFactory->EnumAdapters1( uIdx, &pAdapter1 ) != DXGI_ERROR_NOT_FOUND; uIdx++ )
		{
			DXGI_ADAPTER_DESC1 dxgiAdapterDesc1 = {};
			pAdapter1->GetDesc1( &dxgiAdapterDesc1 );

			if ( ( dxgiAdapterDesc1.Flags & DXGI_ADAPTER_FLAG_SOFTWARE ) != 0 )
				continue; // Discard software adapters.

			hResult = D3D12CreateDevice( pAdapter1.Get(), D3D_FEATURE_LEVEL_11_0, __uuidof( ID3D12Device ), nullptr );
			if ( SUCCEEDED( hResult ) && dxgiAdapterDesc1.DedicatedVideoMemory > uMaxVRAM)
			{
				uMaxVRAM = dxgiAdapterDesc1.DedicatedVideoMemory;
				pAdapter1.As( &pAdapter4 );
				pAdapter = pAdapter4;
			}
		}
	}

	s_pAdapter = pAdapter4;
	return s_pAdapter != nullptr;
}

bool
PCD3D12Rendering::IsVariableRefreshRateSupported() noexcept
{
	BOOL bSupported = false;
	s_pFactory->CheckFeatureSupport( DXGI_FEATURE_PRESENT_ALLOW_TEARING, &bSupported, sizeof( bSupported ) );
	return static_cast<bool>( bSupported );
}

ID3D12CommandQueue*
PCD3D12Rendering::GetImmediateQueue() noexcept
{
	return s_pCommandQueue.Get();
}

PCD3D12Rendering::~PCD3D12Rendering() noexcept
{
	ShutDown();
}
#endif