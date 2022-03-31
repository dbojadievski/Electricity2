#pragma once
#include "CoreTypes.h"

enum class VRAMAllocType
{
	Default = 0,
	Buffer	= 1
};

// forward declarations
class VRAMManager;
class VRAMPool;
class SingleResourceVRAMPool;
class BlockStorageVRAMPool;
class PlatformVRAMPool;

class VRAMHandle
{
	friend VRAMPool;
	friend VRAMManager;
	friend SingleResourceVRAMPool;
	friend BlockStorageVRAMPool;

private:
	uint32			m_uHandleVal;
	uint32			m_uOffsetInPool;
	VRAMPool*		m_pPool;

	VRAMHandle() noexcept;
	~VRAMHandle() noexcept;
public:
	bool IsValid() const noexcept { return m_uHandleVal != 0; }

	bool operator== ( const VRAMHandle& other ) const noexcept { return m_uHandleVal == other.m_uHandleVal; }
	bool operator!= ( const VRAMHandle& other ) const noexcept { return m_uHandleVal != other.m_uHandleVal; }
		
	VRAMHandle& operator=( VRAMHandle&& other ) noexcept 
	{
		m_uHandleVal			= other.m_uHandleVal;
		m_uOffsetInPool			= other.m_uOffsetInPool;
		m_pPool					= other.m_pPool;

		other.m_uHandleVal		= 0;
		other.m_uOffsetInPool	= 0;
		other.m_pPool			= nullptr;

		return *this;
	}

	VRAMHandle& operator=( const VRAMHandle& other ) noexcept
	{
		m_uHandleVal		= other.m_uHandleVal;
		m_uOffsetInPool		= other.m_uOffsetInPool;
		m_pPool				= other.m_pPool;

		return *this;
	}

};