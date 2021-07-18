#include <assert.h>

#include "Fiber.h"
#include "FiberStart.h"
#include "Thread.h"
#include "PlatformFiber.h"

// CoreFiber implementation

CoreFiber::CoreFiber() noexcept
	: m_uID( 0 )
	, m_bScheduled( false )
	, m_pPlatformFiber( nullptr )
{
}

CoreFiber::CoreFiber( CoreFiber&& other ) noexcept
	: m_uID( other.m_uID )
	, m_bScheduled( other.m_bScheduled )
	, m_pPlatformFiber( nullptr )
{
	other.m_uID			= 0;
	other.m_bScheduled	= false;
}

CoreFiber::CoreFiber( const CoreFiberStart& fiberStart ) noexcept
	: m_uID( 0 )
	, m_bScheduled( false )
	, m_pPlatformFiber( nullptr )
{
	const pFiberFunc pfnFunc = fiberStart.GetFiberFunc();
	assert( pfnFunc );
	if ( pfnFunc )
	{
		 m_pPlatformFiber = PlatformFiber::Create( fiberStart );
		 assert( m_pPlatformFiber );
	}
}

CoreFiber::CoreFiber( CoreThread& other ) noexcept
	: m_uID( 0 )
	, m_bScheduled( false )
	, m_pPlatformFiber( nullptr )
{
	assert( other.m_PlatformThreadID != 0 );
	assert( other.m_pPlatformThread );

	m_pPlatformFiber		= PlatformFiber::FromThread( other.m_pPlatformThread );
	const bool bConverted	= ( m_pPlatformFiber != nullptr );
	assert( bConverted );
	if ( bConverted )
	{
		m_bScheduled				= true;
		other.m_PlatformThreadID	= 0;
		other.m_pPlatformThread		= nullptr;
	}
}

CoreFiber::~CoreFiber() noexcept
{
	Delete();
}

CoreFiber&
CoreFiber::operator=( const CoreFiber& other ) noexcept
{
	m_uID				= other.m_uID;
	m_bScheduled		= other.m_bScheduled;
	m_pPlatformFiber	= other.m_pPlatformFiber;

	return *this;
}

CoreFiber&
CoreFiber::operator=( CoreFiber&& other ) noexcept
{
	m_uID				= other.m_uID;
	m_bScheduled		= other.m_bScheduled;
	m_pPlatformFiber	= other.m_pPlatformFiber;

	other.m_uID				= 0;
	other.m_bScheduled		= false;
	other.m_pPlatformFiber	= nullptr;

	return *this;
}

PPlatformFiber
CoreFiber::GetPlatformFiber() const noexcept
{
	return m_pPlatformFiber;
}

uint32
CoreFiber::GetID() const noexcept
{
	return m_uID;
}

bool
CoreFiber::IsScheduled() const noexcept
{
	return m_bScheduled;
}

bool
CoreFiber::SwitchTo( CoreFiber& other ) noexcept
{
	assert( !other.m_bScheduled );

	bool bSwitched		= false;
	if (  !other.m_bScheduled && m_pPlatformFiber != other.m_pPlatformFiber ) 
	{
		// TODO(Dino): 
		// Find a way to check for this switch.
		// Trouble is that the SwitchTo() causes immediate termination of this function.

		m_bScheduled		= false;
		other.m_bScheduled	= true;
		bSwitched		= PlatformFiber::SwitchTo( other.m_pPlatformFiber );
	}
	else
	{
		assert( false );
	}

	return bSwitched;
}

void
CoreFiber::Delete() noexcept
{
	m_uID				= 0;
	m_bScheduled		= false;

	const bool bStopped = PlatformFiber::Delete( m_pPlatformFiber );
	assert( bStopped );
	m_pPlatformFiber	= nullptr;
}

CoreFiber
CoreFiber::GetCurrentFiber() noexcept
{
	CoreFiber fiber;
	PPlatformFiber platformFiber	= PlatformFiber::GetCurrent();
	fiber.m_pPlatformFiber			= platformFiber;
	fiber.m_bScheduled				= true;

	return fiber;
}
