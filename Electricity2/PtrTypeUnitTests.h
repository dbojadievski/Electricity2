#pragma once

#include <assert.h>
#include "CoreTypes.h"
#include "SharedPtr.h"
#include "UniquePtr.h"
#include "UnitTests.h"
#include <string.h>

using std::string;
class UnitTest_SharedPtr : UnitTest
{
public:
	UnitTest_SharedPtr() noexcept : UnitTest( "UnitTest_SharedPtr" ) {}
private:
	virtual bool operator()() const
	{
		{
			// Creation from nullptr.
			SharedPtr<int32> Pt1;
			assert( Pt1.IsValid() == false );
		}

		{
			// Creation from dynamically allocated memory.
			string* pText = new string( "Sample string" );
			SharedPtr<string> Pt1( pText );
			assert( Pt1.IsValid() );
		}

		{
			// Creation from copy constructor.
			string* pText = new string( "Copy Constructor" );
			SharedPtr<string> Pt1( pText );
			assert( Pt1.IsValid() );
			{
				SharedPtr<string> Pt2( Pt1 );
				assert( Pt2.IsValid() );
				assert( Pt1.IsValid() );
				assert( Pt2.GetRefCount() == Pt1.GetRefCount() );
				assert( Pt2.GetRefCount() == 2 );
			}

			assert( Pt1.IsValid() );
			assert( Pt1.GetRefCount() == 1 );
		}

		{
			// Move constructor.
			string* pText = new string( "Move constructor" );
			SharedPtr<string> Pt1( pText );
			assert( Pt1.IsValid() );
			assert( Pt1.GetRefCount() == 1 );
			SharedPtr<string> Pt2( std::move( Pt1 ) );
			assert( Pt2.IsValid() );
			assert( Pt2.GetRefCount() == 1 );
			assert( !Pt1.IsValid() );
		}

		{
			// Move operator.
			string* pText = new string( "Move constructor" );
			SharedPtr<string> Pt1( pText );
			assert( Pt1.IsValid() );
			assert( Pt1.GetRefCount() == 1 );
			SharedPtr<string> Pt2 = std::move( Pt1 );
			assert( Pt2.IsValid() );
			assert( Pt2.GetRefCount() == 1 );
			assert( !Pt1.IsValid() );
		}

		{
			// Implementing nullptr.
			SharedPtr<uint32> pInt( nullptr );
			assert( pInt.GetRefCount() );
		}

		{
			// Constructing from inherited class.
			struct Vec2
			{
				float m_X;
				float m_Y;

				Vec2( float fInX = 0, float fInY = 0 )
					: m_X( fInX )
					, m_Y( fInY )
				{

				}
			};

			struct Vec3 : Vec2
			{
				float m_fZ;

				Vec3( float fInX = 0, float fInY = 0, float fInZ = 0 )
					: m_fZ( fInZ )
					, Vec2( fInX, fInY )
				{

				}
			};

			{
				// Storing derived class.
				SharedPtr<Vec2> Origin( new Vec3() );
				assert( Origin.IsValid() );
			}

			{
				// Copying / assigning derived class.
				SharedPtr<Vec2> Origin( new Vec3() );
				SharedPtr<Vec2> Origin2 = Origin;
				assert( Origin.IsValid() );
				assert( Origin2.IsValid() );
				assert( Origin.GetRefCount() == 2 );
				assert( Origin2.GetRefCount() == 2 );
			}

			{
				// Moving derived class.
				SharedPtr<Vec2> Origin( new Vec3() );
				SharedPtr<Vec2> Origin2( std::move( Origin ) );
				assert( !Origin.IsValid() );
				assert( Origin2.IsValid() );
				assert( Origin2.GetRefCount() == 1 );
			}
		}

		return true;
	}
};

UnitTest_SharedPtr SharedPtrTest;

class UnitTest_UniquePtr : UnitTest
{
public:
	UnitTest_UniquePtr() noexcept: UnitTest( "UnitTest_UniquePtr" ) {}

	virtual bool operator()() const
	{
		{
			// Create from dynamically allocated object.
			string* pstrObj = new string( "Dynamically allocated object." );
			UniquePtr<string> Ptr( pstrObj );
			assert( Ptr.IsValid() );
		}

		{
			// Move from one object to another.
			string* pstrMove = new string( "Move test" );

			UniquePtr<string> Ptr1( pstrMove );
			assert( Ptr1.IsValid() );

			UniquePtr<string> Ptr2 = std::move( Ptr1 );
			assert( Ptr2.IsValid() );
			assert( !Ptr1.IsValid() );
		}

		return true;
	}
};

UnitTest_UniquePtr UniquePtrTest;