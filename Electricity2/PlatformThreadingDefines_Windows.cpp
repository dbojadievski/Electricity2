#ifdef  _WIN32
typedef void* PPlatformThread;
typedef void* PPlatformFiber;

typedef void* pFiberFuncParam;
typedef void( __stdcall* pFiberFunc ) ( pFiberFuncParam pParam );

#endif //  _WIN32
