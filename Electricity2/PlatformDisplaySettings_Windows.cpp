#ifdef _WIN32
#include <assert.h>
#include "PlatformDisplaySettings.h"

void
Platform::Settings::Display::GetMonitorDisplayResolution( uint32& uWidth, uint32& uHeight, PPlatformWindow window ) noexcept
{
	assert( window );

	uWidth				= 0;
	uHeight				= 0;

	HWND hWnd			= static_cast< HWND >( window );
	HMONITOR hMonitor	= MonitorFromWindow( hWnd, MONITOR_DEFAULTTOPRIMARY );

	MONITORINFO info	= {};
	info.cbSize			= sizeof( info );
	const bool bGot		= GetMonitorInfo( hMonitor, &info) ;
	if ( bGot )
	{
		uWidth			= ( info.rcMonitor.right - info.rcMonitor.left );
		uHeight			= ( info.rcMonitor.bottom - info.rcMonitor.top );
	}
}

#endif // _WIN32