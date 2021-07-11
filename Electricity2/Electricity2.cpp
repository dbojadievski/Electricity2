// Electricity2.cpp : Defines the entry point for the application.
//

#include "framework.h"
#include "Electricity2.h"
#include "CoreTypes.h"
#include "UnitTests.h"
#include "PtrTypeUnitTests.h"
#include "Heap.h"
#include "UnitTests_MemoryHeap.h"
#include "UnitTests_CmdLineParser.h"

#include "Thread.h"
#include "ThreadStart.h"
#include "Fiber.h"
#include "FiberStart.h"

#include <future>
#include <iostream>

#define MAX_LOADSTRING 100

HeapManager Manager;

void 
InitializeSystems()
{
    const bool bIsInitted = Manager.Initialize();
    assert( bIsInitted );
}

void 
ShutDownSystems()
{
    const bool bIsShutDown = Manager.ShutDown();
    assert( bIsShutDown );
    assert(FreeConsole());
}

uint32 __stdcall
LongRunningFunc( void* )
{
    uint32 uSum = 0;
    for ( uint32 iIdx = 0; iIdx < 4; iIdx++ )
    {
        uSum += iIdx;
        std::cout << " Calculated sum at: " << uSum << std::endl;
    }


    return uSum;
}

CoreFiber* pFiber1, * pFiber2, *pFiber3;

void __stdcall
Fiber3Func( pFiberFuncParam pFuncParam )
{
	uint32 uIdx = 0;
	while ( true )
	{
		std::cout << "Running from fiber 3 func" << std::endl;
		if ( ++uIdx == 10 )
		{
			std::cout << "Yielding to fiber 2" << std::endl;
			uIdx = 0;
			pFiber3->SwitchTo( *pFiber2 );
		}
	}
}

void __stdcall
Fiber2Func( pFiberFuncParam pFuncParam )
{
    uint32 uIdx = 0;
    while ( true )
    {
        std::cout << "Running from fiber 2 func" << std::endl;
        if ( ++uIdx == 10 )
        {
            std::cout << "Yielding to fiber 3" << std::endl;
            uIdx = 0;
            pFiber2->SwitchTo( *pFiber3 );
        }
    }
}

uint32 __stdcall
FiberToThreadFunc( ThreadFuncParamPtr pParam )
{
    std::cout << "Running from fiber to thread func" << std::endl;

    // How do we give the fiber functons access to the fibers themselves, so the fiber can switch?
    CoreThread currThread = CoreThread::GetCurrentThread();
    pFiber1 = new CoreFiber( currThread );
    
    pFiber3 = new CoreFiber( &Fiber3Func );
    pFiber2 = new CoreFiber( &Fiber2Func );

    pFiber1->SwitchTo( *pFiber2 );
    
    return 0;
}

void 
RunFiberTest()
{
    CoreThreadStart threadStart( &FiberToThreadFunc, true );
    CoreThread* pThread = new CoreThread( threadStart );
}

void 
RunThreadTest()
{
    std::cout << "Running threading test " << std::endl;

    CoreThreadStart threadStart;
    pThreadFunc pThreadFunction = &LongRunningFunc;
    threadStart.SetWorkFunction( &LongRunningFunc );
    
    CoreThread thread( threadStart );
    const bool bRunning = thread.Resume();
    assert( bRunning );

    const bool bIsJoinable = thread.IsJoinable();
    assert( bIsJoinable );
    thread.Join();
    int32 iSum = thread.GetExitCode();
    assert( iSum == 6 );

    std::cout << "Joined secondary thread" << std::endl;
    std::cout << "Computed sum at: " << iSum << std::endl;
}


// Global Variables:
HINSTANCE hInst;                                // current instance
WCHAR szTitle[MAX_LOADSTRING];                  // The title bar text
WCHAR szWindowClass[MAX_LOADSTRING];            // the main window class name

// Forward declarations of functions included in this code module:
ATOM                MyRegisterClass(HINSTANCE hInstance);
BOOL                InitInstance(HINSTANCE, int);
LRESULT CALLBACK    WndProc(HWND, UINT, WPARAM, LPARAM);
INT_PTR CALLBACK    About(HWND, UINT, WPARAM, LPARAM);

int APIENTRY wWinMain(_In_ HINSTANCE hInstance,
                     _In_opt_ HINSTANCE hPrevInstance,
                     _In_ LPWSTR    lpCmdLine,
                     _In_ int       nCmdShow)
{
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);

    // TODO: Place code here.
    InitializeSystems();

#ifdef _DEBUG
    UnitTestManager::GetInstance().RunAllUnitTests();
    UnitTest_CmdLineParser ParserTest;
    assert(ParserTest());
    RunThreadTest();
    RunFiberTest();
#endif
    
    // Can we do futures in our version of C++?
	auto fut = std::async( [] {return 3 + 4; } );
    ShutDownSystems();

    // Initialize global strings
    LoadStringW(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
    LoadStringW(hInstance, IDC_ELECTRICITY2, szWindowClass, MAX_LOADSTRING);
    MyRegisterClass(hInstance);

    // Perform application initialization:
    if (!InitInstance (hInstance, nCmdShow))
    {
        return FALSE;
    }

    HACCEL hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(IDC_ELECTRICITY2));

    MSG msg;

    // Main message loop:
    while (GetMessage(&msg, nullptr, 0, 0))
    {
        if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg))
        {
            TranslateMessage(&msg);
            DispatchMessage(&msg);
        }

        std::cout.flush();
    }

    return (int) msg.wParam;
}



//
//  FUNCTION: MyRegisterClass()
//
//  PURPOSE: Registers the window class.
//
ATOM MyRegisterClass(HINSTANCE hInstance)
{
    WNDCLASSEXW wcex;

    wcex.cbSize = sizeof(WNDCLASSEX);

    wcex.style          = CS_HREDRAW | CS_VREDRAW;
    wcex.lpfnWndProc    = WndProc;
    wcex.cbClsExtra     = 0;
    wcex.cbWndExtra     = 0;
    wcex.hInstance      = hInstance;
    wcex.hIcon          = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_ELECTRICITY2));
    wcex.hCursor        = LoadCursor(nullptr, IDC_ARROW);
    wcex.hbrBackground  = (HBRUSH)(COLOR_WINDOW+1);
    wcex.lpszMenuName   = MAKEINTRESOURCEW(IDC_ELECTRICITY2);
    wcex.lpszClassName  = szWindowClass;
    wcex.hIconSm        = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_SMALL));

    return RegisterClassExW(&wcex);
}

//
//   FUNCTION: InitInstance(HINSTANCE, int)
//
//   PURPOSE: Saves instance handle and creates main window
//
//   COMMENTS:
//
//        In this function, we save the instance handle in a global variable and
//        create and display the main program window.
//
BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
   hInst = hInstance; // Store instance handle in our global variable

   HWND hWnd = CreateWindowW(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
      CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, nullptr, nullptr, hInstance, nullptr);

   if (!hWnd)
   {
      return FALSE;
   }

   ShowWindow(hWnd, nCmdShow);
   UpdateWindow(hWnd);

   return TRUE;
}

//
//  FUNCTION: WndProc(HWND, UINT, WPARAM, LPARAM)
//
//  PURPOSE: Processes messages for the main window.
//
//  WM_COMMAND  - process the application menu
//  WM_PAINT    - Paint the main window
//  WM_DESTROY  - post a quit message and return
//
//
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
    case WM_COMMAND:
        {
            int wmId = LOWORD(wParam);
            // Parse the menu selections:
            switch (wmId)
            {
            case IDM_ABOUT:
                DialogBox(hInst, MAKEINTRESOURCE(IDD_ABOUTBOX), hWnd, About);
                break;
            case IDM_EXIT:
                DestroyWindow(hWnd);
                break;
            default:
                return DefWindowProc(hWnd, message, wParam, lParam);
            }
        }
        break;
    case WM_PAINT:
        {
            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hWnd, &ps);
            // TODO: Add any drawing code that uses hdc here...
            EndPaint(hWnd, &ps);
        }
        break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hWnd, message, wParam, lParam);
    }
    return 0;
}

// Message handler for about box.
INT_PTR CALLBACK About(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
    UNREFERENCED_PARAMETER(lParam);
    switch (message)
    {
    case WM_INITDIALOG:
        return (INT_PTR)TRUE;

    case WM_COMMAND:
        if (LOWORD(wParam) == IDOK || LOWORD(wParam) == IDCANCEL)
        {
            EndDialog(hDlg, LOWORD(wParam));
            return (INT_PTR)TRUE;
        }
        break;
    }
    return (INT_PTR)FALSE;
}

int main()
{
	std::cout << "Output standard\n";
	std::cerr << "Output error\n";

	return wWinMain( GetModuleHandle( NULL ), NULL, GetCommandLineW(), SW_SHOWNORMAL );
}