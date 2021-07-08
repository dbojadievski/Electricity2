#pragma once

#include "CoreTypes.h"
#include "PlatformThread.h"

enum class CoreThreadStatus : sbyte
{
	Invalid					= 0,
	Suspended				= 1,
	Running					= 2,
	Detached				= 3,
	Count					= Running
};

typedef PlatformThreadWaitResult CoreThreadWaitResult;

class CoreThread
{
public:
	CoreThread() noexcept;
	CoreThread( CoreThread&& other ) noexcept;
	CoreThread( CoreThread& other ) = delete;

	uint32 GetID() const noexcept;
	bool IsRunning() const noexcept;

	bool IsValid() const noexcept;
	CoreThreadStatus GetStatus() const noexcept;

	bool Yield( ) const noexcept;

	bool IsJoinable() const noexcept;
	/// <summary>
	/// Wait for thread to finish its execution, either indefinitely or for a time.
	/// </summary>
	/// <param name="uTime">The maximum time to wait, or 0 for indefinite.</param>
	/// <returns>The result of the operation</returns>
	CoreThreadWaitResult Join(const uint64 uTime = 0) noexcept;
	
	bool IsDetachable() const noexcept;
	bool IsDetached() const noexcept;
	/// <summary>
	/// Allows the thread to run independently of the CoreThread object.
	/// This allows the OS object to be destructed safely, while the thread is running.
	///  A detached thread is NOT joinable, nor can it be stopped from another thread.
	/// </summary>
	/// <returns> Whether the operation was successful or not. </returns>
	bool Detach() noexcept;

	/// <summary>
	/// Kills the poor defenseless thread.
	/// This will immediately stop execution without any chance of cleanup. 
	/// You better be sure about this if you're going to use it.
	/// Callers are subject to immediate anathema by the Pope of Rome.
	/// </summary>
	void Kill() noexcept;

	/// <summary>
	/// ALMOST as bad as Kill().
	/// Will stop the thread from running until resumed, without chance of cleanup.
	/// Find another way to achieve what you want.
	/// </summary>
	bool Suspend() noexcept;

	/// <summary>
	/// Resumes a thread that has been previously suspended.
	/// </summary>
	bool Resume() noexcept;

	static uint32 GetCurrentThreadID()  noexcept;
private:
	uint32				m_uID;
	CoreThreadStatus	m_Status;

	PPlatformThread		m_pPlatformThread;
	PlatformThreadID	m_PlatformThreadID;

};