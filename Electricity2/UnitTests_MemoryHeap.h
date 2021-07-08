#ifdef _DEBUG
#pragma once
#include <assert.h>

#include "CoreTypes.h"
#include "Heap.h"
#include "UnitTests.h"

class UnitTest_Heap : UnitTest
{
public:
	UnitTest_Heap() noexcept : UnitTest( "UnitTest_Heap" ) {}
private:
	struct Vector3
	{
		operator size_t () const { return sizeof( this ); }
		float m_fX, m_fY, m_fZ;

		/// <summary>
		/// Can be called from gcnew.
		/// </summary>
		Vector3() : m_fX( 0 ), m_fY( 0 ), m_fZ( 0 )
		{
		}

		/// <summary>
		/// Can't be called from gcnew.
		/// </summary>
		/// <param name="fX"></param>
		/// <param name="fY"></param>
		/// <param name="fZ"></param>
		Vector3( const float fX, const float fY, const float fZ ) :
			m_fX( fX )
			, m_fY( fY )
			, m_fZ( fZ )
		{
		}

		// Should be called from gcdelete.
		~Vector3()
		{
		}
	};

	void UnitTest_Heap_All() const
	{
		// The first one we'll properly delete and make sure it doesn't go boom.
		SharedPtr<Vector3> pSharedVector = CreateObject( Vector3 ); /* static_cast< Vector3* >( gcnew( Vector3 ) )*/;
		DeleteObject( &pSharedVector );
		//assert( pSharedVector = nullptr );
		
		bool bPassedSecondTest = false;
		Vector3* pVector = nullptr;
		try
		{
			// Let's see what happens when we new some memory.
			// The second one we'll forget about and let it explode.
			pVector = static_cast< Vector3* >( gcnew( Vector3 ) );
			assert( pVector );
			HeapManager::CheckForMemoryLeak();
		}
		catch (...)
		{
			bPassedSecondTest = true;
			gcdelete( pVector );
			
		}
		assert( bPassedSecondTest );
	}

	virtual bool operator()() const
	{
		UnitTest_Heap_All();
		return true;
	}
};

UnitTest_Heap HeapTest;
#endif