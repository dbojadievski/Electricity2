#include "UUID.h"

namespace Electricity
{
	UUID::UUID() noexcept :
		  m_Hi( 0 )
		, m_Lo( 0 )
	{

	}

	bool
	UUID::operator==( const UUID& other ) const noexcept
	{
		return ( m_Hi == other.m_Hi && m_Lo == other.m_Lo );
	}

	bool
	UUID::operator!=( const UUID& other ) const noexcept
	{
		return ( m_Hi != other.m_Hi || m_Lo != other.m_Lo );
	}

	bool
	UUID::operator<( const UUID& other ) const noexcept
	{
		if ( m_Hi < other.m_Hi )
			return true;
		else if ( m_Hi == other.m_Hi && m_Lo < other.m_Lo )
			return true;
		else
			return false;
	}

	UUID
	UUID::NewUUID() noexcept
	{
		UUID uuid;
		byte auBytes[ 16 ] = { 0 };
		Platform::Utils::GetNewUUID(auBytes);
		for ( byte idx = 0; idx < 16; idx++ )
		{
			uuid.m_RawBytes[ idx ] = auBytes[ idx ];
		}

		return uuid;
	}
}

