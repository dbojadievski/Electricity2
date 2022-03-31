#pragma once
#include "CoreTypes.h"

namespace Electricity::Rendering
{
	class SwapChain
	{
	public:
		static bool Initialize() noexcept;
		static void Update() noexcept;
		static bool ShutDown() noexcept;

		static uint32 GetWidth() noexcept;
		static uint32 GetHeight() noexcept;
		
		static uint32 GetRequestedWidth()  noexcept;
		static uint32 GetRequestedHeight() noexcept;

		static void RequestSize( const uint32 uWidth, const uint32 uHeight ) noexcept;

		static bool GetIsFullScreen() noexcept;
		static bool GetRequestedFullScreen() noexcept;
		static void RequestFullScreenState( const bool bFullScreen ) noexcept;

		static bool GetRequestedRecreate() noexcept;
		static void RequestRecreate() noexcept;

	private:
		static void Platform_Update() noexcept;
		static inline bool s_bRequestedChange = false;

		static inline uint32 s_uWidth = 0;
		static inline uint32 s_uHeight = 0;

		static inline uint32 s_uRequestedWidth = 0;
		static inline uint32 s_uRequestedHeight = 0;

		static inline uint32 s_uFullScreen = 0;
		static inline bool s_bRequestedFullScreenState = 0;

		static inline bool s_bRequestedRecreate = 0;
	};
}