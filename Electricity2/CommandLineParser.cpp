#include "CommandLineParser.h"
#include <vector>

typedef std::string String;
typedef std::map<String, String> StringMap;
typedef std::vector<String> StringArray;

// Forward declarations of useful utility functions.
void ExplodeString( const String& sString, StringArray& aTokens, const char delimiter = ' ' );

// CommandLineParser implementation.

CommandLineParser::CommandLineParser( String sCmdLine ) noexcept
	: m_sCmdLine( sCmdLine )
{

}

void
CommandLineParser::Initialize( ) noexcept
{
	ParseCmdLine();
}

void
CommandLineParser::ShutDown() noexcept
{
	m_sCmdLine	= "";
	m_mTokens.clear();
}

const String&
CommandLineParser::GetCommandLine() const noexcept
{
	return m_sCmdLine;
}

uint32
CommandLineParser::GetNumParams() const noexcept
{
	return static_cast<uint32>( m_mTokens.size() );
}

bool
CommandLineParser::HasToken( const std::string& sToken ) const noexcept
{
	return ( m_mTokens.find( sToken ) != m_mTokens.end() );
}

bool
CommandLineParser::GetValue( const std::string sToken, std::string& sOutValue ) const noexcept
{
	bool bFound			= false;
	sOutValue.clear();
	
	const auto& pair	= m_mTokens.find( sToken );
	if ( pair != m_mTokens.end() )
	{
		bFound			= true;
		sOutValue		= pair->second;
	}

	return bFound;
}

CommandLineParser::~CommandLineParser() noexcept
{
	ShutDown();
}

void
CommandLineParser::ParseCmdLine() noexcept
{
	// NOTE(Dino):
	// Most runs should be merely blank.
	// So, this should prove a nice, if somewhat pointless, optimization.
	if ( !m_sCmdLine.empty() )
	{
		StringArray aArgValPairs;
		ExplodeString( m_sCmdLine, aArgValPairs );
		for ( const String& sArgValPair : aArgValPairs )
		{
			StringArray aArgValTokens;
			ExplodeString( sArgValPair, aArgValTokens, '=' );
			String arg	= aArgValTokens[ 0 ];
			String val	= ( aArgValTokens.size() == 2 ) ? aArgValTokens[ 1 ] : String( "" );
			m_mTokens.insert( std::make_pair( arg, val ) );
		}
	}
}

// Useful utility functions.
void 
ExplodeString( const String& sString, StringArray& aTokens, const char delimiter /* = " " */ )
{
	// Sample case:
	// meaning=42 senselessness=41
	uint32 uIdxTokenStart = 0;

	bool bInToken		= false;
	uint32 uLength		= sString.length();
	for ( uint32 uIdx	= 0; uIdx < uLength; uIdx++ )
	{
		const char c	= sString[ uIdx ];
		if ( c == delimiter && bInToken )
		{
			const uint32 uTokenLength = ( uIdx - uIdxTokenStart );
			const String& sToken = sString.substr( uIdxTokenStart, uTokenLength );
			aTokens.push_back( sToken );
		
			uIdxTokenStart	= uIdx + 1;
			bInToken		= false;
		}
		else if ( c != delimiter && !bInToken )
		{
			bInToken		= true;
			uIdxTokenStart	= uIdx;
		}
	}

	// We need to deal with the rest of the buffer.
	if ( bInToken )
	{
		const bool bIsLastDelimiter = ( sString[ uLength ] == delimiter );
		uint32 uTokenLenth			= ( bIsLastDelimiter ? uLength - 1 : uLength );
		const String& sToken		= sString.substr( uIdxTokenStart, uTokenLenth );
		aTokens.push_back( sToken );
	}
}