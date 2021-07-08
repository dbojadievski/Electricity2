#pragma once
#include "CoreTypes.h"
#include "ThreadStart.h"

typedef void* PPlatformThread;
typedef uint32 PlatformThreadID;
typedef CoreThreadStart PlatformThreadParam;
typedef CoreThreadStart* PtrPlatformThreadParam;

namespace PlatformThread
{
	PlatformThreadID Create( const PlatformThreadParam& param );
	PlatformThreadID GetCurrentThreadID() noexcept;
	PPlatformThread GetByID( PlatformThreadID idThread ) noexcept;

	bool YieldExecution( ) noexcept;
	PlatformThreadWaitResult Join( PPlatformThread pThread, uint64 uMilliseconds = 0 ) noexcept;
	bool Detach( PPlatformThread pThread ) noexcept;

	void Terminate( PPlatformThread pThread, uint32 uExitCode = 1 ) noexcept;
	bool Suspend( PPlatformThread pThread ) noexcept;
	bool Resume( PPlatformThread pThread ) noexcept;

	uint32 GetStatusCode( PPlatformThread pThread ) noexcept;

}