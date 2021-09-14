#ifdef PAR_PLATFORM_PCD3D12

#include "App.h"
#include "SwapChain.h"
#include "D3D12Rendering.h"
#include "PCD3D12SwapChain.h"

void
Electricity::Rendering::SwapChain::Platform_Update() noexcept
{
	if ( s_bRequestedChange || s_bRequestedRecreate )
	{
		// Await platform end.
		// Platform::Rendering::PCD3D12::PCD3D12Rendering::AwaitFrameEnd();
	}
}

// PCD3D12SwapChain

PCD3D12SwapChain::PCD3D12SwapChain( const uint32 uNumFrames, HWND hwnd, uint32 const uWidth, const uint32 uHeight, const String& name ) noexcept :
	  m_hwndWindow( hwnd )
	, m_uWidth( uWidth )
	, m_uHeight( uHeight )
	, m_uNumBuffers( uNumFrames )
	, m_uCurrentBuffer( 0 )
	, m_pSwapChain( nullptr )
	, m_pRenderTargets( nullptr )
	, m_pFence( nullptr )
	, m_puFrameFenceValues( nullptr )
	, m_hFenceEvent( nullptr )
{
	CreateSwapChain( name );
}

PCD3D12SwapChain::~PCD3D12SwapChain() 
{
	m_hwndWindow		= 0;
	m_uWidth			= 0;
	m_uHeight			= 0;
	m_uNumBuffers		= 0;
	m_pFence->Release();
	m_pFence			= nullptr;
	m_uCurrentBuffer	= 0;
	
	delete[] m_puFrameFenceValues;
}

void
PCD3D12SwapChain::Present() noexcept
{
	const UINT uSyncInterval = 1;
	UINT uPresentFlags = ( PCD3D12Rendering::IsVariableRefreshRateSupported() && !uSyncInterval ) ? DXGI_PRESENT_ALLOW_TEARING : 0;
	uPresentFlags |= DXGI_PRESENT_RESTART;
	HRESULT result = m_pSwapChain->Present( uSyncInterval, uPresentFlags );
	assert( result == S_OK );

	m_uCurrentBuffer = m_pSwapChain->GetCurrentBackBufferIndex();
}

bool
PCD3D12SwapChain::CreateSwapChain( const String& name ) noexcept
{
	bool bInitted = false;

	assert( m_hwndWindow && m_hwndWindow != INVALID_HANDLE_VALUE );

	LPCSTR pName = name.c_str();
	m_hFenceEvent = CreateEventA( NULL, FALSE, FALSE, pName );
	assert( m_hFenceEvent );
	m_puFrameFenceValues = new uint64[ m_uNumBuffers ];
	for ( uint32 uIdx = 0; uIdx < m_uNumBuffers; uIdx++ )
		m_puFrameFenceValues[ uIdx ] = 0;
	m_pFence = PCD3D12Rendering::CreateFence( );
	assert( m_pFence );

	const bool bisVRSSupporred = PCD3D12Rendering::IsVariableRefreshRateSupported();
	DXGI_SWAP_CHAIN_FLAG swapChainFlags = DXGI_SWAP_CHAIN_FLAG_ALLOW_MODE_SWITCH;
	if ( bisVRSSupporred )
		swapChainFlags = DXGI_SWAP_CHAIN_FLAG_ALLOW_TEARING;

	DXGI_SWAP_CHAIN_DESC1 swapChainDesc = {};
	swapChainDesc.Width = m_uWidth;
	swapChainDesc.Height = m_uHeight;
	swapChainDesc.BufferCount = m_uNumBuffers;
	swapChainDesc.Format = DXGI_FORMAT_R8G8B8A8_UNORM;
	swapChainDesc.SampleDesc.Count = 1;
	swapChainDesc.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT;
	swapChainDesc.SwapEffect = DXGI_SWAP_EFFECT_FLIP_DISCARD;
	swapChainDesc.Flags = swapChainFlags;

	ComPtr<IDXGISwapChain1> pChain = nullptr;
	ComPtr<IDXGISwapChain4> pChain4 = nullptr;

	ComPtr<IDXGIFactory7> pFactory;
	UINT createFactoryFlags = DXGI_CREATE_FACTORY_DEBUG; // TODO(Dino): Set based on command line.
	HRESULT hResult = CreateDXGIFactory2( createFactoryFlags, IID_PPV_ARGS( &pFactory ) );
	assert( hResult == S_OK );
	if ( hResult == S_OK )
	{
		HRESULT hResult = pFactory->CreateSwapChainForHwnd( PCD3D12Rendering::GetImmediateQueue(), m_hwndWindow, &swapChainDesc, nullptr, nullptr, &pChain );
		assert( hResult == S_OK );
		hResult = pChain.As( &pChain4 );
		assert( hResult == S_OK );
	}
	m_pSwapChain = pChain4;

	return bInitted;
}
#endif