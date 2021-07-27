#include "SimpleMeshLoader.h"
#include <mutex>
#include "Heap.h"
#include "StringUtils.h"
#include "ChunkHeader.h"

#include <fstream>
#include <stdio.h>

static std::recursive_mutex g_Mutex;

// Class SimpleMesh.

SimpleMesh::SimpleMesh() noexcept :
	  m_uID( 0 )
	, m_Name( "" )
	, m_uNumVertices( 0 )
	, m_aVertices( nullptr )
	, m_uNumIndices( 0 )
	, m_aIndices( nullptr )
	, m_uNumSections( 0 )
	, m_aSections( nullptr )
{
}

SimpleMesh::~SimpleMesh() noexcept
{
	delete [] m_aVertices;
	m_uNumVertices = 0;
	m_aVertices = nullptr;

	delete [] m_aIndices;
	m_uNumIndices = 0;
	m_aIndices = nullptr;

	delete [] m_aSections;
	m_uNumSections = 0;
	m_aSections = nullptr;

	m_Name = "";
	m_uID = 0;
}

void
SimpleMesh::ReadFromStream( std::istream& stream, const ChunkHeader& header ) noexcept
{
	assert( !stream.eof() );
	SimpleMeshChunkVersion uVersion = static_cast<SimpleMeshChunkVersion>( header.m_uVersion );

	SharedPtr<SimpleMesh> pMesh = SharedPtr<SimpleMesh>( new SimpleMesh() );
	pMesh->m_uID = header.m_uID;

	stream >> pMesh->m_Name;
	
	stream >> pMesh->m_uNumVertices;
	if ( pMesh->m_uNumVertices )
		pMesh->m_aVertices = new SimpleVertex[pMesh->m_uNumVertices];

	uint32 uNumPolys = 0;
	stream >> uNumPolys;
	pMesh->m_uNumIndices = 3 * uNumPolys;
	if ( pMesh->m_uNumIndices )
		pMesh->m_aIndices = new uint32[ pMesh->m_uNumIndices ];

	stream >> pMesh->m_uNumSections;
	if ( pMesh->m_uNumSections )
		pMesh->m_aSections = new MeshSection[ pMesh->m_uNumSections ];

	uint32 uReadVertices	= 0;
	uint32 uReadIndices		= 0;
	uint32 uReadSections	= 0;

	// Read vertices.
	while ( !stream.eof() && uReadVertices < pMesh->m_uNumVertices )
	{
		float x = 0, y = 0, z = 0;
		stream >> x;
		stream >> y;
		stream >> z;

		SimpleVertex& vertex = pMesh->m_aVertices[ uReadVertices ];
		vertex.SetPosition( x, y, z );
		uReadVertices++;
	}
	assert( uReadVertices == pMesh->m_uNumVertices );

	// Read polygons / index array.
	while ( !stream.eof() && uReadIndices < pMesh->m_uNumIndices )
	{
		uint32* pIndices = &pMesh->m_aIndices[ uReadIndices ];
		stream >> pIndices[ 0 ];
		stream >> pIndices[ 1 ];
		stream >> pIndices[ 2 ];

		uReadIndices += 3;
	}
	assert( uReadIndices == pMesh->m_uNumIndices );

	// Read section array.
	while ( !stream.eof() && uReadSections < pMesh->m_uNumSections )
	{
		MeshSection& section = pMesh->m_aSections[ uReadSections ];
		
		stream >> section.m_Name;
		stream >> section.m_uStartIndex;
		stream >> section.m_uEndIndex;

		uReadSections++;
	}
	assert( uReadSections == pMesh->m_uNumSections );

	// Mesh read successfully. Push it in the array.
	std::lock_guard<std::recursive_mutex> lock( g_Mutex );
	SimpleMeshLoader::s_apSimpleMeshes.push_back( pMesh );
}

void
SimpleMesh::WriteToStream( std::ostream& stream ) const noexcept
{
	// First, write the chunk header.
	ChunkHeader header	= {};
	header.m_uType		= ChunkType::SimpleMesh;
	header.m_uVersion	= static_cast<ChunkVersion>( SimpleMeshChunkVersion::Current );
	header.m_uID		= m_uID;
	header.m_uSize		= CalcChunkSize( );

	stream << header;
	stream << m_Name << std::endl;

	// Write out how many vertices, polys and sections we've got.
	stream << m_uNumVertices << " " << ( m_uNumIndices / 3 ) << " " << m_uNumSections << std::endl;
	
	// Then, write out the vertex array.
	for ( uint32 uVertexIndex = 0; uVertexIndex < m_uNumVertices; uVertexIndex++ )
	{
		const SimpleVertex& vertex = m_aVertices[ uVertexIndex ];
		stream << vertex.m_Position.x << " " << vertex.m_Position.y << " " << vertex.m_Position.z << std::endl;
	}

	// Continue with the index array in much the same fashion.
	for ( uint32 uIndexIndex = 0; uIndexIndex < m_uNumIndices; uIndexIndex += 3 )
	{
		const uint32* auIndex = &m_aIndices[ uIndexIndex ];
		stream << auIndex[0] << " " << auIndex[1] << " " << auIndex[2] << std::endl;
	}

	// Last thing we've got are sections.
	for ( uint32 uSectionIndex = 0; uSectionIndex < m_uNumSections; uSectionIndex++ )
	{
		const MeshSection& section = m_aSections[ uSectionIndex ];
		stream << section.m_Name << " " << section.m_uStartIndex << " " << section.m_uEndIndex;

		if ( uSectionIndex != ( m_uNumSections - 1 ) )
			stream << std::endl;
	}
}

uint32
SimpleMesh::CalcChunkSize( ) const noexcept
{
	uint32 size = sizeof( ChunkHeader );
	size += sizeof( SimpleMesh );

	// Add dynamic elements: vertices, indices, and sections.
	size += ( m_uNumVertices * sizeof( SimpleVertex ) );
	size += ( m_uNumVertices * sizeof( uint32 ) );
	size += ( m_uNumSections * sizeof( MeshSection ) );

	return size;
}

// Class SimpleMeshLoader.
void
SimpleMeshLoader::ShutDown() noexcept
{
	for ( SharedPtr<SimpleMesh> pMesh : s_apSimpleMeshes )
	{
		delete pMesh.Get();
 	}

	s_apSimpleMeshes.clear();
}