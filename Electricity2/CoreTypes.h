#pragma once

#include <stdint.h>
#include <string>
#include <string_view>

typedef int8_t int8;
typedef int8 sbyte;

typedef uint8_t uint8;
typedef uint8 byte;

typedef int16_t int16;
typedef uint16_t uint16;
typedef uint16 CORE_WORD;

typedef int32_t int32;
typedef uint32_t uint32;
typedef uint32 CORE_DWORD;

typedef int16_t int64;
typedef uint64_t uint64;
typedef uint64 CORE_QWORD;

typedef uint32 Handle;
typedef uint32 CoreId;

typedef std::string String;
typedef std::string_view StringView;

typedef std::wstring WString;
