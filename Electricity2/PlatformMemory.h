#pragma once

#include "CoreTypes.h"
namespace PlatformMemory
{
	bool Initialize();
	bool ShutDown();

	uint32 GetMinAllocSize() noexcept;
	void* InternalAlloc( uint32 uSize );
	bool Free( void* pMemory );

	void Copy( byte* pSource, byte* pDestination, const uint32 uSize ) noexcept;
}
