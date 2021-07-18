#include "App.h"
#include <assert.h>

SharedPtr<App> g_pApp = nullptr;

App::App( PPlatformWindow platformWindow ) noexcept :
	m_PlatformWindow( platformWindow )
{
	assert( m_PlatformWindow );
}

const PPlatformWindow
App::GetPlatformWindow() const noexcept
{
	return m_PlatformWindow;
}