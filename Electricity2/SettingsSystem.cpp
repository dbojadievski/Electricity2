#include "SettingsSystem.h"

#include "App.h"
#include "PlatformDisplaySettings.h"
#include "PlatformMemory.h"
// SettingsSystem implementation.

bool
SettingsSystem::Initialize() noexcept
{
	// Set up display settings around here.
	Platform::Memory::GetMemorySizeInMegabytes( m_uMemorySize );
	Platform::Settings::Display::GetMonitorDisplayResolution( m_DisplaySettings.m_uHorizontalResolution, m_DisplaySettings.m_uVerticalResolution, g_pApp->GetPlatformWindow() );
	return true;
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