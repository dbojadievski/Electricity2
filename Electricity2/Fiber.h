#pragma once
#include "CoreTypes.h"
#include "PlatformThreadingDefines.h"

class CoreThread;
class CoreFiber;
class CoreFiberStart;

class CoreFiber
{
public:
	CoreFiber() noexcept;
	CoreFiber( CoreFiber&& other ) noexcept;
	CoreFiber( CoreFiber& other ) = delete;
	CoreFiber( const CoreFiberStart& fiberStart ) noexcept;
	CoreFiber( CoreThread& other ) noexcept;

	~CoreFiber() noexcept;

	CoreFiber& operator=( const CoreFiber& other ) noexcept;
	CoreFiber& operator=( CoreFiber&& other ) noexcept;

	PPlatformFiber GetPlatformFiber() const noexcept;
	uint32 GetID() const noexcept;
	bool IsScheduled() const noexcept;
	bool SwitchTo( CoreFiber& other ) noexcept;

	void Delete() noexcept;

	static CoreFiber GetCurrentFiber() noexcept;
private:
	uint32			m_uID;
	bool			m_bScheduled;
	PPlatformFiber	m_pPlatformFiber;
};