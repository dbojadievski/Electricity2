#pragma once
#include <assert.h>
#include "CoreTypes.h"
#include "UnitTests.h"

#include "CommandLineParser.h"

class UnitTest_CmdLineParser : UnitTest
{
public:
	UnitTest_CmdLineParser() noexcept : UnitTest( "UnitTest_CmdLineParser" ) {}
private:
	typedef std::string String;
	void ParseSingleParameter() const
	{
		CommandLineParser parser("x=5");
		parser.Initialize();
		String sVal;

		assert( parser.GetNumParams() == 1 );
		assert( parser.GetValue( "x", sVal ) );
		assert( sVal == "5" );
	}

	void ParseMultipleParameters() const
	{
		CommandLineParser parser( "x=5 y=2" );
		parser.Initialize();
		
		assert( parser.GetNumParams() == 2 );
		
		String sX;
		assert( parser.GetValue( "x", sX ) );
		assert( sX == "5" );

		String sY;
		assert( parser.GetValue( "y", sY ) );
		assert( sY == "2" );

	}

	void ParseFlag() const
	{
		CommandLineParser parser( "--debug");
		parser.Initialize();

		assert( parser.GetNumParams() == 1 );
		
		String sFlag;
		assert( parser.GetValue( "--debug", sFlag ) );
		assert( sFlag == "" );
	}

	void ParseStringParam() const
	{
		CommandLineParser parser( "path=\"C:\\\\local\"" );
		parser.Initialize();

		assert( parser.GetNumParams() == 1);
		
		String sPath;
		assert( parser.GetValue( "path", sPath ) );
		assert( sPath == "\"C:\\\\local\"" );
	}

public:
	virtual bool operator()() const
	{
		ParseSingleParameter();
		ParseMultipleParameters();
		ParseFlag();
		ParseStringParam();

		return true;
	}
};

UnitTest_CmdLineParser unitTestsParser;