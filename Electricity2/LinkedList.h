#pragma once
template <class DataType>
class ListNode
{
public:
	DataType m_Data;

	ListNode() noexcept
		: m_Data( nullptr )
		, m_pPrev( nullptr )
		, m_pNext( nullptr ) 
	{
	}

	ListNode( const DataType& InOriginal ) noexcept
		: m_Data( InOriginal )
		, m_pPrev( nullptr )
		, m_pNext( nullptr )
	{

	}

	ListNode( const ListNode<DataType>& InOriginal ) noexcept
		: m_Data( InOriginal.m_Data )
		, m_pPrev( InOriginal.m_pPrev )
		, m_pNext( InOriginal.m_pNext )
	{

	}

	ListNode( ListNode<DataType>&& InOriginal ) noexcept
		: m_Data( InOriginal.m_Data )
		, m_pPrev( InOriginal.m_pPrev )
		, m_pNext( InOriginal.m_pNext )
	{
		InOriginal.m_Data = { }; // Weird hack to initialize templates to default value. Works for built-ins, too.
		InOriginal.m_pPrev = nullptr;
		InOriginal.m_pNext = nullptr;
	}

	ListNode<DataType>& operator=( const ListNode<DataType>& InOriginal ) noexcept
	{
		m_Data = InOriginal.m_Data;

		m_pPrev = InOriginal.m_pPrev;
		m_pNext = InOriginal.m_pNext;

		return this;
	}

	bool operator== ( const ListNode<DataType>& InOther ) const noexcept
	{
		return ( m_Data == InOther.m_Data )
			&& ( m_pPrev == InOther.m_pPrev )
			&& ( m_pNext == InOther.m_pNext );
	}

	const DataType GetValue() noexcept
	{
		return m_Data;
	}

	const bool IsHead() noexcept
	{
		return ( m_pPrev == nullptr );
	}

	const bool IsTail() noexcept
	{
		return ( m_pNext == nullptr );
	}

	const bool IsMiddle() noexcept
	{
		return !IsHead() && !IsTail();
	}

	ListNode<DataType>* GetPrev() const noexcept { return m_pPrev; }
	ListNode<DataType>* GetNext() const noexcept { return m_pNext; }

	ListNode<DataType>& GetHead() noexcept
	{
		ListNode<DataType>* pHead = this;
		while ( pHead->m_pPrev )
		{
			pHead = pHead->m_pPrev;
		}

		return *pHead;
	}

	ListNode<DataType>& GetTail() noexcept
	{
		ListNode<DataType>* pTail = this;
		while ( pTail->m_pNext )
		{
			pTail = pTail->m_pNext;
		}

		return *pTail;
	}

	void Insert( ListNode<DataType>& InToInsert ) noexcept
	{
		ListNode<DataType>* pNext = m_pNext;

		m_pNext = &InToInsert;
		InToInsert.m_pPrev = this;

		if ( pNext )
		{
			pNext->m_pPrev = &InToInsert;
		}

		InToInsert.m_pNext = pNext;
	}

	void PrependTo( ListNode<DataType>& InList ) noexcept
	{
		assert( InList.IsHead() );

		ListNode<DataType>& Head	= InList.GetHead();
		this->m_pNext				= Head;
		Head.m_pPrev				= this;
	}

private:
	ListNode<DataType>* m_pPrev;
	ListNode<DataType>* m_pNext;
};