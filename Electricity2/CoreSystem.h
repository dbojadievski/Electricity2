#pragma once

#include "CoreTypes.h"
#include "CoreObject.h"

class CoreSystem : public CoreObject
{
	INIT_CLASS(CoreSystem)
public:
	virtual bool Initialize() noexcept;
	virtual void Update( uint32 uFrameDelta ) noexcept;
	virtual bool ShutDown() noexcept;
	
};