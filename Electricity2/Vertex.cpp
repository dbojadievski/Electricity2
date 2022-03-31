#include "Vertex.h"

VertexPositionOnly::VertexPositionOnly( float x, float y, float z ) noexcept :
	m_Position( x, y, z )
{
}

VertexPositionOnly::VertexPositionOnly( const Float3& position ) noexcept :
	m_Position( position )
{
}

void
VertexPositionOnly::SetPosition( float x, float y, float z ) noexcept
{
	m_Position.x = x;
	m_Position.y = y;
	m_Position.z = z;
}

void
VertexPositionOnly::SetPosition( const Float3& pos ) noexcept
{
	m_Position = pos;
}

// Vertex position and normal.
VertexPositionNormal::VertexPositionNormal( const Float3& position, const Float3& normal ) noexcept
{
	m_Position = position;
	m_Normal = normal;
}

void
VertexPositionNormal::SetPosition( float x, float y, float z ) noexcept
{
	m_Position.x = x;
	m_Position.y = y;
	m_Position.z = z;
}

void
VertexPositionNormal::SetPosition( const Float3& position ) noexcept
{
	m_Position = position;
}

void
VertexPositionNormal::SetNormal(float x, float y, float z) noexcept
{
	m_Normal.x = x;
	m_Normal.y = y;
	m_Normal.z = z;
}

void
VertexPositionNormal::SetNormal( const Float3& normal ) noexcept
{
	m_Normal = normal;
}