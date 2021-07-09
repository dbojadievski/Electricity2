#pragma once
#include "CoreTypes.h"
#include "PlatformThreadingDefines.h"

class CoreFiberStart;
class CoreThread;

namespace PlatformFiber
{
	PPlatformFiber Create( const CoreFiberStart& fiberStart ) noexcept;
	PPlatformFiber FromThread( pFiberFuncParam pParam = nullptr ) noexcept;
	bool SwitchTo( const PPlatformFiber fiber ) noexcept;
	bool Delete( const PPlatformFiber fiber ) noexcept;
	PPlatformFiber GetCurrent() noexcept;
}