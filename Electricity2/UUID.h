#pragma once
#include "CoreTypes.h"

#include "PlatformUtils.h"

namespace Electricity
{
	struct UUID
	{
		union
		{
			struct
			{
				uint64 m_Hi;
				uint64 m_Lo;
			};
			struct
			{
				uint32 m_Data32[ 4 ];
			};
			struct
			{
				uint16 m_Data16[ 8 ];
			};
			byte m_RawBytes[ 16 ] = { 0 };
		};

		bool operator == ( const UUID& other ) const noexcept;
		bool operator != ( const UUID& other ) const noexcept;
		bool operator < ( const UUID& other ) const noexcept;

		static UUID NewUUID() noexcept;

	private:
		UUID() noexcept;
	};

	typedef UUID CoreGUID;
}