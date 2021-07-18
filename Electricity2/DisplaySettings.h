#pragma once

#include "CoreTypes.h"

enum class WindowType : byte
{
	Unknown = 0,
	Windowed,
	FullScreen,
	WindowedFullScreen
};

struct DisplaySettings
{
	DisplaySettings() noexcept;
	
	WindowType	m_WindowType;
	uint32		m_uRefreshRate;
	
	uint32		m_uHorizontalResolution;
	uint32		m_uVerticalResolution;
	
	bool		m_bIsHDRSupported;
};