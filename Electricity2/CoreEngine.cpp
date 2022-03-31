#include "CoreEngine.h"

#include <assert.h>
#include "CoreTimer.h"
#include "Heap.h"
#include "PAR.h"
#include "SettingsSystem.h"
#include "TaskQueue.h"


CoreEngine::CoreEngine() noexcept :
	m_uPrevFrameTime( 0 )
	, m_pSettingsSystem( nullptr )
{
}

CoreEngine::~CoreEngine() noexcept
{
	ShutDown();
}

void
CoreEngine::Update() noexcept
{
	// Get timer and calculate difference used in simulation.
	const uint32 uCurrFrameTime = CoreTimer::GetUptimeInMilliseconds();
	const uint32 uFrameDelta	= ( uCurrFrameTime - m_uPrevFrameTime );

	// Update all systems.
	m_pSettingsSystem->Update( uFrameDelta );
	Electricity::Rendering::PAR::Update( uFrameDelta );
	m_uPrevFrameTime			= uCurrFrameTime;
}

SharedPtr<SettingsSystem>
CoreEngine::GetSettingsSystem() noexcept
{
	return m_pSettingsSystem;
}

void
CoreEngine::Initialize( const StringView& sCmdLine ) noexcept
{
	HeapManager::Initialize();
	m_pSettingsSystem = CreateObject(SettingsSystem);
	assert( m_pSettingsSystem.IsValid() );

	m_pSettingsSystem->Initialize();

	TaskQueue::Initialize();
	Electricity::Rendering::PAR::Initialize();
}

void
CoreEngine::ShutDown() noexcept
{
	Electricity::Rendering::PAR::ShutDown();
	TaskQueue::Deinitialize();
	m_pSettingsSystem->Deinitialize();
	m_pSettingsSystem.RemoveRef();
	HeapManager::ShutDown();
	m_uPrevFrameTime = 0;
}

SharedPtr<CoreEngine> g_pEngine = nullptr;