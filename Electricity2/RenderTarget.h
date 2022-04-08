#pragma once
#include "CoreTypes.h"
#include "CoreContainers.h"
#include "UUID.h"

#include "RenderTargetHandle.h"
#include "RenderTargetFormat.h"

namespace Electricity::Rendering
{
	class RenderTarget;
	class RenderTargetManager;

	struct RenderTargetDescriptor
	{
		uint32 uWidth;
		uint32 uHeight;
		uint32 uSampleCount;
		uint32 uSampleQuality;
		uint32 uMipLevels;

		RenderTargetFormat xFormat;
	};

	class RenderTarget
	{
		friend class RenderTargetManager;
	public:
		RenderTarget( const RenderTargetDescriptor& xDescriptor, const RenderTargetHandle& xHandle );
		~RenderTarget();

		const uint64 GetSize() const noexcept { return m_uSize; }
		const RenderTargetHandle& GetHandle() const noexcept { return m_xHandle; };
		const RenderTargetDescriptor& GetDescriptor() const noexcept { return m_xDescriptor; }
	private:

		void CreatePlatformRenderTarget( ) noexcept;
		void DeletePlatformRenderTarget() noexcept;

		uint64					m_uSize;
		uint32					m_uNumFramesIdle;
		RenderTargetHandle		m_xHandle;
		RenderTargetDescriptor	m_xDescriptor;
	};
}