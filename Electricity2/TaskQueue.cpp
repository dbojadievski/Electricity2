#include "TaskQueue.h"

#include <mutex>

using std::unique_lock;
using std::lock_guard;
using std::recursive_mutex;

static recursive_mutex g_Mutex;

#include "SettingsSystem.h"

// Class PackagedTask

PackagedTask * 
PackagedTask::Create( TaskHandler pfnHandler, TaskParam pParam /*= nullptr */ ) noexcept
{
	PackagedTask* pPackagedTask = new PackagedTask( pfnHandler, pParam );
	
	unique_lock<recursive_mutex> guard( g_Mutex );
	TaskQueue::s_UnsubmittedTasks.push_back( pPackagedTask );
	
	return pPackagedTask;
}

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
PackagedTask::IsValid() const noexcept
{
	return ( m_pfnHandler );
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
	while ( m_TaskState != TaskState::Completed && m_TaskState != TaskState::Cancelled );
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

void
PackagedTask::SetOnCompleteOrCancelledHandler( TaskOnCompleteOrCancelledHandler pfnHandler ) noexcept
{
	m_pfnOnCompleteOrCancelledHandler = pfnHandler;
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
				
				delete pTask;
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
	s_uNumWorkers = CoreThread::GetLogicalThreadCount() - 1;
	CoreThreadStart threadStart( &WorkerThreadFunc, true );
	s_pWorkers = new CoreThread[ s_uNumWorkers ];
	for ( uint32 uWorkerIdx = 0; uWorkerIdx < s_uNumWorkers; uWorkerIdx++ )
	{
		CoreThread* pThread = &s_pWorkers[ uWorkerIdx ];
		pThread->SetThreadStart( threadStart );
	}
}

void
TaskQueue::Deinitialize() noexcept
{
	s_bShutDown = true;
	for ( uint32 uWorkerIdx = 0; uWorkerIdx < s_uNumWorkers; uWorkerIdx++ )
	{
		CoreThread* pThread = &s_pWorkers[ uWorkerIdx ];
		pThread->Join();
	}

	for ( PackagedTask* pPackagedTask : s_UnsubmittedTasks )
		delete pPackagedTask;

	delete[] s_pWorkers;
}

void
TaskQueue::SubmitTask( PackagedTask* pTask ) noexcept
{
	unique_lock<recursive_mutex> guard( g_Mutex );
	const auto& it = std::find( s_UnsubmittedTasks.begin(), s_UnsubmittedTasks.end(), pTask );
	if (it != s_UnsubmittedTasks.end() && pTask->m_TaskState == TaskState::Invalid)
	{
		pTask->m_TaskState = TaskState::Scheduled;

		if (pTask->m_pfnOnSubmitHandler)
			pTask->m_pfnOnSubmitHandler();

		s_UnsubmittedTasks.erase(it);
		s_Tasks.push(pTask);
	}
	else
		assert("Task already in task list.");
}