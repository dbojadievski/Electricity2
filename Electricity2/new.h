#include "CoreTypes.h"

#ifdef USE_MEMORY_TRACKING
#undef new
void* operator new( decltype( sizeof( 0 ) ) uSize, char* pStrFileName, uint32 uLineNo ) noexcept( false );
#endif