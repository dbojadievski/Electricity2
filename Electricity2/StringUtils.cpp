#include "StringUtils.h"
#include <algorithm>

namespace Electricity::Utils
{

	void
	ExplodeString( const String& sString, StringArray& aTokens, const char delimiter /* = " " */ )
	{
		// Sample case:
		// meaning=42 senselessness=41
		uint32 uIdxTokenStart = 0;

		bool bInToken = false;
		uint32 uLength = sString.length();
		for ( uint32 uIdx = 0; uIdx < uLength; uIdx++ )
		{
			const char c = sString[ uIdx ];
			if ( c == delimiter && bInToken )
			{
				const uint32 uTokenLength = ( uIdx - uIdxTokenStart );
				const String& sToken = sString.substr( uIdxTokenStart, uTokenLength );
				aTokens.push_back( sToken );

				uIdxTokenStart = uIdx + 1;
				bInToken = false;
			}
			else if ( c != delimiter && !bInToken )
			{
				bInToken = true;
				uIdxTokenStart = uIdx;
			}
		}

		// We need to deal with the rest of the buffer.
		if ( bInToken )
		{
			const bool bIsLastDelimiter = ( sString[ uLength ] == delimiter );
			uint32 uTokenLenth = ( bIsLastDelimiter ? uLength - 1 : uLength );
			const String& sToken = sString.substr( uIdxTokenStart, uTokenLenth );
			aTokens.push_back( sToken );
		}
	}

	String&
	TrimFront( String& sString ) noexcept
	{
		uint32 uLen = sString.size();
		char* pStr = sString.data();
		uint32 uFirstNonString = -1;
		for ( uint32 uIdx = 0; uIdx < uLen; uIdx++ )
		{
			if ( !iswspace( pStr[uIdx] ) )
			{
				uFirstNonString = uIdx;
				break;
			}
		}

		if ( uFirstNonString != -1 )
		{
			sString = sString.substr( uFirstNonString, std::string::npos );
		}

		return sString;
	}

	String&
	TrimBack( String& sString ) noexcept
	{
		uint32 uLen = sString.size();
		char* pStr = sString.data();
		uint32 uFirstNonString = -1;
		for ( uint32 uIdx = sString.size(); uIdx > 0; uIdx-- )
		{
			if ( !iswspace( pStr[ uIdx ] ) )
			{
				uFirstNonString = uIdx;
				break;
			}
		}

		if ( uFirstNonString != -1 )
		{
			sString = sString.substr( 0, uFirstNonString );
		}

		return sString;
	}

	String&
	ToLower( String& sString ) noexcept
	{
		std::transform( sString.begin(), sString.end(), sString.begin(), [] ( unsigned char c ) { return std::tolower( c ); } );
		return sString;
	}

	String&
	ToUpper( String& sString ) noexcept
	{
		std::transform( sString.begin(), sString.end(), sString.begin(), [] ( unsigned char c ) { return std::toupper( c ); } );
		return sString;
	}

	bool
	StringToInteger( const String& sString, int32& iResult ) noexcept
	{
		bool bConverted			= true;
		iResult					= -1;

		int32 iPendingInt		= 0;
		int32 iSignMultiplier	= 1;
		int32 iStartIdx			= 0;

		const uint32 uLen		= sString.length();
		if ( uLen > 0 )
		{
			if ( sString[ 0 ] == '-' )
			{
				iSignMultiplier = -1;
				iStartIdx++;
			}
			else if ( sString[ 0 ] == '+' )
				iStartIdx++;

			uint32 uIdx			= iStartIdx;
			while ( uIdx < uLen )
			{
				const char c = sString[ uIdx ];
				if ( c >= '0' && c <= '9' )
				{
					const int32 iChar = c - (int32) '0';
					iPendingInt *= 10;
					iPendingInt += iChar;
				}
				else
				{
					bConverted = false;
					break;
				}
				uIdx++;
			} // end parse loop
		} // end if string not empty

		if ( bConverted )
			iResult = iSignMultiplier * iPendingInt;
		return bConverted;
	}
}