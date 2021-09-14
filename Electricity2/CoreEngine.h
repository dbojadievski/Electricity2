#pragma once

#include "App.h"
#include "CoreTypes.h"
#include "SharedPtr.h"

class SettingsSystem;

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
};

extern SharedPtr<CoreEngine> g_pEngine;