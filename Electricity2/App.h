#pragma once
#include "CoreTypes.h"
#include "PlatformAppDefines.h"
#include "SharedPtr.h"

class App final
{
public:
	App()  = delete;
	App( App& ) = delete;
	App( App&& ) = delete;

	App& operator=( const App& other ) = delete;
	App& operator==( const App&& other ) = delete;

	App( PPlatformWindow platformWindow ) noexcept;
	const PPlatformWindow GetPlatformWindow() const noexcept;
private:
	PPlatformWindow m_PlatformWindow;
};

extern SharedPtr<App> g_pApp;