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