#pragma once
#include <assert.h>
#include <map>

#include "CoreTypes.h"
#include "LinkedList.h"
#include "SharedPtr.h"

class HeapManager;


class HeapNode
{
	friend class HeapManager;
public:
	byte* GetBuffer() const noexcept;
	uint32 GetTotalSize() const noexcept;
	HeapNode* Release() noexcept;
	~HeapNode();
private:
	HeapNode() noexcept = delete;
	HeapNode( const HeapNode& Other ) = delete;
	HeapNode( HeapNode&& Other ) = delete;
	HeapNode& operator=( const HeapNode& Other ) = delete;
	HeapNode& operator=( const HeapNode&& Other ) = delete;
	explicit HeapNode( byte* sbBuffer, const uint32 uSize ) noexcept;

	uint32		m_uSize;
	HeapNode*	m_pNext;

	byte*		m_Buffer;

#ifdef _DEBUG
	const char*	m_pStrFilePath;
	int32		m_iLineNumber;
#endif
};

class HeapManager
{
public:
	friend void* Electricity_New( size_t cbSize, const char* szFile, size_t nLineNo );
	friend void Electricity_Delete( void* pBuffer );

	bool Initialize();
	bool ShutDown();

	static bool HasAvailable( uint32 uSize ) noexcept;
	static HeapNode* Allocate( const uint32 uSize
#ifdef _DEBUG
		, const char* szFile, size_t uLineNumber
#endif
		, byte* InitialContent = nullptr
	) noexcept;
	static void Release( HeapNode& Node ) noexcept;

#ifdef _DEBUG
	static void CheckForMemoryLeak();
#endif
private:
	static HeapNode* FindFirstFit( const uint32 uSize ) noexcept;
	static HeapNode* FindBestFit( const uint32 uSize ) noexcept;
	
	static void MarkFree( HeapNode* pNode ) noexcept;
	static void MarkUsed( HeapNode* pNode
#ifdef _DEBUG
		, const char* szFile, size_t uLineNumber
#endif
	) noexcept;

	static HeapNode * ReservePage( const uint32 uSize, byte* InitialContent = nullptr );
	static HeapNode * ReleasePage( HeapNode& Node );

	static HeapNode*	s_pUsedMemory;
	static HeapNode*	s_pFreeMemory;

	// Fast cached versions of commonly used data.
	static uint64		s_uTotalMemUsed;
	static uint64		s_uTotalMemFree;
	static uint64		s_uMemAlignmentSize;

	static std::map<byte*, HeapNode*> s_BufToNodeMap;
};

void* Electricity_New( size_t cbSize
#ifdef _DEBUG
	, const char* szFile, size_t nLineNo 
#endif
);

void Electricity_Delete( void* pBuffer );

#ifdef _DEBUG
	#define gcnew(type) Electricity_New(sizeof(type), __FILE__, __LINE__)
#else 
	#define gcnew(type) Electricity_New(sizeof(type))
#endif

#define gcdelete( pObj ) Electricity_Delete( pObj );

template <class Type>
SharedPtr<Type> __GCNew__
(
#ifdef _DEBUG
	const char* szFile, size_t uLineNumber
#endif
)
{
	void* pBuffer = Electricity_New(
		sizeof( Type )
#ifdef _DEBUG
		, szFile
		, uLineNumber
#endif
	);
	assert( pBuffer );
	static_cast< byte* >( pBuffer );
	Type* pType = new ( pBuffer ) Type();
	return SharedPtr<Type>( pType );
}
#ifdef _DEBUG
#define CreateObject(Type) __GCNew__<Type>(__FILE__, __LINE__)
#else
#define CreateObject(Type) __GCNew__<Type>()
#endif

template <class Type>
void __GCDelete__( Type* self)
{
	self->~Type(); // Manually call destructor to de-initialise type.
	Electricity_Delete( self );
	self = nullptr;
}

#define DeleteObject(object) __GCDelete__(object)