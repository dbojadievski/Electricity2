#include <assert.h>
#include "Thread.h"

CoreThread::CoreThread() noexcept
	: m_uID( 0 )
	, m_Status( CoreThreadStatus::Invalid )
	, m_pPlatformThread( nullptr )
	, m_PlatformThreadID( 0 )
{
	m_PlatformThreadID	= PlatformThread::Create( nullptr, nullptr, false );
	m_pPlatformThread	= PlatformThread::GetByID( m_PlatformThreadID );
}

CoreThread::CoreThread( CoreThread&& other ) noexcept
	: CoreThread()
{
	m_uID				= other.m_uID;
	m_Status			= other.m_Status;
	m_pPlatformThread	= other.m_pPlatformThread;
	m_PlatformThreadID	= other.m_PlatformThreadID;

	other.m_uID					= 0;
	other.m_Status				= CoreThreadStatus::Invalid;
	other.m_pPlatformThread		= nullptr;
	other.m_PlatformThreadID	= 0;
}


uint32
CoreThread::GetID() const noexcept
{
	return m_uID;
}

bool
CoreThread::IsRunning() const noexcept
{
	return m_Status == CoreThreadStatus::Running;
}

bool
CoreThread::IsValid() const noexcept
{
	return ( m_Status != CoreThreadStatus::Invalid );
}

CoreThreadStatus
CoreThread::GetStatus() const noexcept
{
	return m_Status;
}

bool
CoreThread::Yield() const noexcept
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
	assert( bIsJoinable );

	uint32 uCurrThreadID	= GetCurrentThreadID();
	if ( uCurrThreadID == m_uID ) // If we wait on ourselves to join, then a deadlock would occur.
	{
		threadWaitResult	= PlatformThreadWaitResult::WouldDeadlock;
	}
	else if ( bIsJoinable )
	{
		threadWaitResult	= PlatformThread::Join( m_pPlatformThread, uTime );
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
		bool bIsResumed		= PlatformThread::Resume( m_pPlatformThread );
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
CoreThread::GetCurrentThreadID() noexcept
{
	return PlatformThread::GetCurrentThreadID();
}