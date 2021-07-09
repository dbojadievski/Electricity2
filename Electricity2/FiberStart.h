#pragma once
#include "CoreTypes.h"
#include "PlatformThreadingDefines.h"

class CoreFiberStart
{
public:
	CoreFiberStart( pFiberFunc pfnFiberFunc, pFiberFuncParam pFiberParam = nullptr, uint32 uStackSize = 0 ) noexcept;
	~CoreFiberStart() noexcept;

	pFiberFunc GetFiberFunc() const noexcept;
	pFiberFuncParam GetParam() const noexcept;
	uint32 GetStackSize() const noexcept;

private:
	pFiberFunc		m_pfnFiberFunc;
	pFiberFuncParam m_pFiberParam;
	uint32			m_uStackSize;
};