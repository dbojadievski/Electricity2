#include "SwapChain.h"

#include "CoreEngine.h"
#include "SettingsSystem.h"
#include "DisplaySettings.h"

namespace Electricity::Rendering
{
	bool SwapChain::Initialize() noexcept
	{
		const DisplaySettings& displaySettings = g_pEngine->GetSettingsSystem()->GetDisplaySettings();
		if ( displaySettings.m_uRequestedHorizontalResolution && displaySettings.m_uRequestedVerticalResolution )
		{
			s_uRequestedWidth		= displaySettings.m_uRequestedHorizontalResolution;
			s_uRequestedHeight		= displaySettings.m_uRequestedVerticalResolution;

			s_bRequestedChange		= true;
		}
		else
		{
			s_uRequestedWidth		= displaySettings.m_uHorizontalResolution;
			s_uRequestedHeight		= displaySettings.m_uVerticalResolution;

			s_bRequestedChange		= true;
		}
		
		return true;
	}

	void SwapChain::Update() noexcept 
	{
		Platform_Update();
	}

	bool SwapChain::ShutDown() noexcept 
	{
		s_uHeight					= 0;
		s_uHeight					= 0;
		
		s_uRequestedHeight			= 0;
		s_uRequestedHeight			= 0;
		
		s_uFullScreen				= false;
		s_bRequestedFullScreenState = false;
		
		s_bRequestedChange			= false;
		s_bRequestedRecreate		= false;

		return true;
	}

	uint32 SwapChain::GetWidth() noexcept
	{
		return s_uWidth;
	}

	uint32 SwapChain::GetHeight() noexcept
	{
		return s_uHeight;
	}

	uint32 SwapChain::GetRequestedWidth() noexcept
	{
		return s_uRequestedWidth;
	}

	uint32 SwapChain::GetRequestedHeight() noexcept
	{
		return s_uRequestedHeight;
	}

	void SwapChain::RequestSize( const uint32 uWidth, const uint32 uHeight ) noexcept
	{
		s_uRequestedWidth = uWidth;
		s_uRequestedHeight = uHeight;

		s_bRequestedChange = true;
	}
		 
	bool SwapChain::GetIsFullScreen() noexcept
	{
		return s_uFullScreen;
	}

	bool SwapChain::GetRequestedFullScreen() noexcept
	{
		return ( s_bRequestedFullScreenState );
	}

	void SwapChain::RequestFullScreenState( const bool bFullScreen ) noexcept 
	{
		s_bRequestedFullScreenState = bFullScreen;
		s_bRequestedChange = true;
	}

	bool SwapChain::GetRequestedRecreate() noexcept
	{
		return s_bRequestedRecreate;
	}

	void SwapChain::RequestRecreate() noexcept
	{
		s_bRequestedRecreate = true;
		s_bRequestedChange = true;
	}
}