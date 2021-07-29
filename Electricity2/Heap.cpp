#include "Heap.h"
#include "PlatformMemory.h"
#include <malloc.h>
#include <memory.h>
#include <mutex>

using std::lock_guard;
using std::recursive_mutex;
using std::map;

// Heap node implementation.

recursive_mutex Mutex;

inline uint32
GetHeaderedSize( uint32 uSize )
{
	return ( uSize + sizeof( HeapNode ) );
};

inline uint32
GetAlignedSize( uint32 uSize )
{
	return uSize;
}

inline uint32
GetTotalSize( uint32 uSize )
{
	return ( GetAlignedSize( GetHeaderedSize( uSize ) ) );
}

byte*
HeapNode::GetBuffer() const noexcept
{
	return m_Buffer;
}

uint32
HeapNode::GetTotalSize() const noexcept
{
	return ( m_uSize + sizeof( HeapNode ) );
}

HeapNode::HeapNode( byte* sBuffer, const uint32 uSize ) noexcept :
	m_uSize( uSize )
	, m_Buffer( sBuffer ) 
	, m_pNext( nullptr )
#ifdef _DEBUG
	, m_pStrFilePath( nullptr )
	, m_iLineNumber( 0 )
#endif
{
	assert( m_uSize );
	assert( m_Buffer );

}

HeapNode*
HeapNode::Release() noexcept
{
	HeapNode* pNext = m_pNext;
	HeapManager::Release( *this );
	
	return pNext;
}

HeapNode::~HeapNode()
{
	HeapManager::Release( *this );
}

// Heap implementation.
HeapNode* HeapManager::s_pUsedMemory;
HeapNode* HeapManager::s_pFreeMemory;

uint64 HeapManager::s_uTotalMemUsed;
uint64 HeapManager::s_uTotalMemFree;
uint32 HeapManager::s_uMemAlignmentSize;

map<byte*, HeapNode*> HeapManager::s_BufToNodeMap;
bool
HeapManager::Initialize()
{
	bool bInitialized	 = false;

	Platform::Memory::Initialize();

	s_uMemAlignmentSize				= Platform::Memory::GetMinAllocSize();
	const uint32 HEAP_INIITAL_SIZE = ( 64 * 1024 * 1024 ); // 64 MB.
	HeapNode* pInitialHeap			= ReservePage( HEAP_INIITAL_SIZE );

	bInitialized					= ( pInitialHeap != nullptr );
	return bInitialized;
}

bool
HeapManager::ShutDown()
{
	bool bIsShutDown		= true;
	s_uMemAlignmentSize		= 0;

#ifdef _DEBUG
	CheckForMemoryLeak();
#else
	bIsShutDown				= true;
#endif

	// Give all memory back to the operating system.
	// Both free and used memory is reserved by the OS for us.
	// So, we need to release both!
	while ( s_pUsedMemory )
		s_pUsedMemory		= ReleasePage( *s_pUsedMemory );

	while ( s_pFreeMemory )
		s_pFreeMemory		= ReleasePage( *s_pFreeMemory );

	return bIsShutDown;
}

bool
HeapManager::HasAvailable( uint32 uSize ) noexcept
{
	const uint32 uTotalSize = GetTotalSize( uSize );
	return ( uTotalSize <= uTotalSize );
}

HeapNode*
HeapManager::Allocate( const uint32 uSize, 
#ifdef _DEBUG
	const char* szFile, size_t uLineNumber,
	#endif
	byte* InitialContent /* = nullptr */ 
) noexcept
{
	lock_guard<recursive_mutex> Lock( Mutex ); // Automatically releases mutex when out of scope.

	HeapNode* pNode = HeapManager::FindBestFit( uSize );
	if ( !pNode )
		pNode		= ReservePage( uSize, InitialContent );
	else if ( pNode->GetTotalSize() >= 2 * GetTotalSize( uSize ) )
	{
		uint32 uLine				= pNode->m_iLineNumber;
		const char* pStrFile		= pNode->m_pStrFilePath;
		HeapNode* pNext				= pNode->m_pNext;
		
		// Split node to the requested size, and keep the remainder.
		const uint32 uExpectedSize = GetTotalSize( uSize );

		byte* pBuffer				= reinterpret_cast<byte *>( pNode );
		uint32 uBufSize				= pNode->GetTotalSize();
		uint32 uStartSize			= pNode->m_uSize;
		
		HeapNode* pRequested		= ( HeapNode* ) pBuffer;
#ifdef _DEBUG
		pRequested->m_iLineNumber	= uLineNumber;
		pRequested->m_pStrFilePath	= szFile;
#endif
		pRequested->m_uSize			= uSize;
		pRequested->m_Buffer		= pBuffer + sizeof( HeapNode );
		pNode						= pRequested;
		
		uint32 uReqNodeSize			= pRequested->GetTotalSize();
		// Align the node to cache-friendly size.
		pRequested->m_uSize			+= (uExpectedSize - uReqNodeSize);
		uReqNodeSize				= pRequested->GetTotalSize();
		assert( uReqNodeSize == uExpectedSize );

		const uint32 uRemainingSize = ( uBufSize - uReqNodeSize );
		byte * pRemainingBuffer		= ( pBuffer + uReqNodeSize );
		HeapNode* pRemaining		= reinterpret_cast<HeapNode*>( pRemainingBuffer );
#ifdef _DEBUG
		pRemaining->m_iLineNumber	= uLine;
		pRemaining->m_pStrFilePath	= pStrFile;
#endif
		pRemaining->m_pNext			= pNext;
		pRemaining->m_uSize			= ( uRemainingSize - sizeof( HeapNode ) );
		pRemaining->m_Buffer		= pRemainingBuffer + sizeof( HeapNode );
		MarkFree( pRemaining );
		uint32 uRemNodeSize			= pRemaining->GetTotalSize();

		//Align the node to cache-friendly size.
		const uint32 uAlignedSize	= GetAlignedSize( pRemaining->m_uSize );
		pRemaining->m_uSize			+= ( uAlignedSize - pRemaining->m_uSize ); 
		uRemNodeSize				= pRemaining->GetTotalSize();
		
		const uint32 uTotalSize		= ( uReqNodeSize + uRemNodeSize );
		const uint32 uSizeDiff		= ( uBufSize - uTotalSize );
		assert( uSizeDiff == 0 );
	}
	// Page reservation may fail, if:
	// 1. The OS decides we've become chonky enough,
	// 2. We've eaten all the actual virtual memory the OS is capable of handling,
	// 3. We've enabled hard RAM limits and nommed them all. 
	// TODO(Dino): Think of a way to let the higher ups exit gracefully.
	assert( pNode );
	if ( pNode )
	{
		MarkUsed( 
			pNode 
#ifdef _DEBUG
			, szFile, uLineNumber
#endif
		);
	}

	return pNode;
}

void
HeapManager::Release( HeapNode& Node ) noexcept
{
	lock_guard<recursive_mutex> Lock( Mutex ); // Automatically releases mutex when out of scope.
	MarkFree( &Node );
}

HeapNode*
HeapManager::FindFirstFit( const uint32 uSize ) noexcept
{
	HeapNode* pFirstFit		= nullptr;

	HeapNode* pPrevNode		= nullptr;
	HeapNode* pCurrNode		= s_pFreeMemory;

	while ( pCurrNode )
	{
		if ( pCurrNode->m_uSize >= uSize )
		{
			pFirstFit		= pCurrNode;
			break;
		}

		pPrevNode = pCurrNode;
		pCurrNode = pCurrNode->m_pNext;
	}

	// If we did find some memory, remove it from the free mem list.
	if ( pCurrNode )
	{
		if ( pPrevNode )
			pPrevNode->m_pNext = pCurrNode->m_pNext;
		else
			s_pFreeMemory = nullptr;

	}

	assert( !pFirstFit || pFirstFit->m_Buffer );
	return pFirstFit;
}

HeapNode*
HeapManager::FindBestFit( const uint32 uSize ) noexcept
{
	HeapNode* pBestFit		= nullptr;

	uint32 uBestDiff		= -1;

	HeapNode* pPrevNode		= nullptr;
	HeapNode* pCurrNode		= s_pFreeMemory;
	
	while ( pCurrNode )
	{
		// Best-case scenario: found an exact fit.
		// We won't find a better one than this!
		if ( pCurrNode->m_uSize == uSize )
		{
			pBestFit		= pCurrNode;
			break;
		}
		
		if ( pCurrNode->m_uSize > uSize )
		{
			if ( pBestFit )
			{
				const uint32 uDiff	= ( pCurrNode->m_uSize - uSize );
				if ( uDiff < uBestDiff )
				{
					pBestFit		= pCurrNode;
					uBestDiff		= uDiff;
				}
			}
			else
			{
				pBestFit	= pCurrNode;
				uBestDiff	= 0;
			}
		}

		pPrevNode	= pCurrNode;
		pCurrNode	= pCurrNode->m_pNext;
	}

	// If we did find some memory, remove it from the free mem list.
	if ( pCurrNode )
	{
		if ( pPrevNode )
			pPrevNode->m_pNext = pCurrNode->m_pNext;
		else
			s_pFreeMemory = nullptr;
	}
	
	assert( !pBestFit || pBestFit->m_Buffer );
	return pBestFit;
}

void
HeapManager::MarkFree( HeapNode* pNode ) noexcept
{
	if ( s_pFreeMemory )
		s_pFreeMemory->m_pNext	= pNode;
	else
		s_pFreeMemory			= pNode;

	s_uTotalMemFree				+= pNode->m_uSize;
	s_uTotalMemUsed				-= pNode->m_uSize;
}

void
HeapManager::MarkUsed( HeapNode* pNode
#ifdef _DEBUG
	, const char* szFile, size_t uLineNumber
#endif
) noexcept
{
#ifdef _DEBUG
	pNode->m_pStrFilePath		= szFile;
	pNode->m_iLineNumber		= uLineNumber;
#endif

	if ( s_pUsedMemory )
		s_pUsedMemory->m_pNext	= pNode;
	else
		s_pUsedMemory			= pNode;
	pNode->m_pNext				= nullptr; // This is now our last used node.

	s_uTotalMemUsed				+= pNode->m_uSize;
	s_uTotalMemFree				-= pNode->m_uSize;
}

HeapNode* 
HeapManager::ReservePage( const uint32 uSize, byte* InitialContent /* = nullptr */ )
{
	HeapNode* pPageNode			= nullptr;
	
	// Reserve the actual memory.
	const uint32 uHeaderedSize	= GetHeaderedSize( uSize );
	const uint32 uAlignedSize	= GetAlignedSize( uHeaderedSize );
	byte* pMemory				= reinterpret_cast<byte*>( Platform::Memory::InternalAlloc( uHeaderedSize >= s_uMemAlignmentSize ? uHeaderedSize : s_uMemAlignmentSize ) );
	if ( pMemory )
	{
		// Now use the memory to construct the node, consisting of both payload and metadata.
		byte* pData				= ( pMemory + sizeof( HeapNode ) );
		pPageNode				= reinterpret_cast<HeapNode*>( pMemory );
		pPageNode->m_Buffer		= pData;
		pPageNode->m_uSize		= uSize;
		if ( InitialContent )
		{
			// NOTE(Dino):
			// We don't really have a way of validating this second buffer is of the same size.
			// We'll just have to trust the higher levels to pass the right stuff.
			// And pray we don't explode into a cloud of security vulnerabilities.
			Platform::Memory::Copy( InitialContent, pData, uSize );
		}

		MarkFree( pPageNode );
	}

	return pPageNode;
}

HeapNode *
HeapManager::ReleasePage( HeapNode& Node )
{
	HeapNode* pNext = Node.m_pNext;

	// NOTE(Dino):
	// Platform dealloc is designed to return the memory to the OS entirely.
	// It should be entirely unavailable for writing to us afterwards.
	// So, we have to clear the struct beforehand.
	Node.m_uSize	= 0;
	Node.m_pNext	= nullptr;
	Node.m_Buffer	= nullptr;

	assert( Platform::Memory::Free( &Node ) );


	return pNext;
}

#ifdef _DEBUG
void
HeapManager::CheckForMemoryLeak()
{
	if ( s_pUsedMemory )
	{
		std::string strMessage = "";
		strMessage = "Block size ";
		strMessage.append( std::to_string(s_pUsedMemory->m_uSize));
		strMessage.append("leaked from file ");
		strMessage.append( s_pUsedMemory->m_pStrFilePath );
		strMessage.append( " line #" );
		strMessage.append(std::to_string(s_pUsedMemory->m_iLineNumber));

		throw strMessage.c_str();
	}
}

#endif

void* 
Electricity_Malloc( const size_t cbSize 
	#ifdef _DEBUG
	,const char* szFile
	, size_t nLineNo
	#endif
 
)
{
	HeapNode *pNode = HeapManager::Allocate( cbSize
#ifdef _DEBUG
		, szFile, nLineNo
#endif
	);

	// Track buffer for deletion purposes.
	auto pair = std::make_pair( pNode->GetBuffer(), pNode );
	HeapManager::s_BufToNodeMap.insert( pair );

	return pNode->GetBuffer();
}

void 
Electricity_Free( void* pBuffer )
{
	assert( pBuffer );
	
	byte* pByteBuffer	= static_cast< byte* >( pBuffer );
	// NOTE(Dino):
	// Stack allocations won't go through new, but will still result in the destructor call.
	// That'll cause us to end up here, but not finding anything.
	if ( HeapManager::s_BufToNodeMap.size() > 0 )
	{
		auto pair			= HeapManager::s_BufToNodeMap.find( pByteBuffer );
		if ( pair != HeapManager::s_BufToNodeMap.end() )
		{
			HeapNode* pNode		= pair->second;
			pNode->Release();
		}
	}
}

void*
operator new( size_t n
#ifdef _DEBUG
	, const char* szFile
	, size_t nLineNo
#endif
	)
{

	return Electricity_Malloc( n
#ifdef _DEBUG
		, szFile
		, nLineNo
#endif
	);
}

void*
operator new[]( size_t n
#ifdef _DEBUG
	, const char* szFile
	, size_t nLineNo
#endif
	)
{
	return Electricity_Malloc( n
#ifdef _DEBUG
		, szFile
		, nLineNo
#endif
	);
}

void
operator delete( void* pBuffer )
{
	Electricity_Free( pBuffer );
}
