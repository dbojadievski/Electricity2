#pragma once
#include "CoreTypes.h"
#include "CoreContainers.h"
#include "ChunkHeader.h"
#include "ISerializable.h"
#include "SharedPtr.h"

#include <fstream>

using std::istream;
using std::ifstream;
using std::fstream;
using std::ofstream;

typedef void ( *ChunkReaderDelegate ) ( std::istream& stream, const ChunkHeader& header ) noexcept;

typedef Map<ChunkType, ChunkReaderDelegate> ChunkReaderRegistry;

class SerializationSystem
{

public:
	static void Serialize( const ISerializable& object, const StringView& filePath ) noexcept;
	static void Deserialize( const String& filePath ) noexcept;

private:
	static void ProcessChunkHeader( istream& stream, ChunkHeader& chunkHeader ) noexcept;

	static ChunkReaderRegistry s_ChunkReaderRegistry;
};