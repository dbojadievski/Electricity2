#pragma once

#include "CoreTypes.h"

namespace Electricity::Math
{
	template <class Type>
	class Vector3
	{
	public:
		union
		{
			union
			{
				Type r, g, b;
			};
			union
			{
				Type x, y, z;
			};
			Type m_aData[ 3 ];
		};

		Vector3() noexcept
		{
			r = g = b = 0;
		}

		Vector3( Type InR, Type InG, Type InB ) noexcept
		{
			r = InR;
			g = InG;
			b = InB;
		}

		Vector3( const Vector3<Type>& other ) noexcept
		{
			r = other.r;
			g = other.g;
			b = other.b;
		}

		Vector3( Vector3<Type>&& other ) noexcept
		{
			r = other.r;
			g = other.g;
			b = other.b;

			other.r = other.g = other.b = 0;
		}

		~Vector3() noexcept
		{
			r = g = b = 0;
		}

		Vector3& operator= ( const Vector3<Type>& other ) noexcept
		{
			r = other.r;
			g = other.g;
			b = other.b;

			return *this;
		}

		bool operator==( const Vector3<Type>& other ) noexcept
		{
			return ( ( r == other.r ) && ( g == other.g )  && ( b == other.b ) );
		}

		Type Magnitude() const noexcept
		{
			const Type d = ( r * r ) + ( g * g ) + ( b * b );
			const Type root = static_cast<Type>( sqrt( d ) );

			return root;
		}

		Vector3<Type>& Normalize() noexcept
		{
			const Type magnitude = Magnitude();

			r /= magnitude;
			g /= magnitude;
			b /= magnitude;

			return *this;
		}

		Vector3<Type>& Reflect() noexcept
		{
			r = r * -1;
			g = g * -1;
			b = b * -1;

			return *this;
		}

		Vector3<Type> operator*( const Vector3<Type>& other ) const noexcept
		{
			return Vector3<Type>
				(
				  ( ( g * other.b ) - ( b * other.g ) )
				, ( ( b * other.r ) - ( r * other.b ) )
				, ( ( r * other.g ) - (  g * other.r ) )
			);
		}

		Vector3<Type> operator+( const Vector3<Type>& other ) const noexcept
		{
			return Vector3<Type>( r + other.r, g + other.g, b + other.b );
		}

		Vector3<Type> operator-( const Vector3<Type>& other ) const noexcept
		{
			return Vector3<Type>( r - other.r, g - other.g, b - other.b );
		}


		// Vector-to-scalar operations.

		Vector3<Type> operator/ ( const Type other ) const noexcept
		{
			return Vector3<Type>( r / other, g / other, b / other );
		}

		Vector3<Type> operator+ ( const Type other ) const noexcept
		{
			return Vector3<Type>( r + other, g + other, b + other );
		}

		Vector3<Type> operator- ( const Type other ) const noexcept
		{
			return Vector3<Type>( r - other, g - other, b - other );
		}

		Type Dot( const Vector3<Type>& other ) const noexcept
		{
			return ( ( r * other.r ) + ( g * other.g ) + ( b * other.b ) );
		}

		Vector3<Type> Cross( const Vector3<Type>& other ) const noexcept
		{
			return *this * other;
		}
	};

	template<class Type>
	Vector3<Type> operator* ( const Vector3<Type>& vector, Type scalar ) noexcept
	{
		return Vector3<Type>( vector.r* scalar, vector.g* scalar, vector.b* scalar );
	}

	template<class Type>
	Vector3<Type> operator*( Type scalar, const Vector3<Type>& vector ) noexcept
	{
		return Vector3<Type>( vector.r * scalar, vector.g * scalar, vector.b * scalar );
	}

	// Basic Vector3 examples.
	template class Vector3<uint8>;
	template class Vector3<uint16>;
	template class Vector3<uint32>;

	template class Vector3<int8>;
	template class Vector3<int16>;
	template class Vector3<int32>;

	template class Vector3<float>;
	template class Vector3<double>;

	typedef class Vector3<float> CoreVec3;
}