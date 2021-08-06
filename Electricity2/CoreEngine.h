#pragma once

#include "App.h"
#include "CoreTypes.h"
#include "SettingsSystem.h"
#include "SharedPtr.h"
#include "CoreContainers.h"
#include "PAR.h"
class CoreEngine
{
public:
	CoreEngine() noexcept;
	~CoreEngine() noexcept;

	SharedPtr<SettingsSystem> GetSettingsSystem() noexcept;

	void Initialize( const StringView& sCmdLine  ) noexcept;
	void Update() noexcept;
	void ShutDown() noexcept;
private:
	uint32 m_uPrevFrameTime;
	SharedPtr<SettingsSystem> m_pSettingsSystem;
	SharedPtr<Electricity::Rendering::PAR> m_pPAR;
};

extern SharedPtr<CoreEngine> g_pEngine;