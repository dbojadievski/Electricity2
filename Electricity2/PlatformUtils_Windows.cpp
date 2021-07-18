#ifdef _WIN32
#include "PlatformUtils.h"

#define WIN32_LEAN_AND_MEAN
#include <assert.h>
#include <guiddef.h>
#include <combaseapi.h>

namespace Platform::Utils
{
	void 
	GetNewUUID( byte* aBytes ) noexcept
	{
		GUID guid	= {};
		HRESULT result = CoCreateGuid( &guid );
		assert( result == S_OK );
		byte* sourceAsBytes = reinterpret_cast< byte* >( &guid );
		for ( int idx = 0; idx < 16; idx++ )
		{
			aBytes[ idx ] = sourceAsBytes[ idx ];
		}

		CopyMemory( &aBytes, &guid, sizeof( guid ) );
	}
}
#endif