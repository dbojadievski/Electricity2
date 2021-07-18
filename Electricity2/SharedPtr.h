#pragma once

#include "CoreTypes.h"
#include <atomic>

using std::atomic;

template <class Type>
class SharedPtr
{
public:
	SharedPtr() noexcept
		: m_pData( nullptr )
		, m_puiRefCount( new atomic<uint32>( 1 ) )
	{
	};

	SharedPtr( Type* pData ) noexcept
		: m_pData( pData )
		, m_puiRefCount( new atomic<uint32>( 1 ) )
	{
	}

	SharedPtr<Type>( const SharedPtr<Type>& InOriginal ) noexcept
		: m_pData( InOriginal.m_pData )
		, m_puiRefCount( InOriginal.m_puiRefCount )
	{
		AddRefIfValid();
	}

	SharedPtr* operator= ( SharedPtr& InOriginal ) noexcept
	{
		if ( InOriginal != this )
		{
			m_pData = InOriginal.m_pData;
			m_puiRefCount = InOriginal.m_puiRefCount;

			AddRefIfValid();
		}

		return this;
	}

	bool operator==( const SharedPtr& InOriginal ) const noexcept
	{
		return ( m_pData == InOriginal.m_pData );
	}

	bool operator==( SharedPtr& InOriginal ) const noexcept
	{
		return ( m_pData == InOriginal.m_pData );
	}

	SharedPtr( SharedPtr&& InOriginal ) noexcept
		: m_pData( InOriginal.m_pData )
		, m_puiRefCount( InOriginal.m_puiRefCount )
	{
		InOriginal.m_pData = nullptr;
		InOriginal.m_puiRefCount = nullptr;
	}

	SharedPtr& operator=( SharedPtr<Type>&& InOriginal ) noexcept
	{
		if ( &InOriginal != this )
		{
			m_pData = InOriginal.m_pData;
			m_puiRefCount = InOriginal.m_puiRefCount;

			InOriginal.m_pData = nullptr;
			InOriginal.m_puiRefCount = nullptr;
		}

		return *this;
	}

	template <typename DerivedType>
	SharedPtr( SharedPtr<DerivedType>& InOriginal ) noexcept
		: m_pData( InOriginal.m_pData )
		, m_puiRefCount( InOriginal.m_puiRefCount )
	{
		AddRefIfValid();
	}

	template <typename DerivedType>
	SharedPtr* operator= ( SharedPtr<DerivedType>& InOriginal ) noexcept
	{
		if ( InOriginal != this )
		{
			m_pData = InOriginal.m_pData;
			m_puiRefCount = InOriginal.m_puiRefCount;
		}

		AddRefIfValid();

		return this;
	}

	template <typename DerivedType>
	SharedPtr( SharedPtr<DerivedType>&& InOriginal ) noexcept
		: m_pData( InOriginal.m_pData )
		, m_puiRefCount( InOriginal.m_puiRefCount )
	{
		InOriginal.m_pData			= nullptr;
		InOriginal.m_puiRefCount	= nullptr;
	}

	template <typename DerivedType>
	SharedPtr& operator=( SharedPtr&& InOriginal ) noexcept
	{
		if ( InOriginal != this )
		{
			m_pData			= InOriginal.m_pData;
			m_puiRefCount	= InOriginal.m_puiRefCount;

			InOriginal.m_pData			= nullptr;
			InOriginal.m_puiRefCount	= nullptr;
		}
	}

	SharedPtr( std::nullptr_t ) noexcept
		: m_pData( nullptr )
		, m_puiRefCount( new atomic<uint32>( 1 ) )
	{
	}

	~SharedPtr() noexcept
	{
		if ( IsValid() )
		{
			RemoveRef();
		}
	};

	Type* Get() const noexcept
	{
		return m_pData;
	}

	Type* operator->() const noexcept
	{
		return m_pData;
	}

	bool IsValid() const noexcept
	{
		return ( m_pData && m_puiRefCount->load() );
	}

	bool IsEmpty() const noexcept
	{
		return ( !m_pData && m_puiRefCount->load() );
	}

	uint32 GetRefCount() const noexcept
	{
		return m_puiRefCount->load();
	}

private:
	void AddRef() noexcept
	{
		m_puiRefCount->fetch_add( 1 );
	}

	void AddRefIfValid() noexcept
	{
		if ( IsValid() )
		{
			AddRef();
		}
	}

	void RemoveRef() noexcept
	{
		if ( IsValid() )
		{
			m_puiRefCount->fetch_sub( 1 );
			if ( !m_puiRefCount )
			{
				delete m_pData;
			}
		}
	}

public:
	Type* m_pData;
	atomic<uint32>* m_puiRefCount;
};