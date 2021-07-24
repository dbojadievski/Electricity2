#pragma once

#include "CoreTypes.h"

namespace Electricity::Math
{
	template <class Type>
	class Vector4
	{
	public:
		union
		{
			union
			{
				Type r, g, b, a;
			};
			union
			{
				Type x, y, z, w;
			};
			Type m_aData[ 4 ];
		};

		Vector4() noexcept
		{
			r = g = b = a = 0;
		}

		Vector4( Type InR, Type InG, Type InB, Type InA ) noexcept
		{
			r = InR;
			g = InG;
			b = InB;
			a = InA;
		}

		Vector4( const Vector4<Type>& other ) noexcept
		{
			r = other.r;
			g = other.g;
			b = other.b;
			a = other.a;
		}

		Vector4( Vector4<Type>&& other ) noexcept
		{
			r = other.r;
			g = other.g;
			b = other.b;
			a = other.a;

			other.r = 0;
			other.g = 0;
			other.b = 0;
			other.a = 0;
		}

		~Vector4() noexcept
		{
			r = g = b = a = 0;
		}

		Vector4& operator= ( const Vector4<Type>& other ) noexcept
		{
			r = other.r;
			g = other.g;
			b = other.b;
			a = other.a;

			return *this;
		}

		bool operator==( const Vector4<Type>& other ) noexcept
		{
			return ( ( r == other.r ) && ( g == other.g ) && ( b == other.b ) && ( a == other.a ) );
		}

		Type Magnitude() const noexcept
		{
			const Type d = ( r * r ) + ( g * g ) + ( b * b ) + ( a * a);
			const Type root = static_cast<Type>( sqrt( d ) );

			return root;
		}

		Vector4<Type>& Normalize() noexcept
		{
			const Type magnitude = Magnitude();

			r /= magnitude;
			g /= magnitude;
			b /= magnitude;
			a /= magnitude;

			return *this;
		}

		Vector4<Type>& Reflect() noexcept
		{
			r *= -1;
			g *= -1;
			b *= -1;
			a *= -1;

			return *this;
		}

		Vector4<Type> operator+( const Vector4<Type>& other ) const noexcept
		{
			return Vector4<Type>( r + other.r, g + other.g, b + other.b, a + other.a );
		}

		Vector4<Type> operator-( const Vector4<Type>& other ) const noexcept
		{
			return Vector4<Type>( r - other.r, g - other.g, b - other.b, a - other.a );
		}

		Type operator*( const Vector4<Type>& other ) const noexcept
		{
			return ( ( r * other.r ) + ( g * other.g ) + ( b * other.b ) ) + ( a * other.a );
		}

		// Vector-to-scalar operations.
		Vector4<Type> operator/ ( const Type other ) const noexcept
		{
			return Vector4<Type>( r / other, g / other, b / other, a / other );
		}

		Vector4<Type> operator+ ( const Type other ) const noexcept
		{
			return Vector4<Type>( r + other, g + other, b + other, a + other );
		}

		Vector4<Type> operator- ( const Type other ) const noexcept
		{
			return Vector4<Type>( r - other, g - other, b - other, a - other );
		}

		Type Dot( const Vector4<Type>& other ) const noexcept
		{
			return ( *this * other );
		}
	};

	template <class Type>
	Vector4<Type> operator* ( const Vector3<Type>& vector, Type scalar ) noexcept
	{
		return Vector4<Type>( vector.r* scalar, vector.g* scalar, vector.b* scalar, vector.a* scalar );
	}

	template <class Type>
	Vector4<Type> operator* ( Type scalar, const Vector4<Type>& vector) noexcept
	{
		return Vector4<Type>( vector.r * scalar, vector.g * scalar, vector.b * scalar, vector.a * scalar );
	}

	// Basic Vector4 examples.
	template class Vector4<uint8>;
	template class Vector4<uint16>;
	template class Vector4<uint32>;

	template class Vector4<int8>;
	template class Vector4<int16>;
	template class Vector4<int32>;

	template class Vector4<float>;
	template class Vector4<double>;

	typedef class Vector4<float> CoreVec4;
}