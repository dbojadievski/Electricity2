#ifdef _WIN32

#include "App.h"
#include "D3D12Rendering.h"
namespace Platform::Rendering::PCD3D12
{

	bool 
	PCD3D12Rendering::Initialize() noexcept
	{
		return true;
	}

	void
	PCD3D12Rendering::Update( uint32 uFrameDelta ) noexcept
	{

	}

	bool
		PCD3D12Rendering::ShutDown() noexcept
	{
		return true;
	}
}
#endif