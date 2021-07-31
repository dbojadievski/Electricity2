#pragma once

#include "CoreContainers.h"

#include "Thread.h"
#include "Fiber.h"

typedef void* TaskParam;
typedef void ( *Task )( );

typedef void ( *TaskHandler ) ( TaskParam pParam );

struct PackagedTask
{
	TaskParam	m_pParam;
	TaskHandler m_pfnHandler;

	PackagedTask( TaskHandler pfnHandler, TaskParam pParam = nullptr );
};

class TaskQueue
{
public:
	static void SubmitTask( PackagedTask& task ) noexcept;

	static void Initialize() noexcept;
	static void Deinitialize() noexcept;
	
	static inline uint32 s_uNumWorkers;
private:
	static inline Queue<PackagedTask> s_Tasks;
	static inline CoreThread** s_ppWorkers;

	static inline bool s_bShutDown = false;
	static uint32 __stdcall WorkerThreadFunc( ThreadFuncParamPtr ptrParam ) noexcept;
};