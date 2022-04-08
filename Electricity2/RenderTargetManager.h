#pragma once

#include "CoreTypes.h"
#include "CoreContainers.h"
#include "UUID.h"

#include "RenderTarget.h"
#include "RenderTargetHandle.h"

namespace Electricity::Rendering
{

	class RenderTarget;
	struct RenderTargetDescriptor;

	class RenderTargetManager
	{
		friend class RenderTarget;
	public:
		static void Initialize() noexcept;
		static void Update() noexcept;
		static void Deinitialize() noexcept;

		static bool IsHandleValid( const RenderTargetHandle& xHandle ) noexcept;
		static const RenderTargetHandle& GetRenderTarget( const RenderTargetDescriptor& xDescriptor ) noexcept;
		static const RenderTarget* GetRenderTarget( const RenderTargetHandle& xHandle ) noexcept;

	private:
		static bool IsTargetMatch( const RenderTargetDescriptor& xDescriptor, const RenderTarget& xRenderTarget ) noexcept;
		static void DeregisterTarget( const RenderTarget& xTarget ) noexcept;

		inline static uint32 s_uMaxFramesUnusedCount = 10;
		inline static Array<RenderTarget*> s_xRenderTargets;
		inline static RenderTargetHandle s_xInvalidRenderTargetHandle = CoreGUID();
		
		/// <summary>
		/// The total VRAM consumption of all render targets.
		/// This number is expressed in kilobytes.
		/// </summary>
		inline static uint64 s_uTotalTargetsSize = 0;
	};
}