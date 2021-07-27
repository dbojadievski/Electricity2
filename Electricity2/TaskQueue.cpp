#include "TaskQueue.h"

#include <mutex>

using std::unique_lock;
using std::lock_guard;
using std::recursive_mutex;

static recursive_mutex g_Mutex;

uint32 __stdcall
TaskQueue::WorkerThreadFunc( ThreadFuncParamPtr ptrParam ) noexcept
{

	while ( !s_bShutDown )
	{
		lock_guard<recursive_mutex> guard( g_Mutex );
		if ( s_Tasks.size() )
		{
			Task& pfnTask = s_Tasks.front();
			s_Tasks.pop();
			pfnTask();
		}

	}

	return true;
}

void
TaskQueue::Initialize() noexcept
{
	lock_guard<recursive_mutex> guard( g_Mutex );
	CoreThreadStart threadStart( &WorkerThreadFunc, true );
	for ( uint32 uWorkerIdx = 0; uWorkerIdx < uNumWorkers; uWorkerIdx++ )
	{
		CoreThread* pThread = s_pWorkers[ uWorkerIdx ];
		pThread				= new CoreThread( threadStart );
	}
}

void
TaskQueue::Deinitialize() noexcept
{
	lock_guard<recursive_mutex> guard( g_Mutex );
	s_bShutDown = true;
	for ( uint32 uWorkerIdx = 0; uWorkerIdx < uNumWorkers; uWorkerIdx++ )
	{
		CoreThread* pThread = s_pWorkers[ uWorkerIdx ];
		pThread->Join();
		delete pThread;
		s_pWorkers[ uWorkerIdx ] = nullptr;
	}
}

void
TaskQueue::SubmitTask( Task pfnTask ) noexcept
{
	lock_guard<recursive_mutex> guard( g_Mutex );
	s_Tasks.push( pfnTask );
}