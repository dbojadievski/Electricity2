#pragma once

#include "CoreTypes.h"
#include "CoreContainers.h"

#include "Thread.h"
#include "Fiber.h"

typedef void* TaskParam;
typedef void ( *Task )( );

typedef void ( *TaskHandler ) ( TaskParam pParam, const bool& bIsCancelled );
typedef void ( *TaskOnSubmitHandler ) ( );
typedef void ( *TaskOnBeforeRunHandler ) ( );
typedef void ( *TaskOnCompleteHandler ) ( );
typedef void ( *TaskOnCancelledHandler ) ( );
typedef void ( *TaskOnCompleteOrCancelledHandler ) ( );

enum class TaskState: byte
{
	  Invalid	= 0
	, Scheduled = 1
	, Running	= 2
	, Completed = 3
	, Cancelled = 4
	, Num		= Cancelled
};

class PackagedTask
{
public:
	static PackagedTask * Create( TaskHandler pfnHandler, TaskParam pParam = nullptr ) noexcept;
	bool IsValid() const noexcept;
	bool IsScheduled() const noexcept;
	bool IsRunning() const noexcept;
	bool IsCancelled() const noexcept;
	bool IsCompleted() const noexcept;

	void Submit() noexcept;
	void Cancel() noexcept;
	void Await() noexcept;

	bool SetFollowUpTask( PackagedTask* pFollowUp ) noexcept;
	void SetOnSubmitHandler( TaskOnSubmitHandler pfnOnSubmit ) noexcept;
	void SetOnBeforeRunHandler( TaskOnBeforeRunHandler pfnOnBeforeRun ) noexcept;
	void SetOnCompleteHandler( TaskOnCompleteHandler pfnOnComplete ) noexcept;
	void SetOnCancelledHandler( TaskOnCancelledHandler pfnOnCancelled ) noexcept;
	void SetOnCompleteOrCancelledHandler( TaskOnCompleteOrCancelledHandler pfnHandler ) noexcept;
	friend class TaskQueue;

private:
	PackagedTask( TaskHandler pfnHandler, TaskParam pParam = nullptr ) noexcept;
	~PackagedTask() noexcept;
	TaskState							m_TaskState;
	bool								m_bShouldCancel;

	TaskParam							m_pParam;
	PackagedTask*						m_pFollowUpTask;

	TaskHandler							m_pfnHandler;
	TaskOnSubmitHandler					m_pfnOnSubmitHandler;
	TaskOnBeforeRunHandler				m_pfnOnBeforeRunHandler;
	TaskOnCompleteHandler				m_pfnOnCompleteHandler;
	TaskOnCancelledHandler				m_pfnOnCancelledHandler;
	TaskOnCompleteOrCancelledHandler	m_pfnOnCompleteOrCancelledHandler;
};

class TaskQueue
{
	friend class PackagedTask;
public:

	static void Initialize() noexcept;
	static void Deinitialize() noexcept;
	
	static inline uint32				s_uNumWorkers;
private:
	static inline Array<PackagedTask*>	s_UnsubmittedTasks;
	static inline Queue<PackagedTask*>	s_Tasks;
	static inline CoreThread**			s_ppWorkers;

	static inline bool					s_bShutDown = false;
	static uint32 __stdcall WorkerThreadFunc( ThreadFuncParamPtr ptrParam ) noexcept;
	static void SubmitTask( PackagedTask* pTask ) noexcept;
};