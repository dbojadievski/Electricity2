#include <assert.h>
#include "Thread.h"

/* CoreThread class */
CoreThread::CoreThread() noexcept :
	m_Status( CoreThreadStatus::Invalid )
	, m_pPlatformThread( nullptr )
	, m_PlatformThreadID( 0 )
{
}

CoreThread::CoreThread( CoreThread&& other ) noexcept
	: CoreThread()
{
	m_Status			= other.m_Status;
	m_pPlatformThread	= other.m_pPlatformThread;
	m_PlatformThreadID	= other.m_PlatformThreadID;

	other.m_Status				= CoreThreadStatus::Invalid;
	other.m_pPlatformThread		= nullptr;
	other.m_PlatformThreadID	= 0;
}

CoreThread::CoreThread( const CoreThreadStart& threadStart ) noexcept :
	m_Status( CoreThreadStatus::Invalid )
	, m_PlatformThreadID( 0 )
	, m_pPlatformThread( nullptr )
{	
	InitializeFromThreadStart( threadStart );
}

CoreThread::~CoreThread() noexcept
{
	m_Status	= CoreThreadStatus::Invalid;

	m_PlatformThreadID	= 0;
	m_pPlatformThread	= nullptr;
}

void
CoreThread::SetThreadStart( const CoreThreadStart& threadStart ) noexcept
{
	if ( m_pPlatformThread == nullptr )
	{
		InitializeFromThreadStart( threadStart );
	}
}

bool
CoreThread::IsRunning() const noexcept
{
	return m_Status == CoreThreadStatus::Running;
}

bool
CoreThread::IsValid() const noexcept
{
	return ( ( m_PlatformThreadID != 0 ) && ( m_Status != CoreThreadStatus::Invalid ) );
}

CoreThreadStatus
CoreThread::GetStatus() const noexcept
{
	return m_Status;
}

int32
CoreThread::GetExitCode() const noexcept
{
	int32 iExitCode = -1;

	const bool bIsRunning = IsRunning();
	assert( bIsRunning );
	if ( bIsRunning )
	{
		uint32 uExitCode = PlatformThread::GetStatusCode( m_pPlatformThread );
		iExitCode = static_cast< int32 >( uExitCode );
	}

	return iExitCode;
}

bool
CoreThread::YieldExecution() const noexcept
{
	const bool bIsRunning	= IsRunning();
	assert( bIsRunning );

	bool bHasYielded			= false;
	if ( bIsRunning )
	{
		bHasYielded = PlatformThread::YieldExecution();
		assert( bHasYielded );
	}

	return bHasYielded;
}

bool
CoreThread::IsJoinable() const noexcept
{
	return ( m_Status == CoreThreadStatus::Running );
}

CoreThreadWaitResult
CoreThread::Join( const uint64 uTime /*  = 0 */) noexcept
{
	PlatformThreadWaitResult threadWaitResult = PlatformThreadWaitResult::Invalid;
	const bool bIsJoinable	= IsJoinable();
	//assert( bIsJoinable );

	uint32 uCurrThreadID	= GetCurrentThreadID();
	if ( uCurrThreadID == m_PlatformThreadID ) // If we wait on ourselves to join, then a deadlock would occur.
	{
		threadWaitResult	= PlatformThreadWaitResult::WouldDeadlock;
	}
	else if ( bIsJoinable )
	{
		threadWaitResult	= PlatformThread::Join( m_pPlatformThread, uTime );
		if ( threadWaitResult == PlatformThreadWaitResult::OK )
		{
			m_Status = CoreThreadStatus::Stopped;
		}
	}

	return threadWaitResult;
}

bool
CoreThread::IsDetachable() const noexcept
{
	return ( m_Status == CoreThreadStatus::Running );
}

bool
CoreThread::IsDetached() const noexcept
{
	return ( m_Status == CoreThreadStatus::Detached );
}

bool
CoreThread::Detach() noexcept
{
	bool bIsDetached			= IsDetached();
	
	const bool bIsDetachable	= IsDetachable();
	assert( bIsDetachable );
	
	if ( bIsDetachable  )
	{
		bIsDetached				= PlatformThread::Detach( m_pPlatformThread );
		if ( bIsDetached )
		{
			m_PlatformThreadID	= 0;
			m_pPlatformThread	= nullptr;
			m_Status			= CoreThreadStatus::Detached;
		}
	}

	return bIsDetached;
}

void
CoreThread::Kill() noexcept
{
	const bool bIsValid		= IsValid();
	assert( bIsValid );
	
	if ( bIsValid )
	{
		PlatformThread::Terminate( m_pPlatformThread );
		m_pPlatformThread	= nullptr;
		m_PlatformThreadID	= 0;
		m_Status			= CoreThreadStatus::Invalid;
	}
}

bool
CoreThread::Suspend() noexcept
{
	const bool bIsRunning	= IsRunning();
	assert( bIsRunning );
	
	bool bIsSuspended		= false;
	if ( bIsRunning )
	{
		bIsSuspended		= PlatformThread::Suspend( m_pPlatformThread );
		assert( bIsSuspended );

		if ( bIsSuspended )
		{
			m_Status		= CoreThreadStatus::Suspended;
		}
	}

	return bIsSuspended;
}

bool
CoreThread::Resume() noexcept
{
	const bool bIsSuspended = m_Status == CoreThreadStatus::Suspended;
	assert( bIsSuspended );
	
	bool bIsResumed			= false;
	if ( bIsSuspended )
	{
		bIsResumed		= PlatformThread::Resume( m_pPlatformThread );
		assert( bIsResumed );
		
		if ( bIsResumed )
		{
			m_Status		= CoreThreadStatus::Running;
		}
	}

	return bIsResumed;
}

// Static functions.
uint32
CoreThread::GetLogicalThreadCount() noexcept
{
	return PlatformThread::GetLogicalThreadCount();
}

uint32
CoreThread::GetCurrentThreadID() noexcept
{
	return PlatformThread::GetCurrentThreadID();
}

CoreThread
CoreThread::GetCurrentThread() noexcept
{
	CoreThread currThread;
	
	currThread.m_PlatformThreadID = GetCurrentThreadID();
	currThread.m_pPlatformThread = PlatformThread::GetByID( currThread.m_PlatformThreadID );
	currThread.m_Status = CoreThreadStatus::Running;

	return currThread;
}

void
CoreThread::InitializeFromThreadStart( const CoreThreadStart& threadStart ) noexcept
{
	// A thread with no worker function serves no purpose.
	assert( threadStart.GetWorkFunction() );

	// A detached thread that starts suspended can never be run, as it has no handle that can be used to start it.
	assert( !threadStart.m_bDetached || threadStart.m_bScheduled );

	if ( threadStart.GetWorkFunction() )
	{
		m_PlatformThreadID = PlatformThread::Create( threadStart );
		if ( m_PlatformThreadID )
		{
			// Assign our thread an ID.
			m_pPlatformThread = PlatformThread::GetByID( m_PlatformThreadID );
			assert( m_pPlatformThread );

			if ( threadStart.m_bDetached )
			{
				const bool bDetached = PlatformThread::Detach( m_pPlatformThread );
				assert( bDetached );
				if ( bDetached )
				{
					m_Status = CoreThreadStatus::Detached;
				}
				else
				{
					m_Status = CoreThreadStatus::Running;
				}
			}
			else if ( threadStart.m_bScheduled )
			{
				m_Status = CoreThreadStatus::Running;
			}
			else
			{
				m_Status = CoreThreadStatus::Suspended;
			}
		}
	}
}