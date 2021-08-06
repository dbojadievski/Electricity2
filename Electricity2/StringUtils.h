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