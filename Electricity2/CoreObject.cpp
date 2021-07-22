#include "CoreObject.h"

void
CoreObject::RegisterInheritance() noexcept
{
	ClassID uTypeId = CoreObject::GetClassId();
	if ( m_suInheritanceChain.find( uTypeId ) == m_suInheritanceChain.end() )
	{
		m_suInheritanceChain.insert( uTypeId );
	}
}

void
CoreObject::RegisterInstance() noexcept
{
	CoreObject::s_apInstances.push_back( SharedPtr<CoreObject>(this) );
}

void
CoreObject::Construct() noexcept
{
	RegisterInstance();
	RegisterInheritance();
}

CoreObject::CoreObject () noexcept :
	m_uID( ++s_NextID )
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
	s_apInstances.erase( std::find( s_apInstances.begin(), s_apInstances.end(), SharedPtr<CoreObject>(this) ) );
}

ClassID
CoreObject::GetClass() const noexcept
{
	return s_ClassId;
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

uint32 
CoreObject::GetInheritanceChainDepth()  noexcept
{
	assert( s_apInstances.size() > 0 );
	return m_suInheritanceChain.size();
}

ConstObjectIterator
CoreObject::GetInstances() noexcept
{
	return s_apInstances.cbegin();
}