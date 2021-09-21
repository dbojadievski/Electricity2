#include "MemUtils.h"

#include <assert.h>
namespace Electricity::Utils::Memory
{
	void
	Clear( void* pMem, const uint32 uSize ) noexcept
	{
		assert( pMem );
		assert( uSize );
		
		byte* pData = static_cast<byte*>( pMem );
		for ( uint32 uIdx = 0; uIdx < uSize; uIdx++ )
		{
			pData[ uIdx ] = 0;
		}
	}
}