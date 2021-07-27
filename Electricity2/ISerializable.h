#pragma once

#include "CoreTypes.h"
class ChunkHeader;
class SerializationSystem;

#include <fstream>

class ISerializable
{
	friend class SerializationSystem;
public:
	virtual void WriteToStream( std::ostream& stream ) const noexcept = 0;
private:
	virtual uint32 CalcChunkSize() const noexcept = 0;
};