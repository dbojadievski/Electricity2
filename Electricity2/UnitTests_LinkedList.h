#pragma once
#include <assert.h>
#include "CoreTypes.h"
#include "UnitTests.h"

class UnitTest_LinkedList : UnitTest
{
public:
	UnitTest_LinkedList () noexcept : UnitTest("UnitTest_LinkedList") { }
private:
	void UnitTest_LinkedList_Create() const
{
	{
		// Creation of a single-element list from a given value.
		ListNode<uint32> list( 42 );
		assert( list.GetValue() == 42 );
		assert( list.GetPrev() == nullptr );
		assert( list.GetNext() == nullptr );
	}

	{
		// Creation of a single-element list from a given other node.
		// Also tests the equality operator.
		ListNode<uint32> list( 42 );
		ListNode<uint32> copy( list );
		assert( list == copy );
	}

	{
		// Assignment operator test.
		ListNode<uint32> list( 42 );
		ListNode<uint32> copy = list;
		assert( list == copy );
	}

	{
		// Move constructor test.
		ListNode<uint32> list( 42 );
		ListNode<uint32> moved = std::move( list );
		assert( moved.GetValue() == 42 );
		assert( list.GetValue() == 0 );
	}
}
	void UnitTest_LinkedList_Add() const 
{
	{
		// Insertion. No middle elements.
		ListNode<uint32> head( 1 );
		ListNode<uint32> tail( 2 );
		head.Insert( tail );
		assert( head.IsHead() );
		assert( !head.IsTail() );
		assert( tail.IsTail() );
		assert( !tail.IsHead() );
		assert( *( head.GetNext() ) == tail );
		assert( *( tail.GetPrev() ) == head );
	}

	{
		// Inserting in middle.
		ListNode<uint32> head( 1 );
		ListNode<uint32> tail( 3 );
		head.Insert( tail );
		assert( head.IsHead() );
		assert( tail.IsTail() );
		assert( head.GetNext() == &tail );
		assert( tail.GetPrev() == &head );

		ListNode<uint32> middle( 2 );
		head.Insert( middle );
		assert( head.IsHead() );
		assert( head.GetNext() == &middle );
		assert( middle.IsMiddle() );
		assert( middle.GetPrev() == &head );
		assert( middle.GetNext() == &tail );
		assert( tail.IsTail() );
		assert( tail.GetPrev() == &middle );
	}
}
	
	virtual bool operator()() const 
	{
		UnitTest_LinkedList_Create();
		UnitTest_LinkedList_Add();

		return true;
	}
};

UnitTest_LinkedList LinkedListTest;
