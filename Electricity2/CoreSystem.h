#pragma once

#include "CoreTypes.h"
#include "CoreObject.h"

class CoreSystem : public CoreObject
{
	INIT_CLASS(CoreSystem)
public:
	virtual bool Initialize() noexcept	= 0;
	virtual void Update( uint32 uFrameDelta ) noexcept		= 0;
	virtual bool ShutDown() noexcept	= 0;
};