#pragma once
#include "CoreTypes.h"

template <class Type>
class UniquePtr
{
public:
	UniquePtr() = delete;
	explicit UniquePtr( Type* InData ) noexcept
		:m_pData( InData )
	{

	}

	UniquePtr( const UniquePtr& InOther ) = delete;
	UniquePtr( const UniquePtr&& InOther ) noexcept
	{
		if ( this != InOther )
		{
			m_pData			= InOther.m_pData;
			InOther.m_pData = nullptr;
		}
	}
	UniquePtr& operator=( UniquePtr& InOther ) = delete;
	UniquePtr& operator=( UniquePtr&& InOther ) noexcept
	{
		if ( this != InOther )
		{
			m_pData			= InOther.m_pData;
			InOther.m_pData = nullptr;
		}
	}

	template <typename DerivedType>
	UniquePtr( UniquePtr<DerivedType>& InOther ) = delete;

	template <typename DerivedType>
	UniquePtr& operator=( UniquePtr<DerivedType>& InOther ) = delete;

	template <typename DerivedType>
	UniquePtr( UniquePtr<DerivedType>&& InOther ) noexcept
	{

		m_pData = InOther.m_pData;
		InOther.m_pData = nullptr;
	}

	template <typename DerivedType>
	UniquePtr& operator=( UniquePtr<DerivedType>&& InOther ) noexcept
	{
		if ( this != InOther )
		{
			m_pData = InOther.m_pData;
			InOther.m_pData = nullptr;
		}

		return this;
	}

	Type* Get() const noexcept
	{
		return m_pData;
	}

	Type operator->() const noexcept
	{
		return *m_pData;
	}

	operator bool() const noexcept
	{
		return ( m_pData );
	}

	bool IsValid() const noexcept
	{
		return ( m_pData );
	}

	~UniquePtr() noexcept
	{
		if ( IsValid() )
		{
			delete m_pData;
		}
	}

private:
	Type* m_pData;
};