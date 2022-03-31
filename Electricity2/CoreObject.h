#pragma once
#include "CoreTypes.h"
#include "Heap.h"
#include "UUID.h"
#include "SharedPtr.h"

#include <map>
#include <string>
#include <vector>
#include <set>

typedef uint64 ObjectID;

class CoreObject;
typedef std::vector<SharedPtr<CoreObject>> ObjectArray;
typedef std::map<ObjectID, SharedPtr<CoreObject>> ObjectMap;
typedef ObjectArray::const_iterator ConstObjectIterator;
typedef ObjectArray::iterator ObjectIterator;

typedef Electricity::UUID ClassID;
typedef std::vector<ClassID> ClassIDList;
typedef std::set<ClassID> ClassIDSet;

class CoreObject
{
public:
	class Initializer
	{

	};
protected:
	CoreObject () noexcept;

public:
	CoreObject( const CoreObject& other ) noexcept;
	CoreObject( CoreObject&& ) noexcept;

	virtual CoreObject& operator=( const CoreObject& other ) noexcept;
	virtual CoreObject& operator=( CoreObject&& other ) noexcept;
	virtual bool operator==( const CoreObject& other ) const noexcept;

	virtual ~CoreObject() noexcept;

public:
	virtual ClassID GetClass() const noexcept;
	ObjectID GetID() const noexcept;
	static CoreObject* GetByID( const ObjectID uID ) noexcept;
	void Initialize( const Initializer& initializer ) noexcept;
	virtual void Deinitialize() noexcept;

private:
	void Construct() noexcept;

protected:
	ObjectID	m_uID;
};