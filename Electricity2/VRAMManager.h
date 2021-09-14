#pragma once

#include "CoreTypes.h"

enum class VRAMAllocType;
class VRAMPool;
class VRAMHandle;

class VRAMManager
{
public:
	VRAMManager() noexcept;
	~VRAMManager() noexcept;

	/// <summary>
	/// Not sure if this should pre-allocate a pool or not.
	/// </summary>
	/// <returns></returns>
	static bool Initialize() noexcept;

	/// <summary>
	/// Deallocates all VRAM pools that this manager manages.
	/// </summary>
	static void ShutDown() noexcept;

	static VRAMHandle& AllocateVRAM( const uint32 uSize, const VRAMAllocType eType ) noexcept;
	static bool ReleaseVRAM( VRAMHandle& outHandle ) noexcept;
private:
	static VRAMPool* CreatePreferredVRAMPoolForType( const uint32 uSize, const VRAMAllocType eType ) noexcept;
	static VRAMPool* FindPrevVRAMPoolInChain( VRAMPool* pPool ) noexcept;

	static inline VRAMPool* s_pVRAMPools = nullptr;
};