#include "SwapChain.h"
#include <d3d12.h>

#include <dxgi1_6.h>
#include <wrl.h>

using namespace Microsoft::WRL;

class PCD3D12SwapChain
{
public:
	PCD3D12SwapChain( const uint32 uNumFrames, HWND hwnd, const uint32 uWidth, const uint32 uHeight, const String& name ) noexcept;
	~PCD3D12SwapChain() noexcept;

	inline IDXGISwapChain4* GetRaw() noexcept { return m_pSwapChain.Get(); }
	const inline uint32 GetCurrentIndex() noexcept { return m_pSwapChain->GetCurrentBackBufferIndex();  }

	void Present() noexcept;
private:

	bool CreateSwapChain( const String& name ) noexcept;

	HWND m_hwndWindow;
	uint32 m_uWidth;
	uint32 m_uHeight;
	uint32 m_uNumBuffers;
	uint32 m_uCurrentBuffer;

	ComPtr<IDXGISwapChain4>		m_pSwapChain;
	ComPtr<ID3D12Resource>*		m_pRenderTargets;

	// Sync.
	ComPtr<ID3D12Fence1>		m_pFence;
	uint64*						m_puFrameFenceValues;
	HANDLE						m_hFenceEvent;
};