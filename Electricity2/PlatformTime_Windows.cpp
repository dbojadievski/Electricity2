#pragma once
#ifdef _WIN32

#include "PlatformTime.h"
#define WIN32_LEAN_AND_MEAN
#include <Windows.h>

#include <profileapi.h>
#include <timeapi.h>
namespace Platform
{
	namespace Time
	{
		uint32 GetUptimeInMilliseconds() noexcept
		{
			DWORD dwTime = timeGetTime();
			return static_cast<uint32>( dwTime );
		}
	}
}
#endif // _WIN32