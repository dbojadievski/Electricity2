#pragma once

#include "CoreContainers.h"

#include "Thread.h"
#include "Fiber.h"

typedef void ( *Task )( );

class TaskQueue
{
public:
	static void SubmitTask( Task pfnTask ) noexcept;

	static void Initialize() noexcept;
	static void Deinitialize() noexcept;
	
	static inline uint32 s_uNumWorkers;
private:
	static inline Queue<Task> s_Tasks;
	static inline CoreThread** s_ppWorkers;

	static inline bool s_bShutDown = false;
	static uint32 __stdcall WorkerThreadFunc( ThreadFuncParamPtr ptrParam ) noexcept;
};