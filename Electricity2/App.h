#pragma once
#include "CoreTypes.h"
#include "PlatformAppDefines.h"
#include "SharedPtr.h"
#include "CommandLineParser.h"

class App final
{
public:
	App()  = delete;
	App( App& ) = delete;
	App( App&& ) = delete;

	App& operator=( const App& other ) = delete;
	App& operator==( const App&& other ) = delete;

	App( PPlatformWindow platformWindow, const String& cmdLineArgs ) noexcept;
	const PPlatformWindow GetPlatformWindow() const noexcept;

	CommandLineParser& GetCommandLineParser() noexcept { return m_CommandLineParser; }
private:
	CommandLineParser m_CommandLineParser;
	PPlatformWindow m_PlatformWindow;
};

extern SharedPtr<App> g_pApp;