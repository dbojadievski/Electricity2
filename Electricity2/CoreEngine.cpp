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
	m_pSettingsSystem = CreateObject(SettingsSystem);
	assert( m_pSettingsSystem.IsValid() );

	const uint32 uNumClassIds	= m_pSettingsSystem->GetInheritanceChainDepth();
	assert( uNumClassIds == 3 );

	const auto ID = CoreSystem::GetClassId();
	const bool bIsCoreSystem	= m_pSettingsSystem->IsA<CoreSystem>();
	assert( bIsCoreSystem );
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

	m_uPrevFrameTime = 0;
}

SharedPtr<CoreEngine> g_pEngine = nullptr;