#include "SettingsSystem.h"

#include "App.h"
#include "PlatformDisplaySettings.h"
#include "PlatformMemory.h"
#include "StringUtils.h"

#include <thread>

// SettingsSystem implementation.

using namespace Electricity::Utils;

bool
SettingsSystem::Initialize() noexcept
{
	bool bInitialized = true;

	// Set up display settings around here.
	Platform::Memory::GetMemorySizeInMegabytes( m_uMemorySize );
	Platform::Settings::Display::GetMonitorDisplayResolution( m_DisplaySettings.m_uHorizontalResolution, m_DisplaySettings.m_uVerticalResolution, g_pApp->GetPlatformWindow() );

	bInitialized = ParseResolutionFromCmdLine();
	return bInitialized;
}

void
SettingsSystem::Deinitialize() noexcept
{
	ShutDown();
}

void
SettingsSystem::Update( uint32 uFrameDelta ) noexcept
{
	// TODO(Dino):
	// Some settings need to be updated per frame.
	// This may include:
	// the resolution of the monitor, the refresh rate, and HDR support.
	// Figure them out here.
	Platform::Settings::Display::GetMonitorDisplayResolution( m_DisplaySettings.m_uHorizontalResolution, m_DisplaySettings.m_uVerticalResolution, g_pApp->GetPlatformWindow() );
}

bool
SettingsSystem::ShutDown() noexcept
{
	m_uMemorySize		= 0;
	m_DisplaySettings	= {};

	return true;
}

const DisplaySettings&
SettingsSystem::GetDisplaySettings() const noexcept
{
	return m_DisplaySettings;
}

uint64
SettingsSystem::GetMemorySizeInMegabytes() const noexcept
{
	return m_uMemorySize;
}

uint32
SettingsSystem::GetHardwareThreadCount() const noexcept
{
	return std::thread::hardware_concurrency();
}

bool
SettingsSystem::ParseResolutionFromCmdLine() noexcept
{
	bool bParsed = true;

	String sResolution;
	const bool bHasRes = g_pApp->GetCommandLineParser().GetValue( "-resolution", sResolution );
	if ( bHasRes )
	{
		StringArray asParts;
		const char cDelimiter = 'x';
		ExplodeString( sResolution, asParts, cDelimiter );
		assert( asParts.size() == 2 );
		if ( asParts.size() == 2 )
		{
			int32 iWidth, iHeight;
			const bool bParsedWidth = StringToInteger( asParts[ 0 ], iWidth );
			const bool bParsedHeight = StringToInteger( asParts[ 1 ], iHeight );
			if ( bParsedWidth && bParsedHeight )
			{
				m_DisplaySettings.m_uRequestedHorizontalResolution = iWidth;
				m_DisplaySettings.m_uRequestedVerticalResolution = iHeight;
			}
			else
				bParsed = false;
		}
		else
			bParsed = false;
	}

	return bParsed;
}

SettingsSystem::SettingsSystem(OBJ_CONSTRUCTOR_PARAMS)
{

}