#pragma once
#include "CoreTypes.h"

// forward declarations
class PlatformVRAMPool;
class VRAMHandle;
enum class VRAMAllocType;

enum class VRAMPoolType
{
		VRAMPool					= 0
	, SingleResourceVRAMPool	= 1
	, BlockStorageVRAMPool		= 2
};

class VRAMPool
{
	friend class VRAMManager;

protected:
	VRAMPool( uint32 uSize ) noexcept;

public:
	virtual ~VRAMPool() noexcept;

	virtual bool IsEmpty() const noexcept = 0;
	virtual bool HasAvailable( const uint32 uSize, const VRAMAllocType eAllocType ) const noexcept = 0;
	PlatformVRAMPool* GetPlatformHandle() const noexcept { return m_pVRAMPool; }

	// Return offset in bytes from start of pool.
	virtual VRAMHandle* Allocate( const uint32 uSize ) noexcept = 0;
	virtual bool Deallocate( VRAMHandle& outHandle ) noexcept = 0;

	virtual inline VRAMPoolType GetPoolType() noexcept { return VRAMPoolType::VRAMPool; }

protected:
	uint32				m_uVRAMSize;
	uint32				m_uVRAMGranularity;

	VRAMPool*			m_pNext;
	PlatformVRAMPool*	m_pVRAMPool;
};

/// <summary>
/// This pool is created to contain a single resource.
/// It can fit in a resource of any size and type.
/// Thus, it'll only provide one handle, of ID 1 and offset 0.
/// Upon releasing the handle, this pool will be deallocated by the VRAMManager.
/// </summary>
class SingleResourceVRAMPool : public VRAMPool
{
	friend class VRAMManager;

private:
	SingleResourceVRAMPool( uint32 uSize ) noexcept;

public:
	virtual ~SingleResourceVRAMPool() noexcept;

	virtual bool IsEmpty() const noexcept;
	virtual bool HasAvailable( const uint32 uSize, const VRAMAllocType eAllocType ) const noexcept;
	virtual VRAMHandle* Allocate( const uint32 uSize ) noexcept;
	virtual bool Deallocate( VRAMHandle& outHandle ) noexcept;

	virtual inline VRAMPoolType GetPoolType() noexcept { return VRAMPoolType::SingleResourceVRAMPool; }
private:
	bool m_bIsFilled;
};

/// <summary>
/// This pool divides its memory into a number of equal-sized blocks.
/// Each resource takes at least one, and potentially all, blocks.
/// 
/// The blocks managed by this pool cannot be merged or split.
/// This means that every resource that's not aligned properly will waste memory.
/// It also means that some resources may not be able to fit in due to memory fragmentation.
/// </summary>
class BlockStorageVRAMPool : public VRAMPool
{
	friend class VRAMManager;

private:
	BlockStorageVRAMPool( uint32 uSize ) noexcept;

public:
	virtual ~BlockStorageVRAMPool() noexcept;

	virtual bool IsEmpty() const noexcept;
	virtual bool HasAvailable( const uint32 uSize, const VRAMAllocType eAllocType ) const noexcept;
	virtual VRAMHandle* Allocate( const uint32 uSize ) noexcept;
	virtual bool Deallocate( VRAMHandle& outHandle ) noexcept;

	virtual inline VRAMPoolType GetPoolType() noexcept { return VRAMPoolType::BlockStorageVRAMPool; }

private:

	uint16 CalcRequiredNumSlots( const uint32 uSize ) const noexcept;
	void FindAvailableBlock( const uint32 uSize, uint16& uBlockIdx, bool& bIsAllocable ) const noexcept;

	uint16	m_uNumSlots;
	uint16	m_uNumFreeSlots;
	
	/// <summary>
	/// Book-keeping on the individual blocks of VRAM.
	/// False = free, True = taken.
	/// </summary>
	bool*	m_abSlots;
	uint16	m_uFirstFreeSlot;
};