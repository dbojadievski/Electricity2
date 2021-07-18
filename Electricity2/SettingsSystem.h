#pragma once

#include "CoreTypes.h"
#include "CoreSystem.h"
#include "DisplaySettings.h"

#include "CoreObject.h"
#include "SharedPtr.h"

class SettingsSystem final : public CoreSystem
{
	INIT_CLASS(SettingsSystem)
public:
	virtual bool Initialize() noexcept;
	virtual void Deinitialize() noexcept;

	virtual void Update( uint32 uFrameDelta ) noexcept;
	virtual bool ShutDown() noexcept;

	const DisplaySettings& GetDisplaySettings() const noexcept;
	uint64 GetMemorySizeInMegabytes() const noexcept;
private:
	uint64			m_uMemorySize;
	DisplaySettings m_DisplaySettings;
};