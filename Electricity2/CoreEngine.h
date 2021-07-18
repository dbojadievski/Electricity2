#pragma once

#include "App.h"
#include "CoreTypes.h"
#include "SettingsSystem.h"
#include "SharedPtr.h"

class CoreEngine
{
public:
	CoreEngine() noexcept;
	~CoreEngine() noexcept;

	SharedPtr<SettingsSystem> GetSettingsSystem() noexcept;

	void Initialize() noexcept;
	void Update() noexcept;
	void ShutDown() noexcept;
private:
	uint32 m_uPrevFrameTime;
	SharedPtr<SettingsSystem> m_pSettingsSystem;
};

extern SharedPtr<CoreEngine> g_pEngine;