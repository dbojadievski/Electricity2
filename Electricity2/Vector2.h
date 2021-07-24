#pragma once

#include "CoreTypes.h"

namespace Electricity::Math
{
	template <class Type>
	class Vector2
	{
	public:
		union
		{
			union
			{
				Type r, g;
			};
			union
			{
				Type x, y;
			};
			Type m_aData[ 2 ];
		};

		Vector2() noexcept
		{
			r = g = 0;
		}

		Vector2( Type InR, Type InG ) noexcept
		{
			r = InR;
			g = InG;
		}

		Vector2( const Vector2<Type>& other ) noexcept
		{
			r = other.r;
			g = other.g;
		}

		Vector2( Vector2<Type>&& other ) noexcept
		{
			r = other.r;
			g = other.g;
			
			other.r = other.g = 0;
		}

		~Vector2() noexcept
		{
			r = g = 0;
		}

		Vector2& operator= ( const Vector2<Type>& other ) noexcept
		{
			r = other.r;
			g = other.g;

			return *this;
		}

		bool operator==( const Vector2<Type>& other ) noexcept
		{
			return ( ( r == other.r ) && ( g == other.g ) );
		}

		Type Magnitude() const noexcept
		{
			const Type d = ( r * r ) + ( g * g );
			const Type root = static_cast<Type>( sqrt( d ) );

			return root;
		}

		Vector2<Type>& Normalize() noexcept
		{
			const Type fMagnitude = Magnitude();

			r /= fMagnitude;
			g /= fMagnitude;

			return *this;
		}

		Vector2<Type>& Reflect() noexcept
		{
			r = r * -1;
			g = g * -1;

			return *this;
		}

		Type operator* ( const Vector2<Type>& other ) const noexcept
		{
			return ( r * other.r ) + ( g * other.g );
		}

		Vector2<Type> operator+( const Vector2<Type>& other ) const noexcept
		{
			return Vector2<Type>( r + other.r, g + other.g );
		}

		Vector2<Type> operator-( const Vector2<Type>& other ) const noexcept
		{
			return Vector2<Type>( r - other.r, g - other.g );
		}

		Vector2<Type> operator/ ( const Type other ) const noexcept
		{
			return Vector2( r / other, g / other );
		}

		Vector2<Type> operator+ ( const Type other ) const noexcept
		{
			return Vector2( r + other, g + other );
		}

		Vector2<Type> operator- ( const Type other ) const noexcept
		{
			return Vector2( r - other, g - other );
		}

		Type Dot( const Vector2<Type>& other ) const noexcept
		{
			return ( *this * other );
		}
	};

	template <class Type>
	Vector2<Type> operator*( Type scalar, const Vector2<Type>& vector ) noexcept
	{
		return Vector2<Type>( scalar * vector.r, scalar * vector.g );
	}

	template <class Type>
	Vector2<Type> operator*( const Vector2<Type>& vector, Type scalar ) noexcept
	{
		return Vector2<Type>( scalar * vector.r, scalar * vector.g );
	}

	// Basic Vector2 examples.
	template class Vector2<uint8>;
	template class Vector2<uint16>;
	template class Vector2<uint32>;

	template class Vector2<int8>;
	template class Vector2<int16>;
	template class Vector2<int32>;

	template class Vector2<float>;
	template class Vector2<double>;

	typedef class Vector2<float> CoreVec2;
}