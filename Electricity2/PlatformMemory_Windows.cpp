#ifdef _WIN32
#include "PlatformMemory.h"

#define WIN32_LEAN_AND_MEAN
#include <windows.h>


DWORD	dwPageSize;
size_t	szLargePageSize;
DWORD	dwAllocGranularity;

HANDLE hHeap;
PROCESS_HEAP_ENTRY Entry;

bool
PlatformMemory::Initialize()
{
	bool bInitialized	= false;

	SYSTEM_INFO sSysInfo;
	GetSystemInfo( &sSysInfo );
	
	dwPageSize			= sSysInfo.dwPageSize;
	dwAllocGranularity	= sSysInfo.dwAllocationGranularity;

	szLargePageSize		= GetLargePageMinimum();
	hHeap				= HeapCreate( 0, ( dwAllocGranularity * 64 ), 0 );
	if ( hHeap )
	{
		bInitialized	= true;
	}

	return bInitialized;
}

bool
PlatformMemory::ShutDown()
{
	bool bShutDown	= true;
	return bShutDown;
}

uint32 
PlatformMemory::GetMinAllocSize() noexcept
{
	const uint32 MinAllocSize	= static_cast<uint32>( dwAllocGranularity );
	return MinAllocSize;
}

void* 
PlatformMemory::InternalAlloc( uint32 uSize )
{
	const SIZE_T szSize = static_cast<SIZE_T>( uSize );
	LPVOID pMem			= HeapAlloc( hHeap, HEAP_ZERO_MEMORY, szSize );
	
	return pMem;
}

bool
PlatformMemory::Free( void* pMemory )
{
	return HeapFree( hHeap, 0, pMemory );
}

void
PlatformMemory::Copy( byte* pSource, byte* pDestination, const uint32 uSize ) noexcept
{
	CopyMemory( pDestination, pSource, uSize );
}
#endif