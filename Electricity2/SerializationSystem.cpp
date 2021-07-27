#include "SerializationSystem.h"

#include "SimpleMeshLoader.h"
#include "Heap.h"

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
		ChunkHeader header = {};
		ProcessChunkHeader( stream, header );
	}
	else assert( false );
}

void
SerializationSystem::ProcessChunkHeader( istream& stream, ChunkHeader& chunkHeader ) noexcept
{
	stream >> chunkHeader;
	assert( chunkHeader.m_uSize > 0 );
	void* pBuffer = gcalloc( chunkHeader.m_uSize );

	const auto& it = s_ChunkReaderRegistry.find( chunkHeader.m_uType );
	if ( it != s_ChunkReaderRegistry.cend() )
	{
		ChunkReaderDelegate pfnProcessor = (it->second);
		pfnProcessor( stream, chunkHeader );
	}
}