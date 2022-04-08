#pragma once
#include "D3D12Rendering.h"

namespace Electricity::Rendering
{
	void
	RenderTarget::CreatePlatformRenderTarget() noexcept
	{
		const uint64 uSize = PCD3D12Rendering::CreateRenderTarget( *this );
		assert( uSize );
		m_uSize = uSize;
	}
	void
	RenderTarget::DeletePlatformRenderTarget() noexcept
	{
		PCD3D12Rendering::DeleteRenderTarget( m_xHandle );
	}
}