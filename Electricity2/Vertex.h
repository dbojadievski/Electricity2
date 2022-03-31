#pragma once

#include "Math.h"
struct VertexPositionOnly
{
	VertexPositionOnly() noexcept = default;
	VertexPositionOnly( const VertexPositionOnly& ) noexcept = default;
	VertexPositionOnly( float x, float y, float z ) noexcept;
	VertexPositionOnly( const Float3& position ) noexcept;

	void SetPosition( float x, float y, float z ) noexcept;
	void SetPosition( const Float3& pos ) noexcept;

	Float3 m_Position;
};

struct VertexPositionNormal
{

	VertexPositionNormal() noexcept = default;
	VertexPositionNormal( const VertexPositionNormal& ) noexcept = default;
	VertexPositionNormal( const Float3& position, const Float3& normal ) noexcept;

	void SetPosition(float x, float y, float z) noexcept;
	void SetPosition( const Float3& position ) noexcept;

	void SetNormal(float x, float y, float z) noexcept;
	void SetNormal( const Float3& normal ) noexcept;
	
	Float3 m_Position;
	Float3 m_Normal;
};