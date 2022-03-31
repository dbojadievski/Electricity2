#pragma once
#include <assert.h>
#include "new.h"
#include <map>

#include "CoreObject.h"
#include "CoreTypes.h"

#include "LinkedList.h"
#include "SharedPtr.h"

#ifdef USE_MEMORY_TRACKING
#define OBJ_CONSTRUCTOR_PARAMS const char* m_pStrFilePath, int32 m_iLineNumber
#else
#define OBJ_CONSTRUCTOR_PARAMS
#endif

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

#ifdef USE_MEMORY_TRACKING
	const char*	m_pStrFilePath;
	int32		m_iLineNumber;
#endif
};

class HeapManager
{
public:
	friend void* Electricity_Malloc( const uint32 cbSize
#ifdef USE_MEMORY_TRACKING
		, const char* szFile
		, uint32 nLineNo
#endif
);
	friend void Electricity_Free( void* pBuffer );

	static bool Initialize();
	static bool ShutDown();

	static bool HasAvailable( uint32 uSize ) noexcept;
	static HeapNode* Allocate( const uint32 uSize
#ifdef USE_MEMORY_TRACKING
		, const char* szFile, const uint32 uLineNumber
#endif
		, byte* InitialContent = nullptr
	) noexcept;
	static void Release( HeapNode& Node ) noexcept;

#ifdef USE_MEMORY_TRACKING
	static bool CheckForMemoryLeak();
#endif
private:
	static HeapNode* FindFirstFit( const uint32 uSize ) noexcept;
	static HeapNode* FindBestFit( const uint32 uSize ) noexcept;
	
	static void MarkFree( HeapNode* pNode ) noexcept;
	static void MarkUsed( HeapNode* pNode ) noexcept;

	static HeapNode * ReservePage( const uint32 uSize, byte* InitialContent = nullptr );
	static HeapNode * ReleasePage( HeapNode& Node );

	static void RemoveFromList( HeapNode* pNode, HeapNode** ppList ) noexcept;
	static void PushToFrontOfList( HeapNode* pNode, HeapNode** ppList ) noexcept;
	static HeapNode* FindInList( HeapNode* pNode, HeapNode* pList ) noexcept;
	static void Untrack( HeapNode* pNode ) noexcept;

	static HeapNode*	s_pUsedMemory;
	static HeapNode*	s_pFreeMemory;

	// Fast cached versions of commonly used data.
	static uint32		s_uMemAlignmentSize;

	static std::map<byte*, HeapNode*> s_BufToNodeMap;
};

void* Electricity_Malloc( uint32 cbSize
#ifdef USE_MEMORY_TRACKING
	, const char* szFile, uint32 nLineNo 
#endif
);

void Electricity_Free( void* pBuffer );

#ifdef USE_MEMORY_TRACKING
	#define gcnew(type) Electricity_Malloc(sizeof(type), __FILE__, __LINE__)
	#define gcalloc(uSize) Electricity_Malloc(uSize, __FILE__, __LINE__)
#else
	#define gcnew(type) Electricity_Malloc(sizeof(type))
	#define gcalloc(uSize) Electricity_Malloc(uSize)
#endif

#define gcfree(pBuf) Electricity_Free(pBuf)
#define gcdelete( pObj ) Electricity_Free( pObj );
	
	template <class Type>
	Type* __GCNew_Raw__
	(
#ifdef USE_MEMORY_TRACKING
		const char* szFile
		, size_t uLineNumber
#endif
	)
	{
		void* pBuffer = new Type(
#ifdef USE_MEMORY_TRACKING
			szFile
			, uLineNumber
#endif
		);
		assert( pBuffer );
		Type* pType = reinterpret_cast< Type* >( pBuffer );
		assert( pType );

		return pType;
	}

	template <class Type>
	SharedPtr<Type> __GCNew__
	(
#ifdef USE_MEMORY_TRACKING
		const char* szFile
		, int32 uLineNumber
#endif
	)
	{
		void* pBuffer = new Type(
#ifdef USE_MEMORY_TRACKING
			szFile
			, uLineNumber
#endif
		);
		assert( pBuffer );
		Type* pType = reinterpret_cast< Type* >( pBuffer );
		assert( pType );

		SharedPtr<Type> asShared( pType );
		return asShared;
	}


#ifdef USE_MEMORY_TRACKING
#define CreateObject(Type) __GCNew__<Type>(__FILE__, __LINE__)
#define CreateObjectRaw(Type) __GCNew_Raw__<Type>(__FILE__, __LINE__)
#else
#define CreateObject(Type) __GCNew__<Type>()
#define CreateObjectRaw(Type) __GCNew_Raw__<Type>()
#endif

template <class Type>
void __GCDelete__( Type* self)
{
	self->~Type(); // Manually call destructor to de-initialise type.
	Electricity_Free( self );
	self = nullptr;
}

#define DeleteObject(object) __GCDelete__(object)

// Function signatures typedef-ed for easy befriending where needed.
#ifdef USE_MEMORY_TRACKING
#define __ALLOC__ void* Electricity_Malloc( const size_t cbSize, const char* szFile, size_t nLineNo)
#else
#define __ALLOC__ void* Electricity_Malloc( const size_t cbSize)
#endif

#define __DEALLOC__ void Electricity_Free( void* pBuffer )