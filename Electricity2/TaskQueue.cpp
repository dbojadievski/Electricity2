#include "TaskQueue.h"

#include <mutex>

using std::unique_lock;
using std::lock_guard;
using std::recursive_mutex;

static recursive_mutex g_Mutex;

#include "SettingsSystem.h"

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
		}

	}

	return true;
}

void
TaskQueue::Initialize() noexcept
{
	lock_guard<recursive_mutex> guard( g_Mutex );
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
	lock_guard<recursive_mutex> guard( g_Mutex );
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
TaskQueue::SubmitTask( Task pfnTask ) noexcept
{
	lock_guard<recursive_mutex> guard( g_Mutex );
	s_Tasks.push( pfnTask );
}