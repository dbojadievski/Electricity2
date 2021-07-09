#include <assert.h>
#include "CoreTypes.h"
#include "FiberStart.h"

// CoreFiberStart implementation.
CoreFiberStart::CoreFiberStart( pFiberFunc pfnFiberFunc, pFiberFuncParam pFiberParam /* = nullptr */, uint32 uStackSize /* = 0 */ ) noexcept
	: m_pfnFiberFunc( pfnFiberFunc )
	, m_pFiberParam( pFiberParam )
	, m_uStackSize( uStackSize )
{
	assert( pfnFiberFunc );
}

CoreFiberStart::~CoreFiberStart()
{
	m_pfnFiberFunc		= nullptr;
	m_pFiberParam		= nullptr;
	m_uStackSize		= 0;
}

pFiberFunc
CoreFiberStart::GetFiberFunc() const noexcept
{
	return m_pfnFiberFunc;
}

pFiberFuncParam
CoreFiberStart::GetParam() const noexcept
{
	return m_pFiberParam;
}

uint32
CoreFiberStart::GetStackSize() const noexcept
{
	return m_uStackSize;
}