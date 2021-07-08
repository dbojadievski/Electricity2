#pragma once
#include "CoreTypes.h"

typedef void* PPlatformThread;
typedef uint32 PlatformThreadID;
typedef void* PPlatformThreadParam;

enum class PlatformThreadWaitResult : byte 
{ 
	Invalid = 0,
	OK = 1, 
	Timeout = 2, 
	Failed = 3,
	WouldDeadlock = 4,
	Count = Failed
};

typedef uint32  (__stdcall * pThreadFunc ) ( void* pParam );
namespace PlatformThread
{
	PlatformThreadID Create( pThreadFunc pfnFunc, PPlatformThreadParam pParam, bool bRunImmediately );
	PlatformThreadID GetCurrentThreadID() noexcept;
	PPlatformThread GetByID( PlatformThreadID idThread ) noexcept;

	bool YieldExecution( ) noexcept;
	PlatformThreadWaitResult Join( PPlatformThread pThread, uint64 uMilliseconds = 0 ) noexcept;
	bool Detach( PPlatformThread pThread ) noexcept;

	void Terminate( PPlatformThread pThread, uint32 uExitCode = 1 ) noexcept;
	bool Suspend( PPlatformThread pThread ) noexcept;
	bool Resume( PPlatformThread pThread ) noexcept;

}