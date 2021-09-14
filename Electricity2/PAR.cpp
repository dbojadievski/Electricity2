#include "PAR.h"

#ifdef PCD3D12
#include "D3D12Rendering.h"
#endif
//#include "Platform_Ren"
#include "MemUtils.h"
#include "SwapChain.h"
#include "VRAMManager.h"
#include "VRAMHandle.h"

using namespace Electricity::Utils::Memory;
namespace Electricity::Rendering
{
	bool PAR::Initialize() noexcept
	{

		const bool bSwapChainInitialized	= SwapChain::Initialize();
		const bool bMemManagerInitialized	= VRAMManager::Initialize();
		
		Platform_Initialize();
		
		// Sample alloc as test.
		constexpr uint64 uSize		= ToMegabytes( 8 );
		VRAMHandle& xHandle			= VRAMManager::AllocateVRAM( uSize, VRAMAllocType::Default );
		assert( xHandle.IsValid() );

		bool bReleasedVRAM			= VRAMManager::ReleaseVRAM( xHandle );
		assert( bReleasedVRAM );
		
		return 
		(
			bSwapChainInitialized
			&& bMemManagerInitialized
		);
	}

	void PAR::Update( uint32 uFrameDelta ) noexcept
	{
		Platform_Update( uFrameDelta );
	}

	bool PAR::ShutDown() noexcept
	{
		const bool bSwapChainDeinitialized = SwapChain::ShutDown();
		return true;
	}
}