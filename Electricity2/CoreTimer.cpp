#include "CoreTimer.h"
#include "PlatformTime.h"

uint32
CoreTimer::GetUptimeInMilliseconds() noexcept
{
	uint32 uTime = Platform::Time::GetUptimeInMilliseconds();
	return uTime;
}