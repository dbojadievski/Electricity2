#pragma once
#include "UnitTests.h"
#include "StringUtils.h"


#include <assert.h>
class UnitTest_StringUtils : UnitTest
{
public:
	UnitTest_StringUtils() noexcept : UnitTest( "UnitTest_StringUtils" ) { }
private:

	void UnitTest_StringUtils_Explode() const
	{
		String sample = "This is a string";
		
		StringArray aTokens;
		Electricity::Utils::ExplodeString( sample, aTokens );

		assert( aTokens.size() == 4 );
		assert( aTokens[ 0 ] == "This" );
		assert( aTokens[ 1 ] == "is" );
		assert( aTokens[ 2 ] == "a" );
		assert( aTokens[ 3 ] == "string" );
	}

	void UnitTest_StringUtils_TrimFront() const
	{
		String sample = " Should trim";
		Electricity::Utils::TrimFront( sample );
		assert( sample == "Should trim" );
	}

	void UnitTest_StringUtils_TrimBack() const
	{
		String sample = "Should trim ";
		Electricity::Utils::TrimFront( sample );
		assert( sample == "Should trim" );
	}

	void UnitTest_StringUtils_ToLower() const
	{
		String sample = "Sample";
		Electricity::Utils::ToLower( sample );
		assert( sample == "sample" );
	}

	void UnitTest_StringUtils_ToUpper() const
	{
		String sample = "Sample";
		Electricity::Utils::ToUpper( sample );
		assert( sample == "SAMPLE" );
	}

	virtual bool operator()() const
	{
		UnitTest_StringUtils_Explode();
		UnitTest_StringUtils_TrimFront();
		UnitTest_StringUtils_TrimBack();
		UnitTest_StringUtils_ToLower();
		UnitTest_StringUtils_ToUpper();

		return true;
	}
};

UnitTest_StringUtils StringUtilsTest;