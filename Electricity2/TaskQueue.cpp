#include "TaskQueue.h"

#include <mutex>

using std::unique_lock;
using std::lock_guard;
using std::recursive_mutex;

static recursive_mutex g_Mutex;

#include "SettingsSystem.h"

// Class PackagedTask
PackagedTask::PackagedTask( TaskHandler pfnHandler, TaskParam pParam /* = nullptr */ ) noexcept :
	  m_TaskState( TaskState::Invalid )
	, m_bShouldCancel( false )
	, m_pParam( pParam )
	, m_pFollowUpTask( nullptr )
	, m_pfnHandler( pfnHandler )
	, m_pfnOnSubmitHandler( nullptr )
	, m_pfnOnBeforeRunHandler( nullptr )
	, m_pfnOnCompleteHandler( nullptr )
	, m_pfnOnCancelledHandler( nullptr )
	, m_pfnOnCompleteOrCancelledHandler( nullptr )
{
}

bool
PackagedTask::IsScheduled() const noexcept
{
	return ( m_TaskState == TaskState::Scheduled );
}

bool
PackagedTask::IsRunning() const noexcept
{
	return ( m_TaskState == TaskState::Running );
}

bool
PackagedTask::IsCancelled() const noexcept
{
	return ( m_TaskState == TaskState::Cancelled );
}

bool
PackagedTask::IsCompleted() const noexcept
{
	return ( m_TaskState == TaskState::Completed );
}

void
PackagedTask::Submit() noexcept
{
	TaskQueue::SubmitTask( this );
}

void
PackagedTask::Cancel() noexcept
{

	m_bShouldCancel = true;
}

void
PackagedTask::Await() noexcept
{
	while ( m_TaskState == TaskState::Scheduled || m_TaskState == TaskState::Running || m_TaskState == TaskState::Invalid ) 
	{
	}
}

bool
PackagedTask::SetFollowUpTask( PackagedTask* pFollowUp ) noexcept
{
	if ( !m_pFollowUpTask )
		m_pFollowUpTask = pFollowUp;

	
	return ( m_pFollowUpTask == pFollowUp );
}

void
PackagedTask::SetOnSubmitHandler( TaskOnSubmitHandler pfnOnSubmit ) noexcept
{
	m_pfnOnSubmitHandler = pfnOnSubmit;
}

void
PackagedTask::SetOnBeforeRunHandler( TaskOnBeforeRunHandler pfnOnBeforeRun ) noexcept
{
	m_pfnOnBeforeRunHandler = pfnOnBeforeRun;
}

void
PackagedTask::SetOnCompleteHandler( TaskOnCompleteHandler pfnOnComplete ) noexcept
{
	m_pfnOnCompleteHandler = pfnOnComplete;
}

void
PackagedTask::SetOnCancelledHandler( TaskOnCancelledHandler pfnOnCancelled ) noexcept
{
	m_pfnOnCancelledHandler = pfnOnCancelled;
}

PackagedTask::~PackagedTask() noexcept
{
	m_TaskState							= TaskState::Invalid;

	m_pfnHandler						= nullptr;
	m_pfnOnSubmitHandler				= nullptr;
	m_pfnOnBeforeRunHandler				= nullptr;
	m_pfnOnCompleteHandler				= nullptr;
	m_pfnOnCancelledHandler				= nullptr;
	m_pfnOnCompleteOrCancelledHandler	= nullptr;
}

// Class TaskQueue
uint32 __stdcall
TaskQueue::WorkerThreadFunc( ThreadFuncParamPtr ptrParam ) noexcept
{

	while ( !s_bShutDown )
	{
		unique_lock<recursive_mutex> guard( g_Mutex );
		if ( s_Tasks.size() )
		{
			PackagedTask* pTask = s_Tasks.front();
			PackagedTask* pFollowUp = pTask->m_pFollowUpTask;
			s_Tasks.pop();
			guard.unlock();

			if ( pTask->m_pfnOnBeforeRunHandler )
				pTask->m_pfnOnBeforeRunHandler();

			pTask->m_TaskState = TaskState::Running;
			pTask->m_pfnHandler( pTask->m_pParam, pTask->m_bShouldCancel );

			if ( pTask->m_pfnOnCompleteOrCancelledHandler )
				pTask->m_pfnOnCompleteOrCancelledHandler();

			if ( pTask->m_bShouldCancel )
			{
				pTask->m_TaskState = TaskState::Cancelled;
				if ( pTask->m_pfnOnCancelledHandler )
					pTask->m_pfnOnCancelledHandler();
			}
			else
			{
				pTask->m_TaskState = TaskState::Completed;
				if ( pTask->m_pfnOnCompleteHandler )
					pTask->m_pfnOnCompleteHandler();
				
				if ( pFollowUp )
					pFollowUp->Submit();
			}
		}
		else
			guard.unlock();
	}

	return true;
}

void
TaskQueue::Initialize() noexcept
{
	unique_lock<recursive_mutex> guard( g_Mutex );
	s_uNumWorkers = CoreThread::GetLogicalThreadCount();
	CoreThreadStart threadStart( &WorkerThreadFunc, true );
	s_ppWorkers = new CoreThread*[ s_uNumWorkers ];
	for ( uint32 uWorkerIdx = 0; uWorkerIdx < s_uNumWorkers; uWorkerIdx++ )
	{
		CoreThread* pThread = s_ppWorkers[ uWorkerIdx ];
		pThread				= new CoreThread( threadStart );
	}
}

void
TaskQueue::Deinitialize() noexcept
{
	unique_lock<recursive_mutex> guard( g_Mutex );
	s_bShutDown = true;
	for ( uint32 uWorkerIdx = 0; uWorkerIdx < s_uNumWorkers; uWorkerIdx++ )
	{
		CoreThread* pThread = s_ppWorkers[ uWorkerIdx ];
		pThread->Join();
		delete pThread;
		s_ppWorkers[ uWorkerIdx ] = nullptr;
	}

	delete[] s_ppWorkers;
}

void
TaskQueue::SubmitTask( PackagedTask* pTask ) noexcept
{
	pTask->m_TaskState = TaskState::Scheduled;
	
	if ( pTask->m_pfnOnSubmitHandler )
		pTask->m_pfnOnSubmitHandler();

	unique_lock<recursive_mutex> guard( g_Mutex );
	s_Tasks.push( pTask );
}