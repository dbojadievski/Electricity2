#ifdef _WIN32
#include "PlatformThread.h"

#define WIN32_LEAN_AND_MEAN
#include <assert.h>
#include <Windows.h>

namespace PlatformThread
{
	typedef uint32( __stdcall* pThreadFunc ) ( void* pParam );

	PlatformThreadID
	Create( const PlatformThreadParam& param )
	{
		DWORD dwThreadID	= 0;

		// For now, we do not support thread stack size reservation.
		DWORD dwCreationFlags	= 0;
		dwCreationFlags			|= param.GetCreateRunning() ? 0 : CREATE_SUSPENDED;
		HANDLE hThread			= CreateThread(
			NULL // do not inherit from thread
			, param.GetStackSize() // default stack size
			, reinterpret_cast<LPTHREAD_START_ROUTINE>(param.GetWorkFunction()) // function to execute on thread
			, param.GetThreadFuncParam() // thread function parameter
			, dwCreationFlags
			, &dwThreadID
		);

		assert( hThread );
		assert( dwThreadID );

		return static_cast<PlatformThreadID>(dwThreadID);
	}

	PlatformThreadID
	GetCurrentThreadID() noexcept
	{
		DWORD dwThreadID = 0;

		HANDLE hTargetHandle = nullptr;
		bool bSuccess = DuplicateHandle( 
			GetCurrentProcess() 
			, GetCurrentThread()
			, GetCurrentProcess()
			, &hTargetHandle
			, 0 
			, true 
			, DUPLICATE_SAME_ACCESS 
		);
		assert( bSuccess );

		if ( hTargetHandle )
		{
			dwThreadID = GetThreadId( hTargetHandle );
		}

		return static_cast<PlatformThreadID>( dwThreadID );
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

		DWORD dwError = WaitForSingleObject( pThread, uMilliseconds ? static_cast< DWORD >( uMilliseconds ) : INFINITE );
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

	uint32 
	GetStatusCode( PPlatformThread pThread ) noexcept
	{
		assert( pThread );
		HANDLE hThread = static_cast< HANDLE >( pThread );

		DWORD dwExitCode = 0;
		GetExitCodeThread( pThread, &dwExitCode );

		return static_cast<uint32>( dwExitCode );
	}

	uint32 
	GetLogicalThreadCount() noexcept
	{
		SYSTEM_INFO sysinfo = {};
		GetSystemInfo( &sysinfo );
		const uint32 uNumThreads = static_cast< uint32 >( sysinfo.dwNumberOfProcessors );
		return uNumThreads;
	}

}
#endif