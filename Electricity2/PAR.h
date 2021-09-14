#pragma once

#include "CoreTypes.h"
#include "CoreSystem.h"

namespace Electricity::Rendering
{
	class PAR
	{
	public:
		static bool Initialize() noexcept;
		static void Update( uint32 uFrameDelta ) noexcept;
		static bool ShutDown() noexcept;

		~PAR() noexcept {};
	private:
		static void Platform_Initialize() noexcept;
		static void Platform_Update( uint32 uFrameDelta ) noexcept;
	};
}