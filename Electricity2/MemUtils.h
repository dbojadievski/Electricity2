#pragma once
#include "CoreTypes.h"

namespace Electricity::Utils::Memory
{
	constexpr uint64 ToKilobytes( const uint32 uNumKb ) noexcept { return uNumKb * 1024; }
	constexpr uint64 ToMegabytes( const uint32 uNumMb ) noexcept { return uNumMb * 1024 * 1024; }

	void Clear( void* pMem, const uint32 uSize ) noexcept;
}