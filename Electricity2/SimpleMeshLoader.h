#pragma once

#include "CoreTypes.h"
#include "Vertex.h"

#include "CoreContainers.h"
#include "SharedPtr.h"

#include "ISerializable.h"

#include <istream>

class ChunkHeader;
class SimpleMesh;
class SimpleMeshLoader;

typedef VertexPositionOnly SimpleVertex;
typedef Array<SharedPtr<SimpleMesh>> SimpleMeshArray;

typedef uint32 MeshId;

class MeshSection
{
public:
	String m_Name;
	uint32 m_uStartIndex;
	uint32 m_uEndIndex;
};

class SimpleMesh: public ISerializable
{
	friend class SimpleMeshLoader;
public:
	SimpleMesh() noexcept;
	~SimpleMesh() noexcept;
	
	virtual void WriteToStream( std::ostream& stream ) const noexcept;
	static void ReadFromStream( std::istream& stream, const ChunkHeader& header ) noexcept;

private:

	virtual uint32 CalcChunkSize( ) const noexcept;

	MeshId			m_uID;
	String			m_Name;

	uint32			m_uNumVertices;
	SimpleVertex*	m_aVertices;

	uint32			m_uNumIndices;
	uint32*			m_aIndices;

	uint32			m_uNumSections;
	MeshSection*	m_aSections;
};


enum class SimpleMeshChunkVersion: CoreId
{
	// (DB) Version 1 - position-only mesh.
	PositionOnly = 1,
	Current = PositionOnly
};

class SimpleMeshLoader
{
	friend class SimpleMesh;
public:
	static const SimpleMeshArray& GetMeshes() { return s_apSimpleMeshes; }
	static void ShutDown() noexcept;

private:
	static inline SimpleMeshArray	s_apSimpleMeshes;
};

