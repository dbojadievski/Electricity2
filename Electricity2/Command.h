#pragma once
#include "CoreTypes.h"

namespace Electricity::Rendering
{
	class Command
	{
	public:
		virtual void Execute() = 0;
	private:
#ifdef DEBUG
		String m_sName;
#endif
	};
}