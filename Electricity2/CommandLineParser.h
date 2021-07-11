#pragma once

#include <map>
#include <string>
#include "CoreTypes.h"

class CommandLineParser final
{
public:
	CommandLineParser( const std::string sCmdLine ) noexcept;

	void Initialize() noexcept;
	void ShutDown() noexcept;

	const std::string& GetCommandLine() const noexcept;
	uint32 GetNumParams() const noexcept;

	bool HasToken( const std::string& sToken ) const noexcept;
	bool GetValue( const std::string sToken, std::string& sOutValue ) const noexcept;

	~CommandLineParser() noexcept;
private:
	void ParseCmdLine() noexcept;

	std::string							m_sCmdLine;
	std::map<std::string, std::string>	m_mTokens;
};