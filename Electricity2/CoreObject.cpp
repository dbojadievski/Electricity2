#include "CoreObject.h"


void
CoreObject::Construct() noexcept
{
}

CoreObject::CoreObject () noexcept :
	m_uID( 0 )
{
	Construct();
}

CoreObject::CoreObject( const CoreObject& other ) noexcept :
	m_uID( other.m_uID )
{
	Construct();
}

CoreObject::CoreObject( CoreObject&& other ) noexcept :
	m_uID( other.m_uID )
{
	other.m_uID = 0;
	Construct();
}

CoreObject&
CoreObject::operator=( const CoreObject& other ) noexcept
{
	m_uID		= other.m_uID;
	return *this;
}

CoreObject&
CoreObject::operator=( CoreObject&& other ) noexcept
{
	m_uID		= other.m_uID;
	other.m_uID = 0;

	return *this;
}

bool
CoreObject::operator==( const CoreObject& other ) const noexcept
{
	return ( m_uID == other.m_uID );
}

CoreObject::~CoreObject() noexcept
{
}

ClassID
CoreObject::GetClass() const noexcept
{
	return ClassID::NewUUID();
}

ObjectID
CoreObject::GetID() const noexcept
{
	return m_uID;
}

CoreObject*
CoreObject::GetByID( const ObjectID uID ) noexcept
{
	CoreObject* pRetVal = nullptr;
	return pRetVal;
}

void
CoreObject::Initialize( const Initializer& Initializer ) noexcept
{
}

void
CoreObject::Deinitialize() noexcept
{
}