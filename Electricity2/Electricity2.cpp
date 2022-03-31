// Electricity2.cpp : Defines the entry point for the application.
//

//#include "framework.h"
#include "new.h"
#include "Electricity2.h"
#include "Framework.h"
#include "targetver.h"

#include "App.h"
#include "CoreTypes.h"
#include "UnitTests.h"
#include "PtrTypeUnitTests.h"
#include "Heap.h"
#include "UnitTests_MemoryHeap.h"
#include "UnitTests_CmdLineParser.h"
#include "UnitTests_StringUtils.h"

#include "HashUtils.h"

#include "Thread.h"
#include "ThreadStart.h"
#include "Fiber.h"
#include "FiberStart.h"

#include <future>
#include <iostream>
#include "CoreEngine.h"
#include "ConsoleSystem.h"
#include "SettingsSystem.h"
#include "SerializationSystem.h"
#include "SimpleMeshLoader.h"
#include "Math.h"
#include "TaskQueue.h"

#include <fstream>
#define MAX_LOADSTRING 100

App* pApp = nullptr;

LPSTR pCmdLine = nullptr;

void 
InitializeSystems()
{
    TaskQueue::Initialize();
}

void 
ShutDownSystems()
{
    TaskQueue::Deinitialize();
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

    // How do we give the fiber functions access to the fibers themselves, so the fiber can switch?
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

bool g_bVar = true;
uint32 g_uVar = 1;
float g_fVar = 1.0f;
String g_sVar = "Sample";

bool HelloConsole( const String& string ) noexcept
{
    std::cout << "Hello from the command console!" << std::endl;
    return true;
}

void
ConsoleSystemTest() noexcept
{
    {
        ConsoleSystem::AddCVar( "boolVar", &g_bVar );
        bool bVar = ConsoleSystem::GetCVarBool( "boolVar" );
        assert( bVar == true );
        ConsoleSystem::SetCVarBool( "boolVar", false );
	    bVar = ConsoleSystem::GetCVarBool( "boolVar" );
	    assert( bVar == false );
    }

    {
        ConsoleSystem::AddCVar( "intVar", &g_uVar );
        uint32 uVar = ConsoleSystem::GetCVarInteger( "intVar" );
        assert( uVar == 1 );
	    ConsoleSystem::SetCVarInteger( "intVar", 0 );
        uVar = ConsoleSystem::GetCVarInteger( "intVar" );
	    assert( ( uVar == 0 ) == true );
    }

    {
        ConsoleSystem::AddCVar( "floatVar", &g_fVar );
        float fVar = ConsoleSystem::GetCVarFloat( "floatVar" );
        assert( fVar == 1.0f );
	    ConsoleSystem::SetCVarFloat( "floatVar", 0.0f );
        fVar = ConsoleSystem::GetCVarFloat( "floatVar" );
	    assert( ( fVar == 0.0f ) == true );
    }

    {
        ConsoleSystem::AddCVar( "stringVar", &g_sVar );
	    String var = ConsoleSystem::GetCVarString( "stringVar" );
	    assert( var == "Sample" );
	    ConsoleSystem::SetCVarString( "stringVar", "sample" );
        var = ConsoleSystem::GetCVarString( "stringVar" );
	    assert( var == "sample" );
    }

    {
        const bool bAddedCommand    = ConsoleSystem::AddCommand( "Console.PrintHello", &HelloConsole );
        assert( bAddedCommand );
        
        const bool bParsedCmd       = ConsoleSystem::FeedLine( "Console.PrintHello" );
        assert( bParsedCmd );

        const bool bParsedModifyCmd = ConsoleSystem::FeedLine( "boolVar 1" );
        assert( bParsedModifyCmd && ( g_bVar == false )  );
    }
}


PackagedTask* g_pTaskSerializeTri = nullptr;
PackagedTask* g_pTaskDeserializeTri = nullptr;

void ClearTasks()
{
    //delete g_pTaskDeserializeTri;
    //delete g_pTaskSerializeTri;
}

void
LoadSampleSimpleMesh()
{
    g_pTaskDeserializeTri = PackagedTask::Create( ([] ( TaskParam pParam, const bool& bShouldCancel ) 
    {
		SerializationSystem::Deserialize( "triangle.mesh" );
		const auto& meshes      = SimpleMeshLoader::GetMeshes();
		assert( meshes.size() == 1 );
    }) );

    g_pTaskSerializeTri = PackagedTask::Create( ( [] ( TaskParam pParam, const bool& bShouldCancel ) 
    {
			const auto& meshes = SimpleMeshLoader::GetMeshes();
			assert( meshes.size() == 1 );
			const SharedPtr<SimpleMesh> pMesh = meshes[ 0 ];
			const SimpleMesh& mesh = *pMesh.Get();

			const String exportPath = "triangle_export.dat";
			SerializationSystem::Serialize( mesh, exportPath );
            std::cout << "Serialized triangle" << std::endl;
    }) );
    g_pTaskSerializeTri->SetOnCompleteOrCancelledHandler( &ClearTasks );
    g_pTaskDeserializeTri->SetFollowUpTask( g_pTaskSerializeTri );
    g_pTaskDeserializeTri->Submit();
}

// Global Variables:
HINSTANCE hInst;                                // current instance
WCHAR szTitle[MAX_LOADSTRING];                  // The title bar text
WCHAR szWindowClass[MAX_LOADSTRING];            // the main window class name

// Forward declarations of functions included in this code module:
ATOM                MyRegisterClass(HINSTANCE hInstance);
BOOL                InitInstance(HINSTANCE, int);
LRESULT CALLBACK    WndProc(HWND, UINT, WPARAM, LPARAM);

int APIENTRY WinMain(_In_ HINSTANCE hInstance,
                     _In_opt_ HINSTANCE hPrevInstance,
                     _In_ LPSTR    lpCmdLine,
                     _In_ int       nCmdShow)
{
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);
    pCmdLine = lpCmdLine;

    InitializeSystems();
    
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
        g_pEngine->Update();
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
    WNDCLASSEXW wcex = {};

    wcex.cbSize         = sizeof(WNDCLASSEX);

    wcex.style          = CS_HREDRAW | CS_VREDRAW;
    wcex.lpfnWndProc    = WndProc;
    wcex.cbClsExtra     = 0;
    wcex.cbWndExtra     = 0;
    wcex.hInstance      = hInstance;
    wcex.hIcon          = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_ELECTRICITY2));
    wcex.hCursor        = LoadCursor(nullptr, IDC_ARROW);
    wcex.hbrBackground  = (HBRUSH)(COLOR_WINDOW+1);
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

   LPSTR pCommandline = GetCommandLineA();


   SetProcessDpiAwarenessContext( DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2 );

   // Load these from app settings.
   uint32 uWidth = 2560, uHeight = 1440;

   // Initialize the window class.
   WNDCLASSEX windowClass = { 0 };
   windowClass.cbSize = sizeof( WNDCLASSEX );
   windowClass.style = CS_HREDRAW | CS_VREDRAW;
   windowClass.lpfnWndProc = WndProc;
   windowClass.hInstance = hInstance;
   windowClass.hCursor = LoadCursor( NULL, IDC_ARROW );
   windowClass.lpszClassName = L"Electricity2";
   RegisterClassEx( &windowClass );

   RECT windowRect = { 0, 0, static_cast< LONG >( uWidth ), static_cast< LONG >( uHeight ) };
   HWND hWnd = CreateWindow(
	   windowClass.lpszClassName,
	   L"Electricity 2",
	   WS_OVERLAPPEDWINDOW,
	   CW_USEDEFAULT,
	   CW_USEDEFAULT,
	   windowRect.right - windowRect.left,
	   windowRect.bottom - windowRect.top,
	   nullptr,        // We have no parent window.
	   nullptr,        // We aren't using menus.
	   hInstance,
	   nullptr );

   if (!hWnd)
   {
      return FALSE;
   }

   char* sCmdLineWithoutExeName = pCommandline;
   if ( *sCmdLineWithoutExeName == '"' ) {
	   ++sCmdLineWithoutExeName;
	   while ( *sCmdLineWithoutExeName )
		   if ( *sCmdLineWithoutExeName++ == '"' )
			   break;
   }
   else {
	   while ( *sCmdLineWithoutExeName && *sCmdLineWithoutExeName != ' ' && *sCmdLineWithoutExeName != '\t' )
		   ++sCmdLineWithoutExeName;
   }
   /* (optionally) skip spaces preceding the first argument */
   while ( *sCmdLineWithoutExeName == ' ' || *sCmdLineWithoutExeName == '\t' )
	   sCmdLineWithoutExeName++;
   String cmdLineString( sCmdLineWithoutExeName );


   App* pApp = new App( hWnd, cmdLineString );
   g_pApp = pApp;

   CoreEngine* pEngine = new CoreEngine();
   g_pEngine = SharedPtr<CoreEngine>( pEngine );


   g_pEngine->Initialize( cmdLineString );
   LoadSampleSimpleMesh();


   ShowWindow(hWnd, nCmdShow);
   UpdateWindow(hWnd);

   return TRUE;
}

//
//  FUNCTION: WndProc(HWND, UINT, WPARAM, LPARAM)
//
//  PURPOSE: Processes messages for the main window.
//
//  WM_PAINT    - Paint the main window
//  WM_DESTROY  - post a quit message and return
//
//
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
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

int main()
{
	return WinMain( GetModuleHandle( NULL ), NULL, GetCommandLineA(), SW_SHOWNORMAL );
}