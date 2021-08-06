#pragma once

#include "CoreTypes.h"
#include "CoreSystem.h"
namespace Electricity::Rendering
{
	class PAR
	{
		virtual bool Initialize() noexcept = 0;
		virtual void Update( uint32 uFrameDelta ) noexcept = 0;
		virtual bool ShutDown() noexcept = 0;
	};
}