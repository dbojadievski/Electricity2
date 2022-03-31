#pragma once

#include "CoreTypes.h"
#include "CoreObject.h"

class CoreSystem : public CoreObject
{
public:
	virtual bool Initialize() noexcept;
	virtual void Update( uint32 uFrameDelta ) noexcept;
	virtual bool ShutDown() noexcept;
	
};