#pragma once

#include "CoreTypes.h"
#include "CoreContainers.h"

typedef bool ( *ConsoleCommandHandler ) ( const String& param ) noexcept;

enum class CVarType
{
	Invalid = 0,
	Bool,
	Integer,
	Float,
	String
};

class CVarData
{
	friend class ConsoleSystem;

private:
	union
	{
		bool*	m_pbStorage;
		uint32* m_puStorage;
		float*	m_pfStorage;
		String* m_pStorage;
		void*	m_pData;
	};
private:
	CVarType m_eCVarType;
	String m_Description;
	bool m_bReadOnly;

	CVarData( void *, CVarType eType, const String& description, const bool bReadOnly ) noexcept;
};

class ConsoleSystem
{
public:
	static bool AddCVar( const String& name, bool* pbStorage, const String& description = "", const bool bReadOnly = false ) noexcept;
	static bool AddCVar( const String& name, uint32* puStorage, const String& description = "", const bool bReadOnly = false ) noexcept;
	static bool AddCVar( const String& name, float* pfStorage, const String& description = "", const bool bReadOnly = false ) noexcept;
	static bool AddCVar( const String& name, String* pStorage, const String& description = "", const bool bReadOnly = false ) noexcept;

	static bool GetCVarBool( const String& name ) noexcept;
	static uint32 GetCVarInteger( const String& name ) noexcept;
	static float GetCVarFloat( const String& name ) noexcept;
	static String GetCVarString( const String& name ) noexcept;

	static bool SetCVarBool( const String& name, bool bVal ) noexcept;
	static bool SetCVarInteger( const String& name, uint32 uVal ) noexcept;
	static bool SetCVarFloat( const String& name, float fVal ) noexcept;
	static bool SetCVarString( const String& name, const String& val ) noexcept;


	static bool AddCommand( const String& name, ConsoleCommandHandler pfnHandler ) noexcept;

	static bool FeedLine( const String& name ) noexcept;
private:
	static bool AddCVar( const String& name, void* pStorage, CVarType eType, const String& description = "", const bool bReadOnly = false ) noexcept;
	
	typedef Map<String, CVarData> CVarMap;
	typedef Map<String, ConsoleCommandHandler> CommandMap;

	inline static CVarMap s_sVarData;
	inline static CommandMap s_sCommandData;
};
