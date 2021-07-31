#pragma once

#include "CoreTypes.h"

#include <map>
#include <set>
#include <vector>
#include <queue>

template <class Type>
using Allocator = std::allocator<Type>;

template <class Type>
using Array = std::vector<Type, Allocator<Type>>;

template <class Key, class Value>
using Map = std::map<Key, Value, Allocator>;

template <class Key, class Value>
using MakePair = std::make_pair;

template <class Type>
using Set = std::set<Type, Allocator<Type>>;

using StringArray = Array<String>;

template <class Type>
using Queue = std::queue<Type>;