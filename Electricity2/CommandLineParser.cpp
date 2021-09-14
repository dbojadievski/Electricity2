#include "CommandLineParser.h"

#include "CoreContainers.h"
#include "StringUtils.h"

// CommandLineParser implementation.

CommandLineParser::CommandLineParser( String sCmdLine ) noexcept
	: m_sCmdLine( sCmdLine )
{
	Initialize( );
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
CommandLineParser::HasToken( const String& sToken ) const noexcept
{
	return ( m_mTokens.find( sToken ) != m_mTokens.end() );
}

bool
CommandLineParser::GetValue( const String sToken, String& sOutValue ) const noexcept
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
		Electricity::Utils::ExplodeString( m_sCmdLine, aArgValPairs );
		for ( const String& sArgValPair : aArgValPairs )
		{
			StringArray aArgValTokens;
			Electricity::Utils::ExplodeString( sArgValPair, aArgValTokens, '=' );
			String arg	= aArgValTokens[ 0 ];
			String val	= ( aArgValTokens.size() == 2 ) ? aArgValTokens[ 1 ] : String( "" );
			m_mTokens.insert( std::make_pair( arg, val ) );
		}
	}
}