#pragma once

#include "CoreTypes.h"

// Forward declarations.
class CoreThread;

enum class CoreThreadStatus : sbyte
{
	Invalid = 0,
	Suspended,
	Running,
	Detached,
	Stopped,
	Count = Stopped
};

typedef uint32( __stdcall* pThreadFunc ) ( void* pParam );

enum class PlatformThreadWaitResult : byte
{
	Invalid = 0,
	OK = 1,
	Timeout = 2,
	Failed = 3,
	WouldDeadlock = 4,
	Count = Failed
};

typedef PlatformThreadWaitResult CoreThreadWaitResult;
typedef sbyte CoreThreadProcessorAffinity;


enum class CoreThreadPriority : byte
{
	Idle = 0,
	Low = 1,
	Normal = 2,
	High = 3,
	Critical = 4
};

typedef void* ThreadFuncParamPtr;


class CoreThreadStart
{
	friend class CoreThread;
public:
	CoreThreadStart() noexcept;
	CoreThreadStart( pThreadFunc pfnWorkFunction, const bool bCreateRunning = false, const bool bCreateDetached = false ) noexcept;

	CoreThreadStart( const CoreThreadStart& other ) noexcept;
	CoreThreadStart( CoreThreadStart&& other ) = delete;

	~CoreThreadStart() noexcept;

	CoreThreadStart& operator=( const CoreThreadStart& other ) noexcept;
	CoreThreadStart& operator=( CoreThreadStart&& other ) = delete;

	bool GetCreateRunning() const noexcept;
	bool GetCreateDetached() const noexcept;

	CoreThreadPriority GetThreadPriority() const noexcept;
	CoreThreadProcessorAffinity GetAffinity() const noexcept;

	uint16 GetStackSize() const noexcept;
	pThreadFunc GetWorkFunction() const noexcept;
	ThreadFuncParamPtr GetThreadFuncParam() const noexcept;

	void SetPriority( const CoreThreadPriority& Priority ) noexcept;
	void SetAffinity( const CoreThreadProcessorAffinity& Affinity ) noexcept;
	void SetStackSize( const uint16 uStackSize ) noexcept;

	void SetWorkFunction( pThreadFunc pfnWorkFunction ) noexcept;

private:
	bool m_bRunning;
	bool m_bDetached;

	CoreThreadPriority			m_Priority;
	CoreThreadProcessorAffinity m_Affinity;
	uint16						m_uStackSize;
	pThreadFunc					m_pfnThreadFunc;
	ThreadFuncParamPtr			m_pThreadFuncParam;
};