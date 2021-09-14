#pragma once

#include <DirectXMath.h>

typedef DirectX::XMFLOAT2 Float2;
typedef DirectX::XMFLOAT2A Float2A;

typedef DirectX::XMFLOAT3 Float3;
typedef DirectX::XMFLOAT2A Float3A;

typedef DirectX::XMFLOAT4 Float4;
typedef DirectX::XMFLOAT4A Float4A;

typedef Float2 Vec2;
typedef Float3 Vec3;
typedef Float4 Vec4;
typedef DirectX::XMVECTOR FastVec;

#define FASTVEC_SET DirectX::XMVectorSet

typedef DirectX::XMMATRIX FASTMAT4;

typedef DirectX::XMFLOAT3X3 MAT3;
typedef DirectX::XMFLOAT4X4 MAT4;
typedef FASTMAT4 Transform;

#define FASTMAT_IDENTITY DirectX::XMMatrixIdentity
#define FASTMAT_TRANSPOSE DirectX::XMMatrixTranspose

namespace Electricity::Math
{
	template <typename Type>
	inline Type Min( const Type A, const Type B )
	{
		return ( A > B ? B : A );
	}

	template <typename Type>
	inline Type Max( const Type A, const Type B )
	{
		return ( A > B ? A : B );
	}
}