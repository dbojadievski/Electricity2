#ifdef _WIN32
#include "PlatformThread.h"

#define WIN32_LEAN_AND_MEAN
#include <assert.h>
#include <Windows.h>

namespace PlatformThread
{
	PlatformThreadID
	Create( pThreadFunc pfnFunc, PPlatformThreadParam pParam, const bool bRunImmediately )
	{
		LPDWORD lpdwThreadId	= NULL;

		// For now, we do not support thread stack size reservation.
		DWORD dwCreationFlags	= 0;
		dwCreationFlags			|= bRunImmediately ? 0 : CREATE_SUSPENDED;
		HANDLE hThread			= CreateThread(
			NULL // do not inherit from thread
			, 0 // default stack size
			, reinterpret_cast<LPTHREAD_START_ROUTINE>(pfnFunc) // function to execute on thread
			, pParam // thread function parameter
			, dwCreationFlags
			, lpdwThreadId
		);

		assert( hThread );
		assert( lpdwThreadId );

		return static_cast<PlatformThreadID>(*lpdwThreadId);
	}

	PlatformThreadID
	GetCurrentThreadID() noexcept
	{
		DWORD dwThreadId	= GetCurrentThreadId();
		assert( dwThreadId );

		return static_cast<PlatformThreadID>( dwThreadId );
	}

	PPlatformThread
	GetByID( PlatformThreadID idThread ) noexcept
	{
		DWORD dwThreadID	= static_cast<DWORD>( idThread );
		
		HANDLE hThread		= OpenThread( THREAD_ALL_ACCESS, false, dwThreadID );
		assert( hThread );
		
		return static_cast<PPlatformThread>( hThread );
	}

	PlatformThreadWaitResult
	Join( PPlatformThread pThread, uint64 uMilliseconds /* = 0 */ ) noexcept
	{
		PlatformThreadWaitResult status = PlatformThreadWaitResult::OK;

		DWORD dwError = WaitForSingleObject( pThread, static_cast< DWORD >( uMilliseconds ) );
		switch ( dwError )
		{
			case WAIT_TIMEOUT:
			{
				status = PlatformThreadWaitResult::Timeout;
				break;
			}
			case WAIT_FAILED:
			{
				status = PlatformThreadWaitResult::Failed;
				break;
			}
			default:
			{
				status = PlatformThreadWaitResult::Failed;
				break;
			}
		}

		return status;
	}

	bool PlatformThread::YieldExecution() noexcept
	{
		return SwitchToThread();
	}

	bool
	PlatformThread::Detach( PPlatformThread pThread ) noexcept
	{
		assert( pThread );
		HANDLE hThread	= static_cast<HANDLE>( pThread );
		
		return CloseHandle( hThread );
	}

	void
	PlatformThread::Terminate( PPlatformThread pThread, uint32 uExitCode /*  = 1 */ ) noexcept
	{
		assert( pThread );
		HANDLE hThread		= static_cast<HANDLE>( pThread );
		
		TerminateThread( hThread, uExitCode );
	}

	bool
	PlatformThread::Suspend( PPlatformThread pThread ) noexcept
	{
		assert( pThread );
		HANDLE hThread				= static_cast<HANDLE>( pThread );

		DWORD dwPrevSuspendCount	= SuspendThread( hThread );
		assert( dwPrevSuspendCount != -1 );

		return ( dwPrevSuspendCount != -1 );
	}

	bool
	PlatformThread::Resume( PPlatformThread pThread ) noexcept
	{
		assert( pThread );
		HANDLE hThread				= static_cast<HANDLE>( pThread );
		
		DWORD dwPrevSuspendCount	= ResumeThread( hThread );
		assert( dwPrevSuspendCount != -1 );

		return ( dwPrevSuspendCount != -1 );
	}
}
#endif