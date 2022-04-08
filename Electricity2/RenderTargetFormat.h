#pragma once

#include "CoreTypes.h"

namespace Electricity::Rendering
{
	/// <summary>
	/// Render target formats. Add format as needed.
	/// </summary>
	enum class RenderTargetFormat
	{
		R8_TYPELESS
	   ,R8_UNORM
	   ,R8_UINT
	   ,R8_SINT
	   ,R8_SNORM
	   ,R8G8_TYPELESS
	   ,R8G8_UNORM
	   ,R8G8_UINT
	   ,R8G8_SINT
	   ,R8G8_SNORM
	   ,R8G8B8A8_TYPELESS
	   ,R8G8B8A8_UNORM
	   ,R8G8B8A8_UNORM_SRGB
	   ,R8G8B8A8_UINT
	   ,R8G8B8A8_SNORM
	   ,R8G8B8A8_SINT
	   ,R16G16_TYPELESS
	   ,R16G16_FLOAT
	   ,R16G16_UNORM
	   ,R16G16_UINT
	   ,R16G16_SNORM
	   ,R16G16_SINT
	   ,R32_TYPELESS
	   ,R32_FLOAT
	   ,R32_UINT
	   ,R32_SINT
	   ,R24G8_TYPELESS
	};
}