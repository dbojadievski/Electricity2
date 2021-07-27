#pragma once

#include "CoreTypes.h"
#include <istream>

enum class ChunkType : CoreId
{
	Unused		= 0,
	SimpleMesh	= 1
};

typedef CoreId ChunkVersion;

class ChunkHeader
{
public:
	ChunkHeader() noexcept = default;

	ChunkType		m_uType;
	ChunkVersion	m_uVersion;
	CoreId			m_uID;
	uint32			m_uSize;
};

std::ostream& operator<< ( std::ostream& os, const ChunkHeader& header );
std::istream& operator>> ( std::istream& is, ChunkHeader& header );