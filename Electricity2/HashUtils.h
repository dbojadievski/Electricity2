#pragma once
#include "CoreTypes.h"
#include <string>

namespace Electricity::Utils
{
	constexpr uint32 HashString( std::string_view toHash )
	{
		// For this example, I'm requiring size_t to be 64-bit, but you could
		// easily change the offset and prime used to the appropriate ones
		// based on sizeof(size_t).
		// FNV-1a 64 bit algorithm
		uint32 result = 2166136261; // FNV offset basis

		for ( char c : toHash ) {
			result ^= c;
			result *= 0x01000193; // FNV prime
		}

		return result;
	}
}