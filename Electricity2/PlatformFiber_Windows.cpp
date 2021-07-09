#ifdef _WIN32
#include <assert.h>
#include <windows.h>

#include "PlatformFiber.h"
#include "FiberStart.h"


PPlatformFiber
PlatformFiber::Create( const CoreFiberStart& fiberStart ) noexcept
{
	LPVOID pFiber = CreateFiber(
		static_cast<size_t>( fiberStart.GetStackSize() )
		, static_cast<LPFIBER_START_ROUTINE>( fiberStart.GetFiberFunc() )
		, static_cast<LPVOID>( fiberStart.GetParam() )
	);

	assert( pFiber );
	return static_cast<PPlatformFiber>( pFiber );
}

PPlatformFiber
PlatformFiber::FromThread( pFiberFuncParam pParam /* = nullptr */ ) noexcept
{
	LPVOID pFiber = ConvertThreadToFiber( pParam );
	return static_cast<PPlatformFiber>( pFiber );
}

bool
PlatformFiber::SwitchTo( const PPlatformFiber fiber ) noexcept
{
	bool bSwitched = false;
	assert( fiber );

	if ( fiber )
	{
		LPVOID pFiber = static_cast<LPVOID>( fiber );
		SwitchToFiber( pFiber );
		
		bSwitched = true;
	}

	return bSwitched;
}

bool
PlatformFiber::Delete( const PPlatformFiber fiber ) noexcept
{
	bool bDeleted = false;
	assert( fiber );

	if ( fiber )
	{
		LPVOID pFiber = static_cast<LPVOID>( fiber );
		DeleteFiber( fiber );

		bDeleted = true;
	}
	return bDeleted;
}

PPlatformFiber
PlatformFiber::GetCurrent() noexcept
{
	PVOID pFiber = GetCurrentFiber();
	return static_cast<LPVOID>( pFiber );
}
#endif // _WIN32