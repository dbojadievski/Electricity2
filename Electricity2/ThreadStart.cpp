#include "ThreadStart.h"

/* CoreThreadStart class */
CoreThreadStart::CoreThreadStart( pThreadFunc pfnWorkFunction, const bool bCreateRunning /* = false */, const bool bCreateDetached /* = false */ ) noexcept
	: m_bScheduled( bCreateRunning )
	, m_bDetached( bCreateDetached )
	, m_Priority( CoreThreadPriority::Normal )
	, m_Affinity( -1 )
	, m_uStackSize( 0 )
	, m_pfnThreadFunc( pfnWorkFunction )
	, m_pThreadFuncParam( nullptr )
{
}

CoreThreadStart::CoreThreadStart() noexcept
	: m_bScheduled( false )
	, m_bDetached( false )
	, m_Priority( CoreThreadPriority::Normal )
	, m_Affinity( -1 )
	, m_uStackSize( 0 )
	, m_pfnThreadFunc( nullptr )
	, m_pThreadFuncParam( nullptr )

{
}

CoreThreadStart::CoreThreadStart( const CoreThreadStart& other ) noexcept
{
	*this			= other;
}

CoreThreadStart::~CoreThreadStart() noexcept
{
	m_bScheduled			= false;
	m_bDetached			= false;
	
	m_Priority			= CoreThreadPriority::Idle;
	m_Affinity			= 0;
	
	m_uStackSize		= 0;
	m_pfnThreadFunc		= nullptr;
	m_pThreadFuncParam	= nullptr;

}

CoreThreadStart&
CoreThreadStart::operator=( const CoreThreadStart& other ) noexcept
{
	m_bScheduled			= other.m_bScheduled;
	m_bDetached			= other.m_bDetached;
	
	m_Priority			= other.m_Priority;
	m_Affinity			= other.m_Affinity;

	m_uStackSize		= other.m_uStackSize;
	m_pfnThreadFunc		= other.m_pfnThreadFunc;
	m_pThreadFuncParam	= other.m_pThreadFuncParam;

	return *this;
}

bool
CoreThreadStart::GetCreateRunning() const noexcept
{
	return m_bScheduled;
}

bool
CoreThreadStart::GetCreateDetached() const noexcept
{
	return m_bDetached;
}

CoreThreadPriority
CoreThreadStart::GetThreadPriority() const noexcept
{
	return m_Priority;
}

CoreThreadProcessorAffinity
CoreThreadStart::GetAffinity() const noexcept
{
	return m_Affinity;
}

uint16
CoreThreadStart::GetStackSize() const noexcept
{
	return m_uStackSize;
}

pThreadFunc
CoreThreadStart::GetWorkFunction() const noexcept
{
	return m_pfnThreadFunc;
}

ThreadFuncParamPtr
CoreThreadStart::GetThreadFuncParam() const noexcept
{
	return m_pThreadFuncParam;
}

void
CoreThreadStart::SetPriority( const CoreThreadPriority& Priority ) noexcept
{
	m_Priority		= Priority;
}

void
CoreThreadStart::SetAffinity( const CoreThreadProcessorAffinity& Affinity ) noexcept
{
	m_Affinity		= Affinity;
}

void
CoreThreadStart::SetStackSize( uint16 uStackSize ) noexcept
{
	m_uStackSize	= uStackSize;
}

void
CoreThreadStart::SetWorkFunction( pThreadFunc pfnWorkFunction ) noexcept
{
	m_pfnThreadFunc = pfnWorkFunction;
}

void
CoreThreadStart::SetCreateRunning( const bool bCreateRunning ) noexcept
{
	m_bScheduled = true;
}