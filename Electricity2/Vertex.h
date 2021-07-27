#pragma once

#include "Math.h"
struct VertexPositionOnly
{
	Float3 m_Position;
	
	VertexPositionOnly() noexcept = default;
	VertexPositionOnly( const VertexPositionOnly& ) noexcept = default;
	VertexPositionOnly( float x, float y, float z ) noexcept;
	VertexPositionOnly( const Float3& position ) noexcept;

	void SetPosition( float x, float y, float z ) noexcept;
	void SetPosition( const Float3& pos ) noexcept;
};