#include "ChunkHeader.h"

std::ostream& operator<< ( std::ostream& os, const ChunkHeader& header )
{
	os << static_cast<CoreId> ( header.m_uType ) << " " << header.m_uVersion << " " << header.m_uID << " " << header.m_uSize << std::endl;
	return os;
}

std::istream& operator>> ( std::istream& is, ChunkHeader& header )
{
	CoreId uType;

	is >> uType >> header.m_uVersion >> header.m_uID >> header.m_uSize;
	header.m_uType = static_cast< ChunkType >( uType );

	return is;
}