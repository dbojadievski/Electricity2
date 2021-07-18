#pragma once
#include "CoreTypes.h"
#include "PlatformAppDefines.h"

namespace Platform
{
	namespace Settings
	{
		namespace Display
		{
			void GetMonitorDisplayResolution( uint32& uWidth, uint32& uHeight, PPlatformWindow Window ) noexcept;
		}
	}
}