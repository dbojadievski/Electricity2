#include "UnitTests.h"
#include <assert.h>

UnitTestManager UnitTestManager::s_Instance;

UnitTest::UnitTest( const char* pStrName ) noexcept : 
	m_strName(m_strName)
{
	UnitTestManager::GetInstance().Register( *this );
}

bool 
UnitTest::operator ==( const UnitTest& Other ) const noexcept
{
	return ( m_strName == Other.m_strName );
}

bool 
UnitTest::operator ==( const string& Other ) const noexcept
{
	return ( m_strName == Other );
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*										UnitTestManager implementation.												 */		
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
bool 
UnitTestManager::HasTest( const string& Name ) const noexcept
{
	bool bFound = false;

	for ( const UnitTest& Test : m_Tests )
	{
		if ( Test == Name )
		{
			bFound = true;
			break;
		}
	}

	return bFound;
}

const UnitTest* 
UnitTestManager::FindTest( const string& Name ) const noexcept
{
	const UnitTest* pTest = nullptr;

	for ( const UnitTest& Test : m_Tests )
	{
		if ( Test == Name )
		{
			pTest	= &Test;
			break;
		}
	}

	return pTest;
}

bool 
UnitTestManager::Register( UnitTest& Test ) noexcept
{
	bool bRegistered = false;

	const bool bHasTest = HasTest( Test.m_strName );
	if ( !bHasTest )
	{
		m_Tests.push_back( Test );
	}

	return bRegistered;
}

UnitTestManager& 
UnitTestManager::GetInstance() noexcept
{
	return s_Instance;
}


bool 
UnitTestManager::RunUnitTest( const string& Name ) const
{
	bool bTestPassed		= false;

	const UnitTest* pTest	= FindTest( Name );
	assert( pTest );
	
	bTestPassed				= (*pTest)();
	return bTestPassed;
}

void 
UnitTestManager::RunAllUnitTests() const
{
	for ( const UnitTest& UnitTest : m_Tests )
	{
		UnitTest();
	}
}
