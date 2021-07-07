#pragma once

#include "CoreTypes.h"
#include <string>
#include <vector>

using std::string;
using std::vector;

class UnitTestManager;
typedef bool ( * UnitTestFunction ) ( void );

class UnitTest
{
	friend class UnitTestManager;
public:
	UnitTest( const char* ) noexcept;

	virtual ~UnitTest() { }
private:
	bool operator==( const UnitTest& Other ) const noexcept;
	bool operator==( const string& Other ) const noexcept;
	virtual bool operator()() const { throw "Class must override this implementation"; };
	const string		m_strName;
};


class UnitTestManager
{
public:
	bool HasTest( const string& Name ) const noexcept;
	const UnitTest* FindTest( const string& Name ) const noexcept;
	bool Register( UnitTest& Test ) noexcept;

	static UnitTestManager& GetInstance() noexcept;
	bool RunUnitTest( const string& Name ) const;
	void RunAllUnitTests() const;
private:
	UnitTestManager() noexcept {}
	
	vector<UnitTest>		m_Tests;
	static UnitTestManager	s_Instance;
};