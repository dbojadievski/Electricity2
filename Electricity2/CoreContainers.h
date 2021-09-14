#pragma once

#include "CoreTypes.h"

#include <list>
#include <map>
#include <queue>
#include <set>
#include <vector>

template <class Type>
using Allocator = std::allocator<Type>;

template <class Type>
using Array = std::vector<Type, Allocator<Type>>;

template<class Key, class Value>
using Pair = std::pair<Key, Value>;

template<class Key, class Value>
using Map = std::map<Key, Value>;

#define MakePair std::make_pair

template <class Type>
using Set = std::set<Type, Allocator<Type>>;

using StringArray = Array<String>;

template <class Type>
using Queue = std::queue<Type>;

template <class Type>
using List = std::list<Type>;