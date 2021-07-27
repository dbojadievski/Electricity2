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

#define Map std::map

template <class Type>
using Set = std::set<Type, Allocator<Type>>;

using StringArray = Array<String>;

template <class Type>
using Queue = std::queue<Type>;