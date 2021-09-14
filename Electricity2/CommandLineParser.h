#pragma once

#include <map>
#include <string>
#include "CoreTypes.h"

class CommandLineParser final
{
public:
	CommandLineParser( const String sCmdLine = "" ) noexcept;

	void Initialize() noexcept;
	void ShutDown() noexcept;

	void SetCommandLine( const String wsCommandLine ) noexcept;
	const String& GetCommandLine() const noexcept; 
	uint32 GetNumParams() const noexcept;

	bool HasToken( const String& sToken ) const noexcept;
	bool GetValue( const String sToken, String& sOutValue ) const noexcept;

	~CommandLineParser() noexcept;
private:
	void ParseCmdLine() noexcept;

	String						m_sCmdLine;
	std::map<String, String>	m_mTokens;
};