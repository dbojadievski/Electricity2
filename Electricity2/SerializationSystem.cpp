#include "SerializationSystem.h"

#include "Heap.h"
#include "MemoryStreamBuf.h"
#include "SimpleMeshLoader.h"
#include "TaskQueue.h"

#include <future>

ChunkReaderRegistry
SerializationSystem::s_ChunkReaderRegistry =
{
	{ ChunkType::SimpleMesh, &SimpleMesh::ReadFromStream }
};

void
SerializationSystem::Serialize( const ISerializable& object, const StringView& filePath ) noexcept
{
	std::ofstream stream( filePath.data() );
	if ( stream )
	{
		object.WriteToStream( stream );
		stream.flush();
 		stream.close();
	}
	else assert( false );
}

void
SerializationSystem::Deserialize( const String& filePath ) noexcept
{
	ifstream stream( filePath );
	if ( stream )
	{
		while ( !stream.eof() )
		{
			ChunkHeader header = {};
			ProcessChunkHeader( stream, header );
		}
	}
	else assert( false );
}

void
SerializationSystem::ProcessChunkHeader( istream& stream, ChunkHeader& chunkHeader ) noexcept
{
	stream >> chunkHeader;
	assert( chunkHeader.m_uSize > 0 );
	byte* pBuffer = static_cast<byte*>(gcalloc( chunkHeader.m_uSize ));
	stream.read( reinterpret_cast<char*>(pBuffer), chunkHeader.m_uSize );
	MemoryStream memStream(pBuffer, chunkHeader.m_uSize);

	const auto& it = s_ChunkReaderRegistry.find( chunkHeader.m_uType );
	if ( it != s_ChunkReaderRegistry.cend() )
	{
		ChunkReaderDelegate pfnProcessor = (it->second);
		pfnProcessor( memStream, chunkHeader );
	}
}