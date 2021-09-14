#pragma once
#include "CoreTypes.h"
#include "CoreContainers.h"

namespace Electricity::Utils
{
	void ExplodeString( const String& sString, StringArray& aTokens, const char delimiter = ' ' );
	String& TrimFront( String& sString ) noexcept;
	String& TrimBack( String& sString ) noexcept;
	String& ToLower( String& sString ) noexcept;
	String& ToUpper( String& sString ) noexcept;
	
	/// <summary>
	/// Parses a string and converts it into an integer.
	/// </summary>
	/// <param name="sString">The string to parse.</param>
	/// <param name="iResult">The integer value represented, or -1. </param>
	/// <returns>True if the string consists of an entirely valid integer. and nothing else, whitespace included. False otherwise.</returns>
	bool StringToInteger( const String& sString, int32& iResult ) noexcept;
	//template<typename T, typename U>
	//T string_cast( const U& u );


	//template<>
	//String string_cast<String >( const WString& u ) 
	//{
	//	return utf16ToUtf8( u );
	//}

	//template<>
	//WString string_cast< WString >( const String& u ) 
	//{
	//	return utf8ToUtf16( u );
	//}
}