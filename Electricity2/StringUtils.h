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
}