#include "App.h"
#include <assert.h>

#include "Heap.h"
App * g_pApp = nullptr;

App::App( PPlatformWindow platformWindow, const String& cmdLineArgs ) noexcept :
	m_PlatformWindow( platformWindow )
	, m_CommandLineParser( cmdLineArgs )
{
	assert( m_PlatformWindow );
}

const PPlatformWindow
App::GetPlatformWindow() const noexcept
{
	return m_PlatformWindow;
}