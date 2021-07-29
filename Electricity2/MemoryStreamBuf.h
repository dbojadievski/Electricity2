#pragma once
#include "CoreTypes.h"

#include <assert.h>
#include <streambuf>
#include <istream>

class MemoryStreambuf : public std::streambuf
{
public:
	MemoryStreambuf(byte * pMem, uint64 uSize)
		: m_pMem( pMem )
		, m_uSize( uSize )
	{
		char* p( reinterpret_cast< char* >( m_pMem ) );
		this->setg( p, p, p + uSize );
	}

	~MemoryStreambuf()
	{
		m_uSize = 0;
		delete[] m_pMem;
	}

private:
	byte* m_pMem;
	uint64			m_uSize;
};

class MemoryStream : public std::istream
{
public:
	MemoryStream( MemoryStreambuf& streamBuf ) :
		 m_streamBuf( streamBuf )
		,std::istream(static_cast<std::streambuf*>(&m_streamBuf))
	{

	}

	MemoryStream( byte* pMem, uint32 uSize ) :
		 m_streamBuf( MemoryStreambuf( pMem, uSize ) )
		,std::istream( static_cast< std::streambuf* >( &m_streamBuf ) )

	{

	}
private:
	MemoryStreambuf m_streamBuf;
};