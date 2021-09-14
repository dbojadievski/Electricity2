#include "DisplaySettings.h"

DisplaySettings::DisplaySettings() noexcept :
	m_WindowType( WindowType::Unknown )
	, m_uRefreshRate( 0 )
	, m_uHorizontalResolution( 0 )
	, m_uVerticalResolution( 0 )
	, m_uRequestedHorizontalResolution( 0 )
	, m_uRequestedVerticalResolution( 0 )
	, m_bIsHDRSupported( 0 )
{
}