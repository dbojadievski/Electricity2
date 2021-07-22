#include "ConsoleSystem.h"
#include "StringUtils.h"

#include <assert.h>

#include <mutex>

std::recursive_mutex g_Mutex; // MAYBE(Dino): Should we limit adding and changing vars only to the main thread?

// CVarData implementation.
CVarData::CVarData( void* pData, CVarType eType, const String& description, const bool bReadOnly ) noexcept :
	m_pData( pData )
	, m_eCVarType( eType )
	, m_Description( description )
	, m_bReadOnly( bReadOnly )
{
	assert( pData );
}

// ConsoleSystem implementation.

bool 
ConsoleSystem::AddCVar( const String& name, bool* pbStorage, const String& description /*= ""*/, const bool bReadOnly /*= false*/ ) noexcept
{
	return AddCVar( name, static_cast<void*>( pbStorage ), CVarType::Bool, description, bReadOnly );
}

bool
ConsoleSystem::AddCVar( const String& name, uint32* puStorage, const String& description /*= ""*/, const bool bReadOnly /*= false*/ ) noexcept
{
	return AddCVar( name, static_cast<void*>( puStorage ), CVarType::Integer, description, bReadOnly );
}

bool
ConsoleSystem::AddCVar( const String& name, float* pfStorage, const String& description /*= ""*/, const bool bReadOnly /*= false*/ ) noexcept
{
	return AddCVar( name, static_cast<void*>( pfStorage ), CVarType::Float, description, bReadOnly );
}

bool
ConsoleSystem::AddCVar( const String& name, String* pStorage, const String& description /*= ""*/, const bool bReadOnly /*= false*/ ) noexcept
{
	return AddCVar( name, static_cast<void*>( pStorage ), CVarType::String, description, bReadOnly );
}

bool
ConsoleSystem::AddCVar( const String& name, void* pStorage, CVarType eType, const String& description /*= ""*/, const bool bReadOnly /*= false*/ ) noexcept
{
	const bool bAdded = s_sVarData.find( name ) == s_sVarData.end();
	if ( bAdded )
	{
		std::lock_guard<std::recursive_mutex> Lock( g_Mutex );
		s_sVarData.insert( std::make_pair( name, CVarData(pStorage, eType, description, bReadOnly ) ) );
	}

	return bAdded;
}

bool
ConsoleSystem::GetCVarBool( const String& name ) noexcept
{
	bool bVal = false;
	const CVarMap::iterator& itVar = s_sVarData.find( name );
	if ( itVar != s_sVarData.cend() )
	{
		CVarData& varData = itVar->second;
		assert( varData.m_eCVarType == CVarType::Bool );

		if ( varData.m_eCVarType == CVarType::Bool )
			bVal = *varData.m_pbStorage;
	}

	return bVal;
}

uint32
ConsoleSystem::GetCVarInteger( const String& name ) noexcept
{
	uint32 uVal = 0;
	const CVarMap::iterator& itVar = s_sVarData.find( name );
	if ( itVar != s_sVarData.cend() )
	{
		CVarData& varData = itVar->second;
		assert( varData.m_eCVarType == CVarType::Integer );

		if ( varData.m_eCVarType == CVarType::Integer )
			uVal = *varData.m_puStorage;
	}

	return uVal;
}

float
ConsoleSystem::GetCVarFloat( const String& name ) noexcept
{
	float fVal = 0.f;
	const CVarMap::iterator& itVar = s_sVarData.find( name );
	if ( itVar != s_sVarData.cend() )
	{
		CVarData& varData = itVar->second;
		assert( varData.m_eCVarType == CVarType::Float );

		if ( varData.m_eCVarType == CVarType::Float )
			fVal = *varData.m_pfStorage;
	}

	return fVal;
}

String
ConsoleSystem::GetCVarString( const String& name ) noexcept
{
	String val = "";
	const CVarMap::iterator& itVar = s_sVarData.find( name );
	if ( itVar != s_sVarData.cend() )
	{
		CVarData& varData = itVar->second;
		assert( varData.m_eCVarType == CVarType::String );

		if ( varData.m_eCVarType == CVarType::String )
			val = *varData.m_pStorage;
	}

	return val;
}


bool 
ConsoleSystem::SetCVarBool( const String& name, bool bVal ) noexcept
{
	CVarMap::iterator itCVar = s_sVarData.find( name );
	if ( itCVar == s_sVarData.end() )
		return false;

	CVarData varData = itCVar->second;
	assert( varData.m_eCVarType == CVarType::Bool );
	if ( varData.m_eCVarType != CVarType::Bool )
		return false;

	std::lock_guard<std::recursive_mutex> lock( g_Mutex );
	*varData.m_pbStorage = bVal;

	return true;
}

bool 
ConsoleSystem::SetCVarInteger( const String& name, uint32 uVal ) noexcept
{
	CVarMap::iterator itCVar = s_sVarData.find( name );
	if ( itCVar == s_sVarData.end() )
		return false;

	CVarData varData = itCVar->second;
	
	assert( !varData.m_bReadOnly );
	if ( varData.m_bReadOnly )
		return false;

	assert( varData.m_eCVarType == CVarType::Integer );
	if ( varData.m_eCVarType != CVarType::Integer )
		return false;

	std::lock_guard<std::recursive_mutex> lock( g_Mutex );
	*varData.m_puStorage = uVal;

	return true;
}

bool 
ConsoleSystem::SetCVarFloat( const String& name, float fVal ) noexcept
{
	CVarMap::iterator itCVar = s_sVarData.find( name );
	if ( itCVar == s_sVarData.end() )
		return false;

	CVarData varData = itCVar->second;

	assert( !varData.m_bReadOnly );
	if ( varData.m_bReadOnly )
		return false;

	assert( varData.m_eCVarType == CVarType::Float );
	if ( varData.m_eCVarType != CVarType::Float )
		return false;

	std::lock_guard<std::recursive_mutex> lock( g_Mutex );
	*varData.m_pfStorage = fVal;

	return true;
}

bool ConsoleSystem::SetCVarString( const String& name, const String& val ) noexcept
{
	CVarMap::iterator itCVar = s_sVarData.find( name );
	if ( itCVar == s_sVarData.end() )
		return false;

	CVarData varData = itCVar->second;

	assert( !varData.m_bReadOnly );
	if ( varData.m_bReadOnly )
		return false;

	assert( varData.m_eCVarType == CVarType::String );
	if ( varData.m_eCVarType != CVarType::String )
		return false;

	std::lock_guard<std::recursive_mutex> lock( g_Mutex );
	*varData.m_pStorage = val;

	return true;
}

bool
ConsoleSystem::AddCommand( const String& name, ConsoleCommandHandler pfnHandler ) noexcept
{
	const bool bAdded = s_sCommandData.find( name ) == s_sCommandData.end();
	if ( bAdded )
	{
		std::lock_guard<std::recursive_mutex> Lock( g_Mutex );
		s_sCommandData.insert( std::make_pair( name, pfnHandler ) );
	}
	
	return bAdded;
}

bool
ConsoleSystem::FeedLine( const String& name ) noexcept
{
	StringArray aTokens;
	Electricity::Utils::ExplodeString( name, aTokens );
	if ( aTokens.size() == 0 )
		return false;
	

	String& leadingToken = aTokens[ 0 ];
	{
		const CommandMap::iterator& itCommand = s_sCommandData.find( leadingToken );
		if ( itCommand != s_sCommandData.cend() )
		{
			itCommand->second( name );
			return true;
		}
	}

	{
		const CVarMap::iterator& itCVar = s_sVarData.find( leadingToken );
		if ( itCVar != s_sVarData.cend() )
		{
			CVarData& varData = itCVar->second;
			if ( varData.m_bReadOnly )
			{
				assert( false );
				return false;
			}

			// Set CVar.
			assert( aTokens.size() == 2 );
			String valString = aTokens[ 1 ];
			switch ( varData.m_eCVarType )
			{
				case CVarType::Bool:
				{
					Electricity::Utils::ToLower( valString );
					if ( valString == "false" || valString == "0" )
						*varData.m_pbStorage = true;
					else if ( valString == "true" || valString == "1" )
						*varData.m_pbStorage = false;
					else
						// Can't set boolean cvar to non-boolean data type.
						assert( false );
					break;
				}
				case CVarType::Integer:
				{
					size_t szConverted;
					int iVal = std::stoi( valString, &szConverted );
					if ( szConverted != valString.size() )
						assert( false ); // Invalid characters detected in string.
					*varData.m_puStorage = static_cast< uint32 >( iVal );

					break;
				}
				case CVarType::Float:
				{
					size_t szConverted;
					float fVal = std::stof( valString, &szConverted );
					if ( szConverted != valString.size() )
						assert( false ); // Invalid characters detected in string.
					*varData.m_pfStorage = fVal;

					break;
				}
				case CVarType::String:
				{
					*varData.m_pStorage = valString;
					break;
				}
				default:
				{
					assert( false ); // Type unknown, crash and burn.
					break; // Keep compiler happy.
				}
			}

			return true;
		}
	}

	return false;
}