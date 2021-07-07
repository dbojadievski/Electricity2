#line 1 "C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\Heap.cpp"
#line 1 "C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\Heap.h"
#pragma once
#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\assert.h"
//
// assert.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// Defines the assert macro and related functionality.
//


#line 11 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\assert.h"

#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
//
// corecrt.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// Declarations used throughout the CoreCRT library.
//
#pragma once

#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
//
// vcruntime.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// Declarations used throughout the VCRuntime library.
//
#pragma once
//
// Note on use of "deprecate":
//
// Various places in this header and other headers use
// __declspec(deprecate) or macros that have the term DEPRECATE in them.
// We use "deprecate" here ONLY to signal the compiler to emit a warning
// about these items. The use of "deprecate" should NOT be taken to imply
// that any standard committee has deprecated these functions from the
// relevant standards.  In fact, these functions are NOT deprecated from
// the standard.
//
// Full details can be found in our documentation by searching for
// "Security Enhancements in the CRT".
//




// Many VCRuntime headers avoid exposing their contents to non-compilers like
// the Windows resource compiler and Qt's meta-object compiler (moc).


#line 32 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

#line 34 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
#line 35 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"


    
#line 39 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

// The _CRTIMP macro is not used in the VCRuntime or the CoreCRT anymore, but
// there is a lot of existing code that declares CRT functions using this macro,
// and if we remove its definition, we break that existing code.  It is thus
// defined here only for compatibility.

    
    

#line 49 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
        
            
        

#line 54 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
    #line 55 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
#line 56 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"
/***
*sal.h - markers for documenting the semantics of APIs
*
*       Copyright (c) Microsoft Corporation. All rights reserved.
*
*Purpose:
*       sal.h provides a set of annotations to describe how a function uses its
*       parameters - the assumptions it makes about them, and the guarantees it makes
*       upon finishing.
*
*       [Public]
*
****/
#pragma once

/*==========================================================================

   The comments in this file are intended to give basic understanding of
   the usage of SAL, the Microsoft Source Code Annotation Language.
   For more details, please see https://go.microsoft.com/fwlink/?LinkID=242134

   The macros are defined in 3 layers, plus the structural set:

   _In_/_Out_/_Ret_ Layer:
   ----------------------
   This layer provides the highest abstraction and its macros should be used
   in most cases. These macros typically start with:
      _In_     : input parameter to a function, unmodified by called function
      _Out_    : output parameter, written to by called function, pointed-to
                 location not expected to be initialized prior to call
      _Outptr_ : like _Out_ when returned variable is a pointer type
                 (so param is pointer-to-pointer type). Called function
                 provides/allocated space.
      _Outref_ : like _Outptr_, except param is reference-to-pointer type.
      _Inout_  : inout parameter, read from and potentially modified by
                 called function.
      _Ret_    : for return values
      _Field_  : class/struct field invariants
   For common usage, this class of SAL provides the most concise annotations.
   Note that _In_/_Out_/_Inout_/_Outptr_ annotations are designed to be used
   with a parameter target. Using them with _At_ to specify non-parameter
   targets may yield unexpected results.

   This layer also includes a number of other properties that can be specified
   to extend the ability of code analysis, most notably:
      -- Designating parameters as format strings for printf/scanf/scanf_s
      -- Requesting stricter type checking for C enum parameters

   _Pre_/_Post_ Layer:
   ------------------
   The macros of this layer only should be used when there is no suitable macro
   in the _In_/_Out_ layer. Its macros start with _Pre_ or _Post_.
   This layer provides the most flexibility for annotations.

   Implementation Abstraction Layer:
   --------------------------------
   Macros from this layer should never be used directly. The layer only exists
   to hide the implementation of the annotation macros.

   Structural Layer:
   ----------------
   These annotations, like _At_ and _When_, are used with annotations from
   any of the other layers as modifiers, indicating exactly when and where
   the annotations apply.


   Common syntactic conventions:
   ----------------------------

   Usage:
   -----
   _In_, _Out_, _Inout_, _Pre_, _Post_, are for formal parameters.
   _Ret_, _Deref_ret_ must be used for return values.

   Nullness:
   --------
   If the parameter can be NULL as a precondition to the function, the
   annotation contains _opt. If the macro does not contain '_opt' the
   parameter cannot be NULL.

   If an out/inout parameter returns a null pointer as a postcondition, this is
   indicated by _Ret_maybenull_ or _result_maybenull_. If the macro is not
   of this form, then the result will not be NULL as a postcondition.
     _Outptr_ - output value is not NULL
     _Outptr_result_maybenull_ - output value might be NULL

   String Type:
   -----------
   _z: NullTerminated string
   for _In_ parameters the buffer must have the specified stringtype before the call
   for _Out_ parameters the buffer must have the specified stringtype after the call
   for _Inout_ parameters both conditions apply

   Extent Syntax:
   -------------
   Buffer sizes are expressed as element counts, unless the macro explicitly
   contains _byte_ or _bytes_. Some annotations specify two buffer sizes, in
   which case the second is used to indicate how much of the buffer is valid
   as a postcondition. This table outlines the precondition buffer allocation
   size, precondition number of valid elements, postcondition allocation size,
   and postcondition number of valid elements for representative buffer size
   annotations:
                                     Pre    |  Pre    |  Post   |  Post
                                     alloc  |  valid  |  alloc  |  valid
      Annotation                     elems  |  elems  |  elems  |  elems
      ----------                     ------------------------------------
      _In_reads_(s)                    s    |   s     |   s     |   s
      _Inout_updates_(s)               s    |   s     |   s     |   s
      _Inout_updates_to_(s,c)          s    |   s     |   s     |   c
      _Out_writes_(s)                  s    |   0     |   s     |   s
      _Out_writes_to_(s,c)             s    |   0     |   s     |   c
      _Outptr_result_buffer_(s)        ?    |   ?     |   s     |   s
      _Outptr_result_buffer_to_(s,c)   ?    |   ?     |   s     |   c

   For the _Outptr_ annotations, the buffer in question is at one level of
   dereference. The called function is responsible for supplying the buffer.

   Success and failure:
   -------------------
   The SAL concept of success allows functions to define expressions that can
   be tested by the caller, which if it evaluates to non-zero, indicates the
   function succeeded, which means that its postconditions are guaranteed to
   hold.  Otherwise, if the expression evaluates to zero, the function is
   considered to have failed, and the postconditions are not guaranteed.

   The success criteria can be specified with the _Success_(expr) annotation:
     _Success_(return != FALSE) BOOL
     PathCanonicalizeA(_Out_writes_(MAX_PATH) LPSTR pszBuf, LPCSTR pszPath) :
        pszBuf is only guaranteed to be NULL-terminated when TRUE is returned,
        and FALSE indicates failure. In common practice, callers check for zero
        vs. non-zero returns, so it is preferable to express the success
        criteria in terms of zero/non-zero, not checked for exactly TRUE.

   Functions can specify that some postconditions will still hold, even when
   the function fails, using _On_failure_(anno-list), or postconditions that
   hold regardless of success or failure using _Always_(anno-list).

   The annotation _Return_type_success_(expr) may be used with a typedef to
   give a default _Success_ criteria to all functions returning that type.
   This is the case for common Windows API status types, including
   HRESULT and NTSTATUS.  This may be overridden on a per-function basis by
   specifying a _Success_ annotation locally.

============================================================================*/





#line 151 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"



#line 155 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"

























// Disable expansion of SAL macros in non-Prefast mode to
// improve compiler throughput.


#line 185 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"


#line 188 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"

#line 190 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"

// safeguard for MIDL and RC builds



#line 196 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"



#line 200 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"






#line 207 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"











#line 219 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"






// Some annotations aren't officially SAL2 yet.

#line 228 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"
#line 229 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"


//============================================================================
//   Structural SAL:
//     These annotations modify the use of other annotations.  They may
//     express the annotation target (i.e. what parameter/field the annotation
//     applies to) or the condition under which the annotation is applicable.
//============================================================================

// _At_(target, annos) specifies that the annotations listed in 'annos' is to
// be applied to 'target' rather than to the identifier which is the current
// lexical target.


// _At_buffer_(target, iter, bound, annos) is similar to _At_, except that
// target names a buffer, and each annotation in annos is applied to each
// element of target up to bound, with the variable named in iter usable
// by the annotations to refer to relevant offsets within target.


// _When_(expr, annos) specifies that the annotations listed in 'annos' only
// apply when 'expr' evaluates to non-zero.




// <expr> indicates whether normal post conditions apply to a function


// <expr> indicates whether post conditions apply to a function returning
// the type that this annotation is applied to


// Establish postconditions that apply only if the function does not succeed


// Establish postconditions that apply in both success and failure cases.
// Only applicable with functions that have  _Success_ or _Return_type_succss_.


// Usable on a function defintion. Asserts that a function declaration is
// in scope, and its annotations are to be used. There are no other annotations
// allowed on the function definition.


// _Notref_ may precede a _Deref_ or "real" annotation, and removes one
// level of dereference if the parameter is a C++ reference (&).  If the
// net deref on a "real" annotation is negative, it is simply discarded.


// Annotations for defensive programming styles.







//============================================================================
//   _In_/_Out_ Layer:
//============================================================================

// Reserved pointer parameters, must always be NULL.


// _Const_ allows specification that any namable memory location is considered
// readonly for a given call.



// Input parameters --------------------------

//   _In_ - Annotations for parameters where data is passed into the function, but not modified.
//          _In_ by itself can be used with non-pointer types (although it is redundant).

// e.g. void SetPoint( _In_ const POINT* pPT );



// nullterminated 'in' parameters.
// e.g. void CopyStr( _In_z_ const char* szFrom, _Out_z_cap_(cchTo) char* szTo, size_t cchTo );




// 'input' buffers with given size











// 'input' buffers valid to the given end pointer








// Output parameters --------------------------

//   _Out_ - Annotations for pointer or reference parameters where data passed back to the caller.
//           These are mostly used where the pointer/reference is to a non-pointer type.
//           _Outptr_/_Outref) (see below) are typically used to return pointers via parameters.

// e.g. void GetPoint( _Out_ POINT* pPT );


























// Inout parameters ----------------------------

//   _Inout_ - Annotations for pointer or reference parameters where data is passed in and
//        potentially modified.
//          void ModifyPoint( _Inout_ POINT* pPT );
//          void ModifyPointByRef( _Inout_ POINT& pPT );




// For modifying string buffers
//   void toupper( _Inout_z_ char* sz );



// For modifying buffers with explicit element size











// For modifying buffers with explicit byte size










// Pointer to pointer parameters -------------------------

//   _Outptr_ - Annotations for output params returning pointers
//      These describe parameters where the called function provides the buffer:
//        HRESULT SHStrDupW(_In_ LPCWSTR psz, _Outptr_ LPWSTR *ppwsz);
//      The caller passes the address of an LPWSTR variable as ppwsz, and SHStrDupW allocates
//      and initializes memory and returns the pointer to the new LPWSTR in *ppwsz.
//
//    _Outptr_opt_ - describes parameters that are allowed to be NULL.
//    _Outptr_*_result_maybenull_ - describes parameters where the called function might return NULL to the caller.
//
//    Example:
//       void MyFunc(_Outptr_opt_ int **ppData1, _Outptr_result_maybenull_ int **ppData2);
//    Callers:
//       MyFunc(NULL, NULL);           // error: parameter 2, ppData2, should not be NULL
//       MyFunc(&pData1, &pData2);     // ok: both non-NULL
//       if (*pData1 == *pData2) ...   // error: pData2 might be NULL after call






// Annotations for _Outptr_ parameters returning pointers to null terminated strings.






// Annotations for _Outptr_ parameters where the output pointer is set to NULL if the function fails.




// Annotations for _Outptr_ parameters which return a pointer to a ref-counted COM object,
// following the COM convention of setting the output to NULL on failure.
// The current implementation is identical to _Outptr_result_nullonfailure_.
// For pointers to types that are not COM objects, _Outptr_result_nullonfailure_ is preferred.






// Annotations for _Outptr_ parameters returning a pointer to buffer with a specified number of elements/bytes

































// Annotations for output reference to pointer parameters.


















// Annotations for output reference to pointer parameters that guarantee
// that the pointer is set to NULL on failure.


// Generic annotations to set output value of a by-pointer or by-reference parameter to null/zero on failure.




// return values -------------------------------

//
// _Ret_ annotations
//
// describing conditions that hold for return values after the call

// e.g. _Ret_z_ CString::operator const wchar_t*() const noexcept;



// used with allocated but not yet initialized objects




// used with allocated and initialized objects
//    returns single valid object


//    returns pointer to initialized buffer of specified size







//    returns pointer to partially initialized buffer, with total size 'size' and initialized size 'count'






// Annotations for strict type checking




// Check the return value of a function e.g. _Check_return_ ErrorCode Foo();



// e.g. MyPrintF( _Printf_format_string_ const wchar_t* wzFormat, ... );









// annotations to express value of integral or pointer parameter









// annotation to express that a value (usually a field of a mutable class)
// is not changed by a function call


// Annotations to allow expressing generalized pre and post conditions.
// 'cond' may be any valid SAL expression that is considered to be true as a precondition
// or postcondition (respsectively).



// Annotations to express struct, class and field invariants




















//============================================================================
//   _Pre_/_Post_ Layer:
//============================================================================

//
// Raw Pre/Post for declaring custom pre/post conditions
//




//
// Validity property
//





//
// Buffer size properties
//

// Expressing buffer sizes without specifying pre or post condition








// Expressing buffer size as pre or post condition










//
// Pointer null-ness properties
//




//
// _Pre_ annotations ---
//
// describing conditions that must be met before the call of the function

// e.g. int strlen( _Pre_z_ const char* sz );
// buffer is a zero terminated string


// valid size unknown or indicated by type (e.g.:LPSTR)





// Overrides recursive valid when some field is not yet initialized when using _Inout_


// used with allocated but not yet initialized objects




//
// _Post_ annotations ---
//
// describing conditions that hold after the function call

// void CopyStr( _In_z_ const char* szFrom, _Pre_cap_(cch) _Post_z_ char* szFrom, size_t cchFrom );
// buffer will be a zero-terminated string after the call


// e.g. HRESULT InitStruct( _Post_valid_ Struct* pobj );



// e.g. void free( _Post_ptr_invalid_ void* pv );


// e.g. void ThrowExceptionIfNull( _Post_notnull_ const void* pv );


// e.g. HRESULT GetObject(_Outptr_ _On_failure_(_At_(*p, _Post_null_)) T **p);







#pragma region Input Buffer SAL 1 compatibility macros

/*==========================================================================

   This section contains definitions for macros defined for VS2010 and earlier.
   Usage of these macros is still supported, but the SAL 2 macros defined above
   are recommended instead.  This comment block is retained to assist in
   understanding SAL that still uses the older syntax.

   The macros are defined in 3 layers:

   _In_/_Out_ Layer:
   ----------------
   This layer provides the highest abstraction and its macros should be used
   in most cases. Its macros start with _In_, _Out_ or _Inout_. For the
   typical case they provide the most concise annotations.

   _Pre_/_Post_ Layer:
   ------------------
   The macros of this layer only should be used when there is no suitable macro
   in the _In_/_Out_ layer. Its macros start with _Pre_, _Post_, _Ret_,
   _Deref_pre_ _Deref_post_ and _Deref_ret_. This layer provides the most
   flexibility for annotations.

   Implementation Abstraction Layer:
   --------------------------------
   Macros from this layer should never be used directly. The layer only exists
   to hide the implementation of the annotation macros.


   Annotation Syntax:
   |--------------|----------|----------------|-----------------------------|
   |   Usage      | Nullness | ZeroTerminated |  Extent                     |
   |--------------|----------|----------------|-----------------------------|
   | _In_         | <>       | <>             | <>                          |
   | _Out_        | opt_     | z_             | [byte]cap_[c_|x_]( size )   |
   | _Inout_      |          |                | [byte]count_[c_|x_]( size ) |
   | _Deref_out_  |          |                | ptrdiff_cap_( ptr )         |
   |--------------|          |                | ptrdiff_count_( ptr )       |
   | _Ret_        |          |                |                             |
   | _Deref_ret_  |          |                |                             |
   |--------------|          |                |                             |
   | _Pre_        |          |                |                             |
   | _Post_       |          |                |                             |
   | _Deref_pre_  |          |                |                             |
   | _Deref_post_ |          |                |                             |
   |--------------|----------|----------------|-----------------------------|

   Usage:
   -----
   _In_, _Out_, _Inout_, _Pre_, _Post_, _Deref_pre_, _Deref_post_ are for
   formal parameters.
   _Ret_, _Deref_ret_ must be used for return values.

   Nullness:
   --------
   If the pointer can be NULL the annotation contains _opt. If the macro
   does not contain '_opt' the pointer may not be NULL.

   String Type:
   -----------
   _z: NullTerminated string
   for _In_ parameters the buffer must have the specified stringtype before the call
   for _Out_ parameters the buffer must have the specified stringtype after the call
   for _Inout_ parameters both conditions apply

   Extent Syntax:
   |------|---------------|---------------|
   | Unit | Writ/Readable | Argument Type |
   |------|---------------|---------------|
   |  <>  | cap_          | <>            |
   | byte | count_        | c_            |
   |      |               | x_            |
   |------|---------------|---------------|

   'cap' (capacity) describes the writable size of the buffer and is typically used
   with _Out_. The default unit is elements. Use 'bytecap' if the size is given in bytes
   'count' describes the readable size of the buffer and is typically used with _In_.
   The default unit is elements. Use 'bytecount' if the size is given in bytes.

   Argument syntax for cap_, bytecap_, count_, bytecount_:
   (<parameter>|return)[+n]  e.g. cch, return, cb+2

   If the buffer size is a constant expression use the c_ postfix.
   E.g. cap_c_(20), count_c_(MAX_PATH), bytecount_c_(16)

   If the buffer size is given by a limiting pointer use the ptrdiff_ versions
   of the macros.

   If the buffer size is neither a parameter nor a constant expression use the x_
   postfix. e.g. bytecount_x_(num*size) x_ annotations accept any arbitrary string.
   No analysis can be done for x_ annotations but they at least tell the tool that
   the buffer has some sort of extent description. x_ annotations might be supported
   by future compiler versions.

============================================================================*/

// e.g. void SetCharRange( _In_count_(cch) const char* rgch, size_t cch )
// valid buffer extent described by another parameter





// valid buffer extent described by a constant extression





// nullterminated  'input' buffers with given size

// e.g. void SetCharRange( _In_count_(cch) const char* rgch, size_t cch )
// nullterminated valid buffer extent described by another parameter





// nullterminated valid buffer extent described by a constant extression





// buffer capacity is described by another pointer
// e.g. void Foo( _In_ptrdiff_count_(pchMax) const char* pch, const char* pchMax ) { while pch < pchMax ) pch++; }



// 'x' version for complex expressions that are not supported by the current compiler version
// e.g. void Set3ColMatrix( _In_count_x_(3*cRows) const Elem* matrix, int cRows );






// 'out' with buffer size
// e.g. void GetIndices( _Out_cap_(cIndices) int* rgIndices, size_t cIndices );
// buffer capacity is described by another parameter





// buffer capacity is described by a constant expression





// buffer capacity is described by another parameter multiplied by a constant expression





// buffer capacity is described by another pointer
// e.g. void Foo( _Out_ptrdiff_cap_(pchMax) char* pch, const char* pchMax ) { while pch < pchMax ) pch++; }



// buffer capacity is described by a complex expression





// a zero terminated string is filled into a buffer of given capacity
// e.g. void CopyStr( _In_z_ const char* szFrom, _Out_z_cap_(cchTo) char* szTo, size_t cchTo );
// buffer capacity is described by another parameter





// buffer capacity is described by a constant expression





// buffer capacity is described by a complex expression





// a zero terminated string is filled into a buffer of given capacity
// e.g. size_t CopyCharRange( _In_count_(cchFrom) const char* rgchFrom, size_t cchFrom, _Out_cap_post_count_(cchTo,return)) char* rgchTo, size_t cchTo );





// a zero terminated string is filled into a buffer of given capacity
// e.g. size_t CopyStr( _In_z_ const char* szFrom, _Out_z_cap_post_count_(cchTo,return+1) char* szTo, size_t cchTo );





// only use with dereferenced arguments e.g. '*pcch'










// e.g. GetString( _Out_z_capcount_(*pLen+1) char* sz, size_t* pLen );






// 'inout' buffers with initialized elements before and after the call
// e.g. void ModifyIndices( _Inout_count_(cIndices) int* rgIndices, size_t cIndices );










// nullterminated 'inout' buffers with initialized elements before and after the call
// e.g. void ModifyIndices( _Inout_count_(cIndices) int* rgIndices, size_t cIndices );


















// e.g. void AppendToLPSTR( _In_ LPCSTR szFrom, _Inout_cap_(cchTo) LPSTR* szTo, size_t cchTo );















// inout string buffers with writable size
// e.g. void AppendStr( _In_z_ const char* szFrom, _Inout_z_cap_(cchTo) char* szTo, size_t cchTo );
















// returning pointers to valid objects



// annotations to express 'boundedness' of integral value parameter








// e.g.  HRESULT HrCreatePoint( _Deref_out_opt_ POINT** ppPT );





// e.g.  void CloneString( _In_z_ const wchar_t* wzFrom, _Deref_out_z_ wchar_t** pWzTo );





//
// _Deref_pre_ ---
//
// describing conditions for array elements of dereferenced pointer parameters that must be met before the call

// e.g. void SaveStringArray( _In_count_(cStrings) _Deref_pre_z_ const wchar_t* const rgpwch[] );



// e.g. void FillInArrayOfStr32( _In_count_(cStrings) _Deref_pre_cap_c_(32) _Deref_post_z_ wchar_t* const rgpwch[] );
// buffer capacity is described by another parameter





// buffer capacity is described by a constant expression





// buffer capacity is described by a complex condition





// convenience macros for nullterminated buffers with given capacity















// known capacity and valid but unknown readable extent















// e.g. void SaveMatrix( _In_count_(n) _Deref_pre_count_(n) const Elem** matrix, size_t n );
// valid buffer extent is described by another parameter





// valid buffer extent is described by a constant expression





// valid buffer extent is described by a complex expression





// e.g. void PrintStringArray( _In_count_(cElems) _Deref_pre_valid_ LPCSTR rgStr[], size_t cElems );








// restrict access rights



//
// _Deref_post_ ---
//
// describing conditions for array elements or dereferenced pointer parameters that hold after the call

// e.g. void CloneString( _In_z_ const Wchar_t* wzIn _Out_ _Deref_post_z_ wchar_t** pWzOut );



// e.g. HRESULT HrAllocateMemory( size_t cb, _Out_ _Deref_post_bytecap_(cb) void** ppv );
// buffer capacity is described by another parameter





// buffer capacity is described by a constant expression





// buffer capacity is described by a complex expression





// convenience macros for nullterminated buffers with given capacity















// known capacity and valid but unknown readable extent















// e.g. HRESULT HrAllocateZeroInitializedMemory( size_t cb, _Out_ _Deref_post_bytecount_(cb) void** ppv );
// valid buffer extent is described by another parameter





// buffer capacity is described by a constant expression





// buffer capacity is described by a complex expression





// e.g. void GetStrings( _Out_count_(cElems) _Deref_post_valid_ LPSTR const rgStr[], size_t cElems );







//
// _Deref_ret_ ---
//




//
// special _Deref_ ---
//


//
// _Ret_ ---
//

// e.g. _Ret_opt_valid_ LPSTR void* CloneSTR( _Pre_valid_ LPSTR src );



// e.g. _Ret_opt_bytecap_(cb) void* AllocateMemory( size_t cb );
// Buffer capacity is described by another parameter





// Buffer capacity is described by a constant expression





// Buffer capacity is described by a complex condition





// return value is nullterminated and capacity is given by another parameter





// e.g. _Ret_opt_bytecount_(cb) void* AllocateZeroInitializedMemory( size_t cb );
// Valid Buffer extent is described by another parameter





// Valid Buffer extent is described by a constant expression





// Valid Buffer extent is described by a complex expression





// return value is nullterminated and length is given by another parameter






// _Pre_ annotations ---


// restrict access rights



// e.g. void FreeMemory( _Pre_bytecap_(cb) _Post_ptr_invalid_ void* pv, size_t cb );
// buffer capacity described by another parameter





// buffer capacity described by a constant expression







// buffer capacity is described by another parameter multiplied by a constant expression



// buffer capacity described by size of other buffer, only used by dangerous legacy APIs
// e.g. int strcpy(_Pre_cap_for_(src) char* dst, const char* src);



// buffer capacity described by a complex condition





// buffer capacity described by the difference to another pointer parameter



// e.g. void AppendStr( _Pre_z_ const char* szFrom, _Pre_z_cap_(cchTo) _Post_z_ char* szTo, size_t cchTo );















// known capacity and valid but unknown readable extent















// e.g. void AppendCharRange( _Pre_count_(cchFrom) const char* rgFrom, size_t cchFrom, _Out_z_cap_(cchTo) char* szTo, size_t cchTo );
// Valid buffer extent described by another parameter





// Valid buffer extent described by a constant expression





// Valid buffer extent described by a complex expression





// Valid buffer extent described by the difference to another pointer parameter




// char * strncpy(_Out_cap_(_Count) _Post_maybez_ char * _Dest, _In_z_ const char * _Source, _In_ size_t _Count)
// buffer maybe zero-terminated after the call


// e.g. SIZE_T HeapSize( _In_ HANDLE hHeap, DWORD dwFlags, _Pre_notnull_ _Post_bytecap_(return) LPCVOID lpMem );



// e.g. int strlen( _In_z_ _Post_count_(return+1) const char* sz );







// e.g. size_t CopyStr( _In_z_ const char* szFrom, _Pre_cap_(cch) _Post_z_count_(return+1) char* szFrom, size_t cchFrom );







//
// _Prepost_ ---
//
// describing conditions that hold before and after the function call



















//
// _Deref_<both> ---
//
// short version for _Deref_pre_<ann> _Deref_post_<ann>
// describing conditions for array elements or dereferenced pointer parameters that hold before and after the call










































//
// _Deref_<miscellaneous>
//
// used with references to arrays







#pragma endregion Input Buffer SAL 1 compatibility macros


//============================================================================
//   Implementation Layer:
//============================================================================


// Naming conventions:
// A symbol the begins with _SA_ is for the machinery of creating any
// annotations; many of those come from sourceannotations.h in the case
// of attributes.

// A symbol that ends with _impl is the very lowest level macro.  It is
// not required to be a legal standalone annotation, and in the case
// of attribute annotations, usually is not.  (In the case of some declspec
// annotations, it might be, but it should not be assumed so.)  Those
// symbols will be used in the _PreN..., _PostN... and _RetN... annotations
// to build up more complete annotations.

// A symbol ending in _impl_ is reserved to the implementation as well,
// but it does form a complete annotation; usually they are used to build
// up even higher level annotations.



























































#line 1555 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"






























#line 1586 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"
























#line 1611 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"

// Using "nothing" for sal










#line 1624 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"






































#line 1663 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"















































































































#line 1775 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"






































































































#line 1878 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"








































































































































































#line 2047 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"

































































































// Obsolete -- may be needed for transition to attributes.



#line 2149 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"

// This section contains the deprecated annotations

/*
 -------------------------------------------------------------------------------
 Introduction

 sal.h provides a set of annotations to describe how a function uses its
 parameters - the assumptions it makes about them, and the guarantees it makes
 upon finishing.

 Annotations may be placed before either a function parameter's type or its return
 type, and describe the function's behavior regarding the parameter or return value.
 There are two classes of annotations: buffer annotations and advanced annotations.
 Buffer annotations describe how functions use their pointer parameters, and
 advanced annotations either describe complex/unusual buffer behavior, or provide
 additional information about a parameter that is not otherwise expressible.

 -------------------------------------------------------------------------------
 Buffer Annotations

 The most important annotations in sal.h provide a consistent way to annotate
 buffer parameters or return values for a function. Each of these annotations describes
 a single buffer (which could be a string, a fixed-length or variable-length array,
 or just a pointer) that the function interacts with: where it is, how large it is,
 how much is initialized, and what the function does with it.

 The appropriate macro for a given buffer can be constructed using the table below.
 Just pick the appropriate values from each category, and combine them together
 with a leading underscore. Some combinations of values do not make sense as buffer
 annotations. Only meaningful annotations can be added to your code; for a list of
 these, see the buffer annotation definitions section.

 Only a single buffer annotation should be used for each parameter.

 |------------|------------|---------|--------|----------|----------|---------------|
 |   Level    |   Usage    |  Size   | Output | NullTerm | Optional |  Parameters   |
 |------------|------------|---------|--------|----------|----------|---------------|
 | <>         | <>         | <>      | <>     | _z       | <>       | <>            |
 | _deref     | _in        | _ecount | _full  | _nz      | _opt     | (size)        |
 | _deref_opt | _out       | _bcount | _part  |          |          | (size,length) |
 |            | _inout     |         |        |          |          |               |
 |            |            |         |        |          |          |               |
 |------------|------------|---------|--------|----------|----------|---------------|

 Level: Describes the buffer pointer's level of indirection from the parameter or
          return value 'p'.

 <>         : p is the buffer pointer.
 _deref     : *p is the buffer pointer. p must not be NULL.
 _deref_opt : *p may be the buffer pointer. p may be NULL, in which case the rest of
                the annotation is ignored.

 Usage: Describes how the function uses the buffer.

 <>     : The buffer is not accessed. If used on the return value or with _deref, the
            function will provide the buffer, and it will be uninitialized at exit.
            Otherwise, the caller must provide the buffer. This should only be used
            for alloc and free functions.
 _in    : The function will only read from the buffer. The caller must provide the
            buffer and initialize it. Cannot be used with _deref.
 _out   : The function will only write to the buffer. If used on the return value or
            with _deref, the function will provide the buffer and initialize it.
            Otherwise, the caller must provide the buffer, and the function will
            initialize it.
 _inout : The function may freely read from and write to the buffer. The caller must
            provide the buffer and initialize it. If used with _deref, the buffer may
            be reallocated by the function.

 Size: Describes the total size of the buffer. This may be less than the space actually
         allocated for the buffer, in which case it describes the accessible amount.

 <>      : No buffer size is given. If the type specifies the buffer size (such as
             with LPSTR and LPWSTR), that amount is used. Otherwise, the buffer is one
             element long. Must be used with _in, _out, or _inout.
 _ecount : The buffer size is an explicit element count.
 _bcount : The buffer size is an explicit byte count.

 Output: Describes how much of the buffer will be initialized by the function. For
           _inout buffers, this also describes how much is initialized at entry. Omit this
           category for _in buffers; they must be fully initialized by the caller.

 <>    : The type specifies how much is initialized. For instance, a function initializing
           an LPWSTR must NULL-terminate the string.
 _full : The function initializes the entire buffer.
 _part : The function initializes part of the buffer, and explicitly indicates how much.

 NullTerm: States if the present of a '\0' marks the end of valid elements in the buffer.
 _z    : A '\0' indicated the end of the buffer
 _nz     : The buffer may not be null terminated and a '\0' does not indicate the end of the
          buffer.
 Optional: Describes if the buffer itself is optional.

 <>   : The pointer to the buffer must not be NULL.
 _opt : The pointer to the buffer might be NULL. It will be checked before being dereferenced.

 Parameters: Gives explicit counts for the size and length of the buffer.

 <>            : There is no explicit count. Use when neither _ecount nor _bcount is used.
 (size)        : Only the buffer's total size is given. Use with _ecount or _bcount but not _part.
 (size,length) : The buffer's total size and initialized length are given. Use with _ecount_part
                   and _bcount_part.

 -------------------------------------------------------------------------------
 Buffer Annotation Examples

 LWSTDAPI_(BOOL) StrToIntExA(
     __in LPCSTR pszString,
     DWORD dwFlags,
     __out int *piRet                     -- A pointer whose dereference will be filled in.
 );

 void MyPaintingFunction(
     __in HWND hwndControl,               -- An initialized read-only parameter.
     __in_opt HDC hdcOptional,            -- An initialized read-only parameter that might be NULL.
     __inout IPropertyStore *ppsStore     -- An initialized parameter that may be freely used
                                          --   and modified.
 );

 LWSTDAPI_(BOOL) PathCompactPathExA(
     __out_ecount(cchMax) LPSTR pszOut,   -- A string buffer with cch elements that will
                                          --   be NULL terminated on exit.
     __in LPCSTR pszSrc,
     UINT cchMax,
     DWORD dwFlags
 );

 HRESULT SHLocalAllocBytes(
     size_t cb,
     __deref_bcount(cb) T **ppv           -- A pointer whose dereference will be set to an
                                          --   uninitialized buffer with cb bytes.
 );

 __inout_bcount_full(cb) : A buffer with cb elements that is fully initialized at
     entry and exit, and may be written to by this function.

 __out_ecount_part(count, *countOut) : A buffer with count elements that will be
     partially initialized by this function. The function indicates how much it
     initialized by setting *countOut.

 -------------------------------------------------------------------------------
 Advanced Annotations

 Advanced annotations describe behavior that is not expressible with the regular
 buffer macros. These may be used either to annotate buffer parameters that involve
 complex or conditional behavior, or to enrich existing annotations with additional
 information.

 __success(expr) f :
     <expr> indicates whether function f succeeded or not. If <expr> is true at exit,
     all the function's guarantees (as given by other annotations) must hold. If <expr>
     is false at exit, the caller should not expect any of the function's guarantees
     to hold. If not used, the function must always satisfy its guarantees. Added
     automatically to functions that indicate success in standard ways, such as by
     returning an HRESULT.

 __nullterminated p :
     Pointer p is a buffer that may be read or written up to and including the first
     NULL character or pointer. May be used on typedefs, which marks valid (properly
     initialized) instances of that type as being NULL-terminated.

 __nullnullterminated p :
     Pointer p is a buffer that may be read or written up to and including the first
     sequence of two NULL characters or pointers. May be used on typedefs, which marks
     valid instances of that type as being double-NULL terminated.

 __reserved v :
     Value v must be 0/NULL, reserved for future use.

 __checkReturn v :
     Return value v must not be ignored by callers of this function.

 __typefix(ctype) v :
     Value v should be treated as an instance of ctype, rather than its declared type.

 __override f :
     Specify C#-style 'override' behaviour for overriding virtual methods.

 __callback f :
     Function f can be used as a function pointer.

 __format_string p :
     Pointer p is a string that contains % markers in the style of printf.

 __blocksOn(resource) f :
     Function f blocks on the resource 'resource'.

 __fallthrough :
     Annotates switch statement labels where fall-through is desired, to distinguish
     from forgotten break statements.

 -------------------------------------------------------------------------------
 Advanced Annotation Examples

 __success(return != FALSE) LWSTDAPI_(BOOL)
 PathCanonicalizeA(__out_ecount(MAX_PATH) LPSTR pszBuf, LPCSTR pszPath) :
    pszBuf is only guaranteed to be NULL-terminated when TRUE is returned.

 typedef __nullterminated WCHAR* LPWSTR : Initialized LPWSTRs are NULL-terminated strings.

 __out_ecount(cch) __typefix(LPWSTR) void *psz : psz is a buffer parameter which will be
     a NULL-terminated WCHAR string at exit, and which initially contains cch WCHARs.

 -------------------------------------------------------------------------------
*/






#line 2361 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"
extern "C" {




#line 2367 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"


/*
 -------------------------------------------------------------------------------
 Helper Macro Definitions

 These express behavior common to many of the high-level annotations.
 DO NOT USE THESE IN YOUR CODE.
 -------------------------------------------------------------------------------
*/

/*
    The helper annotations are only understood by the compiler version used by
    various defect detection tools. When the regular compiler is running, they
    are defined into nothing, and do not affect the compiled code.
*/



















































































































































































































#line 2595 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    
    

    
    

#line 2634 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"

/*
-------------------------------------------------------------------------------
Buffer Annotation Definitions

Any of these may be used to directly annotate functions, but only one should
be used for each parameter. To determine which annotation to use for a given
buffer, use the table in the buffer annotations section.
-------------------------------------------------------------------------------
*/
































































































































































































/*
-------------------------------------------------------------------------------
Advanced Annotation Definitions

Any of these may be used to directly annotate functions, and may be used in
combination with each other or with regular buffer macros. For an explanation
of each annotation, see the advanced annotations section.
-------------------------------------------------------------------------------
*/






















#line 2868 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"









#line 2878 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"



    
    


#line 2886 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"
#line 2887 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"






#line 2894 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"
#line 2895 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"






#line 2902 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"
#line 2903 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"











#line 2915 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"

//
// Set the analysis mode (global flags to analysis).
// They take effect at the point of declaration; use at global scope
// as a declaration.
//

// Synthesize a unique symbol.








//
// Floating point warnings are only meaningful in kernel-mode on x86
// so avoid reporting them on other platforms.
//













#line 2949 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"

// The following are predefined:
//  _Analysis_operator_new_throw_   (operator new throws)
//  _Analysis_operator_new_null_        (operator new returns null)
//  _Analysis_operator_new_never_fails_ (operator new never fails)
//

// Function class annotations.














}
#line 2973 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"

#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\concurrencysal.h"
/***
*concurrencysal.h - markers for documenting the concurrent semantics of APIs
*
*       Copyright (c) Microsoft Corporation. All rights reserved.
*
*Purpose:
*       This file contains macros for Concurrency SAL annotations. Definitions
*       starting with _Internal are low level macros that are subject to change.
*       Users should not use those low level macros directly.
*       [ANSI]
*
*       [Public]
*
****/




#pragma once


extern "C" {
#line 24 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\concurrencysal.h"











































































































































































































































































#line 292 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\concurrencysal.h"



#line 296 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\concurrencysal.h"
















































#line 345 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\concurrencysal.h"






/*
 * Old spelling: will be deprecated
 */


































#line 389 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\concurrencysal.h"


}
#line 393 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\concurrencysal.h"

#line 395 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\concurrencysal.h"
#line 2975 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\sal.h"
#line 58 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"
//
// vadefs.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// Definitions of macro helpers used by <stdarg.h>.  This is the topmost header
// in the CRT header lattice, and is always the first CRT header to be included,
// explicitly or implicitly.  Therefore, this header also has several definitions
// that are used throughout the CRT.
//
#pragma once



#pragma pack(push, 8)

// C4339: '__type_info_node': use of undefined type detected in CLR meta-data (/Wall)

    


        
    #line 24 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"
#line 25 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"

// C4412: function signature contains type '<typename>';
//        C++ objects are unsafe to pass between pure code and mixed or native. (/Wall)

    


        
    #line 34 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"
#line 35 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"

// Use _VCRUNTIME_EXTRA_DISABLED_WARNINGS to add additional warning suppressions to VCRuntime headers.

    
#line 40 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"

// C4514: unreferenced inline function has been removed (/Wall)
// C4820: '<typename>' : 'N' bytes padding added after data member (/Wall)

    
#line 46 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"

#pragma warning(push)
#pragma warning(disable:   4514 4820 )


extern "C" {
#line 53 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"



#line 57 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"


    
    
        typedef unsigned __int64  uintptr_t;
    

#line 65 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"
#line 66 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"


    
    


        typedef char* va_list;
    #line 74 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"
#line 75 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"


    


#line 81 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"





#line 87 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"



#line 91 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"
    
    
#line 94 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"











#line 106 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"







#line 114 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"











#line 126 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"





#line 132 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"










#line 143 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"










#line 154 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"

    void __cdecl __va_start(va_list* , ...);

    
    



    

#line 165 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"


} // extern "C"
#line 169 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"


    extern "C++"
    {
        template <typename _Ty>
        struct __vcrt_va_list_is_reference
        {
            enum : bool { __the_value = false };
        };

        template <typename _Ty>
        struct __vcrt_va_list_is_reference<_Ty&>
        {
            enum : bool { __the_value = true };
        };

        template <typename _Ty>
        struct __vcrt_va_list_is_reference<_Ty&&>
        {
            enum : bool { __the_value = true };
        };

        template <typename _Ty>
        struct __vcrt_assert_va_start_is_not_reference
        {
            static_assert(!__vcrt_va_list_is_reference<_Ty>::__the_value,
                "va_start argument must not have reference type and must not be parenthesized");
        };
    } // extern "C++"

    





#line 206 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vadefs.h"

#pragma warning(pop) 
#pragma pack(pop)
#line 59 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

#pragma warning(push)
#pragma warning(disable:   4514 4820 )

// All C headers have a common prologue and epilogue, to enclose the header in
// an extern "C" declaration when the header is #included in a C++ translation
// unit and to push/pop the packing.


    



    





















#line 95 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

__pragma(pack(push, 8)) extern "C" {




    


        
    #line 106 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
#line 107 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
















    

#line 126 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

#line 128 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
        
    #line 130 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
#line 131 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"


    

#line 136 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
        
    #line 138 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
#line 139 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

// Definitions of calling conventions used code sometimes compiled as managed



#line 145 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
    
    
#line 148 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"




    
#line 154 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"



// Definitions of common __declspecs




    


#line 166 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"



#line 170 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
    
#line 172 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"




    
#line 178 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"


    
        
        
    

#line 186 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
#line 187 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

// For backwards compatibility


// Definitions of common types

    typedef unsigned __int64 size_t;
    typedef __int64          ptrdiff_t;
    typedef __int64          intptr_t;




#line 201 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"


    typedef bool  __vcrt_bool;






#line 211 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

// Indicate that these common types are defined

    
#line 216 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"


    
#line 220 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"


    
#line 224 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

// Provide a typedef for wchar_t for use under /Zc:wchar_t-






    
        
    

#line 237 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
#line 238 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"


    


#line 244 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"



#line 248 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"


    extern "C++"
    {
        template <typename _CountofType, size_t _SizeOfArray>
        char (*__countof_helper(__unaligned _CountofType (&_Array)[_SizeOfArray]))[_SizeOfArray];

        
    }


#line 260 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"



#line 264 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"


    
        
    



#line 273 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

    


#line 278 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"


#line 281 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
        
        
    #line 284 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

    
#line 287 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"



#line 291 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

// [[nodiscard]] attributes on STL functions

    


        
    

#line 301 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
#line 302 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"


    


#line 308 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

// See note on use of "deprecate" at the top of this file




#line 315 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"


    


        




    #line 326 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
#line 327 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"



#line 331 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"


    
        
    


#line 339 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
#line 340 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"


    void __cdecl __security_init_cookie(void);

    


#line 348 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"


#line 351 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
        void __cdecl __security_check_cookie(  uintptr_t _StackCookie);
        __declspec(noreturn) void __cdecl __report_gsfailure(  uintptr_t _StackCookie);
    #line 354 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
#line 355 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

extern uintptr_t __security_cookie;


    
    
    
#line 363 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"

} __pragma(pack(pop))

#pragma warning(pop) 

#line 369 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime.h"
#line 11 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Warning Suppression
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

// C4412: function signature contains type '_locale_t';
//        C++ objects are unsafe to pass between pure code and mixed or native. (/Wall)

    


        
    #line 26 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 27 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

// Use _UCRT_EXTRA_DISABLED_WARNINGS to add additional warning suppressions to UCRT headers.

    
#line 32 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

// C4324: structure was padded due to __declspec(align()) (/W4)
// C4514: unreferenced inline function has been removed (/Wall)
// C4574: 'MACRO' is defined to be '0': did you mean to use '#if MACRO'? (/Wall)
// C4710: function not inlined (/Wall)
// C4793: 'function' is compiled as native code (/Wall and /W1 under /clr:pure)
// C4820: padding after data member (/Wall)
// C4995: name was marked #pragma deprecated
// C4996: __declspec(deprecated)
// C28719: Banned API, use a more robust and secure replacement.
// C28726: Banned or deprecated API, use a more robust and secure replacement.
// C28727: Banned API.

    
#line 47 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    











        
    #line 63 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 64 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    


        
    #line 71 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 72 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8)) extern "C" {

//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Annotation Macros
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    

#line 88 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
        
    

#line 92 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 93 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

// If you need the ability to remove __declspec(import) from an API, to support static replacement,
// declare the API using _ACRTIMP_ALT instead of _ACRTIMP.

    
#line 99 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    

#line 104 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
        
    

#line 108 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 109 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 113 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
    
#line 115 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    


#line 121 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"





#line 127 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
    
#line 129 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

// __declspec(guard(overflow)) enabled by /sdl compiler switch for CRT allocators

    


#line 136 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 140 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
    
#line 142 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

// The CLR requires code calling other SecurityCritical code or using SecurityCritical types
// to be marked as SecurityCritical.
// _CRT_SECURITYCRITICAL_ATTRIBUTE covers this for internal function definitions.
// _CRT_INLINE_PURE_SECURITYCRITICAL_ATTRIBUTE is for inline pure functions defined in the header.
// This is clr:pure-only because for mixed mode we compile inline functions as native.



    
#line 153 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"













    


        
    #line 171 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 172 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 176 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
    
#line 178 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 182 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
    
#line 184 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 188 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
    
#line 190 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Miscellaneous Stuff
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

extern "C++"
{
    template<bool _Enable, typename _Ty>
    struct _CrtEnableIf;

    template<typename _Ty>
    struct _CrtEnableIf<true, _Ty>
    {
        typedef _Ty _Type;
    };
}
#line 211 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    typedef bool  __crt_bool;






#line 221 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"










    
        
    #line 234 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"








#line 243 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"









// CRT headers are included into some kinds of source files where only data type
// definitions and macro definitions are required but function declarations and
// inline function definitions are not.  These files include assembly files, IDL
// files, and resource files.  The tools that process these files often have a
// limited ability to process C and C++ code.  The _CRT_FUNCTIONS_REQUIRED macro
// is defined to 1 when we are compiling a file that actually needs functions to
// be declared (and defined, where applicable), and to 0 when we are compiling a
// file that does not.  This allows us to suppress declarations and definitions
// that are not compilable with the aforementioned tools.

    

#line 265 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
        
    #line 267 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 268 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 272 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    
#line 276 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


 
  

#line 282 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
   
  #line 284 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
 





#line 291 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 292 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Windows API Partitioning and ARM Desktop Support
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    

















        
    #line 319 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 320 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    
#line 324 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    
        
    

#line 331 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 332 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

// Verify that the ARM Desktop SDK is available when building an ARM Desktop app








//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Invalid Parameter Handler
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    __declspec(dllimport) void __cdecl _invalid_parameter(
          wchar_t const*,
          wchar_t const*,
          wchar_t const*,
                unsigned int,
                uintptr_t
        );
#line 356 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

__declspec(dllimport) void __cdecl _invalid_parameter_noinfo(void);
__declspec(dllimport) __declspec(noreturn) void __cdecl _invalid_parameter_noinfo_noreturn(void);

__declspec(noreturn)
__declspec(dllimport) void __cdecl _invoke_watson(
      wchar_t const* _Expression,
      wchar_t const* _FunctionName,
      wchar_t const* _FileName,
            unsigned int _LineNo,
            uintptr_t _Reserved);


    
        

    













#line 387 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 388 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Deprecation and Warnings
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+




    


#line 405 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 409 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    


        


    #line 418 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 419 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Managed CRT Support
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    






        
    #line 437 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 438 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    


        
    #line 445 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 446 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 450 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// SecureCRT Configuration
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+





#line 464 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"















#line 480 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"





    
#line 487 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 491 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    

#line 496 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 497 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    


        


            
        #line 507 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
    #line 508 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 509 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 513 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"





#line 519 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    


        



    #line 529 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 530 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    
        
    



#line 539 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

    
        // _CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES_COUNT is ignored if
        // _CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES is set to 0
        
    



#line 549 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

    
        
              
        

#line 556 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
    



#line 561 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

    
        
    



#line 569 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

    
        
    



#line 577 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 578 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    
#line 582 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Basic Types
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
typedef int                           errno_t;
typedef unsigned short                wint_t;
typedef unsigned short                wctype_t;
typedef long                          __time32_t;
typedef __int64                       __time64_t;

typedef struct __crt_locale_data_public
{
      unsigned short const* _locale_pctype;
      int _locale_mb_cur_max;
               unsigned int _locale_lc_codepage;
} __crt_locale_data_public;

typedef struct __crt_locale_pointers
{
    struct __crt_locale_data*    locinfo;
    struct __crt_multibyte_data* mbcinfo;
} __crt_locale_pointers;

typedef __crt_locale_pointers* _locale_t;

typedef struct _Mbstatet
{ // state of a multibyte translation
    unsigned long _Wchar;
    unsigned short _Byte, _State;
} _Mbstatet;

typedef _Mbstatet mbstate_t;



#line 622 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 626 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    


        typedef __time64_t time_t;
    #line 633 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 634 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

// Indicate that these common types are defined

    
#line 639 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"


    typedef size_t rsize_t;
#line 643 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"




//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// C++ Secure Overload Generation Macros
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    

        










        










        










        










        










        










        










        










        










        












        












        
















    














#line 813 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 814 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"






































































//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// C++ Standard Overload Generation Macros
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    













































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 1865 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

        
        
        
        

        

            


            


            


            


            


            


            


            


            



            



            


            


            


            


            


            


            


            


            


            


            



            



            



            


            



            




            

            




            

            




            

            




            

            




            

            




            

            




            

            




            

        











































#line 2055 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
    #line 2056 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 2057 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt.h"

} __pragma(pack(pop))


#pragma warning(pop) 
#line 13 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\assert.h"

#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8)) extern "C" {











    __declspec(dllimport) void __cdecl _wassert(
          wchar_t const* _Message,
          wchar_t const* _File,
            unsigned       _Line
        );

    




#line 42 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\assert.h"



} __pragma(pack(pop))

#pragma warning(pop) 
#line 3 "C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\Heap.h"
#line 1 "C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\CoreTypes.h"
#pragma once

#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\stdint.h"
//
// stdint.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// The C Standard Library <stdint.h> header.
//
#pragma once






#pragma warning(push)
#pragma warning(disable:   4514 4820 )

typedef signed char        int8_t;
typedef short              int16_t;
typedef int                int32_t;
typedef long long          int64_t;
typedef unsigned char      uint8_t;
typedef unsigned short     uint16_t;
typedef unsigned int       uint32_t;
typedef unsigned long long uint64_t;

typedef signed char        int_least8_t;
typedef short              int_least16_t;
typedef int                int_least32_t;
typedef long long          int_least64_t;
typedef unsigned char      uint_least8_t;
typedef unsigned short     uint_least16_t;
typedef unsigned int       uint_least32_t;
typedef unsigned long long uint_least64_t;

typedef signed char        int_fast8_t;
typedef int                int_fast16_t;
typedef int                int_fast32_t;
typedef long long          int_fast64_t;
typedef unsigned char      uint_fast8_t;
typedef unsigned int       uint_fast16_t;
typedef unsigned int       uint_fast32_t;
typedef unsigned long long uint_fast64_t;

typedef long long          intmax_t;
typedef unsigned long long uintmax_t;

// These macros must exactly match those in the Windows SDK's intsafe.h.








































    
    
    




#line 97 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\stdint.h"









    // SIZE_MAX definition must match exactly with limits.h for modules support.
    
        
    

#line 112 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\stdint.h"
#line 113 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\stdint.h"























#pragma warning(pop) 

#line 139 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\stdint.h"
#line 4 "C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\CoreTypes.h"
typedef int8_t int8;
typedef int8 sbyte;

typedef uint8_t uint8;
typedef uint8 byte;

typedef int16_t int16;
typedef uint16_t uint16;
typedef uint16 CORE_WORD;

typedef int32_t int32;
typedef uint32_t uint32;
typedef uint32 CORE_DWORD;

typedef int16_t int64;
typedef uint64_t uint64;
typedef uint64 CORE_QWORD;

typedef uint32 Handle;
#line 4 "C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\Heap.h"

#line 1 "C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\LinkedList.h"
#pragma once
template <class DataType>
class ListNode
{
public:
	DataType m_Data;

	ListNode() noexcept
		: m_Data( nullptr )
		, m_pPrev( nullptr )
		, m_pNext( nullptr ) 
	{
	}

	ListNode( const DataType& InOriginal ) noexcept
		: m_Data( InOriginal )
		, m_pPrev( nullptr )
		, m_pNext( nullptr )
	{

	}

	ListNode( const ListNode<DataType>& InOriginal ) noexcept
		: m_Data( InOriginal.m_Data )
		, m_pPrev( InOriginal.m_pPrev )
		, m_pNext( InOriginal.m_pNext )
	{

	}

	ListNode( ListNode<DataType>&& InOriginal ) noexcept
		: m_Data( InOriginal.m_Data )
		, m_pPrev( InOriginal.m_pPrev )
		, m_pNext( InOriginal.m_pNext )
	{
		InOriginal.m_Data = { }; // Weird hack to initialize templates to default value. Works for built-ins, too.
		InOriginal.m_pPrev = nullptr;
		InOriginal.m_pNext = nullptr;
	}

	ListNode<DataType>& operator=( const ListNode<DataType>& InOriginal ) noexcept
	{
		m_Data = InOriginal.m_Data;

		m_pPrev = InOriginal.m_pPrev;
		m_pNext = InOriginal.m_pNext;

		return this;
	}

	bool operator== ( const ListNode<DataType>& InOther ) const noexcept
	{
		return ( m_Data == InOther.m_Data )
			&& ( m_pPrev == InOther.m_pPrev )
			&& ( m_pNext == InOther.m_pNext );
	}

	const DataType GetValue() noexcept
	{
		return m_Data;
	}

	const bool IsHead() noexcept
	{
		return ( m_pPrev == nullptr );
	}

	const bool IsTail() noexcept
	{
		return ( m_pNext == nullptr );
	}

	const bool IsMiddle() noexcept
	{
		return !IsHead() && !IsTail();
	}

	ListNode<DataType>* GetPrev() const noexcept { return m_pPrev; }
	ListNode<DataType>* GetNext() const noexcept { return m_pNext; }

	ListNode<DataType>& GetHead() noexcept
	{
		ListNode<DataType>* pHead = this;
		while ( pHead->m_pPrev )
		{
			pHead = pHead->m_pPrev;
		}

		return *pHead;
	}

	ListNode<DataType>& GetTail() noexcept
	{
		ListNode<DataType>* pTail = this;
		while ( pTail->m_pNext )
		{
			pTail = pTail->m_pNext;
		}

		return *pTail;
	}

	void Insert( ListNode<DataType>& InToInsert ) noexcept
	{
		ListNode<DataType>* pNext = m_pNext;

		m_pNext = &InToInsert;
		InToInsert.m_pPrev = this;

		if ( pNext )
		{
			pNext->m_pPrev = &InToInsert;
		}

		InToInsert.m_pNext = pNext;
	}

	void PrependTo( ListNode<DataType>& InList ) noexcept
	{
		(void)( (!!(InList.IsHead())) || (_wassert(L"InList.IsHead()", L"C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\LinkedList.h", (unsigned)(120)), 0) );

		ListNode<DataType>& Head	= InList.GetHead();
		this->m_pNext				= Head;
		Head.m_pPrev				= this;
	}

private:
	ListNode<DataType>* m_pPrev;
	ListNode<DataType>* m_pNext;
};
#line 6 "C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\Heap.h"
#line 1 "C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\SharedPtr.h"
#pragma once


#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
// atomic standard header

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once


#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
// yvals.h internal header

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once


#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
// yvals_core.h internal header (core)

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once



// All STL headers avoid exposing their contents when included by various
// non-C++-compiler tools to avoid breaking builds when we use newer language
// features in the headers than such tools understand.


#line 16 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 18 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
#line 19 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"


// Implemented unconditionally:
// N3911 void_t
// N4089 Safe Conversions In unique_ptr<T[]>
// N4169 invoke()
// N4258 noexcept Cleanups
// N4259 uncaught_exceptions()
// N4277 Trivially Copyable reference_wrapper
// N4279 insert_or_assign()/try_emplace() For map/unordered_map
// N4280 size(), empty(), data()
// N4366 Precisely Constraining unique_ptr Assignment
// N4387 Improving pair And tuple
// N4389 bool_constant
// N4508 shared_mutex (Untimed)
// N4510 Supporting Incomplete Types In vector/list/forward_list
// P0006R0 Variable Templates For Type Traits (is_same_v, etc.)
// P0007R1 as_const()
// P0013R1 Logical Operator Type Traits (conjunction, etc.)
// P0033R1 Rewording enable_shared_from_this
// P0063R3 C11 Standard Library
// P0074R0 owner_less<>
// P0092R1 <chrono> floor(), ceil(), round(), abs()
// P0340R3 SFINAE-Friendly underlying_type
// P0414R2 shared_ptr<T[]>, shared_ptr<T[N]>
// P0418R2 atomic compare_exchange memory_order Requirements
// P0435R1 Overhauling common_type
// P0497R0 Fixing shared_ptr For Arrays
// P0513R0 Poisoning hash
// P0516R0 Marking shared_future Copying As noexcept
// P0517R0 Constructing future_error From future_errc
// P0548R1 Tweaking common_type And duration
// P0558R1 Resolving atomic<T> Named Base Class Inconsistencies
// P0599R1 noexcept hash
// P0738R2 istream_iterator Cleanup
// P0771R1 noexcept For std::function's Move Constructor
// P0777R1 Avoiding Unnecessary decay
// P0809R0 Comparing Unordered Containers
// P0883R2 Fixing Atomic Initialization
// P0935R0 Eradicating Unnecessarily Explicit Default Constructors
// P0941R2 Feature-Test Macros
// P0972R0 noexcept For <chrono> zero(), min(), max()
// P1164R1 Making create_directory() Intuitive
// P1165R1 Consistently Propagating Stateful Allocators In basic_string's operator+()
// P1902R1 Missing Feature-Test Macros 2017-2019

// _HAS_CXX17 directly controls:
// P0005R4 not_fn()
// P0024R2 Parallel Algorithms
// P0025R1 clamp()
// P0030R1 hypot(x, y, z)
// P0031R0 constexpr For <array> (Again) And <iterator>
// P0032R3 Homogeneous Interface For variant/any/optional
// P0040R3 Extending Memory Management Tools
// P0067R5 Elementary String Conversions
// P0083R3 Splicing Maps And Sets
// P0084R2 Emplace Return Type
// P0088R3 <variant>
// P0137R1 launder()
// P0152R1 atomic::is_always_lock_free
// P0154R1 hardware_destructive_interference_size, etc.
// P0156R2 scoped_lock
// P0163R0 shared_ptr::weak_type
// P0185R1 is_swappable, is_nothrow_swappable
// P0209R2 make_from_tuple()
// P0218R1 <filesystem>
// P0220R1 <any>, <memory_resource>, <optional>, <string_view>, apply(), sample(), Boyer-Moore search()
// P0226R1 Mathematical Special Functions
// P0253R1 Fixing Searcher Return Types
// P0254R2 Integrating string_view And std::string
// P0258R2 has_unique_object_representations
// P0272R1 Non-const basic_string::data()
// P0295R0 gcd(), lcm()
// P0307R2 Making Optional Greater Equal Again
// P0336R1 Renaming Parallel Execution Policies
// P0337R0 Deleting polymorphic_allocator Assignment
// P0358R1 Fixes For not_fn()
// P0393R3 Making Variant Greater Equal
// P0394R4 Parallel Algorithms Should terminate() For Exceptions
// P0403R1 UDLs For <string_view> ("meow"sv, etc.)
// P0426R1 constexpr For char_traits
// P0433R2 Deduction Guides For The STL
// P0452R1 Unifying <numeric> Parallel Algorithms
// P0504R0 Revisiting in_place_t/in_place_type_t<T>/in_place_index_t<I>
// P0505R0 constexpr For <chrono> (Again)
// P0508R0 Clarifying insert_return_type
// P0510R0 Rejecting variants Of Nothing, Arrays, References, And Incomplete Types
// P0602R4 Propagating Copy/Move Triviality In variant/optional
// P0604R0 invoke_result, is_invocable, is_nothrow_invocable
// P0607R0 Inline Variables For The STL
// P0682R1 Repairing Elementary String Conversions
// P0739R0 Improving Class Template Argument Deduction For The STL
// P0858R0 Constexpr Iterator Requirements
// P1065R2 constexpr INVOKE
//     (the std::invoke function only; other components like bind and reference_wrapper are C++20 only)

// _HAS_CXX17 indirectly controls:
// N4190 Removing auto_ptr, random_shuffle(), And Old <functional> Stuff
// P0003R5 Removing Dynamic Exception Specifications
// P0004R1 Removing Deprecated Iostreams Aliases
// P0298R3 std::byte
// P0302R1 Removing Allocator Support In std::function
// LWG-2385 function::assign allocator argument doesn't make sense
// LWG-2921 packaged_task and type-erased allocators
// LWG-2976 Dangling uses_allocator specialization for packaged_task
// The non-Standard std::tr1 namespace and TR1-only machinery
// Enforcement of matching allocator value_types

// _HAS_CXX17 and _SILENCE_ALL_CXX17_DEPRECATION_WARNINGS control:
// P0174R2 Deprecating Vestigial Library Parts
// P0521R0 Deprecating shared_ptr::unique()
// P0618R0 Deprecating <codecvt>
// Other C++17 deprecation warnings

// _HAS_CXX20 directly controls:
// P0019R8 atomic_ref
// P0020R6 atomic<float>, atomic<double>, atomic<long double>
// P0122R7 <span>
// P0202R3 constexpr For <algorithm> And exchange()
// P0318R1 unwrap_reference, unwrap_ref_decay
// P0325R4 to_array()
// P0339R6 polymorphic_allocator<>
// P0356R5 bind_front()
// P0357R3 Supporting Incomplete Types In reference_wrapper
// P0415R1 constexpr For <complex> (Again)
// P0439R0 enum class memory_order
// P0457R2 starts_with()/ends_with() For basic_string/basic_string_view
// P0458R2 contains() For Ordered And Unordered Associative Containers
// P0463R1 endian
// P0476R2 <bit> bit_cast
// P0482R6 Library Support For char8_t
//     (mbrtoc8 and c8rtomb not yet implemented)
// P0487R1 Fixing operator>>(basic_istream&, CharT*)
// P0528R3 Atomic Compare-And-Exchange With Padding Bits
// P0550R2 remove_cvref
// P0553R4 <bit> Rotating And Counting Functions
// P0556R3 <bit> Integral Power-Of-2 Operations (renamed by P1956R1)
// P0586R2 Integer Comparison Functions
// P0595R2 is_constant_evaluated()
// P0616R0 Using move() In <numeric>
// P0631R8 <numbers> Math Constants
// P0646R1 list/forward_list remove()/remove_if()/unique() Return size_type
// P0653R2 to_address()
// P0655R1 visit<R>()
// P0660R10 <stop_token> And jthread
// P0674R1 make_shared() For Arrays
// P0718R2 atomic<shared_ptr<T>>, atomic<weak_ptr<T>>
// P0758R1 is_nothrow_convertible
// P0768R1 Library Support For The Spaceship Comparison Operator <=>
// P0769R2 shift_left(), shift_right()
// P0811R3 midpoint(), lerp()
// P0879R0 constexpr For Swapping Functions
// P0887R1 type_identity
// P0896R4 Ranges
//     (partially implemented)
// P0898R3 Standard Library Concepts
// P0912R5 Library Support For Coroutines
// P0919R3 Heterogeneous Lookup For Unordered Containers
// P0966R1 string::reserve() Should Not Shrink
// P1001R2 execution::unseq
// P1006R1 constexpr For pointer_traits<T*>::pointer_to()
// P1007R3 assume_aligned()
// P1020R1 Smart Pointer Creation With Default Initialization
// P1023R0 constexpr For std::array Comparisons
// P1024R3 Enhancing span Usability
// P1032R1 Miscellaneous constexpr
// P1065R2 constexpr INVOKE
//     (except the std::invoke function which is implemented in C++17)
// P1085R2 Removing span Comparisons
// P1115R3 erase()/erase_if() Return size_type
// P1123R0 Atomic Compare-And-Exchange With Padding Bits For atomic_ref
// P1135R6 The C++20 Synchronization Library
// P1207R4 Movability Of Single-Pass Iterators
//     (partially implemented)
// P1209R0 erase_if(), erase()
// P1227R2 Signed std::ssize(), Unsigned span::size()
// P1243R4 Rangify New Algorithms
//     (partially implemented)
// P1248R1 Fixing Relations
// P1357R1 is_bounded_array, is_unbounded_array
// P1391R4 Range Constructor For string_view
// P1394R4 Range Constructor For span
// P1423R3 char8_t Backward Compatibility Remediation
// P1456R1 Move-Only Views
// P1474R1 Helpful Pointers For contiguous_iterator
// P1612R1 Relocating endian To <bit>
// P1645R1 constexpr For <numeric> Algorithms
// P1651R0 bind_front() Should Not Unwrap reference_wrapper
// P1690R1 Refining Heterogeneous Lookup For Unordered Containers
// P1716R3 Range Comparison Algorithms Are Over-Constrained
// P1739R4 Avoiding Template Bloat For Ranges
//     (partially implemented)
// P1754R1 Rename Concepts To standard_case
// P1865R1 Adding max() To latch And barrier
// P1870R1 Rename forwarding-range To borrowed_range (Was safe_range before LWG-3379)
// P1871R1 disable_sized_sentinel_for
// P1872R0 span Should Have size_type, Not index_type
// P1878R1 Constraining Readable Types
// P1907R2 ranges::ssize
// P1956R1 <bit> has_single_bit(), bit_ceil(), bit_floor(), bit_width()
// P1959R0 Removing weak_equality And strong_equality
// P1960R0 atomic_ref Cleanup
// P1964R2 Replacing boolean With boolean-testable
// P1973R1 Renaming default_init To for_overwrite
// P1976R2 Explicit Constructors For Fixed-Extent span From Dynamic-Extent Ranges
// P2091R0 Fixing Issues With Range Access CPOs
// P2102R0 Making "Implicit Expression Variations" More Explicit
// P2116R0 Removing tuple-Like Protocol Support From Fixed-Extent span
// P????R? directory_entry::clear_cache()

// _HAS_CXX20 indirectly controls:
// P0619R4 Removing C++17-Deprecated Features

// _HAS_CXX20 and _SILENCE_ALL_CXX20_DEPRECATION_WARNINGS control:
// P0767R1 Deprecating is_pod
// P1831R1 Deprecating volatile In The Standard Library
// Other C++20 deprecation warnings

// Parallel Algorithms Notes
// C++ allows an implementation to implement parallel algorithms as calls to the serial algorithms.
// This implementation parallelizes several common algorithm calls, but not all.
//
// std::execution::unseq has no direct analogue for any optimizer we target as of 2020-07-29,
// though we will map it to #pragma loop(ivdep) for the for_each algorithms only as these are the only algorithms where
// the library does not need to introduce inter-loop-body dependencies to accomplish the algorithm's goals.
//
// The following algorithms are parallelized.
// * adjacent_difference
// * adjacent_find
// * all_of
// * any_of
// * count
// * count_if
// * equal
// * exclusive_scan
// * find
// * find_end
// * find_first_of
// * find_if
// * find_if_not
// * for_each
// * for_each_n
// * inclusive_scan
// * is_heap
// * is_heap_until
// * is_partitioned
// * is_sorted
// * is_sorted_until
// * mismatch
// * none_of
// * partition
// * reduce
// * remove
// * remove_if
// * replace
// * replace_if
// * search
// * search_n
// * set_difference
// * set_intersection
// * sort
// * stable_sort
// * transform
// * transform_exclusive_scan
// * transform_inclusive_scan
// * transform_reduce
//
// The following are not presently parallelized:
//
// No apparent parallelism performance improvement on target hardware; all algorithms which
// merely copy or permute elements with no branches are typically memory bandwidth limited.
// * copy
// * copy_n
// * fill
// * fill_n
// * move
// * reverse
// * reverse_copy
// * rotate
// * rotate_copy
// * shift_left
// * shift_right
// * swap_ranges
//
// Confusion over user parallelism requirements exists; likely in the above category anyway.
// * generate
// * generate_n
//
// Effective parallelism suspected to be infeasible.
// * partial_sort
// * partial_sort_copy
//
// Not yet evaluated; parallelism may be implemented in a future release and is suspected to be beneficial.
// * copy_if
// * includes
// * inplace_merge
// * lexicographical_compare
// * max_element
// * merge
// * min_element
// * minmax_element
// * nth_element
// * partition_copy
// * remove_copy
// * remove_copy_if
// * replace_copy
// * replace_copy_if
// * set_symmetric_difference
// * set_union
// * stable_partition
// * unique
// * unique_copy


#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"
// xkeycheck.h internal header

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once







// clang-format off
// #if defined($KEYWORD)
// #define $KEYWORD EMIT WARNING C4005
// #error The C++ Standard Library forbids macroizing the keyword "$KEYWORD". \
// Enable warning C4005 to find the forbidden define.
// #endif // $KEYWORD
// clang-format on

// *don't* check the "alternative token representations"

// keywords:




#line 30 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 36 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 42 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 48 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 54 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 60 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 66 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 72 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 78 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 84 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 90 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 96 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 102 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 108 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 114 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 120 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 126 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 132 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 138 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 144 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 150 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 156 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 162 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 168 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 174 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 180 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 186 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 192 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 198 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 204 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 210 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 216 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 222 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 228 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 234 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 240 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 246 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 252 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 258 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 264 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 270 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 276 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 282 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 288 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 294 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"






#line 301 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 307 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 313 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 319 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 325 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 331 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 337 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 343 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 349 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 355 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 361 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 367 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 373 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 379 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 385 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 391 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 397 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 403 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 409 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 415 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 421 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 427 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 433 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 439 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 445 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 451 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 457 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 463 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 469 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 475 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 481 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 487 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 493 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 499 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 505 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 511 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"

// contextual keywords (a.k.a. "identifiers with special meaning"):




#line 518 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 524 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 530 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 536 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"

// attribute-tokens:




#line 543 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 549 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 555 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"

// not checking "likely" because it is commonly defined as a function-like macro





#line 563 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 569 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 575 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"





#line 581 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"

// not checking "unlikely" because it is commonly defined as a function-like macro

#line 585 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"

#line 587 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"
#line 588 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xkeycheck.h"
#line 334 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"




#line 339 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 341 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
#line 342 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 346 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 350 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// _HAS_NODISCARD (in vcruntime.h) controls:
// [[nodiscard]] attributes on STL functions







#line 361 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// Determine if we should use [[msvc::known_semantics]] to communicate to the compiler
// that certain type trait specializations have the standard-mandated semantics




#line 369 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 373 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// Controls whether the STL uses "if constexpr" internally in C++14 mode





#line 381 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
#line 382 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// Controls whether the STL uses "conditional explicit" internally





#line 390 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 392 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
#line 393 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// warning C4577: 'noexcept' used with no exception handling mode specified;
// termination on exception is not guaranteed. Specify /EHsc (/Wall)




#line 401 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// warning C4984: 'if constexpr' is a C++17 language extension




#line 408 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// warning C5053: support for 'explicit(<expr>)' in C++17 and earlier is a vendor extension




#line 415 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 419 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// warning C4180: qualifier applied to function type has no meaning; ignored
// warning C4412: function signature contains type 'meow'; C++ objects are unsafe to pass between pure code
//                and mixed or native. (/Wall)
// warning C4455: literal suffix identifiers that do not start with an underscore are reserved
// warning C4494: Ignoring __declspec(allocator) because the function return type is not a pointer or reference
// warning C4514: unreferenced inline function has been removed (/Wall)
// warning C4574: 'MACRO' is defined to be '0': did you mean to use '#if MACRO'? (/Wall)
// warning C4582: 'union': constructor is not implicitly called (/Wall)
// warning C4583: 'union': destructor is not implicitly called (/Wall)
// warning C4587: behavior change: constructor is no longer implicitly called (/Wall)
// warning C4588: behavior change: destructor is no longer implicitly called (/Wall)
// warning C4619: #pragma warning: there is no warning number 'number' (/Wall)
// warning C4623: default constructor was implicitly defined as deleted (/Wall)
// warning C4625: copy constructor was implicitly defined as deleted (/Wall)
// warning C4626: assignment operator was implicitly defined as deleted (/Wall)
// warning C4643: Forward declaring 'meow' in namespace std is not permitted by the C++ Standard. (/Wall)
// warning C4648: standard attribute 'meow' is ignored
// warning C4702: unreachable code
// warning C4793: function compiled as native
// warning C4820: 'N' bytes padding added after data member 'meow' (/Wall)
// warning C4988: variable declared outside class/function scope (/Wall /d1WarnOnGlobals)
// warning C5026: move constructor was implicitly defined as deleted (/Wall)
// warning C5027: move assignment operator was implicitly defined as deleted (/Wall)
// warning C5045: Compiler will insert Spectre mitigation for memory load if /Qspectre switch specified (/Wall)
// warning C6294: Ill-defined for-loop: initial condition does not satisfy test. Loop body not executed


// clang-format off








// clang-format on
#line 458 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// warning: constexpr if is a C++17 extension [-Wc++17-extensions]
// warning: explicit(bool) is a C++20 extension [-Wc++20-extensions]
// warning: ignoring __declspec(allocator) because the function return type '%s' is not a pointer or reference type
//     [-Wignored-attributes]
// warning: user-defined literal suffixes not starting with '_' are reserved [-Wuser-defined-literals]
// warning: unknown pragma ignored [-Wunknown-pragmas]













#line 479 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
#line 480 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"






#line 487 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
#line 488 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// clang-format off









#line 500 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
#line 501 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
// clang-format on






#line 509 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
#line 510 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"












#line 523 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"


#line 526 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"


#line 529 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
#line 530 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 534 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 538 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// N4842 [dcl.constexpr]/1: "A function or static data member declared with the
// constexpr or consteval specifier is implicitly an inline function or variable"

// Functions that became constexpr in C++17


#line 546 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 548 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// Functions that became constexpr in C++20


#line 553 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 555 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// Functions that became constexpr in C++20 via P0784R7


#line 560 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 562 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// P0607R0 Inline Variables For The STL


#line 567 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 569 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// N4190 Removing auto_ptr, random_shuffle(), And Old <functional> Stuff


#line 574 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// P0003R5 Removing Dynamic Exception Specifications


#line 579 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// P0004R1 Removing Deprecated Iostreams Aliases


#line 584 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// P0298R3 std::byte


#line 589 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// P0302R1 Removing Allocator Support In std::function
// LWG-2385 function::assign allocator argument doesn't make sense
// LWG-2921 packaged_task and type-erased allocators
// LWG-2976 Dangling uses_allocator specialization for packaged_task


#line 597 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// The non-Standard std::tr1 namespace and TR1-only machinery


#line 602 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// STL4000 is "_STATIC_CPPLIB is deprecated", currently in yvals.h
// STL4001 is "/clr:pure is deprecated", currently in yvals.h










#line 616 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
#line 617 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// STL4003 was "The non-Standard std::identity struct is deprecated and will be REMOVED."

// Enforcement of matching allocator value_types


#line 624 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"







// Enforcement of Standard facet specializations


#line 635 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"






// To improve compiler throughput, use 'hidden friend' operators in <system_error> instead of non-members that are
// depicted in the Standard.


#line 646 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"





#line 652 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"





#line 658 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// Controls whether the STL will force /fp:fast to enable vectorization of algorithms defined
// in the standard as special cases; such as reduce, transform_reduce, inclusive_scan, exclusive_scan





#line 667 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
#line 668 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// P0174R2 Deprecating Vestigial Library Parts
// P0521R0 Deprecating shared_ptr::unique()
// Other C++17 deprecation warnings

// N4659 D.4 [depr.cpp.headers]






#line 682 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 684 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// N4659 D.6 [depr.str.strstreams]





#line 693 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 695 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// N4659 D.7 [depr.uncaught]







#line 706 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 708 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// N4659 D.8.1 [depr.weak.result_type]
// N4659 D.8.2 [depr.func.adaptor.typedefs]







#line 720 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 722 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// N4659 D.8.3 [depr.negators]







#line 733 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 735 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// STL4009 was "std::allocator<void> is deprecated in C++17"

// N4659 D.9 [depr.default.allocator]







#line 748 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 750 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// N4659 D.10 [depr.storage.iterator]







#line 761 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 763 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// N4659 D.11 [depr.temporary.buffer]






#line 773 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 775 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// N4659 D.12 [depr.meta.types]






#line 785 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 787 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// N4659 D.12 [depr.meta.types]







#line 798 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 800 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// N4659 D.13 [depr.iterator.primitives]











#line 815 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 817 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// N4659 D.14 [depr.util.smartptr.shared.obs]






#line 827 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 829 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// N4659 D.15 [depr.locale.stdcvt]
// N4659 D.16 [depr.conversions]











#line 845 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 847 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// STL4018 was "The non-Standard std::tr2::sys namespace is deprecated and will be REMOVED."














#line 864 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// P0482R6 Library Support For char8_t
// Other C++20 deprecation warnings

// N4810 D.16 [depr.locale.category]








#line 879 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 881 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// N4810 D.17 [depr.fs.path.factory]








#line 893 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 895 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"











#line 907 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"












#line 920 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// P0966R1 [depr.string.capacity]








#line 932 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 934 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// P0767R1 [depr.meta.types]







#line 945 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 947 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"








#line 956 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 958 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// P0768R1 [depr.relops]







#line 969 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 971 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"








#line 981 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 983 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"








#line 993 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 995 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"







#line 1004 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 1006 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"







#line 1015 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 1017 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"








#line 1027 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 1029 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// next warning number: STL4033

// P0619R4 Removing C++17-Deprecated Features


#line 1036 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 1040 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 1044 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 1048 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 1052 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 1056 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 1060 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 1064 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 1068 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"











#line 1080 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// P1423R3 char8_t Backward Compatibility Remediation
// Controls whether we allow the stream insertions this proposal forbids


#line 1086 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// LIBRARY FEATURE-TEST MACROS

// C++14
















#line 1107 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"





// C++17



















































#line 1165 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 1169 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 1171 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// C++20




































































#line 1242 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"




#line 1247 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 1249 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
#line 1250 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 1254 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 1256 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 1260 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 1262 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

// EXPERIMENTAL














// NAMESPACE





// We use the stdext (standard extension) namespace to contain extensions that are not part of the current standard














#line 1300 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"







#line 1308 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 1312 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"



#line 1316 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"







// Note that the STL DLL builds will set this to XP for ABI compatibility with VS2015 which supported XP.




#line 1329 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"


#line 1332 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
// The earliest Windows supported by this implementation is Windows Vista

#line 1335 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
#line 1336 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"





#line 1342 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"

#line 1344 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
#line 1345 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals_core.h"
#line 10 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"


#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\crtdbg.h"
//
// crtdbg.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// Public debugging facilities for the CRT
//
#pragma once




#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime_new_debug.h"
//
// vcruntime_new_debug.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// Declarations and definitions of the debug operators new and delete.
//
#pragma once

#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime_new.h"
//
// vcruntime_new.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// Declarations and definitions of memory management functions in the VCRuntime.
//
#pragma once



#pragma warning(push)
#pragma warning(disable:   4514 4820 )
#pragma warning(disable: 4985) 


extern "C++" {

#pragma pack(push, 8)













    namespace std
    {
        struct nothrow_t {
            explicit nothrow_t() = default;
        };

        


            extern nothrow_t const nothrow;
        #line 44 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime_new.h"
    }
#line 46 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime_new.h"

[[nodiscard]]     __declspec(allocator)
void* __cdecl operator new(
    size_t _Size
    );

[[nodiscard]]       __declspec(allocator)
void* __cdecl operator new(
    size_t _Size,
    ::std::nothrow_t const&
    ) noexcept;

[[nodiscard]]     __declspec(allocator)
void* __cdecl operator new[](
    size_t _Size
    );

[[nodiscard]]       __declspec(allocator)
void* __cdecl operator new[](
    size_t _Size,
    ::std::nothrow_t const&
    ) noexcept;

void __cdecl operator delete(
    void* _Block
    ) noexcept;

void __cdecl operator delete(
    void* _Block,
    ::std::nothrow_t const&
    ) noexcept;

void __cdecl operator delete[](
    void* _Block
    ) noexcept;

void __cdecl operator delete[](
    void* _Block,
    ::std::nothrow_t const&
    ) noexcept;

void __cdecl operator delete(
    void*  _Block,
    size_t _Size
    ) noexcept;

void __cdecl operator delete[](
    void* _Block,
    size_t _Size
    ) noexcept;
































































#pragma warning(push)
#pragma warning(disable: 4577) 
#pragma warning(disable: 4514) 

    
    [[nodiscard]]      
    inline void* __cdecl operator new(size_t _Size,   void* _Where) noexcept
    {
        (void)_Size;
        return _Where;
    }

    inline void __cdecl operator delete(void*, void*) noexcept
    {
        return;
    }
#line 177 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime_new.h"


    
    [[nodiscard]]      
    inline void* __cdecl operator new[](size_t _Size,
          void* _Where) noexcept
    {
        (void)_Size;
        return _Where;
    }

    inline void __cdecl operator delete[](void*, void*) noexcept
    {
    }
#line 192 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime_new.h"
#pragma warning(pop)



#pragma pack(pop)

} // extern "C++"
#line 200 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime_new.h"

#pragma warning(pop) 
#line 11 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime_new_debug.h"

#pragma warning(push)
#pragma warning(disable:   4514 4820 )


extern "C++" {

#pragma pack(push, 8)






    [[nodiscard]]      
    __declspec(allocator) void* __cdecl operator new(
            size_t      _Size,
            int         _BlockUse,
          char const* _FileName,
            int         _LineNumber
        );

    [[nodiscard]]      
    __declspec(allocator) void* __cdecl operator new[](
            size_t      _Size,
            int         _BlockUse,
          char const* _FileName,
            int         _LineNumber
        );

    void __cdecl operator delete(
        void*       _Block,
        int         _BlockUse,
        char const* _FileName,
        int         _LineNumber
        ) noexcept;

    void __cdecl operator delete[](
        void*       _Block,
        int         _BlockUse,
        char const* _FileName,
        int         _LineNumber
        ) noexcept;

#line 56 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime_new_debug.h"



#pragma pack(pop)

} // extern "C++"
#line 63 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime_new_debug.h"

#pragma warning(pop) 
#line 14 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\crtdbg.h"

#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8)) extern "C" {



typedef void* _HFILE; // file handle pointer



















//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Client-defined reporting and allocation hooks
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

typedef int (__cdecl* _CRT_REPORT_HOOK )(int, char*,    int*);
typedef int (__cdecl* _CRT_REPORT_HOOKW)(int, wchar_t*, int*);





typedef int (__cdecl* _CRT_ALLOC_HOOK)(int, void*, size_t, int, long, unsigned char const*, int);











//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Memory Management and State Tracking
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

// Bit values for _crtDbgFlag flag. These bitflags control debug heap behavior.







// Some bit values for _crtDbgFlag which correspond to frequencies for checking
// the heap.




// We do not check the heap by default at this point because the cost was too
// high for some applications. You can still turn this feature on manually.







// Memory block identification







// _UNKNOWN_BLOCK is a sentinel value that may be passed to some functions that
// expect a block type as an argument.  If this value is passed, those functions
// will use the block type specified in the block header instead.  This is used
// in cases where the heap lock cannot be acquired to compute the block type
// before calling the function (e.g. when the caller is outside of the CoreCRT).


typedef void (__cdecl* _CRT_DUMP_CLIENT)(void*, size_t);





struct _CrtMemBlockHeader;

typedef struct _CrtMemState
{
    struct _CrtMemBlockHeader* pBlockHeader;
    size_t lCounts[5];
    size_t lSizes[5];
    size_t lHighWaterCount;
    size_t lTotalCount;
} _CrtMemState;


























    

        __declspec(dllimport) int*  __cdecl __p__crtDbgFlag(void);
        __declspec(dllimport) long* __cdecl __p__crtBreakAlloc(void);

        
        

        __declspec(dllimport) _CRT_ALLOC_HOOK __cdecl _CrtGetAllocHook(void);

        __declspec(dllimport) _CRT_ALLOC_HOOK __cdecl _CrtSetAllocHook(
              _CRT_ALLOC_HOOK _PfnNewHook
            );

        __declspec(dllimport) _CRT_DUMP_CLIENT __cdecl _CrtGetDumpClient(void);

        __declspec(dllimport) _CRT_DUMP_CLIENT __cdecl _CrtSetDumpClient(
              _CRT_DUMP_CLIENT _PFnNewDump
            );

    #line 175 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\crtdbg.h"

    __declspec(dllimport) int __cdecl _CrtCheckMemory(void);

    typedef void (__cdecl* _CrtDoForAllClientObjectsCallback)(void*, void*);

    __declspec(dllimport) void __cdecl _CrtDoForAllClientObjects(
          _CrtDoForAllClientObjectsCallback _Callback,
          void*                             _Context
        );

    __declspec(dllimport) int __cdecl _CrtDumpMemoryLeaks(void);

    __declspec(dllimport) int __cdecl _CrtIsMemoryBlock(
           void const*  _Block,
               unsigned int _Size,
          long*        _RequestNumber,
          char**       _FileName,
          int*         _LineNumber
        );

     
    __declspec(dllimport) int __cdecl _CrtIsValidHeapPointer(
          void const* _Pointer
        );

     
    __declspec(dllimport) int __cdecl _CrtIsValidPointer(
          void const*  _Pointer,
              unsigned int _Size,
              int          _ReadWrite
        );

    __declspec(dllimport) void __cdecl _CrtMemCheckpoint(
          _CrtMemState* _State
        );

    __declspec(dllimport) int __cdecl _CrtMemDifference(
          _CrtMemState*       _State,
           _CrtMemState const* _OldState,
           _CrtMemState const* _NewState
        );

    __declspec(dllimport) void __cdecl _CrtMemDumpAllObjectsSince(
          _CrtMemState const* _State
        );

    __declspec(dllimport) void __cdecl _CrtMemDumpStatistics(
          _CrtMemState const* _State
        );

     
    __declspec(dllimport) int __cdecl _CrtReportBlockType(
          void const* _Block
        );

    __declspec(dllimport) long __cdecl _CrtSetBreakAlloc(
          long _NewValue
        );

    __declspec(dllimport) int __cdecl _CrtSetDbgFlag(
          int _NewFlag
        );

#line 239 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\crtdbg.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Debug Heap Routines
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+








































    












































    __declspec(dllimport) void __cdecl _aligned_free_dbg(
            void* _Block
        );

         
    __declspec(dllimport) __declspec(allocator) void* __cdecl _aligned_malloc_dbg(
                size_t      _Size,
                size_t      _Alignment,
          char const* _FileName,
                int         _LineNumber
        );

    __declspec(dllimport) size_t __cdecl _aligned_msize_dbg(
          void*  _Block,
                   size_t _Alignment,
                   size_t _Offset
        );

         
    __declspec(dllimport) __declspec(allocator) void* __cdecl _aligned_offset_malloc_dbg(
                size_t      _Size,
                size_t      _Alignment,
                size_t      _Offset,
          char const* _FileName,
                int         _LineNumber
        );

           
    __declspec(dllimport) __declspec(allocator) void* __cdecl _aligned_offset_realloc_dbg(
            void*       _Block,
                                    size_t      _Size,
                                    size_t      _Alignment,
                                    size_t      _Offset,
                              char const* _FileName,
                                    int         _LineNumber
        );

           
    __declspec(dllimport) __declspec(allocator) void* __cdecl _aligned_offset_recalloc_dbg(
            void*       _Block,
                                    size_t      _Count,
                                    size_t      _Size,
                                    size_t      _Alignment,
                                    size_t      _Offset,
                              char const* _FileName,
                                    int         _LineNumber
        );

           
    __declspec(dllimport) __declspec(allocator) void* __cdecl _aligned_realloc_dbg(
            void*       _Block,
                                    size_t      _Size,
                                    size_t      _Alignment,
                              char const* _FileName,
                                    int         _LineNumber
        );

           
    __declspec(dllimport) __declspec(allocator) void* __cdecl _aligned_recalloc_dbg(
            void*       _Block,
                                    size_t      _Count,
                                    size_t      _Size,
                                    size_t      _Alignment,
                              char const* _FileName,
                                    int         _LineNumber
        );

         
    __declspec(dllimport) __declspec(allocator) void* __cdecl _calloc_dbg(
                size_t      _Count,
                size_t      _Size,
                int         _BlockUse,
          char const* _FileName,
                int         _LineNumber
        );

         
    __declspec(dllimport) __declspec(allocator) void* __cdecl _expand_dbg(
          void*       _Block,
                   size_t      _Size,
                   int         _BlockUse,
             char const* _FileName,
                   int         _LineNumber
        );

    __declspec(dllimport) void __cdecl _free_dbg(
            void* _Block,
                                    int   _BlockUse
        );

         
    __declspec(dllimport) __declspec(allocator) void* __cdecl _malloc_dbg(
                size_t      _Size,
                int         _BlockUse,
          char const* _FileName,
                int         _LineNumber
        );

    __declspec(dllimport) size_t __cdecl _msize_dbg(
          void* _Block,
                   int   _BlockUse
        );

           
    __declspec(dllimport) __declspec(allocator) void* __cdecl _realloc_dbg(
            void*       _Block,
                                    size_t      _Size,
                                    int         _BlockUse,
                              char const* _FileName,
                                    int         _LineNumber
        );

           
    __declspec(dllimport) __declspec(allocator) void* __cdecl _recalloc_dbg(
            void*       _Block,
                                    size_t      _Count,
                                    size_t      _Size,
                                    int         _BlockUse,
                              char const* _FileName,
                                    int         _LineNumber
        );

     
    
    __declspec(dllimport) errno_t __cdecl _dupenv_s_dbg(
          char** _PBuffer,
                               size_t*     _PBufferSizeInBytes,
                                  char const* _VarName,
                                    int          _BlockType,
                              char const* _FileName,
                                    int          _LineNumber
        );

     
       
    __declspec(dllimport) __declspec(allocator) char* __cdecl _fullpath_dbg(
          char*       _FullPath,
                                    char const* _Path,
                                      size_t      _SizeInBytes,
                                      int         _BlockType,
                                char const* _FileName,
                                      int         _LineNumber
        );

     
       
    __declspec(dllimport) __declspec(allocator) char* __cdecl _getcwd_dbg(
          char*       _DstBuf,
                                      int         _SizeInBytes,
                                      int         _BlockType,
                                char const* _FileName,
                                      int         _LineNumber
        );


     
       
    __declspec(dllimport) __declspec(allocator) char* __cdecl _getdcwd_dbg(
                                      int         _Drive,
          char*       _DstBuf,
                                      int         _SizeInBytes,
                                      int         _BlockType,
                                char const* _FileName,
                                      int         _LineNumber
        );

       
    __declspec(dllimport) __declspec(allocator) char* __cdecl _strdup_dbg(
          char const* _String,
                int         _BlockUse,
          char const* _FileName,
                int         _LineNumber
        );

       
    __declspec(dllimport) __declspec(allocator) char* __cdecl _tempnam_dbg(
          char const* _DirName,
          char const* _FilePrefix,
                int         _BlockType,
          char const* _FileName,
                int         _LineNumber
        );

     
       
    __declspec(dllimport) __declspec(allocator) wchar_t* __cdecl _wcsdup_dbg(
          wchar_t const* _String,
                int            _BlockUse,
          char const*    _FileName,
                int            _LineNumber
        );

     
    
    __declspec(dllimport) errno_t __cdecl _wdupenv_s_dbg(
          wchar_t** _PBuffer,
                                 size_t*         _PBufferSizeInWords,
                                    wchar_t const* _VarName,
                                      int             _BlockType,
                                char const*    _FileName,
                                      int             _LineNumber
        );

     
       
    __declspec(dllimport) __declspec(allocator) wchar_t* __cdecl _wfullpath_dbg(
          wchar_t*       _FullPath,
                                    wchar_t const* _Path,
                                      size_t         _SizeInWords,
                                      int            _BlockType,
                                char const*    _FileName,
                                      int            _LineNumber
        );

     
       
    __declspec(dllimport) __declspec(allocator) wchar_t* __cdecl _wgetcwd_dbg(
          wchar_t*    _DstBuf,
                                      int         _SizeInWords,
                                      int         _BlockType,
                                char const* _FileName,
                                      int         _LineNumber
        );

     
       
    __declspec(dllimport) __declspec(allocator) wchar_t* __cdecl _wgetdcwd_dbg(
                                      int         _Drive,
          wchar_t*    _DstBuf,
                                      int         _SizeInWords,
                                      int         _BlockType,
                                char const* _FileName,
                                      int         _LineNumber
        );

       
    __declspec(dllimport) __declspec(allocator) wchar_t* __cdecl _wtempnam_dbg(
          wchar_t const* _DirName,
          wchar_t const* _FilePrefix,
                int            _BlockType,
          char const*    _FileName,
                int            _LineNumber
        );

    
    

    







#line 588 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\crtdbg.h"

#line 590 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\crtdbg.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Debug Reporting
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+













    __declspec(dllimport) int __cdecl _CrtDbgReport(
                int         _ReportType,
          char const* _FileName,
                int         _Linenumber,
          char const* _ModuleName,
          char const* _Format,
        ...);

    __declspec(dllimport) int __cdecl _CrtDbgReportW(
                int            _ReportType,
          wchar_t const* _FileName,
                int            _LineNumber,
          wchar_t const* _ModuleName,
          wchar_t const* _Format,
        ...);


    __declspec(dllimport) int __cdecl _VCrtDbgReportA(
                int         _ReportType,
            void*       _ReturnAddress,
          char const* _FileName,
                int         _LineNumber,
          char const* _ModuleName,
          char const* _Format,
                   va_list     _ArgList
        );

    __declspec(dllimport) int __cdecl _VCrtDbgReportW(
                int            _ReportType,
            void*          _ReturnAddress,
          wchar_t const* _FileName,
                int            _LineNumber,
          wchar_t const* _ModuleName,
          wchar_t const* _Format,
                   va_list        _ArgList
        );

    __declspec(dllimport) size_t __cdecl _CrtSetDebugFillThreshold(
          size_t _NewDebugFillThreshold
        );

    __declspec(dllimport) size_t __cdecl _CrtGetDebugFillThreshold(void);

    __declspec(dllimport) _HFILE __cdecl _CrtSetReportFile(
              int    _ReportType,
          _HFILE _ReportFile
        );

    __declspec(dllimport) int __cdecl _CrtSetReportMode(
          int _ReportType,
          int _ReportMode
        );

    

        extern long _crtAssertBusy;

        __declspec(dllimport) _CRT_REPORT_HOOK __cdecl _CrtGetReportHook(void);

        // _CrtSetReportHook[[W]2]:
        // For IJW, we need two versions:  one for clrcall and one for cdecl.
        // For pure and native, we just need clrcall and cdecl, respectively.
        __declspec(dllimport) _CRT_REPORT_HOOK __cdecl _CrtSetReportHook(
              _CRT_REPORT_HOOK _PFnNewHook
            );

        __declspec(dllimport) int __cdecl _CrtSetReportHook2(
                  int              _Mode,
              _CRT_REPORT_HOOK _PFnNewHook
            );

        __declspec(dllimport) int __cdecl _CrtSetReportHookW2(
                  int               _Mode,
              _CRT_REPORT_HOOKW _PFnNewHook
            );

    #line 688 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\crtdbg.h"

#line 690 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\crtdbg.h"




//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Assertions and Error Reporting Macros
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+






























    

    // !! is used to ensure that any overloaded operators used to evaluate expr
    // do not end up at &&.
    
        





    #line 741 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\crtdbg.h"

    
        
    #line 745 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\crtdbg.h"

    
        
    #line 749 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\crtdbg.h"

    



    



    
    

    
    

    
    

    
    

#line 771 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\crtdbg.h"

// Asserts in debug.  Invokes Watson in both debug and release









// _ASSERT_BASE is provided only for backwards compatibility.

    
#line 786 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\crtdbg.h"



























} __pragma(pack(pop))

#pragma warning(pop) 
#line 817 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\crtdbg.h"
#line 13 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"
//
// crtdefs.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// Declarations used across the Visual C++ Libraries.  The lack of #pragma once
// is deliberate.
//





//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// CRT DLL Export/Import Macros
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
// used to annotate symbols exported from msvcp140

    

#line 24 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"
        
    #line 26 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"
#line 27 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"

// used to annotate symbols exported from msvcp140_1

    

#line 33 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"
        
    #line 35 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"
#line 36 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"

// used to annotate symbols exported from msvcp140_2

    

#line 42 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"
        
    #line 44 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"
#line 45 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"

// Symbols exported from msvcp140_codecvt_ids are annotated with _CRT_SATELLITE_CODECVT_IDS, except for symbols which
// are data members of classes exported from msvcp140 that must themselves be exported from msvcp140_codecvt_ids, which
// are annotated with _CRT_SATELLITE_CODECVT_IDS_NOIMPORT.

    


#line 54 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"
        
        
    


#line 60 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"
#line 61 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"


    

#line 66 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"
        
            
        

#line 71 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"
    #line 72 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"
#line 73 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"


    

#line 78 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"

#line 80 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"
        
    #line 82 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"
#line 83 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\crtdefs.h"
#line 14 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"

#pragma pack(push, 8)
#pragma warning(push, 3)
#pragma warning(disable : 4180 4412 4455 4494 4514 4574 4582 4583 4587 4588 4619 4623 4625 4626 4643 4648 4702 4793 4820 4988 5026 5027 5045 6294  4984 5053 )












#line 31 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"

#line 33 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"

// CURRENT DLL NAMES









// Visual Studio




#line 50 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 51 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 52 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"










































// B1. Inspect _HAS_ITERATOR_DEBUGGING.











#line 107 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 108 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"

// B2. Inspect _SECURE_SCL.









#line 120 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 121 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"

// B3. Derive _ITERATOR_DEBUG_LEVEL.






#line 130 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"

#line 132 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"



#pragma detect_mismatch("_MSC_VER", "1900")
#line 137 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"


#pragma detect_mismatch("_ITERATOR_DEBUG_LEVEL", "2")
#line 141 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"




#line 146 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"

#line 148 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"

#line 150 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#pragma detect_mismatch("RuntimeLibrary", "MDd_DynamicDebug")
#line 152 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 153 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 154 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"




#line 159 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"

#line 161 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 162 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"



#line 166 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"





























#line 196 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"





#line 202 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"







#line 210 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"






#line 217 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 218 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"





#line 224 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"


#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\use_ansi.h"
// use_ansi.h internal header

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once








#line 16 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\use_ansi.h"
















#line 33 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\use_ansi.h"









#line 43 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\use_ansi.h"




#line 48 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\use_ansi.h"

#pragma comment(lib, "msvcprt" "d" "")






#line 57 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\use_ansi.h"

#line 59 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\use_ansi.h"

#line 61 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\use_ansi.h"
#line 227 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"



















#line 247 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"






#line 254 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 255 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"



#line 259 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"






#line 266 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 267 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"












#line 280 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"



#line 284 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 285 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"






#line 292 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 293 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"






#line 300 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 301 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"




#line 306 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"

#line 308 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 309 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"

// INTEGER PROPERTIES





// MULTITHREAD PROPERTIES
// LOCK MACROS









#line 328 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"

#line 330 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 331 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"



#line 335 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"



#line 339 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"


namespace std {
enum _Uninitialized { // tag for suppressing initialization
    _Noinit
};

// CLASS _Lockit
class __declspec(dllimport) _Lockit { // lock while object in existence -- MUST NEST
public:














    __thiscall _Lockit() noexcept;
    explicit __thiscall _Lockit(int) noexcept; // set the lock
    __thiscall ~_Lockit() noexcept; // clear the lock
#line 367 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"

    static void __cdecl _Lockit_ctor(int) noexcept;
    static void __cdecl _Lockit_dtor(int) noexcept;

private:
    static void __cdecl _Lockit_ctor(_Lockit*) noexcept;
    static void __cdecl _Lockit_ctor(_Lockit*, int) noexcept;
    static void __cdecl _Lockit_dtor(_Lockit*) noexcept;

public:
     _Lockit(const _Lockit&) = delete;
    _Lockit&  operator=(const _Lockit&) = delete;

private:
    int _Locktype;
};








































































#line 456 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"

class __declspec(dllimport) _Init_locks { // initialize mutexes
public:










    __thiscall _Init_locks() noexcept;
    __thiscall ~_Init_locks() noexcept;
#line 472 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"

private:
    static void __cdecl _Init_locks_ctor(_Init_locks*) noexcept;
    static void __cdecl _Init_locks_dtor(_Init_locks*) noexcept;
};

// EXCEPTION MACROS



































#line 515 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
}
#line 517 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"







#pragma warning(pop)
#pragma pack(pop)
#line 527 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 528 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\yvals.h"
#line 10 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"






#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstddef"
// cstddef standard header (core)

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once





#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stddef.h"
//
// stddef.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// The C <stddef.h> Standard Library header.
//
#pragma once





#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8)) extern "C" {




    namespace std
    {
        typedef decltype(__nullptr) nullptr_t;
    }

    using ::std::nullptr_t;
#line 30 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stddef.h"





    __declspec(dllimport) int* __cdecl _errno(void);
    

    __declspec(dllimport) errno_t __cdecl _set_errno(  int _Value);
    __declspec(dllimport) errno_t __cdecl _get_errno(  int* _Value);

#line 42 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stddef.h"









#line 52 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stddef.h"
    
#line 54 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stddef.h"

__declspec(dllimport) extern unsigned long  __cdecl __threadid(void);

__declspec(dllimport) extern uintptr_t __cdecl __threadhandle(void);



} __pragma(pack(pop))

#pragma warning(pop) 
#line 65 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stddef.h"
#line 13 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstddef"
#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xtr1common"
// xtr1common internal header (core)

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once





#pragma pack(push, 8)
#pragma warning(push, 3)
#pragma warning(disable : 4180 4412 4455 4494 4514 4574 4582 4583 4587 4588 4619 4623 4625 4626 4643 4648 4702 4793 4820 4988 5026 5027 5045 6294  4984 5053 )




namespace std {
// STRUCT TEMPLATE integral_constant
template <class _Ty, _Ty _Val>
struct integral_constant {
    static constexpr _Ty value = _Val;

    using value_type = _Ty;
    using type       = integral_constant;

    constexpr operator value_type() const noexcept {
        return value;
    }

    [[nodiscard]] constexpr value_type operator()() const noexcept {
        return value;
    }
};

// ALIAS TEMPLATE bool_constant
template <bool _Val>
using bool_constant = integral_constant<bool, _Val>;

using true_type  = bool_constant<true>;
using false_type = bool_constant<false>;

// STRUCT TEMPLATE enable_if
template <bool _Test, class _Ty = void>
struct enable_if {}; // no member "type" when !_Test

template <class _Ty>
struct enable_if<true, _Ty> { // type is _Ty for _Test
    using type = _Ty;
};

template <bool _Test, class _Ty = void>
using enable_if_t = typename enable_if<_Test, _Ty>::type;

// STRUCT TEMPLATE conditional
template <bool _Test, class _Ty1, class _Ty2>
struct conditional { // Choose _Ty1 if _Test is true, and _Ty2 otherwise
    using type = _Ty1;
};

template <class _Ty1, class _Ty2>
struct conditional<false, _Ty1, _Ty2> {
    using type = _Ty2;
};

template <bool _Test, class _Ty1, class _Ty2>
using conditional_t = typename conditional<_Test, _Ty1, _Ty2>::type;

// STRUCT TEMPLATE is_same







template <class, class>
 constexpr bool is_same_v = false; // determine whether arguments are the same type
template <class _Ty>
 constexpr bool is_same_v<_Ty, _Ty> = true;

template <class _Ty1, class _Ty2>
struct is_same : bool_constant<is_same_v<_Ty1, _Ty2>> {};
#line 86 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xtr1common"

// STRUCT TEMPLATE remove_const
template <class _Ty>
struct remove_const { // remove top-level const qualifier
    using type = _Ty;
};

template <class _Ty>
struct remove_const<const _Ty> {
    using type = _Ty;
};

template <class _Ty>
using remove_const_t = typename remove_const<_Ty>::type;

// STRUCT TEMPLATE remove_volatile
template <class _Ty>
struct remove_volatile { // remove top-level volatile qualifier
    using type = _Ty;
};

template <class _Ty>
struct remove_volatile<volatile _Ty> {
    using type = _Ty;
};

template <class _Ty>
using remove_volatile_t = typename remove_volatile<_Ty>::type;

// STRUCT TEMPLATE remove_cv
template <class _Ty>
struct remove_cv { // remove top-level const and volatile qualifiers
    using type = _Ty;

    template <template <class> class _Fn>
    using _Apply = _Fn<_Ty>; // apply cv-qualifiers from the class template argument to _Fn<_Ty>
};

template <class _Ty>
struct remove_cv<const _Ty> {
    using type = _Ty;

    template <template <class> class _Fn>
    using _Apply = const _Fn<_Ty>;
};

template <class _Ty>
struct remove_cv<volatile _Ty> {
    using type = _Ty;

    template <template <class> class _Fn>
    using _Apply = volatile _Fn<_Ty>;
};

template <class _Ty>
struct remove_cv<const volatile _Ty> {
    using type = _Ty;

    template <template <class> class _Fn>
    using _Apply = const volatile _Fn<_Ty>;
};

template <class _Ty>
using remove_cv_t = typename remove_cv<_Ty>::type;

// STRUCT TEMPLATE disjunction
template <bool _First_value, class _First, class... _Rest>
struct _Disjunction { // handle true trait or last trait
    using type = _First;
};

template <class _False, class _Next, class... _Rest>
struct _Disjunction<false, _False, _Next, _Rest...> { // first trait is false, try the next trait
    using type = typename _Disjunction<_Next::value, _Next, _Rest...>::type;
};

template <class... _Traits>
struct disjunction : false_type {}; // If _Traits is empty, false_type

template <class _First, class... _Rest>
struct disjunction<_First, _Rest...> : _Disjunction<_First::value, _First, _Rest...>::type {
    // the first true trait in _Traits, or the last trait if none are true
};

template <class... _Traits>
 constexpr bool disjunction_v = disjunction<_Traits...>::value;

// VARIABLE TEMPLATE _Is_any_of_v
template <class _Ty, class... _Types>
 constexpr bool _Is_any_of_v = // true if and only if _Ty is in _Types
    disjunction_v<is_same<_Ty, _Types>...>;






#line 184 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xtr1common"

// STRUCT TEMPLATE is_integral
template <class _Ty>
 constexpr bool is_integral_v = _Is_any_of_v<remove_cv_t<_Ty>, bool, char, signed char, unsigned char,
    wchar_t,



    char16_t, char32_t, short, unsigned short, int, unsigned int, long, unsigned long, long long, unsigned long long>;

template <class _Ty>
struct is_integral : bool_constant<is_integral_v<_Ty>> {};

// STRUCT TEMPLATE is_floating_point
template <class _Ty>
 constexpr bool is_floating_point_v = _Is_any_of_v<remove_cv_t<_Ty>, float, double, long double>;

template <class _Ty>
struct is_floating_point : bool_constant<is_floating_point_v<_Ty>> {};

// STRUCT TEMPLATE is_arithmetic
template <class _Ty>
 constexpr bool is_arithmetic_v = // determine whether _Ty is an arithmetic type
    is_integral_v<_Ty> || is_floating_point_v<_Ty>;

template <class _Ty>
struct is_arithmetic : bool_constant<is_arithmetic_v<_Ty>> {};

// STRUCT TEMPLATE remove_reference
template <class _Ty>
struct remove_reference {
    using type                 = _Ty;
    using _Const_thru_ref_type = const _Ty;
};

template <class _Ty>
struct remove_reference<_Ty&> {
    using type                 = _Ty;
    using _Const_thru_ref_type = const _Ty&;
};

template <class _Ty>
struct remove_reference<_Ty&&> {
    using type                 = _Ty;
    using _Const_thru_ref_type = const _Ty&&;
};

template <class _Ty>
using remove_reference_t = typename remove_reference<_Ty>::type;

// ALIAS TEMPLATE _Const_thru_ref
template <class _Ty>
using _Const_thru_ref = typename remove_reference<_Ty>::_Const_thru_ref_type;

template <class _Ty>
using _Remove_cvref_t = remove_cv_t<remove_reference_t<_Ty>>;









#line 250 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xtr1common"

}


#pragma warning(pop)
#pragma pack(pop)
#line 257 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xtr1common"
#line 258 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xtr1common"
#line 14 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstddef"

#pragma pack(push, 8)
#pragma warning(push, 3)
#pragma warning(disable : 4180 4412 4455 4494 4514 4574 4582 4583 4587 4588 4619 4623 4625 4626 4643 4648 4702 4793 4820 4988 5026 5027 5045 6294  4984 5053 )




namespace std {
using :: ptrdiff_t;
using :: size_t;
using max_align_t = double; // most aligned type



































































}

using ::std:: max_align_t; // intentional, for historical reasons



#pragma warning(pop)
#pragma pack(pop)

#line 103 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstddef"
#line 104 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstddef"
#line 17 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstdint"
// cstdint standard header (core)

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once







#pragma pack(push, 8)
#pragma warning(push, 3)
#pragma warning(disable : 4180 4412 4455 4494 4514 4574 4582 4583 4587 4588 4619 4623 4625 4626 4643 4648 4702 4793 4820 4988 5026 5027 5045 6294  4984 5053 )




namespace std {
using :: int8_t;
using :: int16_t;
using :: int32_t;
using :: int64_t;
using :: uint8_t;
using :: uint16_t;
using :: uint32_t;
using :: uint64_t;

using :: int_least8_t;
using :: int_least16_t;
using :: int_least32_t;
using :: int_least64_t;
using :: uint_least8_t;
using :: uint_least16_t;
using :: uint_least32_t;
using :: uint_least64_t;

using :: int_fast8_t;
using :: int_fast16_t;
using :: int_fast32_t;
using :: int_fast64_t;
using :: uint_fast8_t;
using :: uint_fast16_t;
using :: uint_fast32_t;
using :: uint_fast64_t;

using :: intmax_t;
using :: intptr_t;
using :: uintmax_t;
using :: uintptr_t;


namespace [[deprecated( "warning STL4002: " "The non-Standard std::tr1 namespace and TR1-only machinery are deprecated and will be REMOVED. You can " "define _SILENCE_TR1_NAMESPACE_DEPRECATION_WARNING to acknowledge that you have received this warning.")]] tr1 {
    using :: int8_t;
    using :: int16_t;
    using :: int32_t;
    using :: int64_t;
    using :: uint8_t;
    using :: uint16_t;
    using :: uint32_t;
    using :: uint64_t;

    using :: int_least8_t;
    using :: int_least16_t;
    using :: int_least32_t;
    using :: int_least64_t;
    using :: uint_least8_t;
    using :: uint_least16_t;
    using :: uint_least32_t;
    using :: uint_least64_t;

    using :: int_fast8_t;
    using :: int_fast16_t;
    using :: int_fast32_t;
    using :: int_fast64_t;
    using :: uint_fast8_t;
    using :: uint_fast16_t;
    using :: uint_fast32_t;
    using :: uint_fast64_t;

    using :: intmax_t;
    using :: intptr_t;
    using :: uintmax_t;
    using :: uintptr_t;
} // namespace tr1
#line 89 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstdint"
}



#pragma warning(pop)
#pragma pack(pop)

#line 97 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstdint"
#line 98 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstdint"
#line 18 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstring"
// cstring standard header (core)

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once





#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"
//
// string.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// The C Standard Library <string.h> header.
//
#pragma once




#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_memory.h"
//
// corecrt_memory.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// The buffer (memory) manipulation library.  These declarations are split out
// so that they may be included by both <string.h> and <memory.h>.  <string.h>
// does not include <memory.h> to avoid introducing conflicts with other user
// headers named <memory.h>.
//
#pragma once


#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_memcpy_s.h"
//
// corecrt_memcpy_s.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// Inline definitions of memcpy_s and memmove_s
//
#pragma once


#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\errno.h"
//
// errno.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// System error numbers for use with errno and errno_t.
//
#pragma once





#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8)) extern "C" {




    __declspec(dllimport) int* __cdecl _errno(void);
    

    __declspec(dllimport) errno_t __cdecl _set_errno(  int _Value);
    __declspec(dllimport) errno_t __cdecl _get_errno(  int* _Value);

    __declspec(dllimport) unsigned long* __cdecl __doserrno(void);
    

    __declspec(dllimport) errno_t __cdecl _set_doserrno(  unsigned long _Value);
    __declspec(dllimport) errno_t __cdecl _get_doserrno(  unsigned long * _Value);
#line 35 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\errno.h"



// Error codes




































// Error codes used in the Secure CRT functions

    
    
    
    
    
#line 83 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\errno.h"

// Support EDEADLOCK for compatibility with older Microsoft C versions


// POSIX Supplement

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
#line 131 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\errno.h"



} __pragma(pack(pop))

#pragma warning(pop) 
#line 138 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\errno.h"
#line 12 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_memcpy_s.h"
#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime_string.h"
//
// vcruntime_string.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// <string.h> functionality that is implemented in the VCRuntime.
//
#pragma once



#pragma warning(push)
#pragma warning(disable:   4514 4820 )



__pragma(pack(push, 8)) extern "C" {



[[nodiscard]]  
 void const* __cdecl memchr(
      void const* _Buf,
                                 int         _Val,
                                 size_t      _MaxCount
    );

[[nodiscard]]  
int __cdecl memcmp(
      void const* _Buf1,
      void const* _Buf2,
                         size_t      _Size
    );


 

#line 43 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime_string.h"
void* __cdecl memcpy(
      void* _Dst,
            void const* _Src,
                               size_t      _Size
    );


 void* __cdecl memmove(
      void*       _Dst,
            void const* _Src,
                                   size_t      _Size
    );

 

#line 63 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime_string.h"
void* __cdecl memset(
      void*  _Dst,
                               int    _Val,
                               size_t _Size
    );

[[nodiscard]]  
 char const* __cdecl strchr(
      char const* _Str,
        int         _Val
    );

[[nodiscard]]  
 char const* __cdecl strrchr(
      char const* _Str,
        int         _Ch
    );

[[nodiscard]]    
 char const* __cdecl strstr(
      char const* _Str,
      char const* _SubStr
    );

[[nodiscard]]  

 wchar_t const* __cdecl wcschr(
      wchar_t const* _Str,
        wchar_t        _Ch
    );

[[nodiscard]]  
 wchar_t const* __cdecl wcsrchr(
      wchar_t const* _Str,
        wchar_t        _Ch
    );

[[nodiscard]]    

 wchar_t const* __cdecl wcsstr(
      wchar_t const* _Str,
      wchar_t const* _SubStr
    );



} __pragma(pack(pop))

#line 112 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\vcruntime_string.h"

#pragma warning(pop) 
#line 13 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_memcpy_s.h"

#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8)) extern "C" {


    
#line 23 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_memcpy_s.h"














     
    
    static __inline errno_t __cdecl memcpy_s(
          void*       const _Destination,
                                                              rsize_t     const _DestinationSize,
                                 void const* const _Source,
                                                              rsize_t     const _SourceSize
        )
    {
        if (_SourceSize == 0)
        {
            return 0;
        }

        { int _Expr_val=!!(_Destination != 0); if (!(_Expr_val)) { (*_errno()) = 22; _invalid_parameter_noinfo(); return 22; } };
        if (_Source == 0 || _DestinationSize < _SourceSize)
        {
            memset(_Destination, 0, _DestinationSize);

            { int _Expr_val=!!(_Source != 0); if (!(_Expr_val)) { (*_errno()) = 22; _invalid_parameter_noinfo(); return 22; } };
            { int _Expr_val=!!(_DestinationSize >= _SourceSize); if (!(_Expr_val)) { (*_errno()) = 34; _invalid_parameter_noinfo(); return 34; } };

            // Unreachable, but required to suppress /analyze warnings:
            return 22;
        }
        memcpy(_Destination, _Source, _SourceSize);
        return 0;
    }

    
    static __inline errno_t __cdecl memmove_s(
          void*       const _Destination,
                                                              rsize_t     const _DestinationSize,
                                 void const* const _Source,
                                                              rsize_t     const _SourceSize
        )
    {
        if (_SourceSize == 0)
        {
            return 0;
        }

        { int _Expr_val=!!(_Destination != 0); if (!(_Expr_val)) { (*_errno()) = 22; _invalid_parameter_noinfo(); return 22; } };
        { int _Expr_val=!!(_Source != 0); if (!(_Expr_val)) { (*_errno()) = 22; _invalid_parameter_noinfo(); return 22; } };
        { int _Expr_val=!!(_DestinationSize >= _SourceSize); if (!(_Expr_val)) { (*_errno()) = 34; _invalid_parameter_noinfo(); return 34; } };

        memmove(_Destination, _Source, _SourceSize);
        return 0;
    }

#line 88 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_memcpy_s.h"




#pragma warning(pop) 
} __pragma(pack(pop))
#line 15 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_memory.h"


#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )




__pragma(pack(push, 8)) extern "C" {



 
__declspec(dllimport) int __cdecl _memicmp(
      void const* _Buf1,
      void const* _Buf2,
                             size_t      _Size
    );

 
__declspec(dllimport) int __cdecl _memicmp_l(
      void const* _Buf1,
      void const* _Buf2,
                             size_t      _Size,
                         _locale_t   _Locale
    );





    












#line 60 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_memory.h"

    












#line 75 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_memory.h"

#line 77 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_memory.h"





    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_memccpy" ". See online help for details."))
    __declspec(dllimport) void* __cdecl memccpy(
          void*       _Dst,
            void const* _Src,
                                   int         _Val,
                                   size_t      _Size
        );

      __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_memicmp" ". See online help for details."))
    __declspec(dllimport) int __cdecl memicmp(
          void const* _Buf1,
          void const* _Buf2,
                                 size_t      _Size
        );

#line 98 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_memory.h"





    extern "C++"  
    inline void* __cdecl memchr(
          void*  _Pv,
                              int    _C,
                              size_t _N
        )
    {
        void const* const _Pvc = _Pv;
        return const_cast<void*>(memchr(_Pvc, _C, _N));
    }

#line 115 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_memory.h"



} __pragma(pack(pop))

#line 121 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_memory.h"

#pragma warning(pop) 
#line 14 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"
#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"
//
// corecrt_wstring.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// This file declares the wide character (wchar_t) string functionality, shared
// by <string.h> and <wchar.h>.
//
#pragma once




#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )




__pragma(pack(push, 8)) extern "C" {



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Secure Alternatives
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


    
    __declspec(dllimport) errno_t __cdecl wcscat_s(
          wchar_t* _Destination,
          rsize_t _SizeInWords,
          wchar_t const* _Source
        );

    
    __declspec(dllimport) errno_t __cdecl wcscpy_s(
          wchar_t* _Destination,
          rsize_t _SizeInWords,
          wchar_t const* _Source
        );

    
    __declspec(dllimport) errno_t __cdecl wcsncat_s(
          wchar_t*       _Destination,
                                     rsize_t        _SizeInWords,
               wchar_t const* _Source,
                                     rsize_t        _MaxCount
        );

    
    __declspec(dllimport) errno_t __cdecl wcsncpy_s(
          wchar_t*       _Destination,
                                  rsize_t        _SizeInWords,
            wchar_t const* _Source,
                                  rsize_t        _MaxCount
        );

     
    __declspec(dllimport) wchar_t* __cdecl wcstok_s(
                          wchar_t*       _String,
                                 wchar_t const* _Delimiter,
            wchar_t**      _Context
        );

#line 69 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Wide-Character <string.h> Functions
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+



#line 81 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

 
__declspec(dllimport) __declspec(allocator) wchar_t* __cdecl _wcsdup(
      wchar_t const* _String
    );



#line 90 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"



extern "C++" { template <size_t _Size> inline errno_t __cdecl wcscat_s(wchar_t (&_Destination)[_Size],   wchar_t const* _Source) throw() { return wcscat_s(_Destination, _Size, _Source); } }
#line 98 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"


    __declspec(deprecated("This function or variable may be unsafe. Consider using " "wcscat_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) wchar_t* __cdecl wcscat( wchar_t *_Destination,  wchar_t const* _Source);
#line 105 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"
#line 106 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

 
__declspec(dllimport) int __cdecl wcscmp(
      wchar_t const* _String1,
      wchar_t const* _String2
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl wcscpy_s(wchar_t (&_Destination)[_Size],   wchar_t const* _Source) throw() { return wcscpy_s(_Destination, _Size, _Source); } }
#line 118 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "wcscpy_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) wchar_t* __cdecl wcscpy( wchar_t *_Destination,  wchar_t const* _Source);
#line 124 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

 
__declspec(dllimport) size_t __cdecl wcscspn(
      wchar_t const* _String,
      wchar_t const* _Control
    );

 
__declspec(dllimport) size_t __cdecl wcslen(
      wchar_t const* _String
    );

 

#line 141 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

#line 145 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"
__declspec(dllimport) size_t __cdecl wcsnlen(
      wchar_t const* _Source,
                            size_t         _MaxCount
    );



     
    
#line 157 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"
    
#line 161 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"
    static __inline size_t __cdecl wcsnlen_s(
          wchar_t const* _Source,
                                size_t         _MaxCount
        )
    {
        return (_Source == 0) ? 0 : wcsnlen(_Source, _MaxCount);
    }

#line 170 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

extern "C++" { template <size_t _Size> inline errno_t __cdecl wcsncat_s(  wchar_t (&_Destination)[_Size],   wchar_t const* _Source,   size_t _Count) throw() { return wcsncat_s(_Destination, _Size, _Source, _Count); } }
#line 177 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "wcsncat_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) wchar_t* __cdecl wcsncat(  wchar_t *_Destination,   wchar_t const* _Source,   size_t _Count);
#line 185 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

 
__declspec(dllimport) int __cdecl wcsncmp(
      wchar_t const* _String1,
      wchar_t const* _String2,
                            size_t         _MaxCount
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl wcsncpy_s(wchar_t (&_Destination)[_Size],   wchar_t const* _Source,   size_t _Count) throw() { return wcsncpy_s(_Destination, _Size, _Source, _Count); } }
#line 199 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "wcsncpy_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) wchar_t* __cdecl wcsncpy(    wchar_t *_Destination,   wchar_t const* _Source,   size_t _Count);
#line 207 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

 
__declspec(dllimport) wchar_t const* __cdecl wcspbrk(
      wchar_t const* _String,
      wchar_t const* _Control
    );

 
__declspec(dllimport) size_t __cdecl wcsspn(
      wchar_t const* _String,
      wchar_t const* _Control
    );

  __declspec(deprecated("This function or variable may be unsafe. Consider using " "wcstok_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) wchar_t* __cdecl wcstok(
                          wchar_t*       _String,
                                 wchar_t const* _Delimiter,
        wchar_t**      _Context
    );



    

#line 232 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"
        



    #line 237 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

      __declspec(deprecated("This function or variable may be unsafe. Consider using " "wcstok_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
    static __inline wchar_t* __cdecl _wcstok(
          wchar_t*       const _String,
                 wchar_t const* const _Delimiter
        )
    {
        return wcstok(_String, _Delimiter, 0);
    }

    

#line 250 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

    
        extern "C++"   __declspec(deprecated("wcstok has been changed to conform with the ISO C standard, " "adding an extra context parameter. To use the legacy Microsoft " "wcstok, define _CRT_NON_CONFORMING_WCSTOK."))
        inline wchar_t* __cdecl wcstok(
              wchar_t*       _String,
                     wchar_t const* _Delimiter
            ) throw()
        {
            return wcstok(_String, _Delimiter, 0);
        }
    #line 261 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

#line 263 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"



 
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_wcserror_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) wchar_t* __cdecl _wcserror(
      int _ErrorNumber
    );


__declspec(dllimport) errno_t __cdecl _wcserror_s(
      wchar_t* _Buffer,
                                  size_t   _SizeInWords,
                                  int      _ErrorNumber
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _wcserror_s(wchar_t (&_Buffer)[_Size],   int _Error) throw() { return _wcserror_s(_Buffer, _Size, _Error); } }
#line 284 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

 
 
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "__wcserror_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) wchar_t* __cdecl __wcserror(
      wchar_t const* _String
    );

 __declspec(dllimport) errno_t __cdecl __wcserror_s(
      wchar_t*       _Buffer,
                                  size_t         _SizeInWords,
                                wchar_t const* _ErrorMessage
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl __wcserror_s(wchar_t (&_Buffer)[_Size],   wchar_t const* _ErrorMessage) throw() { return __wcserror_s(_Buffer, _Size, _ErrorMessage); } }
#line 303 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

  __declspec(dllimport) int __cdecl _wcsicmp(
      wchar_t const* _String1,
      wchar_t const* _String2
    );

  __declspec(dllimport) int __cdecl _wcsicmp_l(
        wchar_t const* _String1,
        wchar_t const* _String2,
      _locale_t      _Locale
    );

  __declspec(dllimport) int __cdecl _wcsnicmp(
      wchar_t const* _String1,
      wchar_t const* _String2,
                            size_t         _MaxCount
    );

  __declspec(dllimport) int __cdecl _wcsnicmp_l(
      wchar_t const* _String1,
      wchar_t const* _String2,
                            size_t         _MaxCount,
                        _locale_t      _Locale
    );

 __declspec(dllimport) errno_t __cdecl _wcsnset_s(
      wchar_t* _Destination,
                                 size_t   _SizeInWords,
                                 wchar_t  _Value,
                                 size_t   _MaxCount
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _wcsnset_s(  wchar_t (&_Destination)[_Size],   wchar_t _Value,   size_t _MaxCount) throw() { return _wcsnset_s(_Destination, _Size, _Value, _MaxCount); } }
#line 341 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_wcsnset_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) wchar_t* __cdecl _wcsnset(  wchar_t *_String,   wchar_t _Value,   size_t _MaxCount);
#line 349 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

__declspec(dllimport) wchar_t* __cdecl _wcsrev(
      wchar_t* _String
    );

 __declspec(dllimport) errno_t __cdecl _wcsset_s(
      wchar_t* _Destination,
                                 size_t   _SizeInWords,
                                 wchar_t  _Value
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _wcsset_s(  wchar_t (&_String)[_Size],   wchar_t _Value) throw() { return _wcsset_s(_String, _Size, _Value); } }
#line 365 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_wcsset_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) wchar_t* __cdecl _wcsset(  wchar_t *_String,   wchar_t _Value);
#line 372 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

 __declspec(dllimport) errno_t __cdecl _wcslwr_s(
      wchar_t* _String,
                                 size_t   _SizeInWords
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _wcslwr_s(  wchar_t (&_String)[_Size]) throw() { return _wcslwr_s(_String, _Size); } }
#line 382 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_wcslwr_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) wchar_t* __cdecl _wcslwr( wchar_t *_String);
#line 387 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"


__declspec(dllimport) errno_t __cdecl _wcslwr_s_l(
      wchar_t*  _String,
                                 size_t    _SizeInWords,
                             _locale_t _Locale
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _wcslwr_s_l(  wchar_t (&_String)[_Size],   _locale_t _Locale) throw() { return _wcslwr_s_l(_String, _Size, _Locale); } }
#line 400 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_wcslwr_s_l" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) wchar_t* __cdecl _wcslwr_l(  wchar_t *_String,   _locale_t _Locale);
#line 407 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"


__declspec(dllimport) errno_t __cdecl _wcsupr_s(
      wchar_t* _String,
                          size_t   _Size
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _wcsupr_s(  wchar_t (&_String)[_Size]) throw() { return _wcsupr_s(_String, _Size); } }
#line 418 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_wcsupr_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) wchar_t* __cdecl _wcsupr( wchar_t *_String);
#line 423 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"


__declspec(dllimport) errno_t __cdecl _wcsupr_s_l(
      wchar_t*  _String,
                          size_t    _Size,
                      _locale_t _Locale
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _wcsupr_s_l(  wchar_t (&_String)[_Size],   _locale_t _Locale) throw() { return _wcsupr_s_l(_String, _Size, _Locale); } }
#line 436 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_wcsupr_s_l" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) wchar_t* __cdecl _wcsupr_l(  wchar_t *_String,   _locale_t _Locale);
#line 443 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

 

__declspec(dllimport) size_t __cdecl wcsxfrm(
        wchar_t*       _Destination,
                                         wchar_t const* _Source,
                size_t         _MaxCount
    );

 

__declspec(dllimport) size_t __cdecl _wcsxfrm_l(
        wchar_t*       _Destination,
                                         wchar_t const* _Source,
                size_t         _MaxCount,
                                       _locale_t      _Locale
    );

 
__declspec(dllimport) int __cdecl wcscoll(
      wchar_t const* _String1,
      wchar_t const* _String2
    );

 
__declspec(dllimport) int __cdecl _wcscoll_l(
        wchar_t const* _String1,
        wchar_t const* _String2,
      _locale_t      _Locale
    );

 
__declspec(dllimport) int __cdecl _wcsicoll(
      wchar_t const* _String1,
      wchar_t const* _String2
    );

 
__declspec(dllimport) int __cdecl _wcsicoll_l(
        wchar_t const* _String1,
        wchar_t const* _String2,
      _locale_t      _Locale
    );

 
__declspec(dllimport) int __cdecl _wcsncoll(
      wchar_t const* _String1,
      wchar_t const* _String2,
                            size_t         _MaxCount
    );

 
__declspec(dllimport) int __cdecl _wcsncoll_l(
      wchar_t const* _String1,
      wchar_t const* _String2,
                            size_t         _MaxCount,
                        _locale_t      _Locale
    );

 
__declspec(dllimport) int __cdecl _wcsnicoll(
      wchar_t const* _String1,
      wchar_t const* _String2,
                            size_t         _MaxCount
    );

 
__declspec(dllimport) int __cdecl _wcsnicoll_l(
      wchar_t const* _String1,
      wchar_t const* _String2,
                            size_t         _MaxCount,
                        _locale_t      _Locale
    );



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Inline C++ Overloads
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

extern "C++" {

     
    
    inline wchar_t* __cdecl wcschr(  wchar_t* _String, wchar_t _C)
    {
        return const_cast<wchar_t*>(wcschr(static_cast<wchar_t const*>(_String), _C));
    }

     
    inline wchar_t* __cdecl wcspbrk(  wchar_t* _String,   wchar_t const* _Control)
    {
        return const_cast<wchar_t*>(wcspbrk(static_cast<wchar_t const*>(_String), _Control));
    }

     
    inline wchar_t* __cdecl wcsrchr(  wchar_t* _String,   wchar_t _C)
    {
        return const_cast<wchar_t*>(wcsrchr(static_cast<wchar_t const*>(_String), _C));
    }

       
    
    inline wchar_t* __cdecl wcsstr(  wchar_t* _String,   wchar_t const*_SubStr)
    {
        return const_cast<wchar_t*>(wcsstr(static_cast<wchar_t const*>(_String), _SubStr));
    }

}
#line 555 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Non-Standard Names
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    


#line 568 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

      __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_wcsdup" ". See online help for details."))
    __declspec(dllimport) wchar_t* __cdecl wcsdup(
          wchar_t const* _String
        );

    

#line 577 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

    // Declarations of functions defined in oldnames.lib:
    

      __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_wcsicmp" ". See online help for details."))
    __declspec(dllimport) int __cdecl wcsicmp(
          wchar_t const* _String1,
          wchar_t const* _String2
        );

      __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_wcsnicmp" ". See online help for details."))
    __declspec(dllimport) int __cdecl wcsnicmp(
          wchar_t const* _String1,
          wchar_t const* _String2,
                                size_t         _MaxCount
        );

    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_wcsnset" ". See online help for details."))
     
    __declspec(dllimport) wchar_t* __cdecl wcsnset(
          wchar_t* _String,
                                  wchar_t  _Value,
                                  size_t   _MaxCount
        );

    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_wcsrev" ". See online help for details."))
     
    __declspec(dllimport) wchar_t* __cdecl wcsrev(
          wchar_t* _String
        );

    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_wcsset" ". See online help for details."))
     
    __declspec(dllimport) wchar_t* __cdecl wcsset(
          wchar_t* _String,
               wchar_t  _Value
        );

    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_wcslwr" ". See online help for details."))
     
    __declspec(dllimport) wchar_t* __cdecl wcslwr(
          wchar_t* _String
        );

    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_wcsupr" ". See online help for details."))
     
    __declspec(dllimport) wchar_t* __cdecl wcsupr(
          wchar_t* _String
        );

      __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_wcsicoll" ". See online help for details."))
    __declspec(dllimport) int __cdecl wcsicoll(
          wchar_t const* _String1,
          wchar_t const* _String2
        );

#line 634 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"



} __pragma(pack(pop))

#line 640 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstring.h"

#pragma warning(pop) 
#line 15 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"




#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8)) extern "C" {







    
    __declspec(dllimport) errno_t __cdecl strcpy_s(
          char*       _Destination,
                                  rsize_t     _SizeInBytes,
                                char const* _Source
        );

    
    __declspec(dllimport) errno_t __cdecl strcat_s(
          char*       _Destination,
                                     rsize_t     _SizeInBytes,
                                   char const* _Source
        );

    
    __declspec(dllimport) errno_t __cdecl strerror_s(
          char*  _Buffer,
                                  size_t _SizeInBytes,
                                  int    _ErrorNumber);

    
    __declspec(dllimport) errno_t __cdecl strncat_s(
          char*       _Destination,
                                     rsize_t     _SizeInBytes,
               char const* _Source,
                                     rsize_t     _MaxCount
        );

    
    __declspec(dllimport) errno_t __cdecl strncpy_s(
          char*       _Destination,
                                  rsize_t     _SizeInBytes,
            char const* _Source,
                                  rsize_t     _MaxCount
        );

     
    __declspec(dllimport) char*  __cdecl strtok_s(
                          char*       _String,
                                 char const* _Delimiter,
            char**      _Context
        );

#line 75 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

__declspec(dllimport) void* __cdecl _memccpy(
      void*       _Dst,
                                   void const* _Src,
                                   int         _Val,
                                   size_t      _MaxCount
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl strcat_s(char (&_Destination)[_Size],   char const* _Source) throw() { return strcat_s(_Destination, _Size, _Source); } }
#line 88 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"



    __declspec(deprecated("This function or variable may be unsafe. Consider using " "strcat_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))  char* __cdecl strcat( char *_Destination,  char const* _Source);
#line 96 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

#line 98 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

 
int __cdecl strcmp(
      char const* _Str1,
      char const* _Str2
    );

 
__declspec(dllimport) int __cdecl _strcmpi(
      char const* _String1,
      char const* _String2
    );

 
__declspec(dllimport) int __cdecl strcoll(
      char const* _String1,
      char const* _String2
    );

 
__declspec(dllimport) int __cdecl _strcoll_l(
        char const* _String1,
        char const* _String2,
      _locale_t   _Locale
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl strcpy_s(  char (&_Destination)[_Size],   char const* _Source) throw() { return strcpy_s(_Destination, _Size, _Source); } }
#line 129 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "strcpy_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))  char* __cdecl strcpy( char *_Destination,  char const* _Source);
#line 135 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

 
__declspec(dllimport) size_t __cdecl strcspn(
      char const* _Str,
      char const* _Control
    );




#line 146 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

 
__declspec(dllimport) __declspec(allocator) char* __cdecl _strdup(
      char const* _Source
    );



#line 155 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

 
 
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_strerror_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) char*  __cdecl _strerror(
      char const* _ErrorMessage
    );


__declspec(dllimport) errno_t __cdecl _strerror_s(
      char*       _Buffer,
                              size_t      _SizeInBytes,
                        char const* _ErrorMessage
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _strerror_s(char (&_Buffer)[_Size],   char const* _ErrorMessage) throw() { return _strerror_s(_Buffer, _Size, _ErrorMessage); } }
#line 175 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

 
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "strerror_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) char* __cdecl strerror(
      int _ErrorMessage
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl strerror_s(char (&_Buffer)[_Size],   int _ErrorMessage) throw() { return strerror_s(_Buffer, _Size, _ErrorMessage); } }
#line 187 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

 
__declspec(dllimport) int __cdecl _stricmp(
      char const* _String1,
      char const* _String2
    );

 
__declspec(dllimport) int __cdecl _stricoll(
      char const* _String1,
      char const* _String2
    );

 
__declspec(dllimport) int __cdecl _stricoll_l(
        char const* _String1,
        char const* _String2,
      _locale_t   _Locale
    );

 
__declspec(dllimport) int __cdecl _stricmp_l(
        char const* _String1,
        char const* _String2,
      _locale_t   _Locale
    );

 
size_t __cdecl strlen(
      char const* _Str
    );


__declspec(dllimport) errno_t __cdecl _strlwr_s(
      char*  _String,
                          size_t _Size
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _strlwr_s(  char (&_String)[_Size]) throw() { return _strlwr_s(_String, _Size); } }
#line 229 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_strlwr_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) char* __cdecl _strlwr( char *_String);
#line 234 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"


__declspec(dllimport) errno_t __cdecl _strlwr_s_l(
      char*     _String,
                          size_t    _Size,
                      _locale_t _Locale
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _strlwr_s_l(  char (&_String)[_Size],   _locale_t _Locale) throw() { return _strlwr_s_l(_String, _Size, _Locale); } }
#line 247 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_strlwr_s_l" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) char* __cdecl _strlwr_l(  char *_String,   _locale_t _Locale);
#line 254 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

extern "C++" { template <size_t _Size> inline errno_t __cdecl strncat_s(  char (&_Destination)[_Size],   char const* _Source,   size_t _Count) throw() { return strncat_s(_Destination, _Size, _Source, _Count); } }
#line 261 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "strncat_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) char* __cdecl strncat(  char *_Destination,   char const* _Source,   size_t _Count);
#line 269 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

 
__declspec(dllimport) int __cdecl strncmp(
      char const* _Str1,
      char const* _Str2,
                            size_t      _MaxCount
    );

 
__declspec(dllimport) int __cdecl _strnicmp(
      char const* _String1,
      char const* _String2,
                            size_t      _MaxCount
    );

 
__declspec(dllimport) int __cdecl _strnicmp_l(
      char const* _String1,
      char const* _String2,
                            size_t      _MaxCount,
                        _locale_t   _Locale
    );

 
__declspec(dllimport) int __cdecl _strnicoll(
      char const* _String1,
      char const* _String2,
                            size_t      _MaxCount
    );

 
__declspec(dllimport) int __cdecl _strnicoll_l(
      char const* _String1,
      char const* _String2,
                            size_t      _MaxCount,
                        _locale_t   _Locale
    );

 
__declspec(dllimport) int __cdecl _strncoll(
      char const* _String1,
      char const* _String2,
                            size_t      _MaxCount
    );

 
__declspec(dllimport) int __cdecl _strncoll_l(
      char const* _String1,
      char const* _String2,
                            size_t      _MaxCount,
                        _locale_t   _Locale
    );

__declspec(dllimport) size_t __cdecl __strncnt(
      char const* _String,
                         size_t      _Count
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl strncpy_s(char (&_Destination)[_Size],   char const* _Source,   size_t _Count) throw() { return strncpy_s(_Destination, _Size, _Source, _Count); } }
#line 333 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "strncpy_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) char* __cdecl strncpy(    char *_Destination,   char const* _Source,   size_t _Count);
#line 341 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

 

#line 347 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

#line 351 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"
__declspec(dllimport) size_t __cdecl strnlen(
      char const* _String,
                            size_t      _MaxCount
    );



     
    
#line 363 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"
    
#line 367 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"
    static __inline size_t __cdecl strnlen_s(
          char const* _String,
                                size_t      _MaxCount
        )
    {
        return _String == 0 ? 0 : strnlen(_String, _MaxCount);
    }

#line 376 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"


__declspec(dllimport) errno_t __cdecl _strnset_s(
      char*  _String,
                                 size_t _SizeInBytes,
                                 int    _Value,
                                 size_t _MaxCount
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _strnset_s(  char (&_Destination)[_Size],   int _Value,   size_t _Count) throw() { return _strnset_s(_Destination, _Size, _Value, _Count); } }
#line 391 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_strnset_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) char* __cdecl _strnset(  char *_Destination,   int _Value,   size_t _Count);
#line 399 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

 
__declspec(dllimport) char const* __cdecl strpbrk(
      char const* _Str,
      char const* _Control
    );

__declspec(dllimport) char* __cdecl _strrev(
      char* _Str
    );


__declspec(dllimport) errno_t __cdecl _strset_s(
      char*  _Destination,
                                     size_t _DestinationSize,
                                     int    _Value
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _strset_s(  char (&_Destination)[_Size],   int _Value) throw() { return _strset_s(_Destination, _Size, _Value); } }
#line 422 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_strset_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))  char* __cdecl _strset( char *_Destination,  int _Value);
#line 428 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

 
__declspec(dllimport) size_t __cdecl strspn(
      char const* _Str,
      char const* _Control
    );

  __declspec(deprecated("This function or variable may be unsafe. Consider using " "strtok_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) char* __cdecl strtok(
      char*       _String,
             char const* _Delimiter
    );


__declspec(dllimport) errno_t __cdecl _strupr_s(
      char*  _String,
                          size_t _Size
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _strupr_s(  char (&_String)[_Size]) throw() { return _strupr_s(_String, _Size); } }
#line 451 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_strupr_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) char* __cdecl _strupr( char *_String);
#line 456 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"


__declspec(dllimport) errno_t __cdecl _strupr_s_l(
      char*     _String,
                          size_t    _Size,
                      _locale_t _Locale
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _strupr_s_l(  char (&_String)[_Size],   _locale_t _Locale) throw() { return _strupr_s_l(_String, _Size, _Locale); } }
#line 469 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_strupr_s_l" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) char* __cdecl _strupr_l(  char *_String,   _locale_t _Locale);
#line 476 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"

 

__declspec(dllimport) size_t __cdecl strxfrm(
        char*       _Destination,
                                         char const* _Source,
                 size_t      _MaxCount
    );

 

__declspec(dllimport) size_t __cdecl _strxfrm_l(
        char*       _Destination,
                                         char const* _Source,
                 size_t      _MaxCount,
                                       _locale_t   _Locale
    );




extern "C++"
{
     
    inline char* __cdecl strchr(  char* const _String,   int const _Ch)
    {
        return const_cast<char*>(strchr(static_cast<char const*>(_String), _Ch));
    }

     
    inline char* __cdecl strpbrk(  char* const _String,   char const* const _Control)
    {
        return const_cast<char*>(strpbrk(static_cast<char const*>(_String), _Control));
    }

     
    inline char* __cdecl strrchr(  char* const _String,   int const _Ch)
    {
        return const_cast<char*>(strrchr(static_cast<char const*>(_String), _Ch));
    }

       
    inline char* __cdecl strstr(  char* const _String,   char const* const _SubString)
    {
        return const_cast<char*>(strstr(static_cast<char const*>(_String), _SubString));
    }
}
#line 524 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"





    
    
      __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_strdup" ". See online help for details."))
    __declspec(dllimport) char* __cdecl strdup(
          char const* _String
        );
    

    // Declarations of functions defined in oldnames.lib:
      __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_strcmpi" ". See online help for details."))
    __declspec(dllimport) int __cdecl strcmpi(
          char const* _String1,
          char const* _String2
        );

      __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_stricmp" ". See online help for details."))
    __declspec(dllimport) int __cdecl stricmp(
          char const* _String1,
          char const* _String2
        );

    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_strlwr" ". See online help for details."))
    __declspec(dllimport) char* __cdecl strlwr(
          char* _String
        );

      __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_strnicmp" ". See online help for details."))
    __declspec(dllimport) int __cdecl strnicmp(
          char const* _String1,
          char const* _String2,
                                size_t      _MaxCount
        );

    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_strnset" ". See online help for details."))
    __declspec(dllimport) char* __cdecl strnset(
          char*  _String,
                                  int    _Value,
                                  size_t _MaxCount
        );

    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_strrev" ". See online help for details."))
    __declspec(dllimport) char* __cdecl strrev(
          char* _String
        );

    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_strset" ". See online help for details."))
    char* __cdecl strset(
          char* _String,
               int   _Value);

    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_strupr" ". See online help for details."))
    __declspec(dllimport) char* __cdecl strupr(
          char* _String
        );

#line 585 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"



} __pragma(pack(pop))

#pragma warning(pop) 
#line 592 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"
#line 593 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\string.h"
#line 13 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstring"

#pragma pack(push, 8)
#pragma warning(push, 3)
#pragma warning(disable : 4180 4412 4455 4494 4514 4574 4582 4583 4587 4588 4619 4623 4625 4626 4643 4648 4702 4793 4820 4988 5026 5027 5045 6294  4984 5053 )




namespace std {
#pragma warning(push)
#pragma warning(disable : 4995) 

using :: size_t;
using :: memchr;
using :: memcmp;
using :: memcpy;
using :: memmove;
using :: memset;
using :: strcat;
using :: strchr;
using :: strcmp;
using :: strcoll;
using :: strcpy;
using :: strcspn;
using :: strerror;
using :: strlen;
using :: strncat;
using :: strncmp;
using :: strncpy;
using :: strpbrk;
using :: strrchr;
using :: strspn;
using :: strstr;
using :: strtok;
using :: strxfrm;

#pragma warning(pop)
}



#pragma warning(pop)
#pragma pack(pop)

#line 58 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstring"
#line 59 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstring"
#line 19 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xatomic.h"
// xatomic.h internal header

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once





#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"
/***
*   intrin0.h - declarations of compiler intrinsics used by the C++ Standard Library.
*
*       Copyright (c) Microsoft Corporation. All rights reserved.
*
*Purpose:
*   This header file declares compiler intrinsics that are used by the
*   C++ Standard Library, especially <atomic>. Compiler throughput is
*   the only reason that intrin0.h is separate from intrin.h.
*
****/

#pragma once





#pragma warning(push)
#pragma warning(disable:   4514 4820 )


extern "C" {
#line 25 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"

/*
** __MACHINE              : everything
** __MACHINEX86           : x86 only
** __MACHINEX64           : x64 only
** __MACHINEX86_X64       : x86 and x64 only
** __MACHINEARM           : ARM only
** __MACHINEARM64         : ARM64 only
** __MACHINEARM_ARM64     : ARM and ARM64 only
** __MACHINEARM_ARM64_X64 : ARM and 64-bit Arch only
** __MACHINEARM64_X64     : ARM64 and x64 only
** __MACHINECHPEX86ARM64  : CHPE x86 on arm64 only
** __MACHINEWVMPURE       : /clr:pure only
** __MACHINEZ             : nothing
*/











/* Most intrinsics not available to pure managed code */



#line 56 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"


#line 59 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"






#line 66 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"




#line 71 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"




#line 76 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"




#line 81 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"

/* For compatibility with <winnt.h>, some intrinsics are __cdecl except on x64 */




#line 88 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"




#line 93 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"




#line 98 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"




#line 103 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"




#line 108 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"




#line 113 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"

/*******************************************************************
* Note: New intrinsics should be added here IF AND ONLY IF they're *
* being used by the C++ Standard Library.                          *
* OTHERWISE, new intrinsics should be added to intrin.h.           *
*******************************************************************/



unsigned char _BitScanForward(unsigned long * _Index, unsigned long _Mask);
unsigned char _BitScanForward64(unsigned long * _Index, unsigned __int64 _Mask);

unsigned char _BitScanReverse(unsigned long * _Index, unsigned long _Mask);
unsigned char _BitScanReverse64(unsigned long * _Index, unsigned __int64 _Mask);

unsigned char _bittest(long const *, long);


long _InterlockedAnd(long volatile * _Value, long _Mask);
short _InterlockedAnd16(short volatile * _Value, short _Mask);



__int64 _InterlockedAnd64(__int64 volatile * _Value, __int64 _Mask);



char _InterlockedAnd8(char volatile * _Value, char _Mask);






long  _InterlockedCompareExchange(long volatile * _Destination, long _Exchange, long _Comparand);

short _InterlockedCompareExchange16(short volatile * _Destination, short _Exchange, short _Comparand);



__int64 _InterlockedCompareExchange64(__int64 volatile * _Destination, __int64 _Exchange, __int64 _Comparand);



char _InterlockedCompareExchange8(char volatile * _Destination, char _Exchange, char _Comparand);






unsigned char _InterlockedCompareExchange128(__int64 volatile * _Destination, __int64 _ExchangeHigh, __int64 _ExchangeLow, __int64 * _ComparandResult);



long  _InterlockedDecrement(long volatile * _Addend);

short _InterlockedDecrement16(short volatile * _Addend);
__int64 _InterlockedDecrement64(__int64 volatile * _Addend);
long  _InterlockedExchange(long volatile * _Target, long _Value);

short _InterlockedExchange16(short volatile * _Target, short _Value);



__int64 _InterlockedExchange64(__int64 volatile * _Target, __int64 _Value);



char _InterlockedExchange8(char volatile * _Target, char _Value);



long  _InterlockedExchangeAdd(long volatile * _Addend, long _Value);
short _InterlockedExchangeAdd16(short volatile * _Addend, short _Value);



__int64 _InterlockedExchangeAdd64(__int64 volatile * _Addend, __int64 _Value);



char _InterlockedExchangeAdd8(char volatile * _Addend, char _Value);









long  _InterlockedIncrement(long volatile * _Addend);

short _InterlockedIncrement16(short volatile * _Addend);
__int64 _InterlockedIncrement64(__int64 volatile * _Addend);

long _InterlockedOr(long volatile * _Value, long _Mask);
short _InterlockedOr16(short volatile * _Value, short _Mask);



__int64 _InterlockedOr64(__int64 volatile * _Value, __int64 _Mask);



char _InterlockedOr8(char volatile * _Value, char _Mask);






long _InterlockedXor(long volatile * _Value, long _Mask);
short _InterlockedXor16(short volatile * _Value, short _Mask);



__int64 _InterlockedXor64(__int64 volatile * _Value, __int64 _Mask);



char _InterlockedXor8(char volatile * _Value, char _Mask);






void _ReadWriteBarrier(void);
__int16 __iso_volatile_load16(const volatile __int16 *);
__int32 __iso_volatile_load32(const volatile __int32 *);
__int64 __iso_volatile_load64(const volatile __int64 *);
__int8 __iso_volatile_load8(const volatile __int8 *);
void __iso_volatile_store16(volatile __int16 *, __int16);
void __iso_volatile_store32(volatile __int32 *, __int32);
void __iso_volatile_store64(volatile __int64 *, __int64);
void __iso_volatile_store8(volatile __int8 *, __int8);


unsigned char _interlockedbittestandset(long volatile *, long);



unsigned int __lzcnt(unsigned int);
unsigned short __lzcnt16(unsigned short);
unsigned __int64 __lzcnt64(unsigned __int64);
unsigned int __popcnt(unsigned int);
unsigned short __popcnt16(unsigned short);
unsigned __int64 __popcnt64(unsigned __int64);
unsigned __int64 __shiftright128(unsigned __int64 _LowPart, unsigned __int64 _HighPart, unsigned char _Shift);

unsigned int _tzcnt_u32(unsigned int);
unsigned __int64 _tzcnt_u64(unsigned __int64);
#line 268 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"
unsigned __int64 _umul128(unsigned __int64 _Multiplier, unsigned __int64 _Multiplicand, unsigned __int64 * _HighProduct);
double __ceil(double);
float __ceilf(float);
double __floor(double);
float __floorf(float);
double __round(double);
float __roundf(float);
double __trunc(double);
float __truncf(float);
double __copysign(double, double);
float __copysignf(float, float);
unsigned __signbitvalue(double);
unsigned __signbitvaluef(float);


constexpr void * __cdecl __builtin_assume_aligned(const void *, size_t, ...) noexcept;


#line 287 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"
#line 288 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"

/*******************************************************************
* Note: New intrinsics should be added here IF AND ONLY IF they're *
* being used by the C++ Standard Library.                          *
* OTHERWISE, new intrinsics should be added to intrin.h.           *
*******************************************************************/


}
#line 298 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"
#pragma warning(pop) 
#line 300 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\intrin0.h"
#line 13 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xatomic.h"
#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"
// type_traits standard header (core)

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once





#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xstddef"
// xstddef internal header (core)

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once





#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstdlib"
// cstdlib standard header (core)

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once





#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\math.h"
//
// math.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// The C Standard Library <math.h> header.  This header consists of two parts:
// <corecrt_math.h> contains the math library; <corecrt_math_defines.h> contains
// the nonstandard but useful constant definitions.  The headers are divided in
// this way for modularity (to support the C++ modules feature).
//
#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"
//
// corecrt_math.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// The majority of the C Standard Library <math.h> functionality.
//
#pragma once





#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8)) extern "C" {


    // Definition of the _exception struct, which is passed to the matherr function
    // when a floating point exception is detected:
    struct _exception
    {
        int    type;   // exception type - see below
        char*  name;   // name of function where error occurred
        double arg1;   // first argument to function
        double arg2;   // second argument (if any) to function
        double retval; // value to be returned by function
    };

    // Definition of the _complex struct to be used by those who use the complex
    // functions and want type checking.
    
        

        struct _complex
        {
            double x, y; // real and imaginary parts
        };

        


#line 46 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"
    #line 47 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"
#line 48 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"



// On x86, when not using /arch:SSE2 or greater, floating point operations
// are performed using the x87 instruction set and FLT_EVAL_METHOD is 2.
// (When /fp:fast is used, floating point operations may be consistent, so
// we use the default types.)



#line 59 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"
    typedef float  float_t;
    typedef double double_t;
#line 62 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"



// Constant definitions for the exception type passed in the _exception struct







// Definitions of _HUGE and HUGE_VAL - respectively the XENIX and ANSI names
// for a value returned in case of error by a number of the floating point
// math routines.

    
        extern double const _HUGE;
    

#line 82 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"
#line 83 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"


    
#line 87 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"


























// Values for use as arguments to the _fperrraise function





























// IEEE 754 double properties





// IEEE 754 float properties





// IEEE 754 long double properties













void __cdecl _fperrraise(  int _Except);

  __declspec(dllimport) short __cdecl _dclass(  double _X);
  __declspec(dllimport) short __cdecl _ldclass(  long double _X);
  __declspec(dllimport) short __cdecl _fdclass(  float _X);

  __declspec(dllimport) int __cdecl _dsign(  double _X);
  __declspec(dllimport) int __cdecl _ldsign(  long double _X);
  __declspec(dllimport) int __cdecl _fdsign(  float _X);

  __declspec(dllimport) int __cdecl _dpcomp(  double _X,   double _Y);
  __declspec(dllimport) int __cdecl _ldpcomp(  long double _X,   long double _Y);
  __declspec(dllimport) int __cdecl _fdpcomp(  float _X,   float _Y);

  __declspec(dllimport) short __cdecl _dtest(  double* _Px);
  __declspec(dllimport) short __cdecl _ldtest(  long double* _Px);
  __declspec(dllimport) short __cdecl _fdtest(  float* _Px);

__declspec(dllimport) short __cdecl _d_int(  double* _Px,   short _Xexp);
__declspec(dllimport) short __cdecl _ld_int(  long double* _Px,   short _Xexp);
__declspec(dllimport) short __cdecl _fd_int(  float* _Px,   short _Xexp);

__declspec(dllimport) short __cdecl _dscale(  double* _Px,   long _Lexp);
__declspec(dllimport) short __cdecl _ldscale(  long double* _Px,   long _Lexp);
__declspec(dllimport) short __cdecl _fdscale(  float* _Px,   long _Lexp);

__declspec(dllimport) short __cdecl _dunscale(  short* _Pex,   double* _Px);
__declspec(dllimport) short __cdecl _ldunscale(  short* _Pex,   long double* _Px);
__declspec(dllimport) short __cdecl _fdunscale(  short* _Pex,   float* _Px);

  __declspec(dllimport) short __cdecl _dexp(  double* _Px,   double _Y,   long _Eoff);
  __declspec(dllimport) short __cdecl _ldexp(  long double* _Px,   long double _Y,   long _Eoff);
  __declspec(dllimport) short __cdecl _fdexp(  float* _Px,   float _Y,   long _Eoff);

  __declspec(dllimport) short __cdecl _dnorm(  unsigned short* _Ps);
  __declspec(dllimport) short __cdecl _fdnorm(  unsigned short* _Ps);

  __declspec(dllimport) double __cdecl _dpoly(  double _X,   double const* _Tab,   int _N);
  __declspec(dllimport) long double __cdecl _ldpoly(  long double _X,   long double const* _Tab,   int _N);
  __declspec(dllimport) float __cdecl _fdpoly(  float _X,   float const* _Tab,   int _N);

  __declspec(dllimport) double __cdecl _dlog(  double _X,   int _Baseflag);
  __declspec(dllimport) long double __cdecl _ldlog(  long double _X,   int _Baseflag);
  __declspec(dllimport) float __cdecl _fdlog(  float _X,   int _Baseflag);

  __declspec(dllimport) double __cdecl _dsin(  double _X,   unsigned int _Qoff);
  __declspec(dllimport) long double __cdecl _ldsin(  long double _X,   unsigned int _Qoff);
  __declspec(dllimport) float __cdecl _fdsin(  float _X,   unsigned int _Qoff);

// double declarations
typedef union
{   // pun floating type as integer array
    unsigned short _Sh[4];
    double _Val;
} _double_val;

// float declarations
typedef union
{   // pun floating type as integer array
    unsigned short _Sh[2];
    float _Val;
} _float_val;

// long double declarations
typedef union
{   // pun floating type as integer array
    unsigned short _Sh[4];
    long double _Val;
} _ldouble_val;

typedef union
{   // pun float types as integer array
    unsigned short _Word[4];
    float _Float;
    double _Double;
    long double _Long_double;
} _float_const;

extern const _float_const _Denorm_C,  _Inf_C,  _Nan_C,  _Snan_C, _Hugeval_C;
extern const _float_const _FDenorm_C, _FInf_C, _FNan_C, _FSnan_C;
extern const _float_const _LDenorm_C, _LInf_C, _LNan_C, _LSnan_C;

extern const _float_const _Eps_C,  _Rteps_C;
extern const _float_const _FEps_C, _FRteps_C;
extern const _float_const _LEps_C, _LRteps_C;

extern const double      _Zero_C,  _Xbig_C;
extern const float       _FZero_C, _FXbig_C;
extern const long double _LZero_C, _LXbig_C;




























extern "C++"
{
      inline int fpclassify(  float _X) throw()
    {
        return _fdtest(&_X);
    }

      inline int fpclassify(  double _X) throw()
    {
        return _dtest(&_X);
    }

      inline int fpclassify(  long double _X) throw()
    {
        return _ldtest(&_X);
    }

      inline bool signbit(  float _X) throw()
    {
        return _fdsign(_X) != 0;
    }

      inline bool signbit(  double _X) throw()
    {
        return _dsign(_X) != 0;
    }

      inline bool signbit(  long double _X) throw()
    {
        return _ldsign(_X) != 0;
    }

      inline int _fpcomp(  float _X,   float _Y) throw()
    {
        return _fdpcomp(_X, _Y);
    }

      inline int _fpcomp(  double _X,   double _Y) throw()
    {
        return _dpcomp(_X, _Y);
    }

      inline int _fpcomp(  long double _X,   long double _Y) throw()
    {
        return _ldpcomp(_X, _Y);
    }

    template <class _Trc, class _Tre> struct _Combined_type
    {   // determine combined type
        typedef float _Type;
    };

    template <> struct _Combined_type<float, double>
    {   // determine combined type
        typedef double _Type;
    };

    template <> struct _Combined_type<float, long double>
    {   // determine combined type
        typedef long double _Type;
    };

    template <class _Ty, class _T2> struct _Real_widened
    {   // determine widened real type
        typedef long double _Type;
    };

    template <> struct _Real_widened<float, float>
    {   // determine widened real type
        typedef float _Type;
    };

    template <> struct _Real_widened<float, double>
    {   // determine widened real type
        typedef double _Type;
    };

    template <> struct _Real_widened<double, float>
    {   // determine widened real type
        typedef double _Type;
    };

    template <> struct _Real_widened<double, double>
    {   // determine widened real type
        typedef double _Type;
    };

    template <class _Ty> struct _Real_type
    {   // determine equivalent real type
        typedef double _Type;   // default is double
    };

    template <> struct _Real_type<float>
    {   // determine equivalent real type
        typedef float _Type;
    };

    template <> struct _Real_type<long double>
    {   // determine equivalent real type
        typedef long double _Type;
    };

    template <class _T1, class _T2>
      inline int _fpcomp(  _T1 _X,   _T2 _Y) throw()
    {   // compare _Left and _Right
        typedef typename _Combined_type<float,
            typename _Real_widened<
            typename _Real_type<_T1>::_Type,
            typename _Real_type<_T2>::_Type>::_Type>::_Type _Tw;
        return _fpcomp((_Tw)_X, (_Tw)_Y);
    }

    template <class _Ty>
      inline bool isfinite(  _Ty _X) throw()
    {
        return fpclassify(_X) <= 0;
    }

    template <class _Ty>
      inline bool isinf(  _Ty _X) throw()
    {
        return fpclassify(_X) == 1;
    }

    template <class _Ty>
      inline bool isnan(  _Ty _X) throw()
    {
        return fpclassify(_X) == 2;
    }

    template <class _Ty>
      inline bool isnormal(  _Ty _X) throw()
    {
        return fpclassify(_X) == (-1);
    }

    template <class _Ty1, class _Ty2>
      inline bool isgreater(  _Ty1 _X,   _Ty2 _Y) throw()
    {
        return (_fpcomp(_X, _Y) & 4) != 0;
    }

    template <class _Ty1, class _Ty2>
      inline bool isgreaterequal(  _Ty1 _X,   _Ty2 _Y) throw()
    {
        return (_fpcomp(_X, _Y) & (2 | 4)) != 0;
    }

    template <class _Ty1, class _Ty2>
      inline bool isless(  _Ty1 _X,   _Ty2 _Y) throw()
    {
        return (_fpcomp(_X, _Y) & 1) != 0;
    }

    template <class _Ty1, class _Ty2>
      inline bool islessequal(  _Ty1 _X,   _Ty2 _Y) throw()
    {
        return (_fpcomp(_X, _Y) & (1 | 2)) != 0;
    }

    template <class _Ty1, class _Ty2>
      inline bool islessgreater(  _Ty1 _X,   _Ty2 _Y) throw()
    {
        return (_fpcomp(_X, _Y) & (1 | 4)) != 0;
    }

    template <class _Ty1, class _Ty2>
      inline bool isunordered(  _Ty1 _X,   _Ty2 _Y) throw()
    {
        return _fpcomp(_X, _Y) == 0;
    }
}  // extern "C++"
#line 459 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"





      int       __cdecl abs(  int _X);
      long      __cdecl labs(  long _X);
      long long __cdecl llabs(  long long _X);

      double __cdecl acos(  double _X);
      double __cdecl asin(  double _X);
      double __cdecl atan(  double _X);
      double __cdecl atan2(  double _Y,   double _X);

      double __cdecl cos(  double _X);
      double __cdecl cosh(  double _X);
      double __cdecl exp(  double _X);
       double __cdecl fabs(  double _X);
      double __cdecl fmod(  double _X,   double _Y);
      double __cdecl log(  double _X);
      double __cdecl log10(  double _X);
      double __cdecl pow(  double _X,   double _Y);
      double __cdecl sin(  double _X);
      double __cdecl sinh(  double _X);
       double __cdecl sqrt(  double _X);
      double __cdecl tan(  double _X);
      double __cdecl tanh(  double _X);

      __declspec(dllimport) double    __cdecl acosh(  double _X);
      __declspec(dllimport) double    __cdecl asinh(  double _X);
      __declspec(dllimport) double    __cdecl atanh(  double _X);
      __declspec(dllimport)  double    __cdecl atof(  char const* _String);
      __declspec(dllimport)  double    __cdecl _atof_l(  char const* _String,   _locale_t _Locale);
      __declspec(dllimport) double    __cdecl _cabs(  struct _complex _Complex_value);
      __declspec(dllimport) double    __cdecl cbrt(  double _X);
      __declspec(dllimport) double    __cdecl ceil(  double _X);
      __declspec(dllimport) double    __cdecl _chgsign(  double _X);
      __declspec(dllimport) double    __cdecl copysign(  double _Number,   double _Sign);
      __declspec(dllimport) double    __cdecl _copysign(  double _Number,   double _Sign);
      __declspec(dllimport) double    __cdecl erf(  double _X);
      __declspec(dllimport) double    __cdecl erfc(  double _X);
      __declspec(dllimport) double    __cdecl exp2(  double _X);
      __declspec(dllimport) double    __cdecl expm1(  double _X);
      __declspec(dllimport) double    __cdecl fdim(  double _X,   double _Y);
      __declspec(dllimport) double    __cdecl floor(  double _X);
      __declspec(dllimport) double    __cdecl fma(  double _X,   double _Y,   double _Z);
      __declspec(dllimport) double    __cdecl fmax(  double _X,   double _Y);
      __declspec(dllimport) double    __cdecl fmin(  double _X,   double _Y);
      __declspec(dllimport) double    __cdecl frexp(  double _X,   int* _Y);
      __declspec(dllimport) double    __cdecl hypot(  double _X,   double _Y);
      __declspec(dllimport) double    __cdecl _hypot(  double _X,   double _Y);
      __declspec(dllimport) int       __cdecl ilogb(  double _X);
      __declspec(dllimport) double    __cdecl ldexp(  double _X,   int _Y);
      __declspec(dllimport) double    __cdecl lgamma(  double _X);
      __declspec(dllimport) long long __cdecl llrint(  double _X);
      __declspec(dllimport) long long __cdecl llround(  double _X);
      __declspec(dllimport) double    __cdecl log1p(  double _X);
      __declspec(dllimport) double    __cdecl log2(  double _X);
      __declspec(dllimport) double    __cdecl logb(  double _X);
      __declspec(dllimport) long      __cdecl lrint(  double _X);
      __declspec(dllimport) long      __cdecl lround(  double _X);

    int __cdecl _matherr(  struct _exception* _Except);

      __declspec(dllimport) double __cdecl modf(  double _X,   double* _Y);
      __declspec(dllimport) double __cdecl nan(  char const* _X);
      __declspec(dllimport) double __cdecl nearbyint(  double _X);
      __declspec(dllimport) double __cdecl nextafter(  double _X,   double _Y);
      __declspec(dllimport) double __cdecl nexttoward(  double _X,   long double _Y);
      __declspec(dllimport) double __cdecl remainder(  double _X,   double _Y);
      __declspec(dllimport) double __cdecl remquo(  double _X,   double _Y,   int* _Z);
      __declspec(dllimport) double __cdecl rint(  double _X);
      __declspec(dllimport) double __cdecl round(  double _X);
      __declspec(dllimport) double __cdecl scalbln(  double _X,   long _Y);
      __declspec(dllimport) double __cdecl scalbn(  double _X,   int _Y);
      __declspec(dllimport) double __cdecl tgamma(  double _X);
      __declspec(dllimport) double __cdecl trunc(  double _X);
      __declspec(dllimport) double __cdecl _j0(  double _X );
      __declspec(dllimport) double __cdecl _j1(  double _X );
      __declspec(dllimport) double __cdecl _jn(int _X,   double _Y);
      __declspec(dllimport) double __cdecl _y0(  double _X);
      __declspec(dllimport) double __cdecl _y1(  double _X);
      __declspec(dllimport) double __cdecl _yn(  int _X,   double _Y);

      __declspec(dllimport) float     __cdecl acoshf(  float _X);
      __declspec(dllimport) float     __cdecl asinhf(  float _X);
      __declspec(dllimport) float     __cdecl atanhf(  float _X);
      __declspec(dllimport) float     __cdecl cbrtf(  float _X);
      __declspec(dllimport) float     __cdecl _chgsignf(  float _X);
      __declspec(dllimport) float     __cdecl copysignf(  float _Number,   float _Sign);
      __declspec(dllimport) float     __cdecl _copysignf(  float _Number,   float _Sign);
      __declspec(dllimport) float     __cdecl erff(  float _X);
      __declspec(dllimport) float     __cdecl erfcf(  float _X);
      __declspec(dllimport) float     __cdecl expm1f(  float _X);
      __declspec(dllimport) float     __cdecl exp2f(  float _X);
      __declspec(dllimport) float     __cdecl fdimf(  float _X,   float _Y);
      __declspec(dllimport) float     __cdecl fmaf(  float _X,   float _Y,   float _Z);
      __declspec(dllimport) float     __cdecl fmaxf(  float _X,   float _Y);
      __declspec(dllimport) float     __cdecl fminf(  float _X,   float _Y);
      __declspec(dllimport) float     __cdecl _hypotf(  float _X,   float _Y);
      __declspec(dllimport) int       __cdecl ilogbf(  float _X);
      __declspec(dllimport) float     __cdecl lgammaf(  float _X);
      __declspec(dllimport) long long __cdecl llrintf(  float _X);
      __declspec(dllimport) long long __cdecl llroundf(  float _X);
      __declspec(dllimport) float     __cdecl log1pf(  float _X);
      __declspec(dllimport) float     __cdecl log2f(  float _X);
      __declspec(dllimport) float     __cdecl logbf(  float _X);
      __declspec(dllimport) long      __cdecl lrintf(  float _X);
      __declspec(dllimport) long      __cdecl lroundf(  float _X);
      __declspec(dllimport) float     __cdecl nanf(  char const* _X);
      __declspec(dllimport) float     __cdecl nearbyintf(  float _X);
      __declspec(dllimport) float     __cdecl nextafterf(  float _X,   float _Y);
      __declspec(dllimport) float     __cdecl nexttowardf(  float _X,   long double _Y);
      __declspec(dllimport) float     __cdecl remainderf(  float _X,   float _Y);
      __declspec(dllimport) float     __cdecl remquof(  float _X,   float _Y,   int* _Z);
      __declspec(dllimport) float     __cdecl rintf(  float _X);
      __declspec(dllimport) float     __cdecl roundf(  float _X);
      __declspec(dllimport) float     __cdecl scalblnf(  float _X,   long _Y);
      __declspec(dllimport) float     __cdecl scalbnf(  float _X,   int _Y);
      __declspec(dllimport) float     __cdecl tgammaf(  float _X);
      __declspec(dllimport) float     __cdecl truncf(  float _X);

    



#line 586 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"

    

          __declspec(dllimport) float __cdecl _logbf(  float _X);
          __declspec(dllimport) float __cdecl _nextafterf(  float _X,   float _Y);
          __declspec(dllimport) int   __cdecl _finitef(  float _X);
          __declspec(dllimport) int   __cdecl _isnanf(  float _X);
          __declspec(dllimport) int   __cdecl _fpclassf(  float _X);

          __declspec(dllimport) int   __cdecl _set_FMA3_enable(  int _Flag);
          __declspec(dllimport) int   __cdecl _get_FMA3_enable(void);

    




#line 604 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"



    

          __declspec(dllimport) float __cdecl acosf(  float _X);
          __declspec(dllimport) float __cdecl asinf(  float _X);
          __declspec(dllimport) float __cdecl atan2f(  float _Y,   float _X);
          __declspec(dllimport) float __cdecl atanf(  float _X);
          __declspec(dllimport) float __cdecl ceilf(  float _X);
          __declspec(dllimport) float __cdecl cosf(  float _X);
          __declspec(dllimport) float __cdecl coshf(  float _X);
          __declspec(dllimport) float __cdecl expf(  float _X);

    









































#line 661 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"

    



#line 667 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"

          __inline float __cdecl fabsf(  float _X)
        {
            return (float)fabs(_X);
        }

    #line 674 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"

    

          __declspec(dllimport) float __cdecl floorf(  float _X);
          __declspec(dllimport) float __cdecl fmodf(  float _X,   float _Y);

    











#line 693 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"

      __inline float __cdecl frexpf(  float _X,   int *_Y)
    {
        return (float)frexp(_X, _Y);
    }

      __inline float __cdecl hypotf(  float _X,   float _Y)
    {
        return _hypotf(_X, _Y);
    }

      __inline float __cdecl ldexpf(  float _X,   int _Y)
    {
        return (float)ldexp(_X, _Y);
    }

    

          __declspec(dllimport) float  __cdecl log10f(  float _X);
          __declspec(dllimport) float  __cdecl logf(  float _X);
          __declspec(dllimport) float  __cdecl modff(  float _X,   float *_Y);
          __declspec(dllimport) float  __cdecl powf(  float _X,   float _Y);
          __declspec(dllimport) float  __cdecl sinf(  float _X);
          __declspec(dllimport) float  __cdecl sinhf(  float _X);
          __declspec(dllimport) float  __cdecl sqrtf(  float _X);
          __declspec(dllimport) float  __cdecl tanf(  float _X);
          __declspec(dllimport) float  __cdecl tanhf(  float _X);

    

















































#line 772 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"

      __declspec(dllimport) long double __cdecl acoshl(  long double _X);

      __inline long double __cdecl acosl(  long double _X)
    {
        return acos((double)_X);
    }

      __declspec(dllimport) long double __cdecl asinhl(  long double _X);

      __inline long double __cdecl asinl(  long double _X)
    {
        return asin((double)_X);
    }

      __inline long double __cdecl atan2l(  long double _Y,   long double _X)
    {
        return atan2((double)_Y, (double)_X);
    }

      __declspec(dllimport) long double __cdecl atanhl(  long double _X);

      __inline long double __cdecl atanl(  long double _X)
    {
        return atan((double)_X);
    }

      __declspec(dllimport) long double __cdecl cbrtl(  long double _X);

      __inline long double __cdecl ceill(  long double _X)
    {
        return ceil((double)_X);
    }

      __inline long double __cdecl _chgsignl(  long double _X)
    {
        return _chgsign((double)_X);
    }

      __declspec(dllimport) long double __cdecl copysignl(  long double _Number,   long double _Sign);

      __inline long double __cdecl _copysignl(  long double _Number,   long double _Sign)
    {
        return _copysign((double)_Number, (double)_Sign);
    }

      __inline long double __cdecl coshl(  long double _X)
    {
        return cosh((double)_X);
    }

      __inline long double __cdecl cosl(  long double _X)
    {
        return cos((double)_X);
    }

      __declspec(dllimport) long double __cdecl erfl(  long double _X);
      __declspec(dllimport) long double __cdecl erfcl(  long double _X);

      __inline long double __cdecl expl(  long double _X)
    {
        return exp((double)_X);
    }

      __declspec(dllimport) long double __cdecl exp2l(  long double _X);
      __declspec(dllimport) long double __cdecl expm1l(  long double _X);

      __inline long double __cdecl fabsl(  long double _X)
    {
        return fabs((double)_X);
    }

      __declspec(dllimport) long double __cdecl fdiml(  long double _X,   long double _Y);

      __inline long double __cdecl floorl(  long double _X)
    {
        return floor((double)_X);
    }

      __declspec(dllimport) long double __cdecl fmal(  long double _X,   long double _Y,   long double _Z);
      __declspec(dllimport) long double __cdecl fmaxl(  long double _X,   long double _Y);
      __declspec(dllimport) long double __cdecl fminl(  long double _X,   long double _Y);

      __inline long double __cdecl fmodl(  long double _X,   long double _Y)
    {
        return fmod((double)_X, (double)_Y);
    }

      __inline long double __cdecl frexpl(  long double _X,   int *_Y)
    {
        return frexp((double)_X, _Y);
    }

      __declspec(dllimport) int __cdecl ilogbl(  long double _X);

      __inline long double __cdecl _hypotl(  long double _X,   long double _Y)
    {
        return _hypot((double)_X, (double)_Y);
    }

      __inline long double __cdecl hypotl(  long double _X,   long double _Y)
    {
        return _hypot((double)_X, (double)_Y);
    }

      __inline long double __cdecl ldexpl(  long double _X,   int _Y)
    {
        return ldexp((double)_X, _Y);
    }

      __declspec(dllimport) long double __cdecl lgammal(  long double _X);
      __declspec(dllimport) long long __cdecl llrintl(  long double _X);
      __declspec(dllimport) long long __cdecl llroundl(  long double _X);

      __inline long double __cdecl logl(  long double _X)
    {
        return log((double)_X);
    }

      __inline long double __cdecl log10l(  long double _X)
    {
        return log10((double)_X);
    }

      __declspec(dllimport) long double __cdecl log1pl(  long double _X);
      __declspec(dllimport) long double __cdecl log2l(  long double _X);
      __declspec(dllimport) long double __cdecl logbl(  long double _X);
      __declspec(dllimport) long __cdecl lrintl(  long double _X);
      __declspec(dllimport) long __cdecl lroundl(  long double _X);

      __inline long double __cdecl modfl(  long double _X,   long double* _Y)
    {
        double _F, _I;
        _F = modf((double)_X, &_I);
        *_Y = _I;
        return _F;
    }

      __declspec(dllimport) long double __cdecl nanl(  char const* _X);
      __declspec(dllimport) long double __cdecl nearbyintl(  long double _X);
      __declspec(dllimport) long double __cdecl nextafterl(  long double _X,   long double _Y);
      __declspec(dllimport) long double __cdecl nexttowardl(  long double _X,   long double _Y);

      __inline long double __cdecl powl(  long double _X,   long double _Y)
    {
        return pow((double)_X, (double)_Y);
    }

      __declspec(dllimport) long double __cdecl remainderl(  long double _X,   long double _Y);
      __declspec(dllimport) long double __cdecl remquol(  long double _X,   long double _Y,   int* _Z);
      __declspec(dllimport) long double __cdecl rintl(  long double _X);
      __declspec(dllimport) long double __cdecl roundl(  long double _X);
      __declspec(dllimport) long double __cdecl scalblnl(  long double _X,   long _Y);
      __declspec(dllimport) long double __cdecl scalbnl(  long double _X,   int _Y);

      __inline long double __cdecl sinhl(  long double _X)
    {
        return sinh((double)_X);
    }

      __inline long double __cdecl sinl(  long double _X)
    {
        return sin((double)_X);
    }

      __inline long double __cdecl sqrtl(  long double _X)
    {
        return sqrt((double)_X);
    }

      __inline long double __cdecl tanhl(  long double _X)
    {
        return tanh((double)_X);
    }

      __inline long double __cdecl tanl(  long double _X)
    {
        return tan((double)_X);
    }

      __declspec(dllimport) long double __cdecl tgammal(  long double _X);
      __declspec(dllimport) long double __cdecl truncl(  long double _X);

    



#line 960 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"



    
    
    
    
    
    

    

    
        
            extern double HUGE;
        

#line 978 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"

        __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_j0" ". See online help for details."))   __declspec(dllimport) double __cdecl j0(  double _X);
        __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_j1" ". See online help for details."))   __declspec(dllimport) double __cdecl j1(  double _X);
        __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_jn" ". See online help for details."))   __declspec(dllimport) double __cdecl jn(  int _X,   double _Y);
        __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_y0" ". See online help for details."))   __declspec(dllimport) double __cdecl y0(  double _X);
        __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_y1" ". See online help for details."))   __declspec(dllimport) double __cdecl y1(  double _X);
        __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_yn" ". See online help for details."))   __declspec(dllimport) double __cdecl yn(  int _X,   double _Y);
    #line 986 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"

#line 988 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"

} __pragma(pack(pop))

#pragma warning(pop) 
#line 993 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_math.h"
#line 12 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\math.h"




#line 13 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstdlib"
#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"
//
// stdlib.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// The C Standard Library <stdlib.h> header.
//
#pragma once




#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_malloc.h"
//
// corecrt_malloc.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// The memory allocation library.  These pieces of the allocation library are
// shared by both <stdlib.h> and <malloc.h>.
//
#pragma once



#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8)) extern "C" {





































#line 56 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_malloc.h"

     
__declspec(dllimport) __declspec(allocator) __declspec(restrict)
void* __cdecl _calloc_base(
      size_t _Count,
      size_t _Size
    );

     
__declspec(dllimport)  __declspec(allocator) __declspec(restrict) 
void* __cdecl calloc(
      __declspec(guard(overflow)) size_t _Count,
      __declspec(guard(overflow)) size_t _Size
    );

 
__declspec(dllimport) int __cdecl _callnewh(
      size_t _Size
    );

     
__declspec(dllimport) __declspec(allocator) 
void* __cdecl _expand(
                void*  _Block,
      __declspec(guard(overflow)) size_t _Size
    );

__declspec(dllimport)
void __cdecl _free_base(
        void* _Block
    );

__declspec(dllimport) 
void __cdecl free(
        void* _Block
    );

     
__declspec(dllimport) __declspec(allocator) __declspec(restrict)
void* __cdecl _malloc_base(
      size_t _Size
    );

     
__declspec(dllimport) __declspec(allocator)  __declspec(restrict) 
void* __cdecl malloc(
      __declspec(guard(overflow)) size_t _Size
    );

 
__declspec(dllimport)
size_t __cdecl _msize_base(
      void* _Block
    );

 
__declspec(dllimport) 
size_t __cdecl _msize(
      void* _Block
    );

       
__declspec(dllimport) __declspec(allocator) __declspec(restrict)
void* __cdecl _realloc_base(
         void*  _Block,
                                 size_t _Size
    );

       
__declspec(dllimport) __declspec(allocator) __declspec(restrict) 
void* __cdecl realloc(
        void*  _Block,
      __declspec(guard(overflow))        size_t _Size
    );

       
__declspec(dllimport) __declspec(allocator) __declspec(restrict)
void* __cdecl _recalloc_base(
        void*  _Block,
                                size_t _Count,
                                size_t _Size
    );

       
__declspec(dllimport) __declspec(allocator) __declspec(restrict)
void* __cdecl _recalloc(
        void*  _Block,
      __declspec(guard(overflow))        size_t _Count,
      __declspec(guard(overflow))        size_t _Size
    );

__declspec(dllimport)
void __cdecl _aligned_free(
        void* _Block
    );

     
__declspec(dllimport) __declspec(allocator) __declspec(restrict)
void* __cdecl _aligned_malloc(
      __declspec(guard(overflow)) size_t _Size,
                         size_t _Alignment
    );

     
__declspec(dllimport) __declspec(allocator) __declspec(restrict)
void* __cdecl _aligned_offset_malloc(
      __declspec(guard(overflow)) size_t _Size,
                         size_t _Alignment,
                         size_t _Offset
    );

 
__declspec(dllimport)
size_t __cdecl _aligned_msize(
      void*  _Block,
               size_t _Alignment,
               size_t _Offset
    );

       
__declspec(dllimport) __declspec(allocator) __declspec(restrict)
void* __cdecl _aligned_offset_realloc(
        void*  _Block,
      __declspec(guard(overflow))        size_t _Size,
                                size_t _Alignment,
                                size_t _Offset
    );

       
__declspec(dllimport) __declspec(allocator) __declspec(restrict)
void* __cdecl _aligned_offset_recalloc(
        void*  _Block,
      __declspec(guard(overflow))        size_t _Count,
      __declspec(guard(overflow))        size_t _Size,
                                size_t _Alignment,
                                size_t _Offset
    );

       
__declspec(dllimport) __declspec(allocator) __declspec(restrict)
void* __cdecl _aligned_realloc(
        void*  _Block,
      __declspec(guard(overflow))        size_t _Size,
                                size_t _Alignment
    );

       
__declspec(dllimport) __declspec(allocator) __declspec(restrict)
void* __cdecl _aligned_recalloc(
        void*  _Block,
      __declspec(guard(overflow))        size_t _Count,
      __declspec(guard(overflow))        size_t _Size,
                                size_t _Alignment
    );


















#line 229 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_malloc.h"



} __pragma(pack(pop))

#pragma warning(pop) 
#line 14 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"
#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_search.h"
//
// corecrt_search.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// Declarations of functions for sorting and searching.  These declarations are
// split out so that they may be included by both <stdlib.h> and <search.h>.
// <stdlib.h> does not include <search.h> to avoid introducing conflicts with
// other user headers named <search.h>.
//
#pragma once




#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8)) extern "C" {


    typedef int (__cdecl* _CoreCrtSecureSearchSortCompareFunction)(void*, void const*, void const*);
    typedef int (__cdecl* _CoreCrtNonSecureSearchSortCompareFunction)(void const*, void const*);




     
    __declspec(dllimport) void* __cdecl bsearch_s(
                                                        void const* _Key,
          void const* _Base,
                                                        rsize_t     _NumOfElements,
                                                        rsize_t     _SizeOfElements,
                            _CoreCrtSecureSearchSortCompareFunction _CompareFunction,
                                                    void*       _Context
        );

    __declspec(dllimport) void __cdecl qsort_s(
          void*   _Base,
                                                             rsize_t _NumOfElements,
                                                             rsize_t _SizeOfElements,
                             _CoreCrtSecureSearchSortCompareFunction _CompareFunction,
                                                         void*   _Context
        );

#line 48 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_search.h"



 
__declspec(dllimport) void* __cdecl bsearch(
                                                    void const* _Key,
      void const* _Base,
                                                    size_t      _NumOfElements,
                                                    size_t      _SizeOfElements,
                     _CoreCrtNonSecureSearchSortCompareFunction _CompareFunction
    );

__declspec(dllimport) void __cdecl qsort(
      void*  _Base,
                                                         size_t _NumOfElements,
                                                         size_t _SizeOfElements,
                     _CoreCrtNonSecureSearchSortCompareFunction _CompareFunction
    );

 
__declspec(dllimport) void* __cdecl _lfind_s(
                                                       void const*   _Key,
      void const*   _Base,
                                                    unsigned int* _NumOfElements,
                                                       size_t        _SizeOfElements,
                             _CoreCrtSecureSearchSortCompareFunction _CompareFunction,
                                                       void*         _Context
    );

 
__declspec(dllimport) void* __cdecl _lfind(
                                                       void const*   _Key,
      void const*   _Base,
                                                    unsigned int* _NumOfElements,
                                                       unsigned int  _SizeOfElements,
                          _CoreCrtNonSecureSearchSortCompareFunction _CompareFunction
    );

 
__declspec(dllimport) void* __cdecl _lsearch_s(
                                                             void const*   _Key,
      void*         _Base,
                                                          unsigned int* _NumOfElements,
                                                             size_t        _SizeOfElements,
                                   _CoreCrtSecureSearchSortCompareFunction _CompareFunction,
                                                             void*         _Context
    );

 
__declspec(dllimport) void* __cdecl _lsearch(
                                                             void const*   _Key,
      void*         _Base,
                                                          unsigned int* _NumOfElements,
                                                             unsigned int  _SizeOfElements,
                                _CoreCrtNonSecureSearchSortCompareFunction _CompareFunction
    );



// Managed search routines
















































































#line 189 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_search.h"





      __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_lfind" ". See online help for details."))
    __declspec(dllimport) void* __cdecl lfind(
                                                           void const*   _Key,
          void const*   _Base,
                                                        unsigned int* _NumOfElements,
                                                           unsigned int  _SizeOfElements,
                              _CoreCrtNonSecureSearchSortCompareFunction _CompareFunction
        );

      __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_lsearch" ". See online help for details."))
    __declspec(dllimport) void* __cdecl lsearch(
                                                                void const*   _Key,
          void*         _Base,
                                                             unsigned int* _NumOfElements,
                                                                unsigned int  _SizeOfElements,
                                   _CoreCrtNonSecureSearchSortCompareFunction _CompareFunction
        );

#line 213 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_search.h"



} __pragma(pack(pop))

#pragma warning(pop) 
#line 15 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"
#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstdlib.h"
//
// corecrt_wstdlib.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// This file declares the wide character (wchar_t) C Standard Library functions
// that are declared by both <stdlib.h> and <wchar.h>.
//
#pragma once



#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8)) extern "C" {



// Maximum number of elements, including null terminator (and negative sign
// where appropriate), needed for integer-to-string conversions for several
// bases and integer types.




























     
    
    __declspec(dllimport) errno_t __cdecl _itow_s(
                                  int      _Value,
          wchar_t* _Buffer,
                                  size_t   _BufferCount,
                                  int      _Radix
        );

    extern "C++" { template <size_t _Size> inline errno_t __cdecl _itow_s(  int _Value, wchar_t (&_Buffer)[_Size],   int _Radix) throw() { return _itow_s(_Value, _Buffer, _Size, _Radix); } }
#line 67 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstdlib.h"

    __declspec(deprecated("This function or variable may be unsafe. Consider using " "_itow_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) wchar_t* __cdecl _itow( int _Value,   wchar_t *_Buffer,  int _Radix);
#line 74 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstdlib.h"

     
    
    __declspec(dllimport) errno_t __cdecl _ltow_s(
                                  long     _Value,
          wchar_t* _Buffer,
                                  size_t   _BufferCount,
                                  int      _Radix
        );

    extern "C++" { template <size_t _Size> inline errno_t __cdecl _ltow_s(  long _Value, wchar_t (&_Buffer)[_Size],   int _Radix) throw() { return _ltow_s(_Value, _Buffer, _Size, _Radix); } }
#line 90 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstdlib.h"

    __declspec(deprecated("This function or variable may be unsafe. Consider using " "_ltow_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) wchar_t* __cdecl _ltow( long _Value,   wchar_t *_Buffer,  int _Radix);
#line 97 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstdlib.h"

    
    __declspec(dllimport) errno_t __cdecl _ultow_s(
                                  unsigned long _Value,
          wchar_t*      _Buffer,
                                  size_t        _BufferCount,
                                  int           _Radix
        );

    extern "C++" { template <size_t _Size> inline errno_t __cdecl _ultow_s(  unsigned long _Value, wchar_t (&_Buffer)[_Size],   int _Radix) throw() { return _ultow_s(_Value, _Buffer, _Size, _Radix); } }
#line 112 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstdlib.h"

    __declspec(deprecated("This function or variable may be unsafe. Consider using " "_ultow_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) wchar_t* __cdecl _ultow( unsigned long _Value,   wchar_t *_Buffer,  int _Radix);
#line 119 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstdlib.h"

     
    __declspec(dllimport) double __cdecl wcstod(
                            wchar_t const* _String,
            wchar_t**      _EndPtr
        );

     
    __declspec(dllimport) double __cdecl _wcstod_l(
                            wchar_t const* _String,
            wchar_t**      _EndPtr,
                          _locale_t      _Locale
        );

     
    __declspec(dllimport) long __cdecl wcstol(
                            wchar_t const* _String,
            wchar_t**      _EndPtr,
                              int            _Radix
        );

     
    __declspec(dllimport) long __cdecl _wcstol_l(
                            wchar_t const* _String,
            wchar_t**      _EndPtr,
                              int            _Radix,
                          _locale_t      _Locale
        );

     
    __declspec(dllimport) long long __cdecl wcstoll(
                            wchar_t const* _String,
            wchar_t**      _EndPtr,
                              int            _Radix
        );

     
    __declspec(dllimport) long long __cdecl _wcstoll_l(
                            wchar_t const* _String,
            wchar_t**      _EndPtr,
                              int            _Radix,
                          _locale_t      _Locale
        );

     
    __declspec(dllimport) unsigned long __cdecl wcstoul(
                            wchar_t const* _String,
            wchar_t**      _EndPtr,
                              int            _Radix
        );

     
    __declspec(dllimport) unsigned long __cdecl _wcstoul_l(
                            wchar_t const* _String,
            wchar_t**      _EndPtr,
                              int            _Radix,
                          _locale_t      _Locale
        );

     
    __declspec(dllimport) unsigned long long __cdecl wcstoull(
                            wchar_t const* _String,
            wchar_t**      _EndPtr,
                              int            _Radix
        );

     
    __declspec(dllimport) unsigned long long __cdecl _wcstoull_l(
                            wchar_t const* _String,
            wchar_t**      _EndPtr,
                              int            _Radix,
                          _locale_t      _Locale
        );

     
    __declspec(dllimport) long double __cdecl wcstold(
                            wchar_t const* _String,
            wchar_t**      _EndPtr
        );

     
    __declspec(dllimport) long double __cdecl _wcstold_l(
                            wchar_t const* _String,
            wchar_t**      _EndPtr,
                          _locale_t      _Locale
        );

     
    __declspec(dllimport) float __cdecl wcstof(
                            wchar_t const* _String,
            wchar_t**      _EndPtr
        );

     
    __declspec(dllimport) float __cdecl _wcstof_l(
                            wchar_t const* _String,
            wchar_t**      _EndPtr,
                          _locale_t      _Locale
        );

     
    __declspec(dllimport) double __cdecl _wtof(
          wchar_t const* _String
        );

     
    __declspec(dllimport) double __cdecl _wtof_l(
            wchar_t const* _String,
          _locale_t      _Locale
        );

     
    __declspec(dllimport) int __cdecl _wtoi(
          wchar_t const* _String
        );

     
    __declspec(dllimport) int __cdecl _wtoi_l(
            wchar_t const* _String,
          _locale_t      _Locale
        );

     
    __declspec(dllimport) long __cdecl _wtol(
          wchar_t const* _String
        );

     
    __declspec(dllimport) long __cdecl _wtol_l(
            wchar_t const* _String,
          _locale_t      _Locale
        );

     
    __declspec(dllimport) long long __cdecl _wtoll(
          wchar_t const* _String
        );

     
    __declspec(dllimport) long long __cdecl _wtoll_l(
            wchar_t const* _String,
          _locale_t      _Locale
        );

    
    __declspec(dllimport) errno_t __cdecl _i64tow_s(
                                  __int64  _Value,
          wchar_t* _Buffer,
                                  size_t   _BufferCount,
                                  int      _Radix
        );

    __declspec(deprecated("This function or variable may be unsafe. Consider using " "_i64tow_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
    __declspec(dllimport) wchar_t* __cdecl _i64tow(
                            __int64  _Value,
            wchar_t* _Buffer,
                            int      _Radix
        );

    
    __declspec(dllimport) errno_t __cdecl _ui64tow_s(
                                  unsigned __int64 _Value,
          wchar_t*         _Buffer,
                                  size_t           _BufferCount,
                                  int              _Radix
        );

    __declspec(deprecated("This function or variable may be unsafe. Consider using " "_ui64tow_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
    __declspec(dllimport) wchar_t* __cdecl _ui64tow(
                            unsigned __int64 _Value,
            wchar_t*         _Buffer,
                            int              _Radix
        );

     
    __declspec(dllimport) __int64 __cdecl _wtoi64(
          wchar_t const* _String
        );

     
    __declspec(dllimport) __int64 __cdecl _wtoi64_l(
            wchar_t const* _String,
          _locale_t      _Locale
        );

     
    __declspec(dllimport) __int64 __cdecl _wcstoi64(
                            wchar_t const* _String,
            wchar_t**      _EndPtr,
                              int            _Radix
        );

     
    __declspec(dllimport) __int64 __cdecl _wcstoi64_l(
                            wchar_t const* _String,
            wchar_t**      _EndPtr,
                              int            _Radix,
                          _locale_t      _Locale
        );

     
    __declspec(dllimport) unsigned __int64 __cdecl _wcstoui64(
                            wchar_t const* _String,
            wchar_t**      _EndPtr,
                              int            _Radix
        );

     
    __declspec(dllimport) unsigned __int64 __cdecl _wcstoui64_l(
                            wchar_t const* _String,
            wchar_t**      _EndPtr,
                              int            _Radix,
                          _locale_t      _Locale
        );

    
    

     
     
    __declspec(dllimport) __declspec(allocator) wchar_t* __cdecl _wfullpath(
          wchar_t*       _Buffer,
                                    wchar_t const* _Path,
                                      size_t         _BufferCount
        );

    

    
    __declspec(dllimport) errno_t __cdecl _wmakepath_s(
          wchar_t*       _Buffer,
                                  size_t         _BufferCount,
                            wchar_t const* _Drive,
                            wchar_t const* _Dir,
                            wchar_t const* _Filename,
                            wchar_t const* _Ext
        );

    extern "C++" { template <size_t _Size> inline errno_t __cdecl _wmakepath_s(wchar_t (&_Buffer)[_Size],   wchar_t const* _Drive,   wchar_t const* _Dir,   wchar_t const* _Filename,   wchar_t const* _Ext) throw() { return _wmakepath_s(_Buffer, _Size, _Drive, _Dir, _Filename, _Ext); } }
#line 365 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstdlib.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_wmakepath_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) void __cdecl _wmakepath(  wchar_t *_Buffer,  wchar_t const* _Drive,  wchar_t const* _Dir,  wchar_t const* _Filename,  wchar_t const* _Ext);
#line 374 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstdlib.h"

    __declspec(dllimport) void __cdecl _wperror(
          wchar_t const* _ErrorMessage
        );

    __declspec(deprecated("This function or variable may be unsafe. Consider using " "_wsplitpath_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
    __declspec(dllimport) void __cdecl _wsplitpath(
                            wchar_t const* _FullPath,
            wchar_t*       _Drive,
            wchar_t*       _Dir,
            wchar_t*       _Filename,
            wchar_t*       _Ext
        );

    __declspec(dllimport) errno_t __cdecl _wsplitpath_s(
                                      wchar_t const* _FullPath,
             wchar_t*       _Drive,
                                        size_t         _DriveCount,
               wchar_t*       _Dir,
                                        size_t         _DirCount,
          wchar_t*       _Filename,
                                        size_t         _FilenameCount,
               wchar_t*       _Ext,
                                        size_t         _ExtCount
        );

    extern "C++" { template <size_t _DriveSize, size_t _DirSize, size_t _NameSize, size_t _ExtSize> inline errno_t __cdecl _wsplitpath_s(   wchar_t const* _Path,   wchar_t (&_Drive)[_DriveSize],   wchar_t (&_Dir)[_DirSize],   wchar_t (&_Name)[_NameSize],   wchar_t (&_Ext)[_ExtSize] ) throw() { return _wsplitpath_s(_Path, _Drive, _DriveSize, _Dir, _DirSize, _Name, _NameSize, _Ext, _ExtSize); } }
#line 404 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstdlib.h"

        
        

        
        __declspec(dllimport) errno_t __cdecl _wdupenv_s(
                wchar_t**      _Buffer,
                                                                                size_t*        _BufferCount,
                                                                                   wchar_t const* _VarName
            );

        

          __declspec(deprecated("This function or variable may be unsafe. Consider using " "_wdupenv_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
        __declspec(dllimport) wchar_t* __cdecl _wgetenv(
              wchar_t const* _VarName
            );

         
        
        __declspec(dllimport) errno_t __cdecl _wgetenv_s(
                                         size_t*        _RequiredCount,
              wchar_t*       _Buffer,
                                          size_t         _BufferCount,
                                        wchar_t const* _VarName
            );

        extern "C++" { template <size_t _Size> inline   errno_t __cdecl _wgetenv_s(  size_t* _RequiredCount, wchar_t (&_Buffer)[_Size],   wchar_t const* _VarName) throw() { return _wgetenv_s(_RequiredCount, _Buffer, _Size, _VarName); } }
#line 438 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstdlib.h"

         
        __declspec(dllimport) int __cdecl _wputenv(
              wchar_t const* _EnvString
            );

        
        __declspec(dllimport) errno_t __cdecl _wputenv_s(
              wchar_t const* _Name,
              wchar_t const* _Value
            );

        __declspec(dllimport) errno_t __cdecl _wsearchenv_s(
                                    wchar_t const* _Filename,
                                    wchar_t const* _VarName,
              wchar_t*       _Buffer,
                                      size_t         _BufferCount
            );

        extern "C++" { template <size_t _Size> inline errno_t __cdecl _wsearchenv_s(  wchar_t const* _Filename,   wchar_t const* _VarName, wchar_t (&_ResultPath)[_Size]) throw() { return _wsearchenv_s(_Filename, _VarName, _ResultPath, _Size); } }
#line 463 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstdlib.h"

        __declspec(deprecated("This function or variable may be unsafe. Consider using " "_wsearchenv_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) void __cdecl _wsearchenv( wchar_t const* _Filename,  wchar_t const* _VarName,   wchar_t *_ResultPath);
#line 470 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstdlib.h"

        __declspec(dllimport) int __cdecl _wsystem(
              wchar_t const* _Command
            );

#line 476 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wstdlib.h"



} __pragma(pack(pop))

#pragma warning(pop) 
#line 16 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"
#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\limits.h"
//
// limits.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// The C Standard Library <limits.h> header.
//
#pragma once




#pragma warning(push)
#pragma warning(disable:   4514 4820 )

__pragma(pack(push, 8)) extern "C" {







    
    



#line 30 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\limits.h"









































    
        
    #line 74 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\limits.h"
#line 75 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\limits.h"

} __pragma(pack(pop))

#pragma warning(pop) 
#line 17 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8)) extern "C" {




    
#line 29 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"



// Minimum and maximum macros





__declspec(dllimport) void __cdecl _swab(
        char* _Buf1,
        char* _Buf2,
                                                                  int   _SizeInBytes
    );



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Exit and Abort
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
// Argument values for exit()




    __declspec(dllimport) __declspec(noreturn) void __cdecl exit(  int _Code);
    __declspec(dllimport) __declspec(noreturn) void __cdecl _exit(  int _Code);
    __declspec(dllimport) __declspec(noreturn) void __cdecl _Exit(  int _Code);
    __declspec(dllimport) __declspec(noreturn) void __cdecl quick_exit(  int _Code);
    __declspec(dllimport) __declspec(noreturn) void __cdecl abort(void);
#line 62 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

// Argument values for _set_abort_behavior().



__declspec(dllimport) unsigned int __cdecl _set_abort_behavior(
      unsigned int _Flags,
      unsigned int _Mask
    );




    

    typedef int (__cdecl* _onexit_t)(void);
    


#line 82 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"


    // Non-ANSI name for compatibility
    
#line 87 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

























































    int       __cdecl atexit(void (__cdecl*)(void));
    _onexit_t __cdecl _onexit(  _onexit_t _Func);
#line 147 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

int __cdecl at_quick_exit(void (__cdecl*)(void));



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Global State (errno, global handlers, etc.)
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    // a purecall handler procedure. Never returns normally
    typedef void (__cdecl* _purecall_handler)(void);

    // Invalid parameter handler function pointer type
    typedef void (__cdecl* _invalid_parameter_handler)(
        wchar_t const*,
        wchar_t const*,
        wchar_t const*,
        unsigned int,
        uintptr_t
        );

    // Establishes a purecall handler
     _purecall_handler __cdecl _set_purecall_handler(
          _purecall_handler _Handler
        );

     _purecall_handler __cdecl _get_purecall_handler(void);

    // Establishes an invalid parameter handler
    __declspec(dllimport) _invalid_parameter_handler __cdecl _set_invalid_parameter_handler(
          _invalid_parameter_handler _Handler
        );

    __declspec(dllimport) _invalid_parameter_handler __cdecl _get_invalid_parameter_handler(void);

    __declspec(dllimport) _invalid_parameter_handler __cdecl _set_thread_local_invalid_parameter_handler(
          _invalid_parameter_handler _Handler
        );

    __declspec(dllimport) _invalid_parameter_handler __cdecl _get_thread_local_invalid_parameter_handler(void);
#line 190 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"












#line 203 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"



// Argument values for _set_error_mode().





 __declspec(dllimport) int __cdecl _set_error_mode(  int _Mode);




    __declspec(dllimport) int* __cdecl _errno(void);
    

    __declspec(dllimport) errno_t __cdecl _set_errno(  int _Value);
    __declspec(dllimport) errno_t __cdecl _get_errno(  int* _Value);

    __declspec(dllimport) unsigned long* __cdecl __doserrno(void);
    

    __declspec(dllimport) errno_t __cdecl _set_doserrno(  unsigned long _Value);
    __declspec(dllimport) errno_t __cdecl _get_doserrno(  unsigned long * _Value);

    // This is non-const for backwards compatibility; do not modify it.
    __declspec(dllimport) __declspec(deprecated("This function or variable may be unsafe. Consider using " "strerror" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) char** __cdecl __sys_errlist(void);
    

    __declspec(dllimport) __declspec(deprecated("This function or variable may be unsafe. Consider using " "strerror" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) int * __cdecl __sys_nerr(void);
    

    __declspec(dllimport) void __cdecl perror(  char const* _ErrMsg);
#line 238 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"



// These point to the executable module name.
__declspec(deprecated("This function or variable may be unsafe. Consider using " "_get_pgmptr" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) char**    __cdecl __p__pgmptr (void);
__declspec(deprecated("This function or variable may be unsafe. Consider using " "_get_wpgmptr" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) wchar_t** __cdecl __p__wpgmptr(void);
__declspec(deprecated("This function or variable may be unsafe. Consider using " "_get_fmode" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) int*      __cdecl __p__fmode  (void);








    
    
    
#line 257 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

 
__declspec(dllimport) errno_t __cdecl _get_pgmptr (  char**    _Value);

 
__declspec(dllimport) errno_t __cdecl _get_wpgmptr(  wchar_t** _Value);

__declspec(dllimport) errno_t __cdecl _set_fmode  (               int       _Mode );

__declspec(dllimport) errno_t __cdecl _get_fmode  (              int*      _PMode);



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Math
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
typedef struct _div_t
{
    int quot;
    int rem;
} div_t;

typedef struct _ldiv_t
{
    long quot;
    long rem;
} ldiv_t;

typedef struct _lldiv_t
{
    long long quot;
    long long rem;
} lldiv_t;

  int       __cdecl abs   (  int       _Number);
  long      __cdecl labs  (  long      _Number);
  long long __cdecl llabs (  long long _Number);
  __int64   __cdecl _abs64(  __int64   _Number);

  unsigned short   __cdecl _byteswap_ushort(  unsigned short   _Number);
  unsigned long    __cdecl _byteswap_ulong (  unsigned long    _Number);
  unsigned __int64 __cdecl _byteswap_uint64(  unsigned __int64 _Number);

  __declspec(dllimport) div_t   __cdecl div  (  int       _Numerator,   int       _Denominator);
  __declspec(dllimport) ldiv_t  __cdecl ldiv (  long      _Numerator,   long      _Denominator);
  __declspec(dllimport) lldiv_t __cdecl lldiv(  long long _Numerator,   long long _Denominator);

// These functions have declspecs in their declarations in the Windows headers,
// which cause PREfast to fire 6540.
#pragma warning(push)
#pragma warning(disable: 6540)

unsigned int __cdecl _rotl(
      unsigned int _Value,
      int          _Shift
    );

 
unsigned long __cdecl _lrotl(
      unsigned long _Value,
      int           _Shift
    );

unsigned __int64 __cdecl _rotl64(
      unsigned __int64 _Value,
      int              _Shift
    );

unsigned int __cdecl _rotr(
      unsigned int _Value,
      int          _Shift
    );

 
unsigned long __cdecl _lrotr(
      unsigned long _Value,
      int           _Shift
    );

unsigned __int64 __cdecl _rotr64(
      unsigned __int64 _Value,
      int              _Shift
    );

#pragma warning(pop)



// Maximum value that can be returned by the rand function:


__declspec(dllimport) void __cdecl srand(  unsigned int _Seed);

  __declspec(dllimport) int __cdecl rand(void);



#line 357 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"




extern "C++"
{
    inline long abs(long const _X) throw()
    {
        return labs(_X);
    }

    inline long long abs(long long const _X) throw()
    {
        return llabs(_X);
    }

    inline ldiv_t div(long const _A1, long const _A2) throw()
    {
        return ldiv(_A1, _A2);
    }

    inline lldiv_t div(long long const _A1, long long const _A2) throw()
    {
        return lldiv(_A1, _A2);
    }
}
#line 384 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"




// Structs used to fool the compiler into not generating floating point
// instructions when copying and pushing [long] double values




    #pragma pack(push, 4)
    typedef struct
    {
        unsigned char ld[10];
    } _LDOUBLE;
    #pragma pack(pop)

    











#line 414 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

typedef struct
{
    double x;
} _CRT_DOUBLE;

typedef struct
{
    float f;
} _CRT_FLOAT;

// push and pop long, which is #defined as __int64 by a spec2k test



typedef struct
{
    long double x;
} _LONGDOUBLE;



#pragma pack(push, 4)
typedef struct
{
    unsigned char ld12[12];
} _LDBL12;
#pragma pack(pop)



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Narrow String to Number Conversions
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                     __declspec(dllimport) double    __cdecl atof   (  char const* _String);
   __declspec(dllimport) int       __cdecl atoi   (  char const* _String);
                     __declspec(dllimport) long      __cdecl atol   (  char const* _String);
                     __declspec(dllimport) long long __cdecl atoll  (  char const* _String);
                     __declspec(dllimport) __int64   __cdecl _atoi64(  char const* _String);

  __declspec(dllimport) double    __cdecl _atof_l  (  char const* _String,   _locale_t _Locale);
  __declspec(dllimport) int       __cdecl _atoi_l  (  char const* _String,   _locale_t _Locale);
  __declspec(dllimport) long      __cdecl _atol_l  (  char const* _String,   _locale_t _Locale);
  __declspec(dllimport) long long __cdecl _atoll_l (  char const* _String,   _locale_t _Locale);
  __declspec(dllimport) __int64   __cdecl _atoi64_l(  char const* _String,   _locale_t _Locale);

  __declspec(dllimport) int __cdecl _atoflt (  _CRT_FLOAT*  _Result,   char const* _String);
  __declspec(dllimport) int __cdecl _atodbl (  _CRT_DOUBLE* _Result,   char*       _String);
  __declspec(dllimport) int __cdecl _atoldbl(  _LDOUBLE*    _Result,   char*       _String);

 
__declspec(dllimport) int __cdecl _atoflt_l(
         _CRT_FLOAT* _Result,
        char const* _String,
      _locale_t   _Locale
    );

 
__declspec(dllimport) int __cdecl _atodbl_l(
         _CRT_DOUBLE* _Result,
        char*        _String,
      _locale_t    _Locale
    );


 
__declspec(dllimport) int __cdecl _atoldbl_l(
         _LDOUBLE* _Result,
        char*     _String,
      _locale_t _Locale
    );

 
__declspec(dllimport) float __cdecl strtof(
                        char const* _String,
        char**      _EndPtr
    );

 
__declspec(dllimport) float __cdecl _strtof_l(
                        char const* _String,
        char**      _EndPtr,
                      _locale_t   _Locale
    );

 
__declspec(dllimport) double __cdecl strtod(
                        char const* _String,
        char**      _EndPtr
    );

 
__declspec(dllimport) double __cdecl _strtod_l(
                        char const* _String,
        char**      _EndPtr,
                      _locale_t   _Locale
    );

 
__declspec(dllimport) long double __cdecl strtold(
                        char const* _String,
        char**      _EndPtr
    );

 
__declspec(dllimport) long double __cdecl _strtold_l(
                        char const* _String,
        char**      _EndPtr,
                      _locale_t   _Locale
    );

 
__declspec(dllimport) long __cdecl strtol(
                        char const* _String,
        char**      _EndPtr,
                          int         _Radix
    );

 
__declspec(dllimport) long __cdecl _strtol_l(
                        char const* _String,
        char**      _EndPtr,
                          int         _Radix,
                      _locale_t   _Locale
    );

 
__declspec(dllimport) long long __cdecl strtoll(
                        char const* _String,
        char**      _EndPtr,
                          int         _Radix
    );

 
__declspec(dllimport) long long __cdecl _strtoll_l(
                        char const* _String,
        char**      _EndPtr,
                          int         _Radix,
                      _locale_t   _Locale
    );

 
__declspec(dllimport) unsigned long __cdecl strtoul(
                        char const* _String,
        char**      _EndPtr,
                          int         _Radix
    );

 
__declspec(dllimport) unsigned long __cdecl _strtoul_l(
                        char const* _String,
        char**      _EndPtr,
                          int         _Radix,
                      _locale_t   _Locale
    );

 
__declspec(dllimport) unsigned long long __cdecl strtoull(
                        char const* _String,
        char**      _EndPtr,
                          int         _Radix
    );

 
__declspec(dllimport) unsigned long long __cdecl _strtoull_l(
                        char const* _String,
        char**      _EndPtr,
                          int         _Radix,
                      _locale_t   _Locale
    );

 
__declspec(dllimport) __int64 __cdecl _strtoi64(
                        char const* _String,
        char**      _EndPtr,
                          int         _Radix
    );

 
__declspec(dllimport) __int64 __cdecl _strtoi64_l(
                        char const* _String,
        char**      _EndPtr,
                          int         _Radix,
                      _locale_t   _Locale
    );

 
__declspec(dllimport) unsigned __int64 __cdecl _strtoui64(
                        char const* _String,
        char**      _EndPtr,
                          int         _Radix
    );

 
__declspec(dllimport) unsigned __int64 __cdecl _strtoui64_l(
                        char const* _String,
        char**      _EndPtr,
                          int         _Radix,
                      _locale_t   _Locale
    );



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Number to Narrow String Conversions
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 

__declspec(dllimport) errno_t __cdecl _itoa_s(
                              int    _Value,
      char*  _Buffer,
                              size_t _BufferCount,
                              int    _Radix
    );

extern "C++" { template <size_t _Size> inline   errno_t __cdecl _itoa_s(  int _Value, char (&_Buffer)[_Size],   int _Radix) throw() { return _itoa_s(_Value, _Buffer, _Size, _Radix); } }
#line 640 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_itoa_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) char* __cdecl _itoa( int _Value,   char *_Buffer,  int _Radix);
#line 647 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

 

__declspec(dllimport) errno_t __cdecl _ltoa_s(
                              long   _Value,
      char*  _Buffer,
                              size_t _BufferCount,
                              int    _Radix
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _ltoa_s(  long _Value, char (&_Buffer)[_Size],   int _Radix) throw() { return _ltoa_s(_Value, _Buffer, _Size, _Radix); } }
#line 663 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_ltoa_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) char* __cdecl _ltoa( long _Value,   char *_Buffer,  int _Radix);
#line 670 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

 

__declspec(dllimport) errno_t __cdecl _ultoa_s(
                              unsigned long _Value,
      char*         _Buffer,
                              size_t        _BufferCount,
                              int           _Radix
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _ultoa_s(  unsigned long _Value, char (&_Buffer)[_Size],   int _Radix) throw() { return _ultoa_s(_Value, _Buffer, _Size, _Radix); } }
#line 686 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_ultoa_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) char* __cdecl _ultoa( unsigned long _Value,   char *_Buffer,  int _Radix);
#line 693 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

 

__declspec(dllimport) errno_t __cdecl _i64toa_s(
                              __int64 _Value,
      char*   _Buffer,
                              size_t  _BufferCount,
                              int     _Radix
    );

 
__declspec(deprecated("This function or variable may be unsafe. Consider using " "_i64toa_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) char* __cdecl _i64toa(
                        __int64 _Value,
        char*   _Buffer,
                        int     _Radix
    );

 

__declspec(dllimport) errno_t __cdecl _ui64toa_s(
                              unsigned __int64 _Value,
      char*            _Buffer,
                              size_t           _BufferCount,
                              int              _Radix
    );

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_ui64toa_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) char* __cdecl _ui64toa(
                        unsigned __int64 _Value,
        char*            _Buffer,
                        int              _Radix
    );



// _CVTBUFSIZE is the maximum size for the per-thread conversion buffer.  It
// should be at least as long as the number of digits in the largest double
// precision value (?.?e308 in IEEE arithmetic).  We will use the same size
// buffer as is used in the printf support routines.
//
// (This value actually allows 40 additional decimal places; even though there
// are only 16 digits of accuracy in a double precision IEEE number, the user may
// ask for more to effect zero padding.)


 

__declspec(dllimport) errno_t __cdecl _ecvt_s(
      char* _Buffer,
       size_t                       _BufferCount,
       double                       _Value,
       int                          _DigitCount,
      int*                         _PtDec,
      int*                         _PtSign
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _ecvt_s(char (&_Buffer)[_Size],   double _Value,   int _DigitCount,   int* _PtDec,   int* _PtSign) throw() { return _ecvt_s(_Buffer, _Size, _Value, _DigitCount, _PtDec, _PtSign); } }
#line 758 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_ecvt_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) char* __cdecl _ecvt(
       double _Value,
       int    _DigitCount,
      int*   _PtDec,
      int*   _PtSign
    );

 

__declspec(dllimport) errno_t __cdecl _fcvt_s(
      char*  _Buffer,
                              size_t _BufferCount,
                              double _Value,
                              int    _FractionalDigitCount,
                             int*   _PtDec,
                             int*   _PtSign
    );

extern "C++" { template <size_t _Size> inline   errno_t __cdecl _fcvt_s(char (&_Buffer)[_Size],   double _Value,   int _FractionalDigitCount,   int* _PtDec,   int* _PtSign) throw() { return _fcvt_s(_Buffer, _Size, _Value, _FractionalDigitCount, _PtDec, _PtSign); } }
#line 787 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

 
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_fcvt_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) char* __cdecl _fcvt(
       double _Value,
       int    _FractionalDigitCount,
      int*   _PtDec,
      int*   _PtSign
    );

 
__declspec(dllimport) errno_t __cdecl _gcvt_s(
      char*  _Buffer,
                              size_t _BufferCount,
                              double _Value,
                              int    _DigitCount
    );

extern "C++" { template <size_t _Size> inline   errno_t __cdecl _gcvt_s(char (&_Buffer)[_Size],   double _Value,   int _DigitCount) throw() { return _gcvt_s(_Buffer, _Size, _Value, _DigitCount); } }
#line 812 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_gcvt_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) char* __cdecl _gcvt(
                        double _Value,
                        int    _DigitCount,
        char*  _Buffer
    );



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Multibyte String Operations and Conversions
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
// Maximum number of bytes in multi-byte character in the current locale
// (also defined in ctype.h).

    

#line 833 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"
        
    #line 835 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

    


        
    #line 841 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

     
    __declspec(dllimport) int __cdecl ___mb_cur_max_func(void);

     
    __declspec(dllimport) int __cdecl ___mb_cur_max_l_func(_locale_t _Locale);
#line 848 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"



 
__declspec(dllimport) int __cdecl mblen(
        char const* _Ch,
                                             size_t      _MaxCount
    );

 
__declspec(dllimport) int __cdecl _mblen_l(
        char const* _Ch,
                                             size_t      _MaxCount,
                                         _locale_t   _Locale
    );

 
 
__declspec(dllimport) size_t __cdecl _mbstrlen(
      char const* _String
    );

 
 
__declspec(dllimport) size_t __cdecl _mbstrlen_l(
        char const* _String,
      _locale_t   _Locale
    );

 
 
__declspec(dllimport) size_t __cdecl _mbstrnlen(
      char const* _String,
        size_t      _MaxCount
    );

 
 
__declspec(dllimport) size_t __cdecl _mbstrnlen_l(
        char const* _String,
          size_t      _MaxCount,
      _locale_t   _Locale
    );

 
__declspec(dllimport) int __cdecl mbtowc(
                      wchar_t*    _DstCh,
      char const* _SrcCh,
                                      size_t      _SrcSizeInBytes
    );

 
__declspec(dllimport) int __cdecl _mbtowc_l(
                      wchar_t*    _DstCh,
      char const* _SrcCh,
                                      size_t      _SrcSizeInBytes,
                                  _locale_t   _Locale
    );


__declspec(dllimport) errno_t __cdecl mbstowcs_s(
                                                      size_t*     _PtNumOfCharConverted,
      wchar_t*    _DstBuf,
                                                           size_t      _SizeInWords,
                                     char const* _SrcBuf,
                                                           size_t      _MaxCount
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl mbstowcs_s(  size_t* _PtNumOfCharConverted,   wchar_t (&_Dest)[_Size],   char const* _Source,   size_t _MaxCount) throw() { return mbstowcs_s(_PtNumOfCharConverted, _Dest, _Size, _Source, _MaxCount); } }
#line 923 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "mbstowcs_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) size_t __cdecl mbstowcs( wchar_t *_Dest,  char const* _Source,  size_t _MaxCount);
#line 930 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"


__declspec(dllimport) errno_t __cdecl _mbstowcs_s_l(
                                                      size_t*     _PtNumOfCharConverted,
      wchar_t*    _DstBuf,
                                                           size_t      _SizeInWords,
                                     char const* _SrcBuf,
                                                           size_t      _MaxCount,
                                                       _locale_t   _Locale
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _mbstowcs_s_l(  size_t* _PtNumOfCharConverted,   wchar_t (&_Dest)[_Size],   char const* _Source,   size_t _MaxCount,   _locale_t _Locale) throw() { return _mbstowcs_s_l(_PtNumOfCharConverted, _Dest, _Size, _Source, _MaxCount, _Locale); } }
#line 949 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_mbstowcs_s_l" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) size_t __cdecl _mbstowcs_l(  wchar_t *_Dest,   char const* _Source,   size_t _MaxCount,   _locale_t _Locale);
#line 958 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"




__declspec(deprecated("This function or variable may be unsafe. Consider using " "wctomb_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) int __cdecl wctomb(
      char*   _MbCh,
                                wchar_t _WCh
    );

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_wctomb_s_l" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) int __cdecl _wctomb_l(
        char*     _MbCh,
                          wchar_t   _WCh,
                      _locale_t _Locale
    );



    
    __declspec(dllimport) errno_t __cdecl wctomb_s(
                                                         int*    _SizeConverted,
          char*   _MbCh,
                                                              rsize_t _SizeInBytes,
                                                              wchar_t _WCh
        );

#line 986 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"


__declspec(dllimport) errno_t __cdecl _wctomb_s_l(
                             int*     _SizeConverted,
      char*     _MbCh,
                                  size_t    _SizeInBytes,
                                  wchar_t   _WCh,
                              _locale_t _Locale);


__declspec(dllimport) errno_t __cdecl wcstombs_s(
                                                               size_t*        _PtNumOfCharConverted,
      char*          _Dst,
                                                                    size_t         _DstSizeInBytes,
                                                                  wchar_t const* _Src,
                                                                    size_t         _MaxCountInBytes
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl wcstombs_s(  size_t* _PtNumOfCharConverted,   char (&_Dest)[_Size],   wchar_t const* _Source,   size_t _MaxCount) throw() { return wcstombs_s(_PtNumOfCharConverted, _Dest, _Size, _Source, _MaxCount); } }
#line 1011 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "wcstombs_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) size_t __cdecl wcstombs( char *_Dest,  wchar_t const* _Source,  size_t _MaxCount);
#line 1018 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"


__declspec(dllimport) errno_t __cdecl _wcstombs_s_l(
                                                               size_t*        _PtNumOfCharConverted,
      char*          _Dst,
                                                                    size_t         _DstSizeInBytes,
                                                                  wchar_t const* _Src,
                                                                    size_t         _MaxCountInBytes,
                                                                _locale_t      _Locale
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _wcstombs_s_l(  size_t* _PtNumOfCharConverted,   char (&_Dest)[_Size],   wchar_t const* _Source,   size_t _MaxCount,   _locale_t _Locale) throw() { return _wcstombs_s_l(_PtNumOfCharConverted, _Dest, _Size, _Source, _MaxCount, _Locale); } }
#line 1037 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_wcstombs_s_l" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) size_t __cdecl _wcstombs_l(  char *_Dest,   wchar_t const* _Source,   size_t _MaxCount,   _locale_t _Locale);
#line 1046 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Path Manipulation
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
// Sizes for buffers used by the _makepath() and _splitpath() functions.
// note that the sizes include space for 0-terminator










 
 
__declspec(dllimport) __declspec(allocator) char* __cdecl _fullpath(
      char*       _Buffer,
                                char const* _Path,
                                  size_t      _BufferCount
    );




__declspec(dllimport) errno_t __cdecl _makepath_s(
      char*       _Buffer,
                              size_t      _BufferCount,
                        char const* _Drive,
                        char const* _Dir,
                        char const* _Filename,
                        char const* _Ext
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _makepath_s(char (&_Buffer)[_Size],   char const* _Drive,   char const* _Dir,   char const* _Filename,   char const* _Ext) throw() { return _makepath_s(_Buffer, _Size, _Drive, _Dir, _Filename, _Ext); } }
#line 1094 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_makepath_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) void __cdecl _makepath(  char *_Buffer,  char const* _Drive,  char const* _Dir,  char const* _Filename,  char const* _Ext);
#line 1103 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_splitpath_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) void __cdecl _splitpath(
                        char const* _FullPath,
        char*       _Drive,
        char*       _Dir,
        char*       _Filename,
        char*       _Ext
    );


__declspec(dllimport) errno_t __cdecl _splitpath_s(
                                  char const* _FullPath,
         char*       _Drive,
                                    size_t      _DriveCount,
           char*       _Dir,
                                    size_t      _DirCount,
      char*       _Filename,
                                    size_t      _FilenameCount,
           char*       _Ext,
                                    size_t      _ExtCount
    );

extern "C++" { template <size_t _DriveSize, size_t _DirSize, size_t _NameSize, size_t _ExtSize> inline errno_t __cdecl _splitpath_s(   char const* _Dest,   char (&_Drive)[_DriveSize],   char (&_Dir)[_DirSize],   char (&_Name)[_NameSize],   char (&_Ext)[_ExtSize] ) throw() { return _splitpath_s(_Dest, _Drive, _DriveSize, _Dir, _DirSize, _Name, _NameSize, _Ext, _ExtSize); } }




 
__declspec(dllimport) errno_t __cdecl getenv_s(
                                 size_t*     _RequiredCount,
      char*       _Buffer,
                                  rsize_t     _BufferCount,
                                char const* _VarName
    );

#line 1140 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"




__declspec(dllimport) int*       __cdecl __p___argc (void);
__declspec(dllimport) char***    __cdecl __p___argv (void);
__declspec(dllimport) wchar_t*** __cdecl __p___wargv(void);






    
    
    
#line 1157 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

__declspec(dllimport) char***    __cdecl __p__environ (void);
__declspec(dllimport) wchar_t*** __cdecl __p__wenviron(void);


    
#line 1164 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"







    
    
#line 1174 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"



// Sizes for buffers used by the getenv/putenv family of functions.





      __declspec(deprecated("This function or variable may be unsafe. Consider using " "_dupenv_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
    __declspec(dllimport) char* __cdecl getenv(
          char const* _VarName
        );

    extern "C++" { template <size_t _Size> inline errno_t __cdecl getenv_s(  size_t* _RequiredCount, char (&_Buffer)[_Size],   char const* _VarName) throw() { return getenv_s(_RequiredCount, _Buffer, _Size, _VarName); } }
#line 1194 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

    


#line 1199 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

    
    __declspec(dllimport) errno_t __cdecl _dupenv_s(
            char**      _Buffer,
                                                                            size_t*     _BufferCount,
                                                                               char const* _VarName
        );

    

#line 1210 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

    __declspec(dllimport) int __cdecl system(
          char const* _Command
        );

    // The functions below have declspecs in their declarations in the Windows
    // headers, causing PREfast to fire 6540 here
    #pragma warning(push)
    #pragma warning(disable: 6540)

     
    __declspec(dllimport) int __cdecl _putenv(
          char const* _EnvString
        );

    
    __declspec(dllimport) errno_t __cdecl _putenv_s(
          char const* _Name,
          char const* _Value
        );

    #pragma warning(pop)

    __declspec(dllimport) errno_t __cdecl _searchenv_s(
                                char const* _Filename,
                                char const* _VarName,
          char*       _Buffer,
                                  size_t      _BufferCount
        );

    extern "C++" { template <size_t _Size> inline errno_t __cdecl _searchenv_s(  char const* _Filename,   char const* _VarName, char (&_Buffer)[_Size]) throw() { return _searchenv_s(_Filename, _VarName, _Buffer, _Size); } }
#line 1246 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

    __declspec(deprecated("This function or variable may be unsafe. Consider using " "_searchenv_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) void __cdecl _searchenv( char const* _Filename,  char const* _VarName,   char *_Buffer);
#line 1253 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"

    // The Win32 API SetErrorMode, Beep and Sleep should be used instead.
    __declspec(deprecated("This function or variable has been superceded by newer library " "or operating system functionality. Consider using " "SetErrorMode" " " "instead. See online help for details."))
    __declspec(dllimport) void __cdecl _seterrormode(
          int _Mode
        );

    __declspec(deprecated("This function or variable has been superceded by newer library " "or operating system functionality. Consider using " "Beep" " " "instead. See online help for details."))
    __declspec(dllimport) void __cdecl _beep(
          unsigned _Frequency,
          unsigned _Duration
        );

    __declspec(deprecated("This function or variable has been superceded by newer library " "or operating system functionality. Consider using " "Sleep" " " "instead. See online help for details."))
    __declspec(dllimport) void __cdecl _sleep(
          unsigned long _Duration
        );

#line 1272 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"


//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Non-ANSI Names for Compatibility
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


    




    
    

    #pragma warning(push)
    #pragma warning(disable: 4141) 

      __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_ecvt" ". See online help for details.")) __declspec(deprecated("This function or variable may be unsafe. Consider using " "_ecvt_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
    __declspec(dllimport) char* __cdecl ecvt(
           double _Value,
           int    _DigitCount,
          int*   _PtDec,
          int*   _PtSign
        );

      __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_fcvt" ". See online help for details.")) __declspec(deprecated("This function or variable may be unsafe. Consider using " "_fcvt_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
    __declspec(dllimport) char* __cdecl fcvt(
           double _Value,
           int    _FractionalDigitCount,
          int*   _PtDec,
          int*   _PtSign
        );

    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_gcvt" ". See online help for details.")) __declspec(deprecated("This function or variable may be unsafe. Consider using " "_fcvt_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
    __declspec(dllimport) char* __cdecl gcvt(
                            double _Value,
                            int    _DigitCount,
            char*  _DstBuf
        );

    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_itoa" ". See online help for details.")) __declspec(deprecated("This function or variable may be unsafe. Consider using " "_itoa_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
    __declspec(dllimport) char* __cdecl itoa(
                            int   _Value,
            char* _Buffer,
                            int   _Radix
        );

    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_ltoa" ". See online help for details.")) __declspec(deprecated("This function or variable may be unsafe. Consider using " "_ltoa_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
    __declspec(dllimport) char* __cdecl ltoa(
                            long  _Value,
            char* _Buffer,
                            int   _Radix
        );


    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_swab" ". See online help for details."))
    __declspec(dllimport) void __cdecl swab(
          char* _Buf1,
          char* _Buf2,
                                     int   _SizeInBytes
        );

    __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_ultoa" ". See online help for details.")) __declspec(deprecated("This function or variable may be unsafe. Consider using " "_ultoa_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
    __declspec(dllimport) char* __cdecl ultoa(
                            unsigned long _Value,
            char*         _Buffer,
                            int           _Radix
        );

    

      __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_putenv" ". See online help for details."))
    __declspec(dllimport) int __cdecl putenv(
          char const* _EnvString
        );

    #pragma warning(pop)

    _onexit_t __cdecl onexit(  _onexit_t _Func);

#line 1356 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"



} __pragma(pack(pop))

#pragma warning(pop) 
#line 1363 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\stdlib.h"
#line 14 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstdlib"

#pragma pack(push, 8)
#pragma warning(push, 3)
#pragma warning(disable : 4180 4412 4455 4494 4514 4574 4582 4583 4587 4588 4619 4623 4625 4626 4643 4648 4702 4793 4820 4988 5026 5027 5045 6294  4984 5053 )




// <stdlib.h> has abs(long) and abs(long long)
[[nodiscard]]   inline double abs(  double _Xx) noexcept /* strengthened */ {
    return :: fabs(_Xx);
}

[[nodiscard]]   inline float abs(  float _Xx) noexcept /* strengthened */ {
    return :: fabsf(_Xx);
}

[[nodiscard]]   inline long double abs(  long double _Xx) noexcept /* strengthened */ {
    return :: fabsl(_Xx);
}

namespace std {
using :: size_t;
using :: div_t;
using :: ldiv_t;
using :: abort;
using :: abs;
using :: atexit;
using :: atof;
using :: atoi;
using :: atol;
using :: bsearch;
using :: calloc;
using :: div;
using :: exit;
using :: free;
using :: labs;
using :: ldiv;
using :: malloc;
using :: mblen;
using :: mbstowcs;
using :: mbtowc;
using :: qsort;
using :: rand;
using :: realloc;
using :: srand;
using :: strtod;
using :: strtol;
using :: strtoul;
using :: wcstombs;
using :: wctomb;

using :: lldiv_t;


using :: getenv;
using :: system;
#line 72 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstdlib"

using :: atoll;
using :: llabs;
using :: lldiv;
using :: strtof;
using :: strtold;
using :: strtoll;
using :: strtoull;

using :: _Exit;
using :: at_quick_exit;
using :: quick_exit;
}



#pragma warning(pop)
#pragma pack(pop)

#line 92 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstdlib"
#line 93 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\cstdlib"
#line 13 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xstddef"
#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\initializer_list"
// initializer_list standard header (core)

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once






#pragma pack(push, 8)
#pragma warning(push, 3)
#pragma warning(disable : 4180 4412 4455 4494 4514 4574 4582 4583 4587 4588 4619 4623 4625 4626 4643 4648 4702 4793 4820 4988 5026 5027 5045 6294  4984 5053 )




namespace std {
// CLASS TEMPLATE initializer_list
template <class _Elem>
class initializer_list {
public:
    using value_type      = _Elem;
    using reference       = const _Elem&;
    using const_reference = const _Elem&;
    using size_type       = size_t;

    using iterator       = const _Elem*;
    using const_iterator = const _Elem*;

    constexpr initializer_list() noexcept : _First(nullptr), _Last(nullptr) {}

    constexpr initializer_list(const _Elem* _First_arg, const _Elem* _Last_arg) noexcept
        : _First(_First_arg), _Last(_Last_arg) {}

    [[nodiscard]] constexpr const _Elem* begin() const noexcept {
        return _First;
    }

    [[nodiscard]] constexpr const _Elem* end() const noexcept {
        return _Last;
    }

    [[nodiscard]] constexpr size_t size() const noexcept {
        return static_cast<size_t>(_Last - _First);
    }

private:
    const _Elem* _First;
    const _Elem* _Last;
};

// FUNCTION TEMPLATE begin
template <class _Elem>
[[nodiscard]] constexpr const _Elem* begin(initializer_list<_Elem> _Ilist) noexcept {
    return _Ilist.begin();
}

// FUNCTION TEMPLATE end
template <class _Elem>
[[nodiscard]] constexpr const _Elem* end(initializer_list<_Elem> _Ilist) noexcept {
    return _Ilist.end();
}
}


#pragma warning(pop)
#pragma pack(pop)
#line 72 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\initializer_list"
#line 73 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\initializer_list"
#line 14 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xstddef"


#pragma pack(push, 8)
#pragma warning(push, 3)
#pragma warning(disable : 4180 4412 4455 4494 4514 4574 4582 4583 4587 4588 4619 4623 4625 4626 4643 4648 4702 4793 4820 4988 5026 5027 5045 6294  4984 5053 )




namespace std {
// TYPE DEFINITIONS
template <class>
// false value attached to a dependent name (for static_assert)
 constexpr bool _Always_false = false;

// FUNCTIONAL STUFF (from <functional>)

// STRUCT TEMPLATE unary_function
template <class _Arg, class _Result>
struct unary_function { // base class for unary functions
    using argument_type = _Arg;
    using result_type   = _Result;
};

// STRUCT TEMPLATE binary_function
template <class _Arg1, class _Arg2, class _Result>
struct binary_function { // base class for binary functions
    using first_argument_type  = _Arg1;
    using second_argument_type = _Arg2;
    using result_type          = _Result;
};
#line 46 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xstddef"

// STRUCT TEMPLATE plus
template <class _Ty = void>
struct plus {
     typedef _Ty first_argument_type;
     typedef _Ty second_argument_type;
     typedef _Ty result_type;

    [[nodiscard]] constexpr _Ty operator()(const _Ty& _Left, const _Ty& _Right) const {
        return _Left + _Right;
    }
};

// STRUCT TEMPLATE minus
template <class _Ty = void>
struct minus {
     typedef _Ty first_argument_type;
     typedef _Ty second_argument_type;
     typedef _Ty result_type;

    [[nodiscard]] constexpr _Ty operator()(const _Ty& _Left, const _Ty& _Right) const {
        return _Left - _Right;
    }
};

// STRUCT TEMPLATE multiplies
template <class _Ty = void>
struct multiplies {
     typedef _Ty first_argument_type;
     typedef _Ty second_argument_type;
     typedef _Ty result_type;

    [[nodiscard]] constexpr _Ty operator()(const _Ty& _Left, const _Ty& _Right) const {
        return _Left * _Right;
    }
};

// STRUCT TEMPLATE equal_to
template <class _Ty = void>
struct equal_to {
     typedef _Ty first_argument_type;
     typedef _Ty second_argument_type;
     typedef bool result_type;

    [[nodiscard]] constexpr bool operator()(const _Ty& _Left, const _Ty& _Right) const {
        return _Left == _Right;
    }
};

// STRUCT TEMPLATE not_equal_to
template <class _Ty = void>
struct not_equal_to {
     typedef _Ty first_argument_type;
     typedef _Ty second_argument_type;
     typedef bool result_type;

    [[nodiscard]] constexpr bool operator()(const _Ty& _Left, const _Ty& _Right) const {
        return _Left != _Right;
    }
};

// STRUCT TEMPLATE greater
template <class _Ty = void>
struct greater {
     typedef _Ty first_argument_type;
     typedef _Ty second_argument_type;
     typedef bool result_type;

    [[nodiscard]] constexpr bool operator()(const _Ty& _Left, const _Ty& _Right) const {
        return _Left > _Right;
    }
};

// STRUCT TEMPLATE less
template <class _Ty = void>
struct less {
     typedef _Ty first_argument_type;
     typedef _Ty second_argument_type;
     typedef bool result_type;

    [[nodiscard]] constexpr bool operator()(const _Ty& _Left, const _Ty& _Right) const {
        return _Left < _Right;
    }
};

// STRUCT TEMPLATE greater_equal
template <class _Ty = void>
struct greater_equal {
     typedef _Ty first_argument_type;
     typedef _Ty second_argument_type;
     typedef bool result_type;

    [[nodiscard]] constexpr bool operator()(const _Ty& _Left, const _Ty& _Right) const {
        return _Left >= _Right;
    }
};

// STRUCT TEMPLATE less_equal
template <class _Ty = void>
struct less_equal {
     typedef _Ty first_argument_type;
     typedef _Ty second_argument_type;
     typedef bool result_type;

    [[nodiscard]] constexpr bool operator()(const _Ty& _Left, const _Ty& _Right) const {
        return _Left <= _Right;
    }
};

// STRUCT TEMPLATE SPECIALIZATION plus
template <>
struct plus<void> {
    template <class _Ty1, class _Ty2>
    [[nodiscard]] constexpr auto operator()(_Ty1&& _Left, _Ty2&& _Right) const
        noexcept(noexcept(static_cast<_Ty1&&>(_Left) + static_cast<_Ty2&&>(_Right))) // strengthened
        -> decltype(static_cast<_Ty1&&>(_Left) + static_cast<_Ty2&&>(_Right)) {
        return static_cast<_Ty1&&>(_Left) + static_cast<_Ty2&&>(_Right);
    }

    using is_transparent = int;
};

// STRUCT TEMPLATE SPECIALIZATION minus
template <>
struct minus<void> {
    template <class _Ty1, class _Ty2>
    [[nodiscard]] constexpr auto operator()(_Ty1&& _Left, _Ty2&& _Right) const
        noexcept(noexcept(static_cast<_Ty1&&>(_Left) - static_cast<_Ty2&&>(_Right))) // strengthened
        -> decltype(static_cast<_Ty1&&>(_Left) - static_cast<_Ty2&&>(_Right)) {
        return static_cast<_Ty1&&>(_Left) - static_cast<_Ty2&&>(_Right);
    }

    using is_transparent = int;
};

// STRUCT TEMPLATE SPECIALIZATION multiplies
template <>
struct multiplies<void> {
    template <class _Ty1, class _Ty2>
    [[nodiscard]] constexpr auto operator()(_Ty1&& _Left, _Ty2&& _Right) const
        noexcept(noexcept(static_cast<_Ty1&&>(_Left) * static_cast<_Ty2&&>(_Right))) // strengthened
        -> decltype(static_cast<_Ty1&&>(_Left) * static_cast<_Ty2&&>(_Right)) {
        return static_cast<_Ty1&&>(_Left) * static_cast<_Ty2&&>(_Right);
    }

    using is_transparent = int;
};

// STRUCT TEMPLATE SPECIALIZATION equal_to
template <>
struct equal_to<void> {
    template <class _Ty1, class _Ty2>
    [[nodiscard]] constexpr auto operator()(_Ty1&& _Left, _Ty2&& _Right) const
        noexcept(noexcept(static_cast<_Ty1&&>(_Left) == static_cast<_Ty2&&>(_Right))) // strengthened
        -> decltype(static_cast<_Ty1&&>(_Left) == static_cast<_Ty2&&>(_Right)) {
        return static_cast<_Ty1&&>(_Left) == static_cast<_Ty2&&>(_Right);
    }

    using is_transparent = int;
};

// STRUCT TEMPLATE SPECIALIZATION not_equal_to
template <>
struct not_equal_to<void> {
    template <class _Ty1, class _Ty2>
    [[nodiscard]] constexpr auto operator()(_Ty1&& _Left, _Ty2&& _Right) const
        noexcept(noexcept(static_cast<_Ty1&&>(_Left) != static_cast<_Ty2&&>(_Right))) // strengthened
        -> decltype(static_cast<_Ty1&&>(_Left) != static_cast<_Ty2&&>(_Right)) {
        return static_cast<_Ty1&&>(_Left) != static_cast<_Ty2&&>(_Right);
    }

    using is_transparent = int;
};

// STRUCT TEMPLATE SPECIALIZATION greater
template <>
struct greater<void> {
    template <class _Ty1, class _Ty2>
    [[nodiscard]] constexpr auto operator()(_Ty1&& _Left, _Ty2&& _Right) const
        noexcept(noexcept(static_cast<_Ty1&&>(_Left) > static_cast<_Ty2&&>(_Right))) // strengthened
        -> decltype(static_cast<_Ty1&&>(_Left) > static_cast<_Ty2&&>(_Right)) {
        return static_cast<_Ty1&&>(_Left) > static_cast<_Ty2&&>(_Right);
    }

    using is_transparent = int;
};

// STRUCT TEMPLATE SPECIALIZATION less
template <>
struct less<void> {
    template <class _Ty1, class _Ty2>
    [[nodiscard]] constexpr auto operator()(_Ty1&& _Left, _Ty2&& _Right) const
        noexcept(noexcept(static_cast<_Ty1&&>(_Left) < static_cast<_Ty2&&>(_Right))) // strengthened
        -> decltype(static_cast<_Ty1&&>(_Left) < static_cast<_Ty2&&>(_Right)) {
        return static_cast<_Ty1&&>(_Left) < static_cast<_Ty2&&>(_Right);
    }

    using is_transparent = int;
};

// STRUCT TEMPLATE SPECIALIZATION greater_equal
template <>
struct greater_equal<void> {
    template <class _Ty1, class _Ty2>
    [[nodiscard]] constexpr auto operator()(_Ty1&& _Left, _Ty2&& _Right) const
        noexcept(noexcept(static_cast<_Ty1&&>(_Left) >= static_cast<_Ty2&&>(_Right))) // strengthened
        -> decltype(static_cast<_Ty1&&>(_Left) >= static_cast<_Ty2&&>(_Right)) {
        return static_cast<_Ty1&&>(_Left) >= static_cast<_Ty2&&>(_Right);
    }

    using is_transparent = int;
};

// STRUCT TEMPLATE SPECIALIZATION less_equal
template <>
struct less_equal<void> {
    template <class _Ty1, class _Ty2>
    [[nodiscard]] constexpr auto operator()(_Ty1&& _Left, _Ty2&& _Right) const
        noexcept(noexcept(static_cast<_Ty1&&>(_Left) <= static_cast<_Ty2&&>(_Right))) // strengthened
        -> decltype(static_cast<_Ty1&&>(_Left) <= static_cast<_Ty2&&>(_Right)) {
        return static_cast<_Ty1&&>(_Left) <= static_cast<_Ty2&&>(_Right);
    }

    using is_transparent = int;
};

// FUNCTION TEMPLATE addressof
template <class _Ty>
[[nodiscard]] constexpr _Ty* addressof(_Ty& _Val) noexcept {
    return __builtin_addressof(_Val);
}

template <class _Ty>
const _Ty* addressof(const _Ty&&) = delete;

// FUNCTION TEMPLATE _Unfancy
template <class _Ptrty>
[[nodiscard]] constexpr auto _Unfancy(_Ptrty _Ptr) noexcept { // converts from a fancy pointer to a plain pointer
    return ::std:: addressof(*_Ptr);
}

template <class _Ty>
[[nodiscard]] constexpr _Ty* _Unfancy(_Ty* _Ptr) noexcept { // do nothing for plain pointers
    return _Ptr;
}
}








#line 301 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xstddef"




#line 306 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xstddef"

#line 308 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xstddef"








#line 317 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xstddef"






#line 324 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xstddef"

























#line 350 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xstddef"


























#line 377 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xstddef"









































#line 419 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xstddef"



#pragma warning(pop)
#pragma pack(pop)
#line 425 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xstddef"
#line 426 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xstddef"
#line 13 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

#pragma pack(push, 8)
#pragma warning(push, 3)
#pragma warning(disable : 4180 4412 4455 4494 4514 4574 4582 4583 4587 4588 4619 4623 4625 4626 4643 4648 4702 4793 4820 4988 5026 5027 5045 6294  4984 5053 )




namespace std {
// STRUCT TEMPLATE integer_sequence
template <class _Ty, _Ty... _Vals>
struct integer_sequence { // sequence of integer parameters
    static_assert(is_integral_v<_Ty>, "integer_sequence<T, I...> requires T to be an integral type.");

    using value_type = _Ty;

    [[nodiscard]] static constexpr size_t size() noexcept {
        return sizeof...(_Vals);
    }
};

// ALIAS TEMPLATE make_integer_sequence
template <class _Ty, _Ty _Size>
using make_integer_sequence = __make_integer_seq<integer_sequence, _Ty, _Size>;

template <size_t... _Vals>
using index_sequence = integer_sequence<size_t, _Vals...>;

template <size_t _Size>
using make_index_sequence = make_integer_sequence<size_t, _Size>;

template <class... _Types>
using index_sequence_for = make_index_sequence<sizeof...(_Types)>;

// STRUCT TEMPLATE conjunction
template <bool _First_value, class _First, class... _Rest>
struct _Conjunction { // handle false trait or last trait
    using type = _First;
};

template <class _True, class _Next, class... _Rest>
struct _Conjunction<true, _True, _Next, _Rest...> { // the first trait is true, try the next one
    using type = typename _Conjunction<_Next::value, _Next, _Rest...>::type;
};

template <class... _Traits>
struct conjunction : true_type {}; // If _Traits is empty, true_type

template <class _First, class... _Rest>
struct conjunction<_First, _Rest...> : _Conjunction<_First::value, _First, _Rest...>::type {
    // the first false trait in _Traits, or the last trait if none are false
};

template <class... _Traits>
 constexpr bool conjunction_v = conjunction<_Traits...>::value;

// STRUCT TEMPLATE negation
template <class _Trait>
struct negation : bool_constant<!static_cast<bool>(_Trait::value)> {}; // The negated result of _Trait

template <class _Trait>
 constexpr bool negation_v = negation<_Trait>::value;

// STRUCT TEMPLATE is_void
template <class _Ty>
 constexpr bool is_void_v = is_same_v<remove_cv_t<_Ty>, void>;

template <class _Ty>
struct is_void : bool_constant<is_void_v<_Ty>> {};

// ALIAS TEMPLATE void_t
template <class... _Types>
using void_t = void;

// Type modifiers
// STRUCT TEMPLATE add_const
template <class _Ty>
struct add_const { // add top-level const qualifier
    using type = const _Ty;
};

template <class _Ty>
using add_const_t = typename add_const<_Ty>::type;

// STRUCT TEMPLATE add_volatile
template <class _Ty>
struct add_volatile { // add top-level volatile qualifier
    using type = volatile _Ty;
};

template <class _Ty>
using add_volatile_t = typename add_volatile<_Ty>::type;

// STRUCT TEMPLATE add_cv
template <class _Ty>
struct add_cv { // add top-level const and volatile qualifiers
    using type = const volatile _Ty;
};

template <class _Ty>
using add_cv_t = typename add_cv<_Ty>::type;

// STRUCT TEMPLATE _Add_reference
template <class _Ty, class = void>
struct _Add_reference { // add reference (non-referenceable type)
    using _Lvalue = _Ty;
    using _Rvalue = _Ty;
};

template <class _Ty>
struct _Add_reference<_Ty, void_t<_Ty&>> { // (referenceable type)
    using _Lvalue = _Ty&;
    using _Rvalue = _Ty&&;
};

// STRUCT TEMPLATE add_lvalue_reference
template <class _Ty>
struct add_lvalue_reference {
    using type = typename _Add_reference<_Ty>::_Lvalue;
};

template <class _Ty>
using add_lvalue_reference_t = typename _Add_reference<_Ty>::_Lvalue;

// STRUCT TEMPLATE add_rvalue_reference
template <class _Ty>
struct add_rvalue_reference {
    using type = typename _Add_reference<_Ty>::_Rvalue;
};

template <class _Ty>
using add_rvalue_reference_t = typename _Add_reference<_Ty>::_Rvalue;

// FUNCTION TEMPLATE declval
template <class _Ty>
add_rvalue_reference_t<_Ty> declval() noexcept;

// STRUCT TEMPLATE remove_extent
template <class _Ty>
struct remove_extent { // remove array extent
    using type = _Ty;
};

template <class _Ty, size_t _Ix>
struct remove_extent<_Ty[_Ix]> {
    using type = _Ty;
};

template <class _Ty>
struct remove_extent<_Ty[]> {
    using type = _Ty;
};

template <class _Ty>
using remove_extent_t = typename remove_extent<_Ty>::type;

// STRUCT TEMPLATE remove_all_extents
template <class _Ty>
struct remove_all_extents { // remove all array extents
    using type = _Ty;
};

template <class _Ty, size_t _Ix>
struct remove_all_extents<_Ty[_Ix]> {
    using type = typename remove_all_extents<_Ty>::type;
};

template <class _Ty>
struct remove_all_extents<_Ty[]> {
    using type = typename remove_all_extents<_Ty>::type;
};

template <class _Ty>
using remove_all_extents_t = typename remove_all_extents<_Ty>::type;

// STRUCT TEMPLATE remove_pointer
template <class _Ty>
struct remove_pointer {
    using type = _Ty;
};

template <class _Ty>
struct remove_pointer<_Ty*> {
    using type = _Ty;
};

template <class _Ty>
struct remove_pointer<_Ty* const> {
    using type = _Ty;
};

template <class _Ty>
struct remove_pointer<_Ty* volatile> {
    using type = _Ty;
};

template <class _Ty>
struct remove_pointer<_Ty* const volatile> {
    using type = _Ty;
};

template <class _Ty>
using remove_pointer_t = typename remove_pointer<_Ty>::type;

// STRUCT TEMPLATE add_pointer
template <class _Ty, class = void>
struct _Add_pointer { // add pointer (pointer type cannot be formed)
    using type = _Ty;
};

template <class _Ty>
struct _Add_pointer<_Ty, void_t<remove_reference_t<_Ty>*>> { // (pointer type can be formed)
    using type = remove_reference_t<_Ty>*;
};

template <class _Ty>
struct add_pointer {
    using type = typename _Add_pointer<_Ty>::type;
};

template <class _Ty>
using add_pointer_t = typename _Add_pointer<_Ty>::type;

// TYPE PREDICATES
// STRUCT TEMPLATE is_array
template <class>
 constexpr bool is_array_v = false; // determine whether type argument is an array

template <class _Ty, size_t _Nx>
 constexpr bool is_array_v<_Ty[_Nx]> = true;

template <class _Ty>
 constexpr bool is_array_v<_Ty[]> = true;

template <class _Ty>
struct is_array : bool_constant<is_array_v<_Ty>> {};





















#line 271 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

// STRUCT TEMPLATE is_lvalue_reference
template <class>
 constexpr bool is_lvalue_reference_v = false; // determine whether type argument is an lvalue reference

template <class _Ty>
 constexpr bool is_lvalue_reference_v<_Ty&> = true;

template <class _Ty>
struct is_lvalue_reference : bool_constant<is_lvalue_reference_v<_Ty>> {};

// STRUCT TEMPLATE is_rvalue_reference
template <class>
 constexpr bool is_rvalue_reference_v = false; // determine whether type argument is an rvalue reference

template <class _Ty>
 constexpr bool is_rvalue_reference_v<_Ty&&> = true;

template <class _Ty>
struct is_rvalue_reference : bool_constant<is_rvalue_reference_v<_Ty>> {};

// STRUCT TEMPLATE is_reference
template <class>
 constexpr bool is_reference_v = false; // determine whether type argument is a reference

template <class _Ty>
 constexpr bool is_reference_v<_Ty&> = true;

template <class _Ty>
 constexpr bool is_reference_v<_Ty&&> = true;

template <class _Ty>
struct is_reference : bool_constant<is_reference_v<_Ty>> {};

// STRUCT TEMPLATE is_pointer
template <class>
 constexpr bool is_pointer_v = false; // determine whether _Ty is a pointer

template <class _Ty>
 constexpr bool is_pointer_v<_Ty*> = true;

template <class _Ty>
 constexpr bool is_pointer_v<_Ty* const> = true;

template <class _Ty>
 constexpr bool is_pointer_v<_Ty* volatile> = true;

template <class _Ty>
 constexpr bool is_pointer_v<_Ty* const volatile> = true;

template <class _Ty>
struct is_pointer : bool_constant<is_pointer_v<_Ty>> {};

// STRUCT TEMPLATE is_null_pointer
template <class _Ty>
 constexpr bool is_null_pointer_v =
    is_same_v<remove_cv_t<_Ty>, nullptr_t>; // determine whether _Ty is cv-qualified nullptr_t

template <class _Ty>
struct is_null_pointer : bool_constant<is_null_pointer_v<_Ty>> {};

// STRUCT TEMPLATE is_union
template <class _Ty>
struct is_union : bool_constant<__is_union(_Ty)> {}; // determine whether _Ty is a union

template <class _Ty>
 constexpr bool is_union_v = __is_union(_Ty);

// STRUCT TEMPLATE is_class
template <class _Ty>
struct is_class : bool_constant<__is_class(_Ty)> {}; // determine whether _Ty is a class

template <class _Ty>
 constexpr bool is_class_v = __is_class(_Ty);

// STRUCT TEMPLATE is_fundamental
template <class _Ty>
 constexpr bool is_fundamental_v = is_arithmetic_v<_Ty> || is_void_v<_Ty> || is_null_pointer_v<_Ty>;

template <class _Ty>
struct is_fundamental : bool_constant<is_fundamental_v<_Ty>> {}; // determine whether _Ty is a fundamental type

// STRUCT TEMPLATE is_convertible
template <class _From, class _To>
struct is_convertible : bool_constant<__is_convertible_to(_From, _To)> {
    // determine whether _From is convertible to _To
};

template <class _From, class _To>
 constexpr bool is_convertible_v = __is_convertible_to(_From, _To);

// STRUCT TEMPLATE is_enum
template <class _Ty>
struct is_enum : bool_constant<__is_enum(_Ty)> {}; // determine whether _Ty is an enumerated type

template <class _Ty>
 constexpr bool is_enum_v = __is_enum(_Ty);

// STRUCT TEMPLATE is_compound
template <class _Ty>
struct is_compound : bool_constant<!is_fundamental_v<_Ty>> {}; // determine whether _Ty is a compound type

template <class _Ty>
 constexpr bool is_compound_v = !is_fundamental_v<_Ty>;

// STRUCT TEMPLATE _Arg_types
template <class... _Types>
struct _Arg_types {}; // provide argument_type, etc. when sizeof...(_Types) is 1 or 2

template <class _Ty1>
struct _Arg_types<_Ty1> {
     typedef _Ty1 argument_type;
};

template <class _Ty1, class _Ty2>
struct _Arg_types<_Ty1, _Ty2> {
     typedef _Ty1 first_argument_type;
     typedef _Ty2 second_argument_type;
};

// STRUCT TEMPLATE is_member_function_pointer
template <class _Ty>
struct _Is_memfunptr { // base class for member function pointer predicates
    using _Bool_type = false_type; // NB: members are user-visible via _Weak_types
};











template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__cdecl _Arg0::*)(_Types...)   > : _Arg_types< _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int , int&&>, _Ret(_Types...)>; };     template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__vectorcall _Arg0::*)(_Types...)   > : _Arg_types< _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int , int&&>, _Ret(_Types...)>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__cdecl _Arg0::*)(_Types...) const  > : _Arg_types<const _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int , int&&>, _Ret(_Types...)>; };     template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__vectorcall _Arg0::*)(_Types...) const  > : _Arg_types<const _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int , int&&>, _Ret(_Types...)>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__cdecl _Arg0::*)(_Types...) volatile  > : _Arg_types<volatile _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int , int&&>, _Ret(_Types...)>; };     template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__vectorcall _Arg0::*)(_Types...) volatile  > : _Arg_types<volatile _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int , int&&>, _Ret(_Types...)>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__cdecl _Arg0::*)(_Types...) const volatile  > : _Arg_types<const volatile _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int , int&&>, _Ret(_Types...)>; };     template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__vectorcall _Arg0::*)(_Types...) const volatile  > : _Arg_types<const volatile _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int , int&&>, _Ret(_Types...)>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__cdecl _Arg0::*)(_Types...)  & > : _Arg_types< _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &, int&&>, _Ret(_Types...)>; };     template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__vectorcall _Arg0::*)(_Types...)  & > : _Arg_types< _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &, int&&>, _Ret(_Types...)>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__cdecl _Arg0::*)(_Types...) const & > : _Arg_types<const _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &, int&&>, _Ret(_Types...)>; };     template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__vectorcall _Arg0::*)(_Types...) const & > : _Arg_types<const _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &, int&&>, _Ret(_Types...)>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__cdecl _Arg0::*)(_Types...) volatile & > : _Arg_types<volatile _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &, int&&>, _Ret(_Types...)>; };     template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__vectorcall _Arg0::*)(_Types...) volatile & > : _Arg_types<volatile _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &, int&&>, _Ret(_Types...)>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__cdecl _Arg0::*)(_Types...) const volatile & > : _Arg_types<const volatile _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &, int&&>, _Ret(_Types...)>; };     template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__vectorcall _Arg0::*)(_Types...) const volatile & > : _Arg_types<const volatile _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &, int&&>, _Ret(_Types...)>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__cdecl _Arg0::*)(_Types...)  && > : _Arg_types< _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &&, int&&>, _Ret(_Types...)>; };     template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__vectorcall _Arg0::*)(_Types...)  && > : _Arg_types< _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &&, int&&>, _Ret(_Types...)>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__cdecl _Arg0::*)(_Types...) const && > : _Arg_types<const _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &&, int&&>, _Ret(_Types...)>; };     template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__vectorcall _Arg0::*)(_Types...) const && > : _Arg_types<const _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &&, int&&>, _Ret(_Types...)>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__cdecl _Arg0::*)(_Types...) volatile && > : _Arg_types<volatile _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &&, int&&>, _Ret(_Types...)>; };     template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__vectorcall _Arg0::*)(_Types...) volatile && > : _Arg_types<volatile _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &&, int&&>, _Ret(_Types...)>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__cdecl _Arg0::*)(_Types...) const volatile && > : _Arg_types<const volatile _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &&, int&&>, _Ret(_Types...)>; };     template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (__vectorcall _Arg0::*)(_Types...) const volatile && > : _Arg_types<const volatile _Arg0*, _Types...> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<!is_same_v<int &&, int&&>, _Ret(_Types...)>; };












template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) > { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<false>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) const> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<false>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) volatile> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<false>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) const volatile> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<false>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) &> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<false>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) const&> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<false>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) volatile&> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<false>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) const volatile&> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<false>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) &&> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<false>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) const&&> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<false>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) volatile&&> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<false>; }; template <class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) const volatile&&> { using _Bool_type = true_type;  typedef _Ret result_type; using _Class_type = _Arg0; using _Guide_type = enable_if<false>; };






template <class _Ty>
 constexpr bool is_member_function_pointer_v = _Is_memfunptr<remove_cv_t<_Ty>>::_Bool_type::value;
#line 430 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

template <class _Ty>
struct is_member_function_pointer : bool_constant<is_member_function_pointer_v<_Ty>> {};

// STRUCT TEMPLATE is_const
template <class>
 constexpr bool is_const_v = false; // determine whether type argument is const qualified

template <class _Ty>
 constexpr bool is_const_v<const _Ty> = true;

template <class _Ty>
struct is_const : bool_constant<is_const_v<_Ty>> {};

// STRUCT TEMPLATE is_volatile
template <class>
 constexpr bool is_volatile_v = false; // determine whether type argument is volatile qualified

template <class _Ty>
 constexpr bool is_volatile_v<volatile _Ty> = true;

template <class _Ty>
struct is_volatile : bool_constant<is_volatile_v<_Ty>> {};

// STRUCT TEMPLATE is_function
template <class _Ty>
 constexpr bool is_function_v = // only function types and reference types can't be const qualified
    !is_const_v<const _Ty> && !is_reference_v<_Ty>;

template <class _Ty>
struct is_function : bool_constant<is_function_v<_Ty>> {};

// STRUCT TEMPLATE is_object
template <class _Ty>
 constexpr bool is_object_v = // only function types and reference types can't be const qualified
    is_const_v<const _Ty> && !is_void_v<_Ty>;

template <class _Ty>
struct is_object : bool_constant<is_object_v<_Ty>> {};

// STRUCT TEMPLATE is_member_object_pointer
template <class>
struct _Is_member_object_pointer {
    static constexpr bool value = false;
};

template <class _Ty1, class _Ty2>
struct _Is_member_object_pointer<_Ty1 _Ty2::*> {
    static constexpr bool value = !is_function_v<_Ty1>;
    using _Class_type           = _Ty2;
};





template <class _Ty>
 constexpr bool is_member_object_pointer_v = _Is_member_object_pointer<remove_cv_t<_Ty>>::value;
#line 489 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

template <class _Ty>
struct is_member_object_pointer : bool_constant<is_member_object_pointer_v<_Ty>> {};

// STRUCT TEMPLATE is_member_pointer




template <class _Ty>
 constexpr bool is_member_pointer_v = is_member_object_pointer_v<_Ty> || is_member_function_pointer_v<_Ty>;
#line 501 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

template <class _Ty>
struct is_member_pointer : bool_constant<is_member_pointer_v<_Ty>> {}; // determine whether _Ty is a pointer to member

// STRUCT TEMPLATE is_scalar
template <class _Ty>
 constexpr bool is_scalar_v = // determine whether _Ty is a scalar type
    is_arithmetic_v<_Ty> || is_enum_v<_Ty> || is_pointer_v<_Ty> || is_member_pointer_v<_Ty> || is_null_pointer_v<_Ty>;

template <class _Ty>
struct is_scalar : bool_constant<is_scalar_v<_Ty>> {};

// STRUCT TEMPLATE is_pod
template <class _Ty>
struct  is_pod : bool_constant<__is_pod(_Ty)> {}; // determine whether _Ty is a POD type

template <class _Ty>
  constexpr bool is_pod_v = __is_pod(_Ty);

// STRUCT TEMPLATE is_empty
template <class _Ty>
struct is_empty : bool_constant<__is_empty(_Ty)> {}; // determine whether _Ty is an empty class

template <class _Ty>
 constexpr bool is_empty_v = __is_empty(_Ty);

// STRUCT TEMPLATE is_polymorphic
template <class _Ty>
struct is_polymorphic : bool_constant<__is_polymorphic(_Ty)> {}; // determine whether _Ty is a polymorphic type

template <class _Ty>
 constexpr bool is_polymorphic_v = __is_polymorphic(_Ty);

// STRUCT TEMPLATE is_abstract
template <class _Ty>
struct is_abstract : bool_constant<__is_abstract(_Ty)> {}; // determine whether _Ty is an abstract class

template <class _Ty>
 constexpr bool is_abstract_v = __is_abstract(_Ty);

// STRUCT TEMPLATE is_final
template <class _Ty>
struct is_final : bool_constant<__is_final(_Ty)> {}; // determine whether _Ty is a final class

template <class _Ty>
 constexpr bool is_final_v = __is_final(_Ty);

// STRUCT TEMPLATE is_standard_layout
template <class _Ty>
struct is_standard_layout : bool_constant<__is_standard_layout(_Ty)> {}; // determine whether _Ty is standard layout

template <class _Ty>
 constexpr bool is_standard_layout_v = __is_standard_layout(_Ty);


// STRUCT TEMPLATE is_literal_type
template <class _Ty>
struct  is_literal_type : bool_constant<__is_literal_type(_Ty)> {
    // determine whether _Ty is a literal type
};

template <class _Ty>
  constexpr bool is_literal_type_v = __is_literal_type(_Ty);
#line 565 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

// STRUCT TEMPLATE is_trivial

template <class _Ty>
struct is_trivial : bool_constant<__is_trivially_constructible(_Ty) && __is_trivially_copyable(_Ty)> {
    // determine whether _Ty is a trivial type
};

template <class _Ty>
 constexpr bool is_trivial_v = __is_trivially_constructible(_Ty) && __is_trivially_copyable(_Ty);






#line 582 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

// STRUCT TEMPLATE is_trivially_copyable
template <class _Ty>
struct is_trivially_copyable : bool_constant<__is_trivially_copyable(_Ty)> {
    // determine whether _Ty is a trivially copyable type
};

template <class _Ty>
 constexpr bool is_trivially_copyable_v = __is_trivially_copyable(_Ty);

// STRUCT TEMPLATE has_virtual_destructor
template <class _Ty>
struct has_virtual_destructor : bool_constant<__has_virtual_destructor(_Ty)> {
    // determine whether _Ty has a virtual destructor
};

template <class _Ty>
 constexpr bool has_virtual_destructor_v = __has_virtual_destructor(_Ty);

















#line 618 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

// CONSTRUCTIBLE/ASSIGNABLE TRAITS
// STRUCT TEMPLATE is_constructible
template <class _Ty, class... _Args>
struct is_constructible : bool_constant<__is_constructible(_Ty, _Args...)> {
    // determine whether _Ty can be direct-initialized with _Args...
};

template <class _Ty, class... _Args>
 constexpr bool is_constructible_v = __is_constructible(_Ty, _Args...);

// STRUCT TEMPLATE is_copy_constructible
template <class _Ty>
struct is_copy_constructible : bool_constant<__is_constructible(_Ty, add_lvalue_reference_t<const _Ty>)> {
    // determine whether _Ty can be direct-initialized with an lvalue const _Ty
};

template <class _Ty>
 constexpr bool is_copy_constructible_v = __is_constructible(_Ty, add_lvalue_reference_t<const _Ty>);

// STRUCT TEMPLATE is_default_constructible
template <class _Ty>
struct is_default_constructible : bool_constant<__is_constructible(_Ty)> {
    // determine whether _Ty can be value-initialized
};

template <class _Ty>
 constexpr bool is_default_constructible_v = __is_constructible(_Ty);

// STRUCT TEMPLATE _Is_implicitly_default_constructible
template <class _Ty, class = void>
struct _Is_implicitly_default_constructible : false_type {
    // determine whether _Ty can be copy-initialized with {}
};

template <class _Ty>
void _Implicitly_default_construct(const _Ty&);

template <class _Ty>
struct _Is_implicitly_default_constructible<_Ty, void_t<decltype(_Implicitly_default_construct<_Ty>({}))>> : true_type {
};

// STRUCT TEMPLATE is_move_constructible
template <class _Ty>
struct is_move_constructible : bool_constant<__is_constructible(_Ty, _Ty)> {
    // determine whether _Ty can be direct-initialized from an rvalue _Ty
};

template <class _Ty>
 constexpr bool is_move_constructible_v = __is_constructible(_Ty, _Ty);

// STRUCT TEMPLATE is_assignable
template <class _To, class _From>
struct is_assignable : bool_constant<__is_assignable(_To, _From)> {}; // determine whether _From can be assigned to _To

template <class _To, class _From>
 constexpr bool is_assignable_v = __is_assignable(_To, _From);

// STRUCT TEMPLATE is_copy_assignable
template <class _Ty>
struct is_copy_assignable
    : bool_constant<__is_assignable(add_lvalue_reference_t<_Ty>, add_lvalue_reference_t<const _Ty>)> {
    // determine whether an lvalue const _Ty can be assigned to an lvalue _Ty
};

template <class _Ty>
 constexpr bool is_copy_assignable_v = __is_assignable(
    add_lvalue_reference_t<_Ty>, add_lvalue_reference_t<const _Ty>);


template <class _Ty>
struct _Is_copy_assignable_no_precondition_check
    : bool_constant<__is_assignable_no_precondition_check(
          add_lvalue_reference_t<_Ty>, add_lvalue_reference_t<const _Ty>)> {};

template <class _Ty>
 constexpr bool _Is_copy_assignable_unchecked_v = __is_assignable_no_precondition_check(
    add_lvalue_reference_t<_Ty>, add_lvalue_reference_t<const _Ty>);






#line 703 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

// STRUCT TEMPLATE is_move_assignable
template <class _Ty>
struct is_move_assignable : bool_constant<__is_assignable(add_lvalue_reference_t<_Ty>, _Ty)> {
    // determine whether an rvalue _Ty can be assigned to an lvalue _Ty
};

template <class _Ty>
 constexpr bool is_move_assignable_v = __is_assignable(add_lvalue_reference_t<_Ty>, _Ty);


template <class _Ty>
struct _Is_move_assignable_no_precondition_check
    : bool_constant<__is_assignable_no_precondition_check(add_lvalue_reference_t<_Ty>, _Ty)> {};

template <class _Ty>
 constexpr bool _Is_move_assignable_unchecked_v = __is_assignable_no_precondition_check(
    add_lvalue_reference_t<_Ty>, _Ty);






#line 728 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

// STRUCT TEMPLATE is_destructible
template <class _Ty>
struct is_destructible : bool_constant<__is_destructible(_Ty)> {
    // true iff remove_all_extents_t<_Ty> is a reference type, or can be explicitly destroyed
};

template <class _Ty>
 constexpr bool is_destructible_v = __is_destructible(_Ty);

// TRIVIAL TRAITS
// STRUCT TEMPLATE is_trivially_constructible
template <class _Ty, class... _Args>
struct is_trivially_constructible : bool_constant<__is_trivially_constructible(_Ty, _Args...)> {
    // determine whether direct-initialization of _Ty with _Args... is trivial
};

template <class _Ty, class... _Args>
 constexpr bool is_trivially_constructible_v = __is_trivially_constructible(_Ty, _Args...);

// STRUCT TEMPLATE is_trivially_copy_constructible
template <class _Ty>
struct is_trivially_copy_constructible
    : bool_constant<__is_trivially_constructible(_Ty, add_lvalue_reference_t<const _Ty>)> {
    // determine whether direct-initialization of _Ty with an lvalue const _Ty is trivial
};

template <class _Ty>
 constexpr bool is_trivially_copy_constructible_v = __is_trivially_constructible(
    _Ty, add_lvalue_reference_t<const _Ty>);

// STRUCT TEMPLATE is_trivially_default_constructible
template <class _Ty>
struct is_trivially_default_constructible : bool_constant<__is_trivially_constructible(_Ty)> {
    // determine whether value-initialization of _Ty is trivial
};

template <class _Ty>
 constexpr bool is_trivially_default_constructible_v = __is_trivially_constructible(_Ty);

// STRUCT TEMPLATE is_trivially_move_constructible
template <class _Ty>
struct is_trivially_move_constructible : bool_constant<__is_trivially_constructible(_Ty, _Ty)> {
    // determine whether direct-initialization of _Ty with an rvalue _Ty is trivial
};

template <class _Ty>
 constexpr bool is_trivially_move_constructible_v = __is_trivially_constructible(_Ty, _Ty);

// STRUCT TEMPLATE is_trivially_assignable
template <class _To, class _From>
struct is_trivially_assignable : bool_constant<__is_trivially_assignable(_To, _From)> {
    // determine whether _From can be trivially assigned to _To
};

template <class _To, class _From>
 constexpr bool is_trivially_assignable_v = __is_trivially_assignable(_To, _From);

// STRUCT TEMPLATE is_trivially_copy_assignable
template <class _Ty>
struct is_trivially_copy_assignable
    : bool_constant<__is_trivially_assignable(add_lvalue_reference_t<_Ty>, add_lvalue_reference_t<const _Ty>)> {
    // determine whether an lvalue const _Ty can be trivially assigned to an lvalue _Ty
};

template <class _Ty>
 constexpr bool is_trivially_copy_assignable_v = __is_trivially_assignable(
    add_lvalue_reference_t<_Ty>, add_lvalue_reference_t<const _Ty>);

// STRUCT TEMPLATE is_trivially_move_assignable
template <class _Ty>
struct is_trivially_move_assignable : bool_constant<__is_trivially_assignable(add_lvalue_reference_t<_Ty>, _Ty)> {
    // determine whether an rvalue _Ty can be trivially assigned to an lvalue _Ty
};

template <class _Ty>
 constexpr bool is_trivially_move_assignable_v = __is_trivially_assignable(add_lvalue_reference_t<_Ty>, _Ty);

// STRUCT TEMPLATE is_trivially_destructible
template <class _Ty>
struct is_trivially_destructible : bool_constant<__is_trivially_destructible(_Ty)> {
    // determine whether remove_all_extents_t<_Ty> is a reference type or can trivially be explicitly destroyed
};

template <class _Ty>
 constexpr bool is_trivially_destructible_v = __is_trivially_destructible(_Ty);

// NOTHROW TRAITS
// STRUCT TEMPLATE is_nothrow_constructible
template <class _Ty, class... _Args>
struct is_nothrow_constructible : bool_constant<__is_nothrow_constructible(_Ty, _Args...)> {
    // determine whether direct-initialization of _Ty from _Args... is both valid and not potentially-throwing
};

template <class _Ty, class... _Args>
 constexpr bool is_nothrow_constructible_v = __is_nothrow_constructible(_Ty, _Args...);

// STRUCT TEMPLATE is_nothrow_copy_constructible
template <class _Ty>
struct is_nothrow_copy_constructible
    : bool_constant<__is_nothrow_constructible(_Ty, add_lvalue_reference_t<const _Ty>)> {
    // determine whether direct-initialization of _Ty from an lvalue const _Ty is both valid
    // and not potentially-throwing
};

template <class _Ty>
 constexpr bool is_nothrow_copy_constructible_v = __is_nothrow_constructible(
    _Ty, add_lvalue_reference_t<const _Ty>);

// STRUCT TEMPLATE is_nothrow_default_constructible
template <class _Ty>
struct is_nothrow_default_constructible : bool_constant<__is_nothrow_constructible(_Ty)> {
    // determine whether value-initialization of _Ty is both valid and not potentially-throwing
};

template <class _Ty>
 constexpr bool is_nothrow_default_constructible_v = __is_nothrow_constructible(_Ty);

// STRUCT TEMPLATE is_nothrow_move_constructible
template <class _Ty>
struct is_nothrow_move_constructible : bool_constant<__is_nothrow_constructible(_Ty, _Ty)> {
    // determine whether direct-initialization of _Ty from an rvalue _Ty is both valid and not potentially-throwing
};

template <class _Ty>
 constexpr bool is_nothrow_move_constructible_v = __is_nothrow_constructible(_Ty, _Ty);

// STRUCT TEMPLATE is_nothrow_assignable
template <class _To, class _From>
struct is_nothrow_assignable : bool_constant<__is_nothrow_assignable(_To, _From)> {
    // determine whether assignment of _From to _To is both valid and not potentially-throwing
};

template <class _To, class _From>
 constexpr bool is_nothrow_assignable_v = __is_nothrow_assignable(_To, _From);

// STRUCT TEMPLATE is_nothrow_copy_assignable
template <class _Ty>
struct is_nothrow_copy_assignable
    : bool_constant<__is_nothrow_assignable(add_lvalue_reference_t<_Ty>, add_lvalue_reference_t<const _Ty>)> {
    // determine whether assignment of an lvalue const _Ty to an lvalue _Ty is both valid and not potentially-throwing
};

template <class _Ty>
 constexpr bool is_nothrow_copy_assignable_v = __is_nothrow_assignable(
    add_lvalue_reference_t<_Ty>, add_lvalue_reference_t<const _Ty>);

// STRUCT TEMPLATE is_nothrow_move_assignable
template <class _Ty>
struct is_nothrow_move_assignable : bool_constant<__is_nothrow_assignable(add_lvalue_reference_t<_Ty>, _Ty)> {
    // determine whether assignment of an rvalue _Ty to an lvalue _Ty is both valid and not potentially-throwing
};

template <class _Ty>
 constexpr bool is_nothrow_move_assignable_v = __is_nothrow_assignable(add_lvalue_reference_t<_Ty>, _Ty);

// STRUCT TEMPLATE is_nothrow_destructible
template <class _Ty>
struct is_nothrow_destructible : bool_constant<__is_nothrow_destructible(_Ty)> {
    // determine whether remove_all_extents_t<_Ty> is a reference type or has
    // non-potentially-throwing explicit destruction
};

template <class _Ty>
 constexpr bool is_nothrow_destructible_v = __is_nothrow_destructible(_Ty);

// STRUCT TEMPLATE is_signed
template <class _Ty, bool = is_integral_v<_Ty>>
struct _Sign_base { // determine whether integral type _Ty is signed or unsigned
    using _Uty = remove_cv_t<_Ty>;

    static constexpr bool _Signed   = static_cast<_Uty>(-1) < static_cast<_Uty>(0);
    static constexpr bool _Unsigned = !_Signed;
};

template <class _Ty>
struct _Sign_base<_Ty, false> { // floating-point _Ty is signed
                                // non-arithmetic _Ty is neither signed nor unsigned
    static constexpr bool _Signed   = is_floating_point_v<_Ty>;
    static constexpr bool _Unsigned = false;
};

template <class _Ty>
struct is_signed : bool_constant<_Sign_base<_Ty>::_Signed> {}; // determine whether _Ty is a signed type

template <class _Ty>
 constexpr bool is_signed_v = _Sign_base<_Ty>::_Signed;

// STRUCT TEMPLATE is_unsigned
template <class _Ty>
struct is_unsigned : bool_constant<_Sign_base<_Ty>::_Unsigned> {}; // determine whether _Ty is an unsigned type

template <class _Ty>
 constexpr bool is_unsigned_v = _Sign_base<_Ty>::_Unsigned;

// VARIABLE TEMPLATE _Is_nonbool_integral
template <class _Ty>
 constexpr bool _Is_nonbool_integral = is_integral_v<_Ty> && !is_same_v<remove_cv_t<_Ty>, bool>;

// STRUCT TEMPLATE make_signed
template <bool>
struct _Select { // Select between aliases that extract either their first or second parameter
    template <class _Ty1, class>
    using _Apply = _Ty1;
};

template <>
struct _Select<false> {
    template <class, class _Ty2>
    using _Apply = _Ty2;
};

template <size_t>
struct _Make_signed2; // Choose make_signed strategy by type size

template <>
struct _Make_signed2<1> {
    template <class>
    using _Apply = signed char;
};

template <>
struct _Make_signed2<2> {
    template <class>
    using _Apply = short;
};

template <>
struct _Make_signed2<4> {
    template <class _Ty>
    using _Apply = // assumes LLP64
        typename _Select<is_same_v<_Ty, long> || is_same_v<_Ty, unsigned long>>::template _Apply<long, int>;
};

template <>
struct _Make_signed2<8> {
    template <class>
    using _Apply = long long;
};

template <class _Ty>
using _Make_signed1 = // signed partner to cv-unqualified _Ty
    typename _Make_signed2<sizeof(_Ty)>::template _Apply<_Ty>;

template <class _Ty>
struct make_signed { // signed partner to _Ty
    static_assert(_Is_nonbool_integral<_Ty> || is_enum_v<_Ty>,
        "make_signed<T> requires that T shall be a (possibly cv-qualified) "
        "integral type or enumeration but not a bool type.");

    using type = typename remove_cv<_Ty>::template _Apply<_Make_signed1>;
};

template <class _Ty>
using make_signed_t = typename make_signed<_Ty>::type;

// STRUCT TEMPLATE make_unsigned
template <size_t>
struct _Make_unsigned2; // Choose make_unsigned strategy by type size

template <>
struct _Make_unsigned2<1> {
    template <class>
    using _Apply = unsigned char;
};

template <>
struct _Make_unsigned2<2> {
    template <class>
    using _Apply = unsigned short;
};

template <>
struct _Make_unsigned2<4> {
    template <class _Ty>
    using _Apply = // assumes LLP64
        typename _Select<is_same_v<_Ty, long> || is_same_v<_Ty, unsigned long>>::template _Apply<unsigned long,
            unsigned int>;
};

template <>
struct _Make_unsigned2<8> {
    template <class>
    using _Apply = unsigned long long;
};

template <class _Ty>
using _Make_unsigned1 = // unsigned partner to cv-unqualified _Ty
    typename _Make_unsigned2<sizeof(_Ty)>::template _Apply<_Ty>;

template <class _Ty>
struct make_unsigned { // unsigned partner to _Ty
    static_assert(_Is_nonbool_integral<_Ty> || is_enum_v<_Ty>,
        "make_unsigned<T> requires that T shall be a (possibly cv-qualified) "
        "integral type or enumeration but not a bool type.");

    using type = typename remove_cv<_Ty>::template _Apply<_Make_unsigned1>;
};

template <class _Ty>
using make_unsigned_t = typename make_unsigned<_Ty>::type;

// FUNCTION TEMPLATE _Unsigned_value
template <class _Rep>
constexpr make_unsigned_t<_Rep> _Unsigned_value(_Rep _Val) { // makes _Val unsigned
    return static_cast<make_unsigned_t<_Rep>>(_Val);
}

// STRUCT TEMPLATE alignment_of
template <class _Ty>
struct alignment_of : integral_constant<size_t, alignof(_Ty)> {}; // determine alignment of _Ty

template <class _Ty>
 constexpr size_t alignment_of_v = alignof(_Ty);

// STRUCT TEMPLATE aligned_storage
template <class _Ty, size_t _Len>
union _Align_type { // union with size _Len bytes and alignment of _Ty
    _Ty _Val;
    char _Pad[_Len];
};

template <size_t _Len, size_t _Align, class _Ty, bool _Ok>
struct _Aligned; // define type with size _Len and alignment _Ty

template <size_t _Len, size_t _Align, class _Ty>
struct _Aligned<_Len, _Align, _Ty, true> {
    using type = _Align_type<_Ty, _Len>;
};

template <size_t _Len, size_t _Align>
struct _Aligned<_Len, _Align, double, false> {






    static_assert(_Always_false<_Aligned>,
        "You've instantiated std::aligned_storage<Len, Align> with an extended alignment (in other "
        "words, Align > alignof(max_align_t)). Before VS 2017 15.8, the member \"type\" would "
        "non-conformingly have an alignment of only alignof(max_align_t). VS 2017 15.8 was fixed to "
        "handle this correctly, but the fix inherently changes layout and breaks binary compatibility "
        "(*only* for uses of aligned_storage with extended alignments). "
        "Please define either "
        "(1) _ENABLE_EXTENDED_ALIGNED_STORAGE to acknowledge that you understand this message and "
        "that you actually want a type with an extended alignment, or "
        "(2) _DISABLE_EXTENDED_ALIGNED_STORAGE to silence this message and get the old non-conforming "
        "behavior.");
#line 1078 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"
    using type = _Align_type<max_align_t, _Len>;
#line 1080 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"
};

template <size_t _Len, size_t _Align>
struct _Aligned<_Len, _Align, int, false> {
    using _Next                 = double;
    static constexpr bool _Fits = _Align <= alignof(_Next);
    using type                  = typename _Aligned<_Len, _Align, _Next, _Fits>::type;
};

template <size_t _Len, size_t _Align>
struct _Aligned<_Len, _Align, short, false> {
    using _Next                 = int;
    static constexpr bool _Fits = _Align <= alignof(_Next);
    using type                  = typename _Aligned<_Len, _Align, _Next, _Fits>::type;
};

template <size_t _Len, size_t _Align>
struct _Aligned<_Len, _Align, char, false> {
    using _Next                 = short;
    static constexpr bool _Fits = _Align <= alignof(_Next);
    using type                  = typename _Aligned<_Len, _Align, _Next, _Fits>::type;
};

template <size_t _Len, size_t _Align = alignof(max_align_t)>
struct aligned_storage { // define type with size _Len and alignment _Align
    using _Next                 = char;
    static constexpr bool _Fits = _Align <= alignof(_Next);
    using type                  = typename _Aligned<_Len, _Align, _Next, _Fits>::type;
};

template <size_t _Len, size_t _Align = alignof(max_align_t)>
using aligned_storage_t = typename aligned_storage<_Len, _Align>::type;

// STRUCT TEMPLATE aligned_union
template <size_t... _Vals>
struct _Maximum;

template <>
struct _Maximum<> : integral_constant<size_t, 0> {}; // maximum of nothing is 0

template <size_t _Val>
struct _Maximum<_Val> : integral_constant<size_t, _Val> {}; // maximum of _Val is _Val

template <size_t _First, size_t _Second, size_t... _Rest>
struct _Maximum<_First, _Second, _Rest...> : _Maximum<(_First < _Second ? _Second : _First), _Rest...>::type {
    // find maximum value in _First, _Second, _Rest...
};

template <size_t _Len, class... _Types>
struct aligned_union { // define type with size at least _Len, for storing anything in _Types
    static constexpr size_t _Max_len        = _Maximum<_Len, sizeof(_Types)...>::value; // NOT sizeof...(_Types)
    static constexpr size_t alignment_value = _Maximum<alignof(_Types)...>::value;

    using type = aligned_storage_t<_Max_len, alignment_value>;
};

template <size_t _Len, class... _Types>
using aligned_union_t = typename aligned_union<_Len, _Types...>::type;

// STRUCT TEMPLATE underlying_type
template <class _Ty, bool = is_enum_v<_Ty>>
struct _Underlying_type {
    using type = __underlying_type(_Ty);
};

template <class _Ty>
struct _Underlying_type<_Ty, false> {};

template <class _Ty>
struct underlying_type : _Underlying_type<_Ty> {}; // determine underlying type for enum

template <class _Ty>
using underlying_type_t = typename _Underlying_type<_Ty>::type;

// STRUCT TEMPLATE rank
template <class _Ty>
 constexpr size_t rank_v = 0; // determine number of dimensions of array _Ty

template <class _Ty, size_t _Nx>
 constexpr size_t rank_v<_Ty[_Nx]> = rank_v<_Ty> + 1;

template <class _Ty>
 constexpr size_t rank_v<_Ty[]> = rank_v<_Ty> + 1;

template <class _Ty>
struct rank : integral_constant<size_t, rank_v<_Ty>> {};

// STRUCT TEMPLATE extent
template <class _Ty, unsigned int _Ix = 0>
 constexpr size_t extent_v = 0; // determine extent of dimension _Ix of array _Ty

template <class _Ty, size_t _Nx>
 constexpr size_t extent_v<_Ty[_Nx], 0> = _Nx;

template <class _Ty, unsigned int _Ix, size_t _Nx>
 constexpr size_t extent_v<_Ty[_Nx], _Ix> = extent_v<_Ty, _Ix - 1>;

template <class _Ty, unsigned int _Ix>
 constexpr size_t extent_v<_Ty[], _Ix> = extent_v<_Ty, _Ix - 1>;

template <class _Ty, unsigned int _Ix = 0>
struct extent : integral_constant<size_t, extent_v<_Ty, _Ix>> {};

// STRUCT TEMPLATE is_base_of
template <class _Base, class _Derived>
struct is_base_of : bool_constant<__is_base_of(_Base, _Derived)> {
    // determine whether _Base is a base of or the same as _Derived
};

template <class _Base, class _Derived>
 constexpr bool is_base_of_v = __is_base_of(_Base, _Derived);

// STRUCT TEMPLATE decay
template <class _Ty>
struct decay { // determines decayed version of _Ty
    using _Ty1 = remove_reference_t<_Ty>;
    using _Ty2 = typename _Select<is_function_v<_Ty1>>::template _Apply<add_pointer<_Ty1>, remove_cv<_Ty1>>;
    using type = typename _Select<is_array_v<_Ty1>>::template _Apply<add_pointer<remove_extent_t<_Ty1>>, _Ty2>::type;
};

template <class _Ty>
using decay_t = typename decay<_Ty>::type;

// ALIAS TEMPLATE _Conditional_type
template <class _Ty1, class _Ty2>
using _Conditional_type = decltype(false ? ::std:: declval<_Ty1>() : ::std:: declval<_Ty2>());

// STRUCT TEMPLATE common_type













#line 1222 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"
template <class _Ty1, class _Ty2, class = void>
struct _Decayed_cond_oper {};
#line 1225 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

template <class _Ty1, class _Ty2>
struct _Decayed_cond_oper<_Ty1, _Ty2, void_t<_Conditional_type<_Ty1, _Ty2>>> {
    using type = decay_t<_Conditional_type<_Ty1, _Ty2>>;
};

template <class... _Ty>
struct common_type;

template <class... _Ty>
using common_type_t = typename common_type<_Ty...>::type;

template <>
struct common_type<> {};

template <class _Ty1>
struct common_type<_Ty1> : common_type<_Ty1, _Ty1> {};

template <class _Ty1, class _Ty2, class _Decayed1 = decay_t<_Ty1>, class _Decayed2 = decay_t<_Ty2>>
struct _Common_type2 : common_type<_Decayed1, _Decayed2> {};

template <class _Ty1, class _Ty2>
struct _Common_type2<_Ty1, _Ty2, _Ty1, _Ty2> : _Decayed_cond_oper<_Ty1, _Ty2> {};

template <class _Ty1, class _Ty2>
struct common_type<_Ty1, _Ty2> : _Common_type2<_Ty1, _Ty2> {};

template <class _Void, class _Ty1, class _Ty2, class... _Rest>
struct _Common_type3 {};

template <class _Ty1, class _Ty2, class... _Rest>
struct _Common_type3<void_t<common_type_t<_Ty1, _Ty2>>, _Ty1, _Ty2, _Rest...>
    : common_type<common_type_t<_Ty1, _Ty2>, _Rest...> {};

template <class _Ty1, class _Ty2, class... _Rest>
struct common_type<_Ty1, _Ty2, _Rest...> : _Common_type3<void, _Ty1, _Ty2, _Rest...> {};






















































































































































#line 1412 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

// STRUCT TEMPLATE _Identity
template <class _Ty>
struct _Identity {
    using type = _Ty;
};
template <class _Ty>
using _Identity_t = typename _Identity<_Ty>::type;









#line 1430 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

// STRUCT TEMPLATE _Is_specialization
template <class _Type, template <class...> class _Template>
 constexpr bool _Is_specialization_v = false; // true if and only if _Type is a specialization of _Template
template <template <class...> class _Template, class... _Types>
 constexpr bool _Is_specialization_v<_Template<_Types...>, _Template> = true;

template <class _Type, template <class...> class _Template>
struct _Is_specialization : bool_constant<_Is_specialization_v<_Type, _Template>> {};

// FUNCTION TEMPLATE forward
template <class _Ty>
[[nodiscard]] constexpr _Ty&& forward(
    remove_reference_t<_Ty>& _Arg) noexcept { // forward an lvalue as either an lvalue or an rvalue
    return static_cast<_Ty&&>(_Arg);
}

template <class _Ty>
[[nodiscard]] constexpr _Ty&& forward(remove_reference_t<_Ty>&& _Arg) noexcept { // forward an rvalue as an rvalue
    static_assert(!is_lvalue_reference_v<_Ty>, "bad forward call");
    return static_cast<_Ty&&>(_Arg);
}

// FUNCTION TEMPLATE move
template <class _Ty>
[[nodiscard]] constexpr remove_reference_t<_Ty>&& move(_Ty&& _Arg) noexcept { // forward _Arg as movable
    return static_cast<remove_reference_t<_Ty>&&>(_Arg);
}

// FUNCTION TEMPLATE move_if_noexcept
template <class _Ty>
[[nodiscard]] constexpr conditional_t<!is_nothrow_move_constructible_v<_Ty> && is_copy_constructible_v<_Ty>, const _Ty&,
    _Ty&&>
    move_if_noexcept(_Ty& _Arg) noexcept { // forward _Arg as movable, sometimes
    return ::std:: move(_Arg);
}

template <class _Ty>
class reference_wrapper;

// std::invoke isn't constexpr in C++17, and normally implementers are forbidden from "strengthening" constexpr
// (WG21-N4842 [constexpr.functions]/1), yet both std::apply and std::visit are required to be constexpr and have
// invoke-like behavior. As a result, we've chosen to apply the part of P1065R2 resolving LWG-2894 as a defect report.

// FUNCTION TEMPLATE invoke
#pragma warning(push) 
#pragma warning(disable : 28278) 
enum class _Invoker_strategy {
    _Functor,
    _Pmf_object,
    _Pmf_refwrap,
    _Pmf_pointer,
    _Pmd_object,
    _Pmd_refwrap,
    _Pmd_pointer
};

struct _Invoker_functor {
    static constexpr _Invoker_strategy _Strategy = _Invoker_strategy::_Functor;

    template <class _Callable, class... _Types>
    static constexpr auto _Call(_Callable&& _Obj, _Types&&... _Args) noexcept(
        noexcept(static_cast<_Callable&&>(_Obj)(static_cast<_Types&&>(_Args)...)))
        -> decltype(static_cast<_Callable&&>(_Obj)(static_cast<_Types&&>(_Args)...)) {
        return static_cast<_Callable&&>(_Obj)(static_cast<_Types&&>(_Args)...);
    }
};

struct _Invoker_pmf_object {
    static constexpr _Invoker_strategy _Strategy = _Invoker_strategy::_Pmf_object;

    template <class _Decayed, class _Ty1, class... _Types2>
    static constexpr auto _Call(_Decayed _Pmf, _Ty1&& _Arg1, _Types2&&... _Args2) noexcept(
        noexcept((static_cast<_Ty1&&>(_Arg1).*_Pmf)(static_cast<_Types2&&>(_Args2)...)))
        -> decltype((static_cast<_Ty1&&>(_Arg1).*_Pmf)(static_cast<_Types2&&>(_Args2)...)) {
        return (static_cast<_Ty1&&>(_Arg1).*_Pmf)(static_cast<_Types2&&>(_Args2)...);
    }
};

struct _Invoker_pmf_refwrap {
    static constexpr _Invoker_strategy _Strategy = _Invoker_strategy::_Pmf_refwrap;

    template <class _Decayed, class _Refwrap, class... _Types2>
    static constexpr auto _Call(_Decayed _Pmf, _Refwrap _Rw, _Types2&&... _Args2) noexcept(
        noexcept((_Rw.get().*_Pmf)(static_cast<_Types2&&>(_Args2)...)))
        -> decltype((_Rw.get().*_Pmf)(static_cast<_Types2&&>(_Args2)...)) {
        return (_Rw.get().*_Pmf)(static_cast<_Types2&&>(_Args2)...);
    }
};

struct _Invoker_pmf_pointer {
    static constexpr _Invoker_strategy _Strategy = _Invoker_strategy::_Pmf_pointer;

    template <class _Decayed, class _Ty1, class... _Types2>
    static constexpr auto _Call(_Decayed _Pmf, _Ty1&& _Arg1, _Types2&&... _Args2) noexcept(
        noexcept(((*static_cast<_Ty1&&>(_Arg1)).*_Pmf)(static_cast<_Types2&&>(_Args2)...)))
        -> decltype(((*static_cast<_Ty1&&>(_Arg1)).*_Pmf)(static_cast<_Types2&&>(_Args2)...)) {
        return ((*static_cast<_Ty1&&>(_Arg1)).*_Pmf)(static_cast<_Types2&&>(_Args2)...);
    }
};

struct _Invoker_pmd_object {
    static constexpr _Invoker_strategy _Strategy = _Invoker_strategy::_Pmd_object;

    template <class _Decayed, class _Ty1>
    static constexpr auto _Call(_Decayed _Pmd, _Ty1&& _Arg1) noexcept -> decltype(static_cast<_Ty1&&>(_Arg1).*_Pmd) {
        return static_cast<_Ty1&&>(_Arg1).*_Pmd;
    }
};

struct _Invoker_pmd_refwrap {
    static constexpr _Invoker_strategy _Strategy = _Invoker_strategy::_Pmd_refwrap;

    template <class _Decayed, class _Refwrap>
    static constexpr auto _Call(_Decayed _Pmd, _Refwrap _Rw) noexcept -> decltype(_Rw.get().*_Pmd) {
        return _Rw.get().*_Pmd;
    }
};

struct _Invoker_pmd_pointer {
    static constexpr _Invoker_strategy _Strategy = _Invoker_strategy::_Pmd_pointer;

    template <class _Decayed, class _Ty1>
    static constexpr auto _Call(_Decayed _Pmd, _Ty1&& _Arg1) noexcept(noexcept((*static_cast<_Ty1&&>(_Arg1)).*_Pmd))
        -> decltype((*static_cast<_Ty1&&>(_Arg1)).*_Pmd) {
        return (*static_cast<_Ty1&&>(_Arg1)).*_Pmd;
    }
};

template <class _Callable, class _Ty1, class _Removed_cvref = _Remove_cvref_t<_Callable>,
    bool _Is_pmf = is_member_function_pointer_v<_Removed_cvref>,
    bool _Is_pmd = is_member_object_pointer_v<_Removed_cvref>>
struct _Invoker1;

template <class _Callable, class _Ty1, class _Removed_cvref>
struct _Invoker1<_Callable, _Ty1, _Removed_cvref, true, false>
    : conditional_t<is_base_of_v<typename _Is_memfunptr<_Removed_cvref>::_Class_type, remove_reference_t<_Ty1>>,
          _Invoker_pmf_object,
          conditional_t<_Is_specialization_v<_Remove_cvref_t<_Ty1>, reference_wrapper>, _Invoker_pmf_refwrap,
              _Invoker_pmf_pointer>> {}; // pointer to member function

template <class _Callable, class _Ty1, class _Removed_cvref>
struct _Invoker1<_Callable, _Ty1, _Removed_cvref, false, true>
    : conditional_t<
          is_base_of_v<typename _Is_member_object_pointer<_Removed_cvref>::_Class_type, remove_reference_t<_Ty1>>,
          _Invoker_pmd_object,
          conditional_t<_Is_specialization_v<_Remove_cvref_t<_Ty1>, reference_wrapper>, _Invoker_pmd_refwrap,
              _Invoker_pmd_pointer>> {}; // pointer to member data

template <class _Callable, class _Ty1, class _Removed_cvref>
struct _Invoker1<_Callable, _Ty1, _Removed_cvref, false, false> : _Invoker_functor {};

template <class _Callable>
inline auto invoke(_Callable&& _Obj) noexcept(noexcept(static_cast<_Callable&&>(_Obj)()))
    -> decltype(static_cast<_Callable&&>(_Obj)()) {
    return static_cast<_Callable&&>(_Obj)();
}

template <class _Callable, class _Ty1, class... _Types2>
inline auto invoke(_Callable&& _Obj, _Ty1&& _Arg1, _Types2&&... _Args2) noexcept(
    noexcept(_Invoker1<_Callable, _Ty1>::_Call(
        static_cast<_Callable&&>(_Obj), static_cast<_Ty1&&>(_Arg1), static_cast<_Types2&&>(_Args2)...)))
    -> decltype(_Invoker1<_Callable, _Ty1>::_Call(
        static_cast<_Callable&&>(_Obj), static_cast<_Ty1&&>(_Arg1), static_cast<_Types2&&>(_Args2)...)) {

    if constexpr (_Invoker1<_Callable, _Ty1>::_Strategy == _Invoker_strategy::_Functor) {
        return static_cast<_Callable&&>(_Obj)(static_cast<_Ty1&&>(_Arg1), static_cast<_Types2&&>(_Args2)...);
    } else if constexpr (_Invoker1<_Callable, _Ty1>::_Strategy == _Invoker_strategy::_Pmf_object) {
        return (static_cast<_Ty1&&>(_Arg1).*_Obj)(static_cast<_Types2&&>(_Args2)...);
    } else if constexpr (_Invoker1<_Callable, _Ty1>::_Strategy == _Invoker_strategy::_Pmf_refwrap) {
        return (_Arg1.get().*_Obj)(static_cast<_Types2&&>(_Args2)...);
    } else if constexpr (_Invoker1<_Callable, _Ty1>::_Strategy == _Invoker_strategy::_Pmf_pointer) {
        return ((*static_cast<_Ty1&&>(_Arg1)).*_Obj)(static_cast<_Types2&&>(_Args2)...);
    } else if constexpr (_Invoker1<_Callable, _Ty1>::_Strategy == _Invoker_strategy::_Pmd_object) {
        return static_cast<_Ty1&&>(_Arg1).*_Obj;
    } else if constexpr (_Invoker1<_Callable, _Ty1>::_Strategy == _Invoker_strategy::_Pmd_refwrap) {
        return _Arg1.get().*_Obj;
    } else {
        static_assert(_Invoker1<_Callable, _Ty1>::_Strategy == _Invoker_strategy::_Pmd_pointer, "bug in invoke");
        return (*static_cast<_Ty1&&>(_Arg1)).*_Obj;
    }



#line 1615 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"
}
#pragma warning(pop) 

// TYPE TRAITS FOR invoke()
#pragma warning(push)
#pragma warning(disable : 4242) 
#pragma warning(disable : 4244) 
#pragma warning(disable : 4365) 
#pragma warning(disable : 5215) 






template <class _To>
void _Implicitly_convert_to(_To) noexcept; // not defined

template <class _From, class _To, bool = is_convertible_v<_From, _To>, bool = is_void_v<_To>>
 constexpr bool _Is_nothrow_convertible_v = noexcept(_Implicitly_convert_to<_To>(::std:: declval<_From>()));





#pragma warning(pop)

template <class _From, class _To, bool _IsVoid>
 constexpr bool _Is_nothrow_convertible_v<_From, _To, false, _IsVoid> = false;

template <class _From, class _To>
 constexpr bool _Is_nothrow_convertible_v<_From, _To, true, true> = true;

template <class _From, class _To>
struct _Is_nothrow_convertible : bool_constant<_Is_nothrow_convertible_v<_From, _To>> {
    // determine whether _From is nothrow-convertible to _To
};







#line 1660 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

template <class _Ty>
_Ty _Returns_exactly() noexcept; // not defined

template <class _From, class _To, class = void>
struct _Invoke_convertible : false_type {};

template <class _From, class _To>
struct _Invoke_convertible<_From, _To, void_t<decltype(_Implicitly_convert_to<_To>(_Returns_exactly<_From>()))>>
    : true_type {};

template <class _From, class _To>
struct _Invoke_nothrow_convertible : bool_constant<noexcept(_Implicitly_convert_to<_To>(_Returns_exactly<_From>()))> {};

template <class _Result, bool _Nothrow>
struct _Invoke_traits_common {
    using type                  = _Result;
    using _Is_invocable         = true_type;
    using _Is_nothrow_invocable = bool_constant<_Nothrow>;
    template <class _Rx>
    using _Is_invocable_r = bool_constant<disjunction_v<is_void<_Rx>, _Invoke_convertible<type, _Rx>>>;
    template <class _Rx>
    using _Is_nothrow_invocable_r = bool_constant<conjunction_v<_Is_nothrow_invocable,
        disjunction<is_void<_Rx>,
            conjunction<_Invoke_convertible<type, _Rx>, _Invoke_nothrow_convertible<type, _Rx>>>>>;
};

template <class _Void, class _Callable>
struct _Invoke_traits_zero {
    // selected when _Callable isn't callable with zero _Args
    using _Is_invocable         = false_type;
    using _Is_nothrow_invocable = false_type;
    template <class _Rx>
    using _Is_invocable_r = false_type;
    template <class _Rx>
    using _Is_nothrow_invocable_r = false_type;
};

template <class _Callable>
using _Decltype_invoke_zero = decltype(::std:: declval<_Callable>()());

template <class _Callable>
struct _Invoke_traits_zero<void_t<_Decltype_invoke_zero<_Callable>>, _Callable>
    : _Invoke_traits_common<_Decltype_invoke_zero<_Callable>, noexcept(::std:: declval<_Callable>()())> {};

template <class _Void, class... _Types>
struct _Invoke_traits_nonzero {
    // selected when _Callable isn't callable with nonzero _Args
    using _Is_invocable         = false_type;
    using _Is_nothrow_invocable = false_type;
    template <class _Rx>
    using _Is_invocable_r = false_type;
    template <class _Rx>
    using _Is_nothrow_invocable_r = false_type;
};

template <class _Callable, class _Ty1, class... _Types2>
using _Decltype_invoke_nonzero = decltype(
    _Invoker1<_Callable, _Ty1>::_Call(::std:: declval<_Callable>(), ::std:: declval<_Ty1>(), ::std:: declval<_Types2>()...));

template <class _Callable, class _Ty1, class... _Types2>
struct _Invoke_traits_nonzero<void_t<_Decltype_invoke_nonzero<_Callable, _Ty1, _Types2...>>, _Callable, _Ty1,
    _Types2...> : _Invoke_traits_common<_Decltype_invoke_nonzero<_Callable, _Ty1, _Types2...>,
                      noexcept(_Invoker1<_Callable, _Ty1>::_Call(
                          ::std:: declval<_Callable>(), ::std:: declval<_Ty1>(), ::std:: declval<_Types2>()...))> {};

template <class _Callable, class... _Args>
using _Select_invoke_traits = conditional_t<sizeof...(_Args) == 0, _Invoke_traits_zero<void, _Callable>,
    _Invoke_traits_nonzero<void, _Callable, _Args...>>;


// STRUCT TEMPLATE result_of
template <class _Fty>
struct  result_of { // explain usage
    static_assert(_Always_false<_Fty>, "result_of<CallableType> is invalid; use "
                                       "result_of<CallableType(zero or more argument types)> instead.");
};







template <class _Callable, class... _Args> struct  result_of<_Callable __cdecl(_Args...)> : _Select_invoke_traits<_Callable, _Args...> { };    template <class _Callable, class... _Args> struct  result_of<_Callable __vectorcall(_Args...)> : _Select_invoke_traits<_Callable, _Args...> { };


__pragma(warning(push)) __pragma(warning(disable : 4996))
template <class _Ty>
using result_of_t  = typename result_of<_Ty>::type;
__pragma(warning(pop))
#line 1752 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

template <class _Callable, class... _Args>
using _Invoke_result_t = typename _Select_invoke_traits<_Callable, _Args...>::type;

template <class _Rx, class _Callable, class... _Args>
using _Is_invocable_r_ = typename _Select_invoke_traits<_Callable, _Args...>::template _Is_invocable_r<_Rx>;

template <class _Rx, class _Callable, class... _Args>
struct _Is_invocable_r : _Is_invocable_r_<_Rx, _Callable, _Args...> {
    // determines whether _Callable is callable with _Args and return type _Rx
};















































#line 1811 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

// ALIAS TEMPLATE _Weak_types
template <class _Ty>
struct _Function_args {}; // determine whether _Ty is a function







template <class _Ret, class... _Types> struct _Function_args<_Ret __cdecl(_Types...)   > : _Arg_types<_Types...> {  typedef _Ret result_type; };    template <class _Ret, class... _Types> struct _Function_args<_Ret __vectorcall(_Types...)   > : _Arg_types<_Types...> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret __cdecl(_Types...) const  > : _Arg_types<_Types...> {  typedef _Ret result_type; };    template <class _Ret, class... _Types> struct _Function_args<_Ret __vectorcall(_Types...) const  > : _Arg_types<_Types...> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret __cdecl(_Types...) volatile  > : _Arg_types<_Types...> {  typedef _Ret result_type; };    template <class _Ret, class... _Types> struct _Function_args<_Ret __vectorcall(_Types...) volatile  > : _Arg_types<_Types...> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret __cdecl(_Types...) const volatile  > : _Arg_types<_Types...> {  typedef _Ret result_type; };    template <class _Ret, class... _Types> struct _Function_args<_Ret __vectorcall(_Types...) const volatile  > : _Arg_types<_Types...> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret __cdecl(_Types...)  & > : _Arg_types<_Types...> {  typedef _Ret result_type; };    template <class _Ret, class... _Types> struct _Function_args<_Ret __vectorcall(_Types...)  & > : _Arg_types<_Types...> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret __cdecl(_Types...) const & > : _Arg_types<_Types...> {  typedef _Ret result_type; };    template <class _Ret, class... _Types> struct _Function_args<_Ret __vectorcall(_Types...) const & > : _Arg_types<_Types...> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret __cdecl(_Types...) volatile & > : _Arg_types<_Types...> {  typedef _Ret result_type; };    template <class _Ret, class... _Types> struct _Function_args<_Ret __vectorcall(_Types...) volatile & > : _Arg_types<_Types...> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret __cdecl(_Types...) const volatile & > : _Arg_types<_Types...> {  typedef _Ret result_type; };    template <class _Ret, class... _Types> struct _Function_args<_Ret __vectorcall(_Types...) const volatile & > : _Arg_types<_Types...> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret __cdecl(_Types...)  && > : _Arg_types<_Types...> {  typedef _Ret result_type; };    template <class _Ret, class... _Types> struct _Function_args<_Ret __vectorcall(_Types...)  && > : _Arg_types<_Types...> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret __cdecl(_Types...) const && > : _Arg_types<_Types...> {  typedef _Ret result_type; };    template <class _Ret, class... _Types> struct _Function_args<_Ret __vectorcall(_Types...) const && > : _Arg_types<_Types...> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret __cdecl(_Types...) volatile && > : _Arg_types<_Types...> {  typedef _Ret result_type; };    template <class _Ret, class... _Types> struct _Function_args<_Ret __vectorcall(_Types...) volatile && > : _Arg_types<_Types...> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret __cdecl(_Types...) const volatile && > : _Arg_types<_Types...> {  typedef _Ret result_type; };    template <class _Ret, class... _Types> struct _Function_args<_Ret __vectorcall(_Types...) const volatile && > : _Arg_types<_Types...> {  typedef _Ret result_type; };








template <class _Ret, class... _Types> struct _Function_args<_Ret(_Types..., ...) > {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret(_Types..., ...) const> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret(_Types..., ...) volatile> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret(_Types..., ...) const volatile> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret(_Types..., ...) &> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret(_Types..., ...) const&> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret(_Types..., ...) volatile&> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret(_Types..., ...) const volatile&> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret(_Types..., ...) &&> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret(_Types..., ...) const&&> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret(_Types..., ...) volatile&&> {  typedef _Ret result_type; }; template <class _Ret, class... _Types> struct _Function_args<_Ret(_Types..., ...) const volatile&&> {  typedef _Ret result_type; };


template <class _Ty, class = void>
struct _Weak_result_type {}; // default definition

__pragma(warning(push)) __pragma(warning(disable : 4996))
template <class _Ty>
struct _Weak_result_type<_Ty, void_t<typename _Ty::result_type>> { // defined if _Ty::result_type exists
     typedef typename _Ty::result_type result_type;
};
__pragma(warning(pop))

template <class _Ty, class = void>
struct _Weak_argument_type : _Weak_result_type<_Ty> {}; // default definition

__pragma(warning(push)) __pragma(warning(disable : 4996))
template <class _Ty>
struct _Weak_argument_type<_Ty, void_t<typename _Ty::argument_type>> : _Weak_result_type<_Ty> {
    // defined if _Ty::argument_type exists
     typedef typename _Ty::argument_type argument_type;
};
__pragma(warning(pop))

template <class _Ty, class = void>
struct _Weak_binary_args : _Weak_argument_type<_Ty> {}; // default definition

__pragma(warning(push)) __pragma(warning(disable : 4996))
template <class _Ty>
struct _Weak_binary_args<_Ty, void_t<typename _Ty::first_argument_type,
                                  typename _Ty::second_argument_type>>
    : _Weak_argument_type<_Ty> { // defined if both types exist
     typedef typename _Ty::first_argument_type first_argument_type;
     typedef typename _Ty::second_argument_type second_argument_type;
};
__pragma(warning(pop))

template <class _Ty>
using _Weak_types = conditional_t<is_function_v<remove_pointer_t<_Ty>>, _Function_args<remove_pointer_t<_Ty>>,
    conditional_t<is_member_function_pointer_v<_Ty>, _Is_memfunptr<remove_cv_t<_Ty>>, _Weak_binary_args<_Ty>>>;

// CLASS TEMPLATE reference_wrapper
template <class _Ty>
void _Refwrap_ctor_fun(_Identity_t<_Ty&>) noexcept;
template <class _Ty>
void _Refwrap_ctor_fun(_Identity_t<_Ty&&>) = delete;

template <class _Ty, class _Uty, class = void>
struct _Refwrap_has_ctor_from : false_type {};

template <class _Ty, class _Uty>
struct _Refwrap_has_ctor_from<_Ty, _Uty, void_t<decltype(_Refwrap_ctor_fun<_Ty>(::std:: declval<_Uty>()))>> : true_type {};

template <class _Ty>
class reference_wrapper

    : public _Weak_types<_Ty>
#line 1889 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"
{
public:
    static_assert(is_object_v<_Ty> || is_function_v<_Ty>,
        "reference_wrapper<T> requires T to be an object type or a function type.");

    using type = _Ty;

    template <class _Uty, enable_if_t<conjunction_v<negation<is_same<_Remove_cvref_t<_Uty>, reference_wrapper>>,
                                          _Refwrap_has_ctor_from<_Ty, _Uty>>,
                              int> = 0>
    inline reference_wrapper(_Uty&& _Val) noexcept(noexcept(_Refwrap_ctor_fun<_Ty>(::std:: declval<_Uty>()))) {
        _Ty& _Ref = static_cast<_Uty&&>(_Val);
        _Ptr      = ::std:: addressof(_Ref);
    }

    inline operator _Ty&() const noexcept {
        return *_Ptr;
    }

    [[nodiscard]] inline _Ty& get() const noexcept {
        return *_Ptr;
    }

private:
    _Ty* _Ptr{};

public:
    template <class... _Types>
    inline auto operator()(_Types&&... _Args) const
        noexcept(noexcept(::std:: invoke(*_Ptr, static_cast<_Types&&>(_Args)...))) // strengthened
        -> decltype(::std:: invoke(*_Ptr, static_cast<_Types&&>(_Args)...)) {
        return ::std:: invoke(*_Ptr, static_cast<_Types&&>(_Args)...);
    }
};




#line 1928 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

// FUNCTION TEMPLATES ref AND cref
template <class _Ty>
[[nodiscard]] inline reference_wrapper<_Ty> ref(_Ty& _Val) noexcept {
    return reference_wrapper<_Ty>(_Val);
}

template <class _Ty>
void ref(const _Ty&&) = delete;

template <class _Ty>
[[nodiscard]] inline reference_wrapper<_Ty> ref(reference_wrapper<_Ty> _Val) noexcept {
    return ::std:: ref(_Val.get());
}

template <class _Ty>
[[nodiscard]] inline reference_wrapper<const _Ty> cref(const _Ty& _Val) noexcept {
    return reference_wrapper<const _Ty>(_Val);
}

template <class _Ty>
void cref(const _Ty&&) = delete;

template <class _Ty>
[[nodiscard]] inline reference_wrapper<const _Ty> cref(reference_wrapper<_Ty> _Val) noexcept {
    return ::std:: cref(_Val.get());
}





















#line 1977 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

// STRUCT TEMPLATE _Is_swappable
template <class _Ty>
struct _Is_swappable;

// STRUCT TEMPLATE _Is_nothrow_swappable
template <class _Ty>
struct _Is_nothrow_swappable;

// FUNCTION TEMPLATE swap


#line 1990 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"
template <class _Ty, int _Enabled = 0>
#line 1992 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"
inline void swap(_Ty&, _Ty&) noexcept(is_nothrow_move_constructible_v<_Ty>&& is_nothrow_move_assignable_v<_Ty>);

template <class _Ty, size_t _Size, enable_if_t<_Is_swappable<_Ty>::value, int> = 0>
inline void swap(_Ty (&)[_Size], _Ty (&)[_Size]) noexcept(_Is_nothrow_swappable<_Ty>::value);

// STRUCT TEMPLATE _Swappable_with_helper
template <class _Ty1, class _Ty2, class = void>
struct _Swappable_with_helper : false_type {}; // swap(declval<_Ty1>(), declval<_Ty2>()) is not valid

template <class _Ty1, class _Ty2>
struct _Swappable_with_helper<_Ty1, _Ty2, void_t<decltype(swap(::std:: declval<_Ty1>(), ::std:: declval<_Ty2>()))>>
    : true_type {}; // swap(declval<_Ty1>(), declval<_Ty2>()) is valid

// STRUCT TEMPLATE _Is_swappable_with
template <class _Ty1, class _Ty2>
struct _Is_swappable_with
    : bool_constant<conjunction_v<_Swappable_with_helper<_Ty1, _Ty2>, _Swappable_with_helper<_Ty2, _Ty1>>> {
    // Determine if expressions with type and value category _Ty1 and _Ty2 can be swapped (and vice versa)
};

// STRUCT TEMPLATE _Is_swappable
template <class _Ty>
struct _Is_swappable : _Is_swappable_with<add_lvalue_reference_t<_Ty>, add_lvalue_reference_t<_Ty>>::type {
    // Determine if _Ty lvalues satisfy is_swappable_with
};

// STRUCT TEMPLATE _Swap_cannot_throw
template <class _Ty1, class _Ty2>
struct _Swap_cannot_throw : bool_constant<noexcept(swap(::std:: declval<_Ty1>(), ::std:: declval<_Ty2>())) //
                                    && noexcept(swap(::std:: declval<_Ty2>(), ::std:: declval<_Ty1>()))> {
    // Determine if expressions with type and value category _Ty1 and _Ty2
    // (presumed to satisfy is_swappable_with) can be swapped without emitting exceptions
};

// STRUCT TEMPLATE _Is_nothrow_swappable_with
template <class _Ty1, class _Ty2>
struct _Is_nothrow_swappable_with
    : bool_constant<conjunction_v<_Is_swappable_with<_Ty1, _Ty2>, _Swap_cannot_throw<_Ty1, _Ty2>>> {
    // Determine if expressions with type and value category _Ty1 and _Ty2
    // satisfy is_swappable_with, and can be swapped without emitting exceptions
};

// STRUCT TEMPLATE _Is_nothrow_swappable
template <class _Ty>
struct _Is_nothrow_swappable
    : _Is_nothrow_swappable_with<add_lvalue_reference_t<_Ty>, add_lvalue_reference_t<_Ty>>::type {
    // Determine if _Ty lvalues satisfy is_nothrow_swappable_with
};






































#line 2079 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

// TYPE TRAIT _Is_trivially_swappable
namespace _Has_ADL_swap_detail {
    void swap(); // undefined (deliberate shadowing)

    template <class, class = void>
    struct _Has_ADL_swap : false_type {};
    template <class _Ty>
    struct _Has_ADL_swap<_Ty, void_t<decltype(swap(::std:: declval<_Ty&>(), ::std:: declval<_Ty&>()))>> : true_type {};
} // namespace _Has_ADL_swap_detail
using _Has_ADL_swap_detail::_Has_ADL_swap;

template <class _Ty>
 constexpr bool _Is_trivially_swappable_v = conjunction_v<is_trivially_destructible<_Ty>,
    is_trivially_move_constructible<_Ty>, is_trivially_move_assignable<_Ty>, negation<_Has_ADL_swap<_Ty>>>;

template <class _Ty>
struct _Is_trivially_swappable : bool_constant<_Is_trivially_swappable_v<_Ty>> {
    // true_type if and only if it is valid to swap two _Ty lvalues by exchanging object representations.
};

// BITMASK OPERATIONS











































// FNV-1a UTILITIES
// These functions are extremely performance sensitive, check examples like
// that in VSO-653642 before making changes.

 constexpr size_t _FNV_offset_basis = 14695981039346656037ULL;
 constexpr size_t _FNV_prime        = 1099511628211ULL;



#line 2154 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

[[nodiscard]] inline size_t _Fnv1a_append_bytes(size_t _Val, const unsigned char* const _First,
    const size_t _Count) noexcept { // accumulate range [_First, _First + _Count) into partial FNV-1a hash _Val
    for (size_t _Idx = 0; _Idx < _Count; ++_Idx) {
        _Val ^= static_cast<size_t>(_First[_Idx]);
        _Val *= _FNV_prime;
    }

    return _Val;
}

template <class _Ty>
[[nodiscard]] size_t _Fnv1a_append_range(const size_t _Val, const _Ty* const _First,
    const _Ty* const _Last) noexcept { // accumulate range [_First, _Last) into partial FNV-1a hash _Val
    static_assert(is_trivial_v<_Ty>, "Only trivial types can be directly hashed.");
    const auto _Firstb = reinterpret_cast<const unsigned char*>(_First);
    const auto _Lastb  = reinterpret_cast<const unsigned char*>(_Last);
    return _Fnv1a_append_bytes(_Val, _Firstb, static_cast<size_t>(_Lastb - _Firstb));
}

template <class _Kty>
[[nodiscard]] size_t _Fnv1a_append_value(
    const size_t _Val, const _Kty& _Keyval) noexcept { // accumulate _Keyval into partial FNV-1a hash _Val
    static_assert(is_trivial_v<_Kty>, "Only trivial types can be directly hashed.");
    return _Fnv1a_append_bytes(_Val, &reinterpret_cast<const unsigned char&>(_Keyval), sizeof(_Kty));
}

// FUNCTION TEMPLATE _Hash_representation
template <class _Kty>
[[nodiscard]] size_t _Hash_representation(const _Kty& _Keyval) noexcept { // bitwise hashes the representation of a key
    return _Fnv1a_append_value(_FNV_offset_basis, _Keyval);
}

// FUNCTION TEMPLATE _Hash_array_representation
template <class _Kty>
[[nodiscard]] size_t _Hash_array_representation(
    const _Kty* const _First, const size_t _Count) noexcept { // bitwise hashes the representation of an array
    static_assert(is_trivial_v<_Kty>, "Only trivial types can be directly hashed.");
    return _Fnv1a_append_bytes(
        _FNV_offset_basis, reinterpret_cast<const unsigned char*>(_First), _Count * sizeof(_Kty));
}

// STRUCT TEMPLATE _Conditionally_enabled_hash
template <class _Kty>
struct hash;

template <class _Kty, bool _Enabled>
struct _Conditionally_enabled_hash { // conditionally enabled hash base
     typedef _Kty argument_type;
     typedef size_t result_type;

    [[nodiscard]] size_t operator()(const _Kty& _Keyval) const
        noexcept(noexcept(hash<_Kty>::_Do_hash(_Keyval))) /* strengthened */ {
        return hash<_Kty>::_Do_hash(_Keyval);
    }
};

template <class _Kty>
struct _Conditionally_enabled_hash<_Kty, false> { // conditionally disabled hash base
    _Conditionally_enabled_hash()                                   = delete;
    _Conditionally_enabled_hash(const _Conditionally_enabled_hash&) = delete;
    _Conditionally_enabled_hash(_Conditionally_enabled_hash&&)      = delete;
    _Conditionally_enabled_hash& operator=(const _Conditionally_enabled_hash&) = delete;
    _Conditionally_enabled_hash& operator=(_Conditionally_enabled_hash&&) = delete;
};

// STRUCT TEMPLATE hash
template <class _Kty>
struct hash
    : _Conditionally_enabled_hash<_Kty,
          !is_const_v<_Kty> && !is_volatile_v<_Kty> && (is_enum_v<_Kty> || is_integral_v<_Kty> || is_pointer_v<_Kty>)> {
    // hash functor primary template (handles enums, integrals, and pointers)
    static size_t _Do_hash(const _Kty& _Keyval) noexcept {
        return _Hash_representation(_Keyval);
    }
};

template <>
struct hash<float> {
     typedef float argument_type;
     typedef size_t result_type;
    [[nodiscard]] size_t operator()(const float _Keyval) const noexcept {
        return _Hash_representation(_Keyval == 0.0F ? 0.0F : _Keyval); // map -0 to 0
    }
};

template <>
struct hash<double> {
     typedef double argument_type;
     typedef size_t result_type;
    [[nodiscard]] size_t operator()(const double _Keyval) const noexcept {
        return _Hash_representation(_Keyval == 0.0 ? 0.0 : _Keyval); // map -0 to 0
    }
};

template <>
struct hash<long double> {
     typedef long double argument_type;
     typedef size_t result_type;
    [[nodiscard]] size_t operator()(const long double _Keyval) const noexcept {
        return _Hash_representation(_Keyval == 0.0L ? 0.0L : _Keyval); // map -0 to 0
    }
};

template <>
struct hash<nullptr_t> {
     typedef nullptr_t argument_type;
     typedef size_t result_type;
    [[nodiscard]] size_t operator()(nullptr_t) const noexcept {
        void* _Null{};
        return _Hash_representation(_Null);
    }
};

// STRUCT TEMPLATE _Is_nothrow_hashable
template <class _Kty, class = void>
struct _Is_nothrow_hashable : false_type {}; // tests if std::hash can hash _Kty with noexcept

template <class _Kty>
struct _Is_nothrow_hashable<_Kty, void_t<decltype(hash<_Kty>{}(::std:: declval<const _Kty&>()))>>
    : bool_constant<noexcept(hash<_Kty>{}(::std:: declval<const _Kty&>()))> {};

// vvvvvvvvvv DERIVED FROM corecrt_internal_fltintrn.h vvvvvvvvvv

template <class _FloatingType>
struct _Floating_type_traits;

template <>
struct _Floating_type_traits<float> {
    static constexpr int32_t _Mantissa_bits           = 24; // FLT_MANT_DIG
    static constexpr int32_t _Exponent_bits           = 8; // sizeof(float) * CHAR_BIT - FLT_MANT_DIG
    static constexpr int32_t _Maximum_binary_exponent = 127; // FLT_MAX_EXP - 1
    static constexpr int32_t _Minimum_binary_exponent = -126; // FLT_MIN_EXP - 1
    static constexpr int32_t _Exponent_bias           = 127;
    static constexpr int32_t _Sign_shift              = 31; // _Exponent_bits + _Mantissa_bits - 1
    static constexpr int32_t _Exponent_shift          = 23; // _Mantissa_bits - 1

    using _Uint_type = uint32_t;

    static constexpr uint32_t _Exponent_mask             = 0x000000FFu; // (1u << _Exponent_bits) - 1
    static constexpr uint32_t _Normal_mantissa_mask      = 0x00FFFFFFu; // (1u << _Mantissa_bits) - 1
    static constexpr uint32_t _Denormal_mantissa_mask    = 0x007FFFFFu; // (1u << (_Mantissa_bits - 1)) - 1
    static constexpr uint32_t _Special_nan_mantissa_mask = 0x00400000u; // 1u << (_Mantissa_bits - 2)
    static constexpr uint32_t _Shifted_sign_mask         = 0x80000000u; // 1u << _Sign_shift
    static constexpr uint32_t _Shifted_exponent_mask     = 0x7F800000u; // _Exponent_mask << _Exponent_shift
};

template <>
struct _Floating_type_traits<double> {
    static constexpr int32_t _Mantissa_bits           = 53; // DBL_MANT_DIG
    static constexpr int32_t _Exponent_bits           = 11; // sizeof(double) * CHAR_BIT - DBL_MANT_DIG
    static constexpr int32_t _Maximum_binary_exponent = 1023; // DBL_MAX_EXP - 1
    static constexpr int32_t _Minimum_binary_exponent = -1022; // DBL_MIN_EXP - 1
    static constexpr int32_t _Exponent_bias           = 1023;
    static constexpr int32_t _Sign_shift              = 63; // _Exponent_bits + _Mantissa_bits - 1
    static constexpr int32_t _Exponent_shift          = 52; // _Mantissa_bits - 1

    using _Uint_type = uint64_t;

    static constexpr uint64_t _Exponent_mask             = 0x00000000000007FFu; // (1ULL << _Exponent_bits) - 1
    static constexpr uint64_t _Normal_mantissa_mask      = 0x001FFFFFFFFFFFFFu; // (1ULL << _Mantissa_bits) - 1
    static constexpr uint64_t _Denormal_mantissa_mask    = 0x000FFFFFFFFFFFFFu; // (1ULL << (_Mantissa_bits - 1)) - 1
    static constexpr uint64_t _Special_nan_mantissa_mask = 0x0008000000000000u; // 1ULL << (_Mantissa_bits - 2)
    static constexpr uint64_t _Shifted_sign_mask         = 0x8000000000000000u; // 1ULL << _Sign_shift
    static constexpr uint64_t _Shifted_exponent_mask     = 0x7FF0000000000000u; // _Exponent_mask << _Exponent_shift
};

template <>
struct _Floating_type_traits<long double> : _Floating_type_traits<double> {};

// ^^^^^^^^^^ DERIVED FROM corecrt_internal_fltintrn.h ^^^^^^^^^^


__pragma(warning(push)) __pragma(warning(disable : 4996))
namespace [[deprecated( "warning STL4002: " "The non-Standard std::tr1 namespace and TR1-only machinery are deprecated and will be REMOVED. You can " "define _SILENCE_TR1_NAMESPACE_DEPRECATION_WARNING to acknowledge that you have received this warning.")]] tr1 {
    using ::std:: add_const;
    using ::std:: add_cv;
    using ::std:: add_pointer;
    using ::std:: add_volatile;
    using ::std:: aligned_storage;
    using ::std:: alignment_of;
    using ::std:: conditional;
    using ::std:: decay;
    using ::std:: enable_if;
    using ::std:: extent;
    using ::std:: false_type;
    using ::std:: has_virtual_destructor;
    using ::std:: integral_constant;
    using ::std:: is_abstract;
    using ::std:: is_arithmetic;
    using ::std:: is_array;
    using ::std:: is_base_of;
    using ::std:: is_class;
    using ::std:: is_compound;
    using ::std:: is_const;
    using ::std:: is_convertible;
    using ::std:: is_empty;
    using ::std:: is_enum;
    using ::std:: is_floating_point;
    using ::std:: is_function;
    using ::std:: is_fundamental;
    using ::std:: is_integral;
    using ::std:: is_member_function_pointer;
    using ::std:: is_member_object_pointer;
    using ::std:: is_member_pointer;
    using ::std:: is_object;
    using ::std:: is_pod;
    using ::std:: is_pointer;
    using ::std:: is_polymorphic;
    using ::std:: is_reference;
    using ::std:: is_same;
    using ::std:: is_scalar;
    using ::std:: is_signed;
    using ::std:: is_union;
    using ::std:: is_unsigned;
    using ::std:: is_void;
    using ::std:: is_volatile;
    using ::std:: make_signed;
    using ::std:: make_unsigned;
    using ::std:: rank;
    using ::std:: remove_all_extents;
    using ::std:: remove_const;
    using ::std:: remove_cv;
    using ::std:: remove_extent;
    using ::std:: remove_pointer;
    using ::std:: remove_reference;
    using ::std:: remove_volatile;
    using ::std:: true_type;
    using ::std:: cref;
    using ::std:: ref;
    using ::std:: reference_wrapper;

    using ::std:: result_of;
#line 2388 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"
    using ::std:: hash;
} // namespace tr1
__pragma(warning(pop))
#line 2392 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"

}



#pragma warning(pop)
#pragma pack(pop)

#line 2401 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"
#line 2402 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\type_traits"
#line 14 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xatomic.h"

#pragma pack(push, 8)
#pragma warning(push, 3)
#pragma warning(disable : 4180 4412 4455 4494 4514 4574 4582 4583 4587 4588 4619 4623 4625 4626 4643 4648 4702 4793 4820 4988 5026 5027 5045 6294  4984 5053 )







// Interlocked intrinsic mapping for _nf/_acq/_rel


















#line 45 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xatomic.h"




namespace std {

























#line 76 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xatomic.h"
// ENUM memory_order
enum memory_order {
    memory_order_relaxed,
    memory_order_consume,
    memory_order_acquire,
    memory_order_release,
    memory_order_acq_rel,
    memory_order_seq_cst
};
#line 86 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xatomic.h"

using _Atomic_counter_t = unsigned long;

// FUNCTION TEMPLATE _Atomic_address_as
template <class _Integral, class _Ty>
[[nodiscard]] volatile _Integral* _Atomic_address_as(_Ty& _Source) noexcept {
    // gets a pointer to the argument as an integral type (to pass to intrinsics)
    static_assert(is_integral_v<_Integral>, "Tried to reinterpret memory as non-integral");
    return &reinterpret_cast<volatile _Integral&>(_Source);
}

template <class _Integral, class _Ty>
[[nodiscard]] const volatile _Integral* _Atomic_address_as(const _Ty& _Source) noexcept {
    // gets a pointer to the argument as an integral type (to pass to intrinsics)
    static_assert(is_integral_v<_Integral>, "Tried to reinterpret memory as non-integral");
    return &reinterpret_cast<const volatile _Integral&>(_Source);
}

}



#pragma warning(pop)
#pragma pack(pop)
#line 111 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xatomic.h"
#line 112 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xatomic.h"
#line 20 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"


#line 23 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xthreads.h"
// xthreads.h internal header

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once




#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\climits"
// climits standard header (core)

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once







#line 15 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\climits"
#line 16 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\climits"
#line 12 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xthreads.h"
#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xtimec.h"
// xtimec.h internal header

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once





#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\ctime"
// ctime standard header (core)

// Copyright (c) Microsoft Corporation.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#pragma once





#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"
//
// time.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// The C Standard Library <time.h> header.
//
#pragma once




#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wtime.h"
//
// corecrt_wtime.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// This file declares the wide character (wchar_t) time functionality, shared
// by <time.h> and <wchar.h>.
//
#pragma once



#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8)) extern "C" {



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Types
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
struct tm
{
    int tm_sec;   // seconds after the minute - [0, 60] including leap second
    int tm_min;   // minutes after the hour - [0, 59]
    int tm_hour;  // hours since midnight - [0, 23]
    int tm_mday;  // day of the month - [1, 31]
    int tm_mon;   // months since January - [0, 11]
    int tm_year;  // years since 1900
    int tm_wday;  // days since Sunday - [0, 6]
    int tm_yday;  // days since January 1 - [0, 365]
    int tm_isdst; // daylight savings time flag
};


//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Wide String Time Functions
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_wasctime_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
 
 
__declspec(dllimport) wchar_t* __cdecl _wasctime(
      struct tm const* _Tm
    );

 

__declspec(dllimport) errno_t __cdecl _wasctime_s(
        wchar_t*         _Buffer,
                                          size_t           _SizeInWords,
                                                       struct tm const* _Tm
    );

extern "C++" { template <size_t _Size> inline   errno_t __cdecl _wasctime_s(  wchar_t (&_Buffer)[_Size],   struct tm const* _Time) throw() { return _wasctime_s(_Buffer, _Size, _Time); } }
#line 66 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wtime.h"

 

__declspec(dllimport) size_t __cdecl wcsftime(
       wchar_t*         _Buffer,
                               size_t           _SizeInWords,
                             wchar_t const*   _Format,
                               struct tm const* _Tm
    );

 

__declspec(dllimport) size_t __cdecl _wcsftime_l(
       wchar_t*         _Buffer,
                               size_t           _SizeInWords,
                             wchar_t const*   _Format,
                               struct tm const* _Tm,
                           _locale_t        _Locale
    );

 
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_wctime32_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) wchar_t* __cdecl _wctime32(
      __time32_t const* _Time
    );


__declspec(dllimport) errno_t __cdecl _wctime32_s(
        wchar_t*          _Buffer,
                                      size_t            _SizeInWords,
                                                       __time32_t const* _Time
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _wctime32_s(  wchar_t (&_Buffer)[_Size],   __time32_t const* _Time) throw() { return _wctime32_s(_Buffer, _Size, _Time); } }
#line 104 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wtime.h"

 
 
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_wctime64_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) wchar_t* __cdecl _wctime64(
      __time64_t const* _Time
    );


__declspec(dllimport) errno_t __cdecl _wctime64_s(
        wchar_t*          _Buffer,
                                      size_t            _SizeInWords,
                                                       __time64_t const* _Time);

extern "C++" { template <size_t _Size> inline errno_t __cdecl _wctime64_s(  wchar_t (&_Buffer)[_Size],   __time64_t const* _Time) throw() { return _wctime64_s(_Buffer, _Size, _Time); } }
#line 123 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wtime.h"


__declspec(dllimport) errno_t __cdecl _wstrdate_s(
       wchar_t* _Buffer,
                                                                                size_t   _SizeInWords
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _wstrdate_s(  wchar_t (&_Buffer)[_Size]) throw() { return _wstrdate_s(_Buffer, _Size); } }
#line 134 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wtime.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_wstrdate_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport)  wchar_t* __cdecl _wstrdate( wchar_t *_Buffer);
#line 139 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wtime.h"


__declspec(dllimport) errno_t __cdecl _wstrtime_s(
       wchar_t* _Buffer,
                                                                                size_t   _SizeInWords
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _wstrtime_s(  wchar_t (&_Buffer)[_Size]) throw() { return _wstrtime_s(_Buffer, _Size); } }
#line 150 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wtime.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_wstrtime_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport)  wchar_t* __cdecl _wstrtime( wchar_t *_Buffer);
#line 155 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wtime.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Inline Definitions
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    




















         
        static __inline wchar_t * __cdecl _wctime(
              time_t const* const _Time)
        {
            return _wctime64(_Time);
        }

        
        static __inline errno_t __cdecl _wctime_s(
                  wchar_t*      const _Buffer,
                                                             size_t        const _SizeInWords,
                                                             time_t const* const _Time
            )
        {
            return _wctime64_s(_Buffer, _SizeInWords, _Time);
        }

    #line 203 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wtime.h"
#line 204 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\corecrt_wtime.h"

} __pragma(pack(pop))

#pragma warning(pop) 
#line 14 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"

#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8)) extern "C" {



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Types
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
typedef long clock_t;

struct _timespec32
{
    __time32_t tv_sec;
    long       tv_nsec;
};

struct _timespec64
{
    __time64_t tv_sec;
    long       tv_nsec;
};


    struct timespec
    {
        time_t tv_sec;  // Seconds - >= 0
        long   tv_nsec; // Nanoseconds - [0, 999999999]
    };
#line 49 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"



// The number of clock ticks per second






//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Time Zone and Daylight Savings Time Data and Accessors
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
// Nonzero if Daylight Savings Time is used
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_get_daylight" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) int* __cdecl __daylight(void);



// Offset for Daylight Savings Time
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_get_dstbias" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) long* __cdecl __dstbias(void);



// Difference in seconds between GMT and local time
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_get_timezone" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) long* __cdecl __timezone(void);



// Standard and Daylight Savings Time time zone names
    __declspec(deprecated("This function or variable may be unsafe. Consider using " "_get_tzname" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) char** __cdecl __tzname(void);



  
__declspec(dllimport) errno_t __cdecl _get_daylight(
      int* _Daylight
    );

 
__declspec(dllimport) errno_t __cdecl _get_dstbias(
      long* _DaylightSavingsBias
    );

  
__declspec(dllimport) errno_t __cdecl _get_timezone(
      long* _TimeZone
    );

 
__declspec(dllimport) errno_t __cdecl _get_tzname(
                             size_t* _ReturnValue,
      char*   _Buffer,
                              size_t  _SizeInBytes,
                              int     _Index
    );



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// AppCRT Time Functions
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 
 
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "asctime_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) char* __cdecl asctime(
      struct tm const* _Tm
    );


     
    
    __declspec(dllimport) errno_t __cdecl asctime_s(
            char*            _Buffer,
                                            size_t           _SizeInBytes,
                                                         struct tm const* _Tm
        );
#line 134 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"

extern "C++" { template <size_t _Size> inline errno_t __cdecl asctime_s(  char (&_Buffer)[_Size],   struct tm const* _Time) throw() { return asctime_s(_Buffer, _Size, _Time); } }
#line 140 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"

 
__declspec(dllimport) clock_t __cdecl clock(void);

 
 
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_ctime32_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) char* __cdecl _ctime32(
      __time32_t const* _Time
    );


__declspec(dllimport) errno_t __cdecl _ctime32_s(
        char*             _Buffer,
                                        size_t            _SizeInBytes,
                                                     __time32_t const* _Time
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _ctime32_s(  char (&_Buffer)[_Size],   __time32_t const* _Time) throw() { return _ctime32_s(_Buffer, _Size, _Time); } }
#line 163 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"

 
 
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_ctime64_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) char* __cdecl _ctime64(
      __time64_t const* _Time
    );


__declspec(dllimport) errno_t __cdecl _ctime64_s(
        char*             _Buffer,
                                          size_t            _SizeInBytes,
                                                       __time64_t const* _Time
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _ctime64_s(  char (&_Buffer)[_Size],   __time64_t const* _Time) throw() { return _ctime64_s(_Buffer, _Size, _Time); } }
#line 183 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"

 
__declspec(dllimport) double __cdecl _difftime32(
      __time32_t _Time1,
      __time32_t _Time2
    );

 
__declspec(dllimport) double __cdecl _difftime64(
      __time64_t _Time1,
      __time64_t _Time2
    );

 
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_gmtime32_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) struct tm* __cdecl _gmtime32(
      __time32_t const* _Time
    );


__declspec(dllimport) errno_t __cdecl _gmtime32_s(
      struct tm*        _Tm,
       __time32_t const* _Time
    );

 
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_gmtime64_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) struct tm* __cdecl _gmtime64(
      __time64_t const* _Time
    );


__declspec(dllimport) errno_t __cdecl _gmtime64_s(
      struct tm*        _Tm,
       __time64_t const* _Time
    );

 
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_localtime32_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) struct tm* __cdecl _localtime32(
      __time32_t const* _Time
    );


__declspec(dllimport) errno_t __cdecl _localtime32_s(
      struct tm*        _Tm,
       __time32_t const* _Time
    );

 
  __declspec(deprecated("This function or variable may be unsafe. Consider using " "_localtime64_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
__declspec(dllimport) struct tm* __cdecl _localtime64(
      __time64_t const* _Time
    );


__declspec(dllimport) errno_t __cdecl _localtime64_s(
      struct tm*        _Tm,
       __time64_t const* _Time
    );

 
__declspec(dllimport) __time32_t __cdecl _mkgmtime32(
      struct tm* _Tm
    );

 
__declspec(dllimport) __time64_t __cdecl _mkgmtime64(
      struct tm* _Tm
    );


__declspec(dllimport) __time32_t __cdecl _mktime32(
      struct tm* _Tm
    );


__declspec(dllimport) __time64_t __cdecl _mktime64(
      struct tm* _Tm
    );

 

__declspec(dllimport) size_t __cdecl strftime(
       char*            _Buffer,
                               size_t           _SizeInBytes,
        char const*      _Format,
                               struct tm const* _Tm
    );

 

__declspec(dllimport) size_t __cdecl _strftime_l(
           char*            _Buffer,
                               size_t           _MaxSize,
        char const*      _Format,
                               struct tm const* _Tm,
                           _locale_t        _Locale
    );


__declspec(dllimport) errno_t __cdecl _strdate_s(
       char*  _Buffer,
                                                                              size_t _SizeInBytes
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _strdate_s(  char (&_Buffer)[_Size]) throw() { return _strdate_s(_Buffer, _Size); } }
#line 293 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_strdate_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport)  char* __cdecl _strdate( char *_Buffer);
#line 298 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"


__declspec(dllimport) errno_t __cdecl _strtime_s(
       char*  _Buffer,
                                                                              size_t _SizeInBytes
    );

extern "C++" { template <size_t _Size> inline errno_t __cdecl _strtime_s(  char (&_Buffer)[_Size]) throw() { return _strtime_s(_Buffer, _Size); } }
#line 309 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"

__declspec(deprecated("This function or variable may be unsafe. Consider using " "_strtime_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details.")) __declspec(dllimport) char* __cdecl _strtime( char *_Buffer);
#line 314 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"

__declspec(dllimport) __time32_t __cdecl _time32(
      __time32_t* _Time
    );

__declspec(dllimport) __time64_t __cdecl _time64(
      __time64_t* _Time
    );

 
 
__declspec(dllimport) int __cdecl _timespec32_get(
      struct _timespec32* _Ts,
       int                 _Base
    );

 
 
__declspec(dllimport) int __cdecl _timespec64_get(
      struct _timespec64* _Ts,
       int                 _Base
    );



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// DesktopCRT Time Functions
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


    __declspec(dllimport) void __cdecl _tzset(void);

    // The Win32 API GetLocalTime and SetLocalTime should be used instead.
    __declspec(deprecated("This function or variable has been superceded by newer library " "or operating system functionality. Consider using " "GetLocalTime" " " "instead. See online help for details."))
    __declspec(dllimport) unsigned __cdecl _getsystime(
          struct tm* _Tm
        );

    __declspec(deprecated("This function or variable has been superceded by newer library " "or operating system functionality. Consider using " "SetLocalTime" " " "instead. See online help for details."))
    __declspec(dllimport) unsigned __cdecl _setsystime(
          struct tm* _Tm,
          unsigned   _Milliseconds
        );

#line 361 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Inline Function Definitions
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


    


































































































          __declspec(deprecated("This function or variable may be unsafe. Consider using " "ctime_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
        static __inline char* __cdecl ctime(
              time_t const* const _Time
            )
        {
            return _ctime64(_Time);
        }

         
        static __inline double __cdecl difftime(
              time_t const _Time1,
              time_t const _Time2
            )
        {
            return _difftime64(_Time1, _Time2);
        }

          __declspec(deprecated("This function or variable may be unsafe. Consider using " "gmtime_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
        static __inline struct tm* __cdecl gmtime(
              time_t const* const _Time)
        {
            return _gmtime64(_Time);
        }

        __declspec(deprecated("This function or variable may be unsafe. Consider using " "localtime_s" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details."))
        static __inline struct tm* __cdecl localtime(
              time_t const* const _Time
            )
        {
            return _localtime64(_Time);
        }

         
        static __inline time_t __cdecl _mkgmtime(
              struct tm* const _Tm
            )
        {
            return _mkgmtime64(_Tm);
        }

        
        static __inline time_t __cdecl mktime(
              struct tm* const _Tm
            )
        {
            return _mktime64(_Tm);
        }

        static __inline time_t __cdecl time(
              time_t* const _Time
            )
        {
            return _time64(_Time);
        }

         
        static __inline int __cdecl timespec_get(
              struct timespec* const _Ts,
               int              const _Base
            )
        {
            return _timespec64_get((struct _timespec64*)_Ts, _Base);
        }

        
            
            static __inline errno_t __cdecl ctime_s(
                    char*         const _Buffer,
                                                    size_t        const _SizeInBytes,
                                                                 time_t const* const _Time
                )
            {
                return _ctime64_s(_Buffer, _SizeInBytes, _Time);
            }

            
            static __inline errno_t __cdecl gmtime_s(
                  struct tm*    const _Tm,
                   time_t const* const _Time
                )
            {
                return _gmtime64_s(_Tm, _Time);
            }

            
            static __inline errno_t __cdecl localtime_s(
                  struct tm*    const _Tm,
                   time_t const* const _Time
                )
            {
                return _localtime64_s(_Tm, _Time);
            }
        #line 563 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"

    #line 565 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"

#line 567 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Non-ANSI Names for Compatibility
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


    

    
        __declspec(deprecated("The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "_tzset" ". See online help for details.")) __declspec(dllimport) void __cdecl tzset(void);
    #line 582 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"

#line 584 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"



} __pragma(pack(pop))

#pragma warning(pop) 
#line 591 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\time.h"
#line 13 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\ctime"

#pragma pack(push, 8)
#pragma warning(push, 3)
#pragma warning(disable : 4180 4412 4455 4494 4514 4574 4582 4583 4587 4588 4619 4623 4625 4626 4643 4648 4702 4793 4820 4988 5026 5027 5045 6294  4984 5053 )




namespace std {
using :: clock_t;
using :: size_t;
using :: time_t;
using :: tm;
using :: asctime;
using :: clock;
using :: ctime;
using :: difftime;
using :: gmtime;
using :: localtime;
using :: mktime;
using :: strftime;
using :: time;



#line 39 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\ctime"
}



#pragma warning(pop)
#pragma pack(pop)

#line 47 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\ctime"
#line 48 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\ctime"
#line 13 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xtimec.h"

#pragma pack(push, 8)
#pragma warning(push, 3)
#pragma warning(disable : 4180 4412 4455 4494 4514 4574 4582 4583 4587 4588 4619 4623 4625 4626 4643 4648 4702 4793 4820 4988 5026 5027 5045 6294  4984 5053 )




extern "C" {

struct xtime { // store time with nanosecond resolution
    __time64_t sec;
    long nsec;
};

 int __cdecl xtime_get(xtime*, int);

 long __cdecl _Xtime_diff_to_millis(const xtime*);
 long __cdecl _Xtime_diff_to_millis2(const xtime*, const xtime*);
 long long __cdecl _Xtime_get_ticks();

 long long __cdecl _Query_perf_counter();
 long long __cdecl _Query_perf_frequency();

}



#pragma warning(pop)
#pragma pack(pop)
#line 44 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xtimec.h"
#line 45 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xtimec.h"

/*
 * This file is derived from software bearing the following
 * restrictions:
 *
 * (c) Copyright William E. Kempf 2001
 *
 * Permission to use, copy, modify, distribute and sell this
 * software and its documentation for any purpose is hereby
 * granted without fee, provided that the above copyright
 * notice appear in all copies and that both that copyright
 * notice and this permission notice appear in supporting
 * documentation. William E. Kempf makes no representations
 * about the suitability of this software for any purpose.
 * It is provided "as is" without express or implied warranty.
 */
#line 13 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xthreads.h"

#pragma pack(push, 8)
#pragma warning(push, 3)
#pragma warning(disable : 4180 4412 4455 4494 4514 4574 4582 4583 4587 4588 4619 4623 4625 4626 4643 4648 4702 4793 4820 4988 5026 5027 5045 6294  4984 5053 )




extern "C" {
using _Thrd_id_t = unsigned int;
struct _Thrd_t { // thread identifier for Win32
    void* _Hnd; // Win32 HANDLE
    _Thrd_id_t _Id;
};

// Size and alignment for _Mtx_internal_imp_t and _Cnd_internal_imp_t























#line 53 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xthreads.h"
#line 54 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xthreads.h"

using _Mtx_t = struct _Mtx_internal_imp_t*;

using _Cnd_t = struct _Cnd_internal_imp_t*;

enum { _Thrd_success, _Thrd_nomem, _Thrd_timedout, _Thrd_busy, _Thrd_error };

// threads
 int __cdecl _Thrd_detach(_Thrd_t);
 int __cdecl _Thrd_join(_Thrd_t, int*);
 void __cdecl _Thrd_sleep(const xtime*);
 void __cdecl _Thrd_yield();
 unsigned int __cdecl _Thrd_hardware_concurrency();
 _Thrd_id_t __cdecl _Thrd_id();

// mutexes
enum { // mutex types
    _Mtx_plain     = 0x01,
    _Mtx_try       = 0x02,
    _Mtx_timed     = 0x04,
    _Mtx_recursive = 0x100
};

 int __cdecl _Mtx_init(_Mtx_t*, int);
 void __cdecl _Mtx_destroy(_Mtx_t);
 void __cdecl _Mtx_init_in_situ(_Mtx_t, int);
 void __cdecl _Mtx_destroy_in_situ(_Mtx_t);
 int __cdecl _Mtx_current_owns(_Mtx_t);
 int __cdecl _Mtx_lock(_Mtx_t);
 int __cdecl _Mtx_trylock(_Mtx_t);
 int __cdecl _Mtx_timedlock(_Mtx_t, const xtime*);
 int __cdecl _Mtx_unlock(_Mtx_t); // TRANSITION, ABI: always returns _Thrd_success

 void* __cdecl _Mtx_getconcrtcs(_Mtx_t);
 void __cdecl _Mtx_clear_owner(_Mtx_t);
 void __cdecl _Mtx_reset_owner(_Mtx_t);

// shared mutex
// these declarations must be in sync with those in sharedmutex.cpp
using _Smtx_t = void*;
void __cdecl _Smtx_lock_exclusive(_Smtx_t*);
void __cdecl _Smtx_lock_shared(_Smtx_t*);
int __cdecl _Smtx_try_lock_exclusive(_Smtx_t*);
int __cdecl _Smtx_try_lock_shared(_Smtx_t*);
void __cdecl _Smtx_unlock_exclusive(_Smtx_t*);
void __cdecl _Smtx_unlock_shared(_Smtx_t*);

// condition variables
 int __cdecl _Cnd_init(_Cnd_t*);
 void __cdecl _Cnd_destroy(_Cnd_t);
 void __cdecl _Cnd_init_in_situ(_Cnd_t);
 void __cdecl _Cnd_destroy_in_situ(_Cnd_t);
 int __cdecl _Cnd_wait(_Cnd_t, _Mtx_t); // TRANSITION, ABI: Always returns _Thrd_success
 int __cdecl _Cnd_timedwait(_Cnd_t, _Mtx_t, const xtime*);
 int __cdecl _Cnd_broadcast(_Cnd_t); // TRANSITION, ABI: Always returns _Thrd_success
 int __cdecl _Cnd_signal(_Cnd_t); // TRANSITION, ABI: Always returns _Thrd_success
 void __cdecl _Cnd_register_at_thread_exit(_Cnd_t, _Mtx_t, int*);
 void __cdecl _Cnd_unregister_at_thread_exit(_Mtx_t);
 void __cdecl _Cnd_do_broadcast_at_thread_exit();
}

namespace std {
enum { // constants for error codes
    _DEVICE_OR_RESOURCE_BUSY,
    _INVALID_ARGUMENT,
    _NO_SUCH_PROCESS,
    _NOT_ENOUGH_MEMORY,
    _OPERATION_NOT_PERMITTED,
    _RESOURCE_DEADLOCK_WOULD_OCCUR,
    _RESOURCE_UNAVAILABLE_TRY_AGAIN
};

[[noreturn]]  void __cdecl _Throw_C_error(int _Code);
[[noreturn]]  void __cdecl _Throw_Cpp_error(int _Code);

inline int _Check_C_return(int _Res) { // throw exception on failure
    if (_Res != _Thrd_success) {
        _Throw_C_error(_Res);
    }

    return _Res;
}
}


#pragma warning(pop)
#pragma pack(pop)
#line 142 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xthreads.h"
#line 143 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\xthreads.h"

/*
 * This file is derived from software bearing the following
 * restrictions:
 *
 * (c) Copyright William E. Kempf 2001
 *
 * Permission to use, copy, modify, distribute and sell this
 * software and its documentation for any purpose is hereby
 * granted without fee, provided that the above copyright
 * notice appear in all copies and that both that copyright
 * notice and this permission notice appear in supporting
 * documentation. William E. Kempf makes no representations
 * about the suitability of this software for any purpose.
 * It is provided "as is" without express or implied warranty.
 */
#line 24 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

#pragma pack(push, 8)
#pragma warning(push, 3)
#pragma warning(disable : 4180 4412 4455 4494 4514 4574 4582 4583 4587 4588 4619 4623 4625 4626 4643 4648 4702 4793 4820 4988 5026 5027 5045 6294  4984 5053 )









#line 38 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
// x86/x64 hardware only emits memory barriers inside _Interlocked intrinsics



#line 43 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"






#line 50 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
#line 51 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

// MACRO _STD_COMPARE_EXCHANGE_128



#line 57 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
// 16-byte atomics are separately compiled for x64, as not all x64 hardware has the cmpxchg16b
// instruction; in the event this instruction is not available, the fallback is a global
// synchronization object shared by all 16-byte atomics.
// (Note: machines without this instruction typically have 2 cores or fewer, so this isn't too bad)
// All pointer parameters must be 16-byte aligned.
extern "C" [[nodiscard]] unsigned char __stdcall __std_atomic_compare_exchange_128(
      long long* _Destination,   long long _ExchangeHigh,   long long _ExchangeLow,
      long long* _ComparandResult) noexcept;
extern "C" [[nodiscard]] char __stdcall __std_atomic_has_cmpxchg16b() noexcept;

#line 68 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
#line 69 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

// MACRO _ATOMIC_HAS_DCAS
// Controls whether atomic::is_always_lock_free triggers for sizeof(void *) or 2 * sizeof(void *)


#line 75 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

#line 77 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

// MACRO _ATOMIC_CHOOSE_INTRINSIC

























#line 105 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

// LOCK-FREE PROPERTY














extern "C" {
_Smtx_t* __stdcall __std_atomic_get_mutex(const void* _Key) noexcept;
}
// Padding bits should not participate in cmpxchg comparison starting in C++20.
// Clang does not have __builtin_zero_non_value_bits to exclude these bits to implement this C++20 feature.
// The EDG front-end substitutes everything and runs into incomplete types passed to atomic<T>.


#line 130 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

#line 132 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

namespace std {
// STRUCT TEMPLATE _Storage_for



#line 139 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

template <class _Ty>
struct _Storage_for {
    // uninitialized space to store a _Ty
    alignas(_Ty) unsigned char _Storage[sizeof(_Ty)];

    _Storage_for()                    = default;
    _Storage_for(const _Storage_for&) = delete;
    _Storage_for& operator=(const _Storage_for&) = delete;






#line 155 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    [[nodiscard]] _Ty& _Ref() noexcept {
        return reinterpret_cast<_Ty&>(_Storage);
    }

    [[nodiscard]] _Ty* _Ptr() noexcept {
        return reinterpret_cast<_Ty*>(&_Storage);
    }
};





#line 170 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

// FENCES
extern "C" inline void atomic_thread_fence(const memory_order _Order) noexcept {
    if (_Order == memory_order_relaxed) {
        return;
    }


    __pragma(warning(push)) __pragma(warning(disable : 4996)) _ReadWriteBarrier() __pragma(warning(pop));
    if (_Order == memory_order_seq_cst) {
        volatile long _Guard; // Not initialized to avoid an unnecessary operation; the value does not matter

        // _mm_mfence could have been used, but it is not supported on older x86 CPUs and is slower on some recent CPUs.
        // The memory fence provided by interlocked operations has some exceptions, but this is fine:
        // std::atomic_thread_fence works with respect to other atomics only; it may not be a full fence for all ops.
#pragma warning(suppress : 6001) 
#pragma warning(suppress : 28113) 
                                  // usage which could be reconsidered."
        (void) _InterlockedIncrement(&_Guard);
        __pragma(warning(push)) __pragma(warning(disable : 4996)) _ReadWriteBarrier() __pragma(warning(pop));
    }




#line 196 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
}

extern "C" inline void atomic_signal_fence(const memory_order _Order) noexcept {
    if (_Order != memory_order_relaxed) {
        __pragma(warning(push)) __pragma(warning(disable : 4996)) _ReadWriteBarrier() __pragma(warning(pop));
    }
}

// FUNCTION TEMPLATE kill_dependency
template <class _Ty>
_Ty kill_dependency(_Ty _Arg) noexcept { // "magic" template that kills dependency ordering when called
    return _Arg;
}

// FUNCTION _Check_memory_order
inline void _Check_memory_order(const memory_order _Order) noexcept {
    // check that _Order is a valid memory_order
    if (static_cast<unsigned int>(_Order) > static_cast<unsigned int>(memory_order_seq_cst)) {
        do { (void) ((1 != _CrtDbgReport(2, "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 214, 0, "%s", "Invalid memory order")) || (__debugbreak(), 0)); ::_invalid_parameter(L"\"Invalid memory order\"", __LPREFIX( __FUNCTION__), L"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 214, 0); } while (false);
    }
}

// FUNCTION _Check_store_memory_order
inline void _Check_store_memory_order(const memory_order _Order) noexcept {
    switch (_Order) {
    case memory_order_relaxed:
    case memory_order_release:
    case memory_order_seq_cst:
        // nothing to do
        break;
    case memory_order_consume:
    case memory_order_acquire:
    case memory_order_acq_rel:
    default:
        do { (void) ((1 != _CrtDbgReport(2, "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 230, 0, "%s", "Invalid memory order")) || (__debugbreak(), 0)); ::_invalid_parameter(L"\"Invalid memory order\"", __LPREFIX( __FUNCTION__), L"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 230, 0); } while (false);
        break;
    }
}

// FUNCTION _Check_load_memory_order
inline void _Check_load_memory_order(const memory_order _Order) noexcept {
    switch (_Order) {
    case memory_order_relaxed:
    case memory_order_consume:
    case memory_order_acquire:
    case memory_order_seq_cst:
        // nothing to do
        break;
    case memory_order_release:
    case memory_order_acq_rel:
    default:
        do { (void) ((1 != _CrtDbgReport(2, "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 247, 0, "%s", "Invalid memory order")) || (__debugbreak(), 0)); ::_invalid_parameter(L"\"Invalid memory order\"", __LPREFIX( __FUNCTION__), L"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 247, 0); } while (false);
        break;
    }
}

// FUNCTION _Combine_cas_memory_orders
[[nodiscard]] inline memory_order _Combine_cas_memory_orders(
    const memory_order _Success, const memory_order _Failure) noexcept {
    // Finds upper bound of a compare/exchange memory order
    // pair, according to the following partial order:
    //     seq_cst
    //        |
    //     acq_rel
    //     /     \
    // acquire  release
    //    |       |
    // consume    |
    //     \     /
    //     relaxed
    static constexpr memory_order _Combined_memory_orders[6][6] = {// combined upper bounds
        {memory_order_relaxed, memory_order_consume, memory_order_acquire, memory_order_release, memory_order_acq_rel,
            memory_order_seq_cst},
        {memory_order_consume, memory_order_consume, memory_order_acquire, memory_order_acq_rel, memory_order_acq_rel,
            memory_order_seq_cst},
        {memory_order_acquire, memory_order_acquire, memory_order_acquire, memory_order_acq_rel, memory_order_acq_rel,
            memory_order_seq_cst},
        {memory_order_release, memory_order_acq_rel, memory_order_acq_rel, memory_order_release, memory_order_acq_rel,
            memory_order_seq_cst},
        {memory_order_acq_rel, memory_order_acq_rel, memory_order_acq_rel, memory_order_acq_rel, memory_order_acq_rel,
            memory_order_seq_cst},
        {memory_order_seq_cst, memory_order_seq_cst, memory_order_seq_cst, memory_order_seq_cst, memory_order_seq_cst,
            memory_order_seq_cst}};

    _Check_memory_order(_Success);
    _Check_load_memory_order(_Failure);
    return _Combined_memory_orders[static_cast<int>(_Success)][static_cast<int>(_Failure)];
}

// FUNCTION TEMPLATE _Atomic_reinterpret_as
template <class _Integral, class _Ty>
[[nodiscard]] _Integral _Atomic_reinterpret_as(const _Ty& _Source) noexcept {
    // interprets _Source as the supplied integral type
    static_assert(is_integral_v<_Integral>, "Tried to reinterpret memory as non-integral");

    if constexpr (is_integral_v<_Ty> && sizeof(_Integral) == sizeof(_Ty)) {
        return static_cast<_Integral>(_Source);
    } else if constexpr (is_pointer_v<_Ty> && sizeof(_Integral) == sizeof(_Ty)) {
        return reinterpret_cast<_Integral>(_Source);
    } else
#line 297 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
    {
        _Integral _Result{}; // zero padding bits
        :: memcpy(&_Result, ::std:: addressof(_Source), sizeof(_Source));
        return _Result;
    }
}

// FUNCTION _Load_barrier
inline void _Load_barrier(const memory_order _Order) noexcept { // implement memory barrier for atomic load functions
    switch (_Order) {
    case memory_order_relaxed:
        // no barrier
        break;
    default:
    case memory_order_release:
    case memory_order_acq_rel:
        do { (void) ((1 != _CrtDbgReport(2, "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 313, 0, "%s", "Invalid memory order")) || (__debugbreak(), 0)); ::_invalid_parameter(L"\"Invalid memory order\"", __LPREFIX( __FUNCTION__), L"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 313, 0); } while (false);
        // [[fallthrough]];
    case memory_order_consume:
    case memory_order_acquire:
    case memory_order_seq_cst:
        __pragma(warning(push)) __pragma(warning(disable : 4996)) _ReadWriteBarrier() __pragma(warning(pop));
        break;
    }
}


template <class _Ty>
struct _Atomic_padded {
    alignas(sizeof(_Ty)) mutable _Ty _Value; // align to sizeof(T); x86 stack aligns 8-byte objects on 4-byte boundaries
};










































#line 371 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

template <class _Ty>
struct _Atomic_storage_types {
    using _TStorage = _Atomic_padded<_Ty>;
    using _Spinlock = long;
};

template <class _Ty>
struct _Atomic_storage_types<_Ty&> {
    using _TStorage = _Ty&;
    using _Spinlock = _Smtx_t*; // POINTER TO mutex
};

// STRUCT TEMPLATE _Atomic_storage

template <class _Ty, size_t = sizeof(remove_reference_t<_Ty>)>


#line 390 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
struct _Atomic_storage;




























#line 420 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"


inline void _Atomic_lock_acquire(long& _Spinlock) noexcept {
    while (_InterlockedExchange(&_Spinlock, 1)) {
        ;
    }
}

inline void _Atomic_lock_release(long& _Spinlock) noexcept {




#line 434 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
    _InterlockedExchange(&_Spinlock, 0);
#line 436 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
}


inline void _Atomic_lock_acquire(_Smtx_t* _Spinlock) noexcept {
    _Smtx_lock_exclusive(_Spinlock);
}

inline void _Atomic_lock_release(_Smtx_t* _Spinlock) noexcept {
    _Smtx_unlock_exclusive(_Spinlock);
}

template <class _Spinlock_t>
class [[nodiscard]] _Atomic_lock_guard {
public:
    explicit _Atomic_lock_guard(_Spinlock_t& _Spinlock_) noexcept : _Spinlock(_Spinlock_) {
        _Atomic_lock_acquire(_Spinlock);
    }

    ~_Atomic_lock_guard() {
        _Atomic_lock_release(_Spinlock);
    }

    _Atomic_lock_guard(const _Atomic_lock_guard&) = delete;
    _Atomic_lock_guard& operator=(const _Atomic_lock_guard&) = delete;

private:
    _Spinlock_t& _Spinlock;
};





































#line 502 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
#line 503 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

template <class _Ty, size_t /* = ... */>
struct _Atomic_storage {
    // Provides operations common to all specializations of std::atomic, load, store, exchange, and CAS.
    // Locking version used when hardware has no atomic operations for sizeof(_Ty).

    using _TVal  = remove_reference_t<_Ty>;
    using _Guard = _Atomic_lock_guard<typename _Atomic_storage_types<_Ty>::_Spinlock>;

    _Atomic_storage() = default;

    /* implicit */ constexpr _Atomic_storage(conditional_t<is_reference_v<_Ty>, _Ty, const _TVal> _Value) noexcept
        : _Storage(_Value) {
        // non-atomically initialize this atomic
    }

    void store(const _TVal _Value, const memory_order _Order = memory_order_seq_cst) noexcept {
        // store with sequential consistency
        _Check_store_memory_order(_Order);
        _Guard _Lock{_Spinlock};
        _Storage = _Value;
    }

    [[nodiscard]] _TVal load(const memory_order _Order = memory_order_seq_cst) const noexcept {
        // load with sequential consistency
        _Check_load_memory_order(_Order);
        _Guard _Lock{_Spinlock};
        _TVal _Local(_Storage);
        return _Local;
    }

    _TVal exchange(const _TVal _Value, const memory_order _Order = memory_order_seq_cst) noexcept {
        // exchange _Value with _Storage with sequential consistency
        _Check_memory_order(_Order);
        _Guard _Lock{_Spinlock};
        _TVal _Result(_Storage);
        _Storage = _Value;
        return _Result;
    }

    bool compare_exchange_strong(_TVal& _Expected, const _TVal _Desired,
        const memory_order _Order = memory_order_seq_cst) noexcept { // CAS with sequential consistency, plain
        _Check_memory_order(_Order);
        const auto _Storage_ptr  = ::std:: addressof(_Storage);
        const auto _Expected_ptr = ::std:: addressof(_Expected);
        bool _Result;


#line 552 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        _Guard _Lock{_Spinlock};










#line 564 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        _Result = :: memcmp(_Storage_ptr, _Expected_ptr, sizeof(_TVal)) == 0;
#line 566 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        if (_Result) {
            :: memcpy(_Storage_ptr, ::std:: addressof(_Desired), sizeof(_TVal));
        } else {
            :: memcpy(_Expected_ptr, _Storage_ptr, sizeof(_TVal));
        }

        return _Result;
    }













































#line 620 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"


protected:
    void _Init_spinlock_for_ref() noexcept {
        _Spinlock = __std_atomic_get_mutex(::std:: addressof(_Storage));
    }

private:
    // Spinlock integer for non-lock-free atomic. <xthreads.h> mutex pointer for non-lock-free atomic_ref
    mutable typename _Atomic_storage_types<_Ty>::_Spinlock _Spinlock{};

public:
    _Ty _Storage{};




#line 638 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
};

template <class _Ty>
struct _Atomic_storage<_Ty, 1> { // lock-free using 1-byte intrinsics

    using _TVal = remove_reference_t<_Ty>;

    _Atomic_storage() = default;

    /* implicit */ constexpr _Atomic_storage(conditional_t<is_reference_v<_Ty>, _Ty, const _TVal> _Value) noexcept
        : _Storage{_Value} {
        // non-atomically initialize this atomic
    }

    void store(const _TVal _Value) noexcept { // store with sequential consistency
        const auto _Mem      = _Atomic_address_as<char>(_Storage);
        const char _As_bytes = _Atomic_reinterpret_as<char>(_Value);




#line 660 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        (void) _InterlockedExchange8(_Mem, _As_bytes);
#line 662 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
    }

    void store(const _TVal _Value, const memory_order _Order) noexcept { // store with given memory order
        const auto _Mem      = _Atomic_address_as<char>(_Storage);
        const char _As_bytes = _Atomic_reinterpret_as<char>(_Value);
        switch (_Order) {
        case memory_order_relaxed:
            __iso_volatile_store8(_Mem, _As_bytes);
            return;
        case memory_order_release:
            __pragma(warning(push)) __pragma(warning(disable : 4996)) _ReadWriteBarrier() __pragma(warning(pop));
            __iso_volatile_store8(_Mem, _As_bytes);
            return;
        default:
        case memory_order_consume:
        case memory_order_acquire:
        case memory_order_acq_rel:
            do { (void) ((1 != _CrtDbgReport(2, "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 679, 0, "%s", "Invalid memory order")) || (__debugbreak(), 0)); ::_invalid_parameter(L"\"Invalid memory order\"", __LPREFIX( __FUNCTION__), L"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 679, 0); } while (false);
            // [[fallthrough]];
        case memory_order_seq_cst:
            store(_Value);
            return;
        }
    }

    [[nodiscard]] _TVal load() const noexcept { // load with sequential consistency
        const auto _Mem = _Atomic_address_as<char>(_Storage);
        char _As_bytes  = __iso_volatile_load8(_Mem);
        __pragma(warning(push)) __pragma(warning(disable : 4996)) _ReadWriteBarrier() __pragma(warning(pop));
        return reinterpret_cast<_TVal&>(_As_bytes);
    }

    [[nodiscard]] _TVal load(const memory_order _Order) const noexcept { // load with given memory order
        const auto _Mem = _Atomic_address_as<char>(_Storage);
        char _As_bytes  = __iso_volatile_load8(_Mem);
        _Load_barrier(_Order);
        return reinterpret_cast<_TVal&>(_As_bytes);
    }

    _TVal exchange(const _TVal _Value, const memory_order _Order = memory_order_seq_cst) noexcept {
        // exchange with given memory order
        char _As_bytes;
        _Check_memory_order(_Order); _As_bytes = _InterlockedExchange8(_Atomic_address_as<char>(_Storage), _Atomic_reinterpret_as<char>(_Value));
#line 706 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return reinterpret_cast<_TVal&>(_As_bytes);
    }

    bool compare_exchange_strong(_TVal& _Expected, const _TVal _Desired,
        const memory_order _Order = memory_order_seq_cst) noexcept { // CAS with given memory order
        char _Expected_bytes = _Atomic_reinterpret_as<char>(_Expected); // read before atomic operation
        char _Prev_bytes;




















#line 734 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        _Check_memory_order(_Order); _Prev_bytes = _InterlockedCompareExchange8(_Atomic_address_as<char>(_Storage), _Atomic_reinterpret_as<char>(_Desired), _Expected_bytes);
#line 736 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        if (_Prev_bytes == _Expected_bytes) {
            return true;
        }

        reinterpret_cast<char&>(_Expected) = _Prev_bytes;
        return false;
    }













#line 757 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    typename _Atomic_storage_types<_Ty>::_TStorage _Storage;
};

template <class _Ty>
struct _Atomic_storage<_Ty, 2> { // lock-free using 2-byte intrinsics

    using _TVal = remove_reference_t<_Ty>;

    _Atomic_storage() = default;

    /* implicit */ constexpr _Atomic_storage(conditional_t<is_reference_v<_Ty>, _Ty, const _TVal> _Value) noexcept
        : _Storage{_Value} {
        // non-atomically initialize this atomic
    }

    void store(const _TVal _Value) noexcept { // store with sequential consistency
        const auto _Mem       = _Atomic_address_as<short>(_Storage);
        const short _As_bytes = _Atomic_reinterpret_as<short>(_Value);




#line 781 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        (void) _InterlockedExchange16(_Mem, _As_bytes);
#line 783 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
    }

    void store(const _TVal _Value, const memory_order _Order) noexcept { // store with given memory order
        const auto _Mem       = _Atomic_address_as<short>(_Storage);
        const short _As_bytes = _Atomic_reinterpret_as<short>(_Value);
        switch (_Order) {
        case memory_order_relaxed:
            __iso_volatile_store16(_Mem, _As_bytes);
            return;
        case memory_order_release:
            __pragma(warning(push)) __pragma(warning(disable : 4996)) _ReadWriteBarrier() __pragma(warning(pop));
            __iso_volatile_store16(_Mem, _As_bytes);
            return;
        default:
        case memory_order_consume:
        case memory_order_acquire:
        case memory_order_acq_rel:
            do { (void) ((1 != _CrtDbgReport(2, "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 800, 0, "%s", "Invalid memory order")) || (__debugbreak(), 0)); ::_invalid_parameter(L"\"Invalid memory order\"", __LPREFIX( __FUNCTION__), L"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 800, 0); } while (false);
            // [[fallthrough]];
        case memory_order_seq_cst:
            store(_Value);
            return;
        }
    }

    [[nodiscard]] _TVal load() const noexcept { // load with sequential consistency
        const auto _Mem = _Atomic_address_as<short>(_Storage);
        short _As_bytes = __iso_volatile_load16(_Mem);
        __pragma(warning(push)) __pragma(warning(disable : 4996)) _ReadWriteBarrier() __pragma(warning(pop));
        return reinterpret_cast<_TVal&>(_As_bytes);
    }

    [[nodiscard]] _TVal load(const memory_order _Order) const noexcept { // load with given memory order
        const auto _Mem = _Atomic_address_as<short>(_Storage);
        short _As_bytes = __iso_volatile_load16(_Mem);
        _Load_barrier(_Order);
        return reinterpret_cast<_TVal&>(_As_bytes);
    }

    _TVal exchange(const _TVal _Value, const memory_order _Order = memory_order_seq_cst) noexcept {
        // exchange with given memory order
        short _As_bytes;
        _Check_memory_order(_Order); _As_bytes = _InterlockedExchange16(_Atomic_address_as<short>(_Storage), _Atomic_reinterpret_as<short>(_Value));
#line 827 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return reinterpret_cast<_TVal&>(_As_bytes);
    }

    bool compare_exchange_strong(_TVal& _Expected, const _TVal _Desired,
        const memory_order _Order = memory_order_seq_cst) noexcept { // CAS with given memory order
        short _Expected_bytes = _Atomic_reinterpret_as<short>(_Expected); // read before atomic operation
        short _Prev_bytes;



















#line 854 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        _Check_memory_order(_Order); _Prev_bytes = _InterlockedCompareExchange16(_Atomic_address_as<short>(_Storage), _Atomic_reinterpret_as<short>(_Desired), _Expected_bytes);
#line 856 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        if (_Prev_bytes == _Expected_bytes) {
            return true;
        }

        :: memcpy(::std:: addressof(_Expected), &_Prev_bytes, sizeof(_Ty));
        return false;
    }













#line 877 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    typename _Atomic_storage_types<_Ty>::_TStorage _Storage;
};

template <class _Ty>
struct _Atomic_storage<_Ty, 4> { // lock-free using 4-byte intrinsics

    using _TVal = remove_reference_t<_Ty>;

    _Atomic_storage() = default;

    /* implicit */ constexpr _Atomic_storage(conditional_t<is_reference_v<_Ty>, _Ty, const _TVal> _Value) noexcept
        : _Storage{_Value} {
        // non-atomically initialize this atomic
    }

    void store(const _TVal _Value) noexcept { // store with sequential consistency




#line 899 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        (void) _InterlockedExchange(_Atomic_address_as<long>(_Storage), _Atomic_reinterpret_as<long>(_Value));
#line 901 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
    }

    void store(const _TVal _Value, const memory_order _Order) noexcept { // store with given memory order
        const auto _Mem     = _Atomic_address_as<int>(_Storage);
        const int _As_bytes = _Atomic_reinterpret_as<int>(_Value);
        switch (_Order) {
        case memory_order_relaxed:
            __iso_volatile_store32(_Mem, _As_bytes);
            return;
        case memory_order_release:
            __pragma(warning(push)) __pragma(warning(disable : 4996)) _ReadWriteBarrier() __pragma(warning(pop));
            __iso_volatile_store32(_Mem, _As_bytes);
            return;
        default:
        case memory_order_consume:
        case memory_order_acquire:
        case memory_order_acq_rel:
            do { (void) ((1 != _CrtDbgReport(2, "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 918, 0, "%s", "Invalid memory order")) || (__debugbreak(), 0)); ::_invalid_parameter(L"\"Invalid memory order\"", __LPREFIX( __FUNCTION__), L"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 918, 0); } while (false);
            // [[fallthrough]];
        case memory_order_seq_cst:
            store(_Value);
            return;
        }
    }

    [[nodiscard]] _TVal load() const noexcept { // load with sequential consistency
        const auto _Mem = _Atomic_address_as<int>(_Storage);
        auto _As_bytes  = __iso_volatile_load32(_Mem);
        __pragma(warning(push)) __pragma(warning(disable : 4996)) _ReadWriteBarrier() __pragma(warning(pop));
        return reinterpret_cast<_TVal&>(_As_bytes);
    }

    [[nodiscard]] _TVal load(const memory_order _Order) const noexcept { // load with given memory order
        const auto _Mem = _Atomic_address_as<int>(_Storage);
        auto _As_bytes  = __iso_volatile_load32(_Mem);
        _Load_barrier(_Order);
        return reinterpret_cast<_TVal&>(_As_bytes);
    }

    _TVal exchange(const _TVal _Value, const memory_order _Order = memory_order_seq_cst) noexcept {
        // exchange with given memory order
        long _As_bytes;
        _Check_memory_order(_Order); _As_bytes = _InterlockedExchange(_Atomic_address_as<long>(_Storage), _Atomic_reinterpret_as<long>(_Value));
#line 945 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return reinterpret_cast<_TVal&>(_As_bytes);
    }

    bool compare_exchange_strong(_TVal& _Expected, const _TVal _Desired,
        const memory_order _Order = memory_order_seq_cst) noexcept { // CAS with given memory order
        long _Expected_bytes = _Atomic_reinterpret_as<long>(_Expected); // read before atomic operation
        long _Prev_bytes;



















#line 972 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        _Check_memory_order(_Order); _Prev_bytes = _InterlockedCompareExchange(_Atomic_address_as<long>(_Storage), _Atomic_reinterpret_as<long>(_Desired), _Expected_bytes);
#line 974 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        if (_Prev_bytes == _Expected_bytes) {
            return true;
        }

        :: memcpy(::std:: addressof(_Expected), &_Prev_bytes, sizeof(_TVal));
        return false;
    }













#line 995 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    typename _Atomic_storage_types<_Ty>::_TStorage _Storage;
};

template <class _Ty>
struct _Atomic_storage<_Ty, 8> { // lock-free using 8-byte intrinsics

    using _TVal = remove_reference_t<_Ty>;

    _Atomic_storage() = default;

    /* implicit */ constexpr _Atomic_storage(conditional_t<is_reference_v<_Ty>, _Ty, const _TVal> _Value) noexcept
        : _Storage{_Value} {
        // non-atomically initialize this atomic
    }

    void store(const _TVal _Value) noexcept { // store with sequential consistency
        const auto _Mem           = _Atomic_address_as<long long>(_Storage);
        const long long _As_bytes = _Atomic_reinterpret_as<long long>(_Value);




#line 1019 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"



#line 1023 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        (void) _InterlockedExchange64(_Mem, _As_bytes);
#line 1025 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
    }

    void store(const _TVal _Value, const memory_order _Order) noexcept { // store with given memory order
        const auto _Mem           = _Atomic_address_as<long long>(_Storage);
        const long long _As_bytes = _Atomic_reinterpret_as<long long>(_Value);
        switch (_Order) {
        case memory_order_relaxed:
            __iso_volatile_store64(_Mem, _As_bytes);
            return;
        case memory_order_release:
            __pragma(warning(push)) __pragma(warning(disable : 4996)) _ReadWriteBarrier() __pragma(warning(pop));
            __iso_volatile_store64(_Mem, _As_bytes);
            return;
        default:
        case memory_order_consume:
        case memory_order_acquire:
        case memory_order_acq_rel:
            do { (void) ((1 != _CrtDbgReport(2, "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 1042, 0, "%s", "Invalid memory order")) || (__debugbreak(), 0)); ::_invalid_parameter(L"\"Invalid memory order\"", __LPREFIX( __FUNCTION__), L"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic", 1042, 0); } while (false);
            // [[fallthrough]];
        case memory_order_seq_cst:
            store(_Value);
            return;
        }
    }

    [[nodiscard]] _TVal load() const noexcept { // load with sequential consistency
        const auto _Mem = _Atomic_address_as<long long>(_Storage);
        long long _As_bytes;




        _As_bytes = __iso_volatile_load64(_Mem);
        __pragma(warning(push)) __pragma(warning(disable : 4996)) _ReadWriteBarrier() __pragma(warning(pop));
#line 1060 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return reinterpret_cast<_TVal&>(_As_bytes);
    }

    [[nodiscard]] _TVal load(const memory_order _Order) const noexcept { // load with given memory order
        const auto _Mem = _Atomic_address_as<long long>(_Storage);



        long long _As_bytes = __iso_volatile_load64(_Mem);
#line 1070 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        _Load_barrier(_Order);
        return reinterpret_cast<_TVal&>(_As_bytes);
    }











    _TVal exchange(const _TVal _Value, const memory_order _Order = memory_order_seq_cst) noexcept {
        // exchange with given memory order
        long long _As_bytes;
        _Check_memory_order(_Order); _As_bytes = _InterlockedExchange64(_Atomic_address_as<long long>(_Storage), _Atomic_reinterpret_as<long long>(_Value));
#line 1089 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return reinterpret_cast<_TVal&>(_As_bytes);
    }
#line 1092 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    bool compare_exchange_strong(_TVal& _Expected, const _TVal _Desired,
        const memory_order _Order = memory_order_seq_cst) noexcept { // CAS with given memory order
        long long _Expected_bytes = _Atomic_reinterpret_as<long long>(_Expected); // read before atomic operation
        long long _Prev_bytes;





















#line 1119 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        _Check_memory_order(_Order); _Prev_bytes = _InterlockedCompareExchange64(_Atomic_address_as<long long>(_Storage), _Atomic_reinterpret_as<long long>(_Desired), _Expected_bytes);
#line 1121 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        if (_Prev_bytes == _Expected_bytes) {
            return true;
        }

        :: memcpy(::std:: addressof(_Expected), &_Prev_bytes, sizeof(_TVal));
        return false;
    }













#line 1142 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    typename _Atomic_storage_types<_Ty>::_TStorage _Storage;
};


template <class _Ty>
struct _Atomic_storage<_Ty&, 16> { // lock-free using 16-byte intrinsics
    // TRANSITION, ABI: replace '_Ty&' with '_Ty' in this specialization
    using _TVal = remove_reference_t<_Ty&>;

    _Atomic_storage() = default;

    /* implicit */ constexpr _Atomic_storage(conditional_t<is_reference_v<_Ty&>, _Ty&, const _TVal> _Value) noexcept
        : _Storage{_Value} {} // non-atomically initialize this atomic

    void store(const _TVal _Value) noexcept { // store with sequential consistency
        (void) exchange(_Value);
    }

    void store(const _TVal _Value, const memory_order _Order) noexcept { // store with given memory order
        _Check_store_memory_order(_Order);
        (void) exchange(_Value, _Order);
    }

    [[nodiscard]] _TVal load() const noexcept { // load with sequential consistency
        long long* const _Storage_ptr = const_cast<long long*>(_Atomic_address_as<const long long>(_Storage));
        _Int128 _Result{}; // atomic CAS 0 with 0
        (void) __std_atomic_compare_exchange_128(_Storage_ptr, 0, 0, &_Result._Low);
        return reinterpret_cast<_TVal&>(_Result);
    }

    [[nodiscard]] _TVal load(const memory_order _Order) const noexcept { // load with given memory order






















#line 1197 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        _Check_load_memory_order(_Order);
        return load();
#line 1200 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
    }

    _TVal exchange(const _TVal _Value) noexcept { // exchange with sequential consistency
        _TVal _Result{_Value};
        while (!compare_exchange_strong(_Result, _Value)) { // keep trying
        }

        return _Result;
    }

    _TVal exchange(const _TVal _Value, const memory_order _Order) noexcept { // exchange with given memory order
        _TVal _Result{_Value};
        while (!compare_exchange_strong(_Result, _Value, _Order)) { // keep trying
        }

        return _Result;
    }

    bool compare_exchange_strong(_TVal& _Expected, const _TVal _Desired,
        const memory_order _Order = memory_order_seq_cst) noexcept { // CAS with given memory order
        _Int128 _Desired_bytes{};
        :: memcpy(&_Desired_bytes, ::std:: addressof(_Desired), sizeof(_TVal));
        _Int128 _Expected_temp{};
        :: memcpy(&_Expected_temp, ::std:: addressof(_Expected), sizeof(_TVal));
        unsigned char _Result;


































#line 1260 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"



#line 1264 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        (void) _Order;
        _Result = __std_atomic_compare_exchange_128(
            &reinterpret_cast<long long&>(_Storage), _Desired_bytes._High, _Desired_bytes._Low, &_Expected_temp._Low);
#line 1268 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        if (_Result == 0) {
            :: memcpy(::std:: addressof(_Expected), &_Expected_temp, sizeof(_TVal));
        }

        return _Result != 0;
    }







































#line 1314 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    struct _Int128 {
        alignas(16) long long _Low;
        long long _High;
    };

    typename _Atomic_storage_types<_Ty&>::_TStorage _Storage;
};
#line 1323 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

// STRUCT TEMPLATE _Atomic_integral
template <class _Ty, size_t = sizeof(_Ty)>
struct _Atomic_integral; // not defined

template <class _Ty>
struct _Atomic_integral<_Ty, 1> : _Atomic_storage<_Ty> { // atomic integral operations using 1-byte intrinsics
    using _Base = _Atomic_storage<_Ty>;
    using typename _Base::_TVal;






    using _Base::_Base;
#line 1340 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    _TVal fetch_add(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        char _Result;
        _Check_memory_order(_Order); _Result = _InterlockedExchangeAdd8(_Atomic_address_as<char>(this->_Storage), static_cast<char>(_Operand));
#line 1345 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal fetch_and(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        char _Result;
        _Check_memory_order(_Order); _Result = _InterlockedAnd8(_Atomic_address_as<char>(this->_Storage), static_cast<char>(_Operand));
#line 1352 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal fetch_or(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        char _Result;
        _Check_memory_order(_Order); _Result = _InterlockedOr8(_Atomic_address_as<char>(this->_Storage), static_cast<char>(_Operand));
#line 1359 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal fetch_xor(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        char _Result;
        _Check_memory_order(_Order); _Result = _InterlockedXor8(_Atomic_address_as<char>(this->_Storage), static_cast<char>(_Operand));
#line 1366 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal operator++(int) noexcept {
        return static_cast<_TVal>(_InterlockedExchangeAdd8(_Atomic_address_as<char>(this->_Storage), 1));
    }

    _TVal operator++() noexcept {
        unsigned char _Before =
            static_cast<unsigned char>(_InterlockedExchangeAdd8(_Atomic_address_as<char>(this->_Storage), 1));
        ++_Before;
        return static_cast<_TVal>(_Before);
    }

    _TVal operator--(int) noexcept {
        return static_cast<_TVal>(_InterlockedExchangeAdd8(_Atomic_address_as<char>(this->_Storage), -1));
    }

    _TVal operator--() noexcept {
        unsigned char _Before =
            static_cast<unsigned char>(_InterlockedExchangeAdd8(_Atomic_address_as<char>(this->_Storage), -1));
        --_Before;
        return static_cast<_TVal>(_Before);
    }
};

template <class _Ty>
struct _Atomic_integral<_Ty, 2> : _Atomic_storage<_Ty> { // atomic integral operations using 2-byte intrinsics
    using _Base = _Atomic_storage<_Ty>;
    using typename _Base::_TVal;






    using _Base::_Base;
#line 1404 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    _TVal fetch_add(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        short _Result;
        _Check_memory_order(_Order); _Result = _InterlockedExchangeAdd16(_Atomic_address_as<short>(this->_Storage), static_cast<short>(_Operand));
#line 1409 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal fetch_and(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        short _Result;
        _Check_memory_order(_Order); _Result = _InterlockedAnd16(_Atomic_address_as<short>(this->_Storage), static_cast<short>(_Operand));
#line 1416 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal fetch_or(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        short _Result;
        _Check_memory_order(_Order); _Result = _InterlockedOr16(_Atomic_address_as<short>(this->_Storage), static_cast<short>(_Operand));
#line 1423 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal fetch_xor(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        short _Result;
        _Check_memory_order(_Order); _Result = _InterlockedXor16(_Atomic_address_as<short>(this->_Storage), static_cast<short>(_Operand));
#line 1430 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal operator++(int) noexcept {
        unsigned short _After =
            static_cast<unsigned short>(_InterlockedIncrement16(_Atomic_address_as<short>(this->_Storage)));
        --_After;
        return static_cast<_TVal>(_After);
    }

    _TVal operator++() noexcept {
        return static_cast<_TVal>(_InterlockedIncrement16(_Atomic_address_as<short>(this->_Storage)));
    }

    _TVal operator--(int) noexcept {
        unsigned short _After =
            static_cast<unsigned short>(_InterlockedDecrement16(_Atomic_address_as<short>(this->_Storage)));
        ++_After;
        return static_cast<_TVal>(_After);
    }

    _TVal operator--() noexcept {
        return static_cast<_TVal>(_InterlockedDecrement16(_Atomic_address_as<short>(this->_Storage)));
    }
};

template <class _Ty>
struct _Atomic_integral<_Ty, 4> : _Atomic_storage<_Ty> { // atomic integral operations using 4-byte intrinsics
    using _Base = _Atomic_storage<_Ty>;
    using typename _Base::_TVal;






    using _Base::_Base;
#line 1468 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    _TVal fetch_add(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        long _Result;
        _Check_memory_order(_Order); _Result = _InterlockedExchangeAdd(_Atomic_address_as<long>(this->_Storage), static_cast<long>(_Operand));
#line 1473 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal fetch_and(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        long _Result;
        _Check_memory_order(_Order); _Result = _InterlockedAnd(_Atomic_address_as<long>(this->_Storage), static_cast<long>(_Operand));
#line 1480 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal fetch_or(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        long _Result;
        _Check_memory_order(_Order); _Result = _InterlockedOr(_Atomic_address_as<long>(this->_Storage), static_cast<long>(_Operand));
#line 1487 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal fetch_xor(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        long _Result;
        _Check_memory_order(_Order); _Result = _InterlockedXor(_Atomic_address_as<long>(this->_Storage), static_cast<long>(_Operand));
#line 1494 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal operator++(int) noexcept {
        unsigned long _After =
            static_cast<unsigned long>(_InterlockedIncrement(_Atomic_address_as<long>(this->_Storage)));
        --_After;
        return static_cast<_TVal>(_After);
    }

    _TVal operator++() noexcept {
        return static_cast<_TVal>(_InterlockedIncrement(_Atomic_address_as<long>(this->_Storage)));
    }

    _TVal operator--(int) noexcept {
        unsigned long _After =
            static_cast<unsigned long>(_InterlockedDecrement(_Atomic_address_as<long>(this->_Storage)));
        ++_After;
        return static_cast<_TVal>(_After);
    }

    _TVal operator--() noexcept {
        return static_cast<_TVal>(_InterlockedDecrement(_Atomic_address_as<long>(this->_Storage)));
    }
};

template <class _Ty>
struct _Atomic_integral<_Ty, 8> : _Atomic_storage<_Ty> { // atomic integral operations using 8-byte intrinsics
    using _Base = _Atomic_storage<_Ty>;
    using typename _Base::_TVal;






    using _Base::_Base;
#line 1532 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"























































    _TVal fetch_add(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        long long _Result;
        _Check_memory_order(_Order); _Result = _InterlockedExchangeAdd64(_Atomic_address_as<long long>(this->_Storage), static_cast<long long>(_Operand));
#line 1591 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal fetch_and(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        long long _Result;
        _Check_memory_order(_Order); _Result = _InterlockedAnd64(_Atomic_address_as<long long>(this->_Storage), static_cast<long long>(_Operand));
#line 1598 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal fetch_or(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        long long _Result;
        _Check_memory_order(_Order); _Result = _InterlockedOr64(_Atomic_address_as<long long>(this->_Storage), static_cast<long long>(_Operand));
#line 1605 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal fetch_xor(const _TVal _Operand, const memory_order _Order = memory_order_seq_cst) noexcept {
        long long _Result;
        _Check_memory_order(_Order); _Result = _InterlockedXor64(_Atomic_address_as<long long>(this->_Storage), static_cast<long long>(_Operand));
#line 1612 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return static_cast<_TVal>(_Result);
    }

    _TVal operator++(int) noexcept {
        unsigned long long _After =
            static_cast<unsigned long long>(_InterlockedIncrement64(_Atomic_address_as<long long>(this->_Storage)));
        --_After;
        return static_cast<_TVal>(_After);
    }

    _TVal operator++() noexcept {
        return static_cast<_TVal>(_InterlockedIncrement64(_Atomic_address_as<long long>(this->_Storage)));
    }

    _TVal operator--(int) noexcept {
        unsigned long long _After =
            static_cast<unsigned long long>(_InterlockedDecrement64(_Atomic_address_as<long long>(this->_Storage)));
        ++_After;
        return static_cast<_TVal>(_After);
    }

    _TVal operator--() noexcept {
        return static_cast<_TVal>(_InterlockedDecrement64(_Atomic_address_as<long long>(this->_Storage)));
    }
#line 1637 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
};


template <size_t _TypeSize>
 constexpr bool _Is_always_lock_free = _TypeSize <= 8 && (_TypeSize & (_TypeSize - 1)) == 0;








#line 1651 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

template <class _Ty, bool _Is_lock_free = _Is_always_lock_free<sizeof(_Ty)>>
 constexpr bool _Deprecate_non_lock_free_volatile = true;

template <class _Ty>
  constexpr bool _Deprecate_non_lock_free_volatile<_Ty, false> = true;

// STRUCT TEMPLATE _Atomic_integral_facade
template <class _Ty>
struct _Atomic_integral_facade : _Atomic_integral<_Ty> {
    // provides operator overloads and other support for atomic integral specializations
    using _Base           = _Atomic_integral<_Ty>;
    using difference_type = _Ty;





    using _Base::_Base;
#line 1671 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    // _Deprecate_non_lock_free_volatile is unnecessary here.

    // note: const_cast-ing away volatile is safe because all our intrinsics add volatile back on.
    // We make the primary functions non-volatile for better debug codegen, as non-volatile atomics
    // are far more common than volatile ones.
    using _Base::fetch_add;
    _Ty fetch_add(const _Ty _Operand) volatile noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_add(_Operand);
    }

    _Ty fetch_add(const _Ty _Operand, const memory_order _Order) volatile noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_add(_Operand, _Order);
    }

    [[nodiscard]] static _Ty _Negate(const _Ty _Value) noexcept { // returns two's complement negated value of _Value
        return static_cast<_Ty>(0U - static_cast<make_unsigned_t<_Ty>>(_Value));
    }

    _Ty fetch_sub(const _Ty _Operand) noexcept {
        return fetch_add(_Negate(_Operand));
    }

    _Ty fetch_sub(const _Ty _Operand) volatile noexcept {
        return fetch_add(_Negate(_Operand));
    }

    _Ty fetch_sub(const _Ty _Operand, const memory_order _Order) noexcept {
        return fetch_add(_Negate(_Operand), _Order);
    }

    _Ty fetch_sub(const _Ty _Operand, const memory_order _Order) volatile noexcept {
        return fetch_add(_Negate(_Operand), _Order);
    }

    using _Base::fetch_and;
    _Ty fetch_and(const _Ty _Operand) volatile noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_and(_Operand);
    }

    _Ty fetch_and(const _Ty _Operand, const memory_order _Order) volatile noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_and(_Operand, _Order);
    }

    using _Base::fetch_or;
    _Ty fetch_or(const _Ty _Operand) volatile noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_or(_Operand);
    }

    _Ty fetch_or(const _Ty _Operand, const memory_order _Order) volatile noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_or(_Operand, _Order);
    }

    using _Base::fetch_xor;
    _Ty fetch_xor(const _Ty _Operand) volatile noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_xor(_Operand);
    }

    _Ty fetch_xor(const _Ty _Operand, const memory_order _Order) volatile noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_xor(_Operand, _Order);
    }

    using _Base::operator++;
    _Ty operator++(int) volatile noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::operator++(0);
    }

    _Ty operator++() volatile noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::operator++();
    }

    using _Base::operator--;
    _Ty operator--(int) volatile noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::operator--(0);
    }

    _Ty operator--() volatile noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::operator--();
    }

    _Ty operator+=(const _Ty _Operand) noexcept {
        return static_cast<_Ty>(this->_Base::fetch_add(_Operand) + _Operand);
    }

    _Ty operator+=(const _Ty _Operand) volatile noexcept {
        return static_cast<_Ty>(const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_add(_Operand) + _Operand);
    }

    _Ty operator-=(const _Ty _Operand) noexcept {
        return static_cast<_Ty>(fetch_sub(_Operand) - _Operand);
    }

    _Ty operator-=(const _Ty _Operand) volatile noexcept {
        return static_cast<_Ty>(const_cast<_Atomic_integral_facade*>(this)->fetch_sub(_Operand) - _Operand);
    }

    _Ty operator&=(const _Ty _Operand) noexcept {
        return static_cast<_Ty>(this->_Base::fetch_and(_Operand) & _Operand);
    }

    _Ty operator&=(const _Ty _Operand) volatile noexcept {
        return static_cast<_Ty>(const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_and(_Operand) & _Operand);
    }

    _Ty operator|=(const _Ty _Operand) noexcept {
        return static_cast<_Ty>(this->_Base::fetch_or(_Operand) | _Operand);
    }

    _Ty operator|=(const _Ty _Operand) volatile noexcept {
        return static_cast<_Ty>(const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_or(_Operand) | _Operand);
    }

    _Ty operator^=(const _Ty _Operand) noexcept {
        return static_cast<_Ty>(this->_Base::fetch_xor(_Operand) ^ _Operand);
    }

    _Ty operator^=(const _Ty _Operand) volatile noexcept {
        return static_cast<_Ty>(const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_xor(_Operand) ^ _Operand);
    }
};

// STRUCT TEMPLATE _Atomic_integral_facade
template <class _Ty>
struct _Atomic_integral_facade<_Ty&> : _Atomic_integral<_Ty&> {
    // provides operator overloads and other support for atomic integral specializations
    using _Base           = _Atomic_integral<_Ty&>;
    using difference_type = _Ty;





    using _Base::_Base;
#line 1805 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    [[nodiscard]] static _Ty _Negate(const _Ty _Value) noexcept { // returns two's complement negated value of _Value
        return static_cast<_Ty>(0U - static_cast<make_unsigned_t<_Ty>>(_Value));
    }

    _Ty fetch_add(const _Ty _Operand) const noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_add(_Operand);
    }

    _Ty fetch_add(const _Ty _Operand, const memory_order _Order) const noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_add(_Operand, _Order);
    }

    _Ty fetch_sub(const _Ty _Operand) const noexcept {
        return fetch_add(_Negate(_Operand));
    }

    _Ty fetch_sub(const _Ty _Operand, const memory_order _Order) const noexcept {
        return fetch_add(_Negate(_Operand), _Order);
    }

    _Ty operator++(int) const noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::operator++(0);
    }

    _Ty operator++() const noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::operator++();
    }

    _Ty operator--(int) const noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::operator--(0);
    }

    _Ty operator--() const noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::operator--();
    }

    _Ty operator+=(const _Ty _Operand) const noexcept {
        return static_cast<_Ty>(fetch_add(_Operand) + _Operand);
    }

    _Ty operator-=(const _Ty _Operand) const noexcept {
        return static_cast<_Ty>(fetch_sub(_Operand) - _Operand);
    }

    _Ty fetch_and(const _Ty _Operand) const noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_and(_Operand);
    }

    _Ty fetch_and(const _Ty _Operand, const memory_order _Order) const noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_and(_Operand, _Order);
    }

    _Ty fetch_or(const _Ty _Operand) const noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_or(_Operand);
    }

    _Ty fetch_or(const _Ty _Operand, const memory_order _Order) const noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_or(_Operand, _Order);
    }

    _Ty fetch_xor(const _Ty _Operand) const noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_xor(_Operand);
    }

    _Ty fetch_xor(const _Ty _Operand, const memory_order _Order) const noexcept {
        return const_cast<_Atomic_integral_facade*>(this)->_Base::fetch_xor(_Operand, _Order);
    }

    _Ty operator&=(const _Ty _Operand) const noexcept {
        return static_cast<_Ty>(fetch_and(_Operand) & _Operand);
    }

    _Ty operator|=(const _Ty _Operand) const noexcept {
        return static_cast<_Ty>(fetch_or(_Operand) | _Operand);
    }

    _Ty operator^=(const _Ty _Operand) const noexcept {
        return static_cast<_Ty>(fetch_xor(_Operand) ^ _Operand);
    }
};




































































































#line 1987 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

// STRUCT TEMPLATE _Atomic_pointer
template <class _Ty>
struct _Atomic_pointer : _Atomic_storage<_Ty> {
    using _Base           = _Atomic_storage<_Ty>;
    using difference_type = ptrdiff_t;





    using _Base::_Base;
#line 2000 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    _Ty fetch_add(const ptrdiff_t _Diff, const memory_order _Order = memory_order_seq_cst) noexcept {
        const ptrdiff_t _Shift_bytes =
            static_cast<ptrdiff_t>(static_cast<size_t>(_Diff) * sizeof(remove_pointer_t<_Ty>));
        ptrdiff_t _Result;



#line 2009 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        _Check_memory_order(_Order); _Result = _InterlockedExchangeAdd64(_Atomic_address_as<long long>(this->_Storage), _Shift_bytes);
#line 2011 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
#line 2012 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return reinterpret_cast<_Ty>(_Result);
    }

    // _Deprecate_non_lock_free_volatile is unnecessary here.

    _Ty fetch_add(const ptrdiff_t _Diff) volatile noexcept {
        return const_cast<_Atomic_pointer*>(this)->fetch_add(_Diff);
    }

    _Ty fetch_add(const ptrdiff_t _Diff, const memory_order _Order) volatile noexcept {
        return const_cast<_Atomic_pointer*>(this)->fetch_add(_Diff, _Order);
    }

    _Ty fetch_sub(const ptrdiff_t _Diff) volatile noexcept {
        return fetch_add(static_cast<ptrdiff_t>(0 - static_cast<size_t>(_Diff)));
    }

    _Ty fetch_sub(const ptrdiff_t _Diff) noexcept {
        return fetch_add(static_cast<ptrdiff_t>(0 - static_cast<size_t>(_Diff)));
    }

    _Ty fetch_sub(const ptrdiff_t _Diff, const memory_order _Order) volatile noexcept {
        return fetch_add(static_cast<ptrdiff_t>(0 - static_cast<size_t>(_Diff)), _Order);
    }

    _Ty fetch_sub(const ptrdiff_t _Diff, const memory_order _Order) noexcept {
        return fetch_add(static_cast<ptrdiff_t>(0 - static_cast<size_t>(_Diff)), _Order);
    }

    _Ty operator++(int) volatile noexcept {
        return fetch_add(1);
    }

    _Ty operator++(int) noexcept {
        return fetch_add(1);
    }

    _Ty operator++() volatile noexcept {
        return fetch_add(1) + 1;
    }

    _Ty operator++() noexcept {
        return fetch_add(1) + 1;
    }

    _Ty operator--(int) volatile noexcept {
        return fetch_add(-1);
    }

    _Ty operator--(int) noexcept {
        return fetch_add(-1);
    }

    _Ty operator--() volatile noexcept {
        return fetch_add(-1) - 1;
    }

    _Ty operator--() noexcept {
        return fetch_add(-1) - 1;
    }

    _Ty operator+=(const ptrdiff_t _Diff) volatile noexcept {
        return fetch_add(_Diff) + _Diff;
    }

    _Ty operator+=(const ptrdiff_t _Diff) noexcept {
        return fetch_add(_Diff) + _Diff;
    }

    _Ty operator-=(const ptrdiff_t _Diff) volatile noexcept {
        return fetch_add(static_cast<ptrdiff_t>(0 - static_cast<size_t>(_Diff))) - _Diff;
    }

    _Ty operator-=(const ptrdiff_t _Diff) noexcept {
        return fetch_add(static_cast<ptrdiff_t>(0 - static_cast<size_t>(_Diff))) - _Diff;
    }
};


// STRUCT TEMPLATE _Atomic_pointer
template <class _Ty>
struct _Atomic_pointer<_Ty&> : _Atomic_storage<_Ty&> {
    using _Base           = _Atomic_storage<_Ty&>;
    using difference_type = ptrdiff_t;





    using _Base::_Base;
#line 2103 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    _Ty fetch_add(const ptrdiff_t _Diff, const memory_order _Order = memory_order_seq_cst) const noexcept {
        const ptrdiff_t _Shift_bytes =
            static_cast<ptrdiff_t>(static_cast<size_t>(_Diff) * sizeof(remove_pointer_t<_Ty>));
        ptrdiff_t _Result;



#line 2112 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        _Check_memory_order(_Order); _Result = _InterlockedExchangeAdd64(_Atomic_address_as<long long>(this->_Storage), _Shift_bytes);
#line 2114 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
#line 2115 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
        return reinterpret_cast<_Ty>(_Result);
    }

    _Ty fetch_sub(const ptrdiff_t _Diff) const noexcept {
        return fetch_add(static_cast<ptrdiff_t>(0 - static_cast<size_t>(_Diff)));
    }

    _Ty fetch_sub(const ptrdiff_t _Diff, const memory_order _Order) const noexcept {
        return fetch_add(static_cast<ptrdiff_t>(0 - static_cast<size_t>(_Diff)), _Order);
    }

    _Ty operator++(int) const noexcept {
        return fetch_add(1);
    }

    _Ty operator++() const noexcept {
        return fetch_add(1) + 1;
    }

    _Ty operator--(int) const noexcept {
        return fetch_add(-1);
    }

    _Ty operator--() const noexcept {
        return fetch_add(-1) - 1;
    }

    _Ty operator+=(const ptrdiff_t _Diff) const noexcept {
        return fetch_add(_Diff) + _Diff;
    }

    _Ty operator-=(const ptrdiff_t _Diff) const noexcept {
        return fetch_add(static_cast<ptrdiff_t>(0 - static_cast<size_t>(_Diff))) - _Diff;
    }
};


// STRUCT TEMPLATE atomic



template <class _TVal, class _Ty = _TVal>
using _Choose_atomic_base2_t =
    typename _Select<is_integral_v<_TVal> && !is_same_v<bool, _TVal>>::template _Apply<_Atomic_integral_facade<_Ty>,
        typename _Select<is_pointer_v<_TVal> && is_object_v<remove_pointer_t<_TVal>>>::template _Apply<
            _Atomic_pointer<_Ty>, _Atomic_storage<_Ty>>>;





#line 2167 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
template <class _TVal, class _Ty = _TVal>
using _Choose_atomic_base_t = _Choose_atomic_base2_t<_TVal, _Ty>;
#line 2170 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

template <class _Ty>
struct atomic : _Choose_atomic_base_t<_Ty> { // atomic value
private:
    using _Base = _Choose_atomic_base_t<_Ty>;

public:
    // clang-format off
    static_assert(is_trivially_copyable_v<_Ty> && is_copy_constructible_v<_Ty> && is_move_constructible_v<_Ty>
        && is_copy_assignable_v<_Ty> && is_move_assignable_v<_Ty>,
        "atomic<T> requires T to be trivially copyable, copy constructible, move constructible, copy assignable, "
        "and move assignable.");
    // clang-format on

    using value_type = _Ty;




    using _Base::_Base;
#line 2191 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    constexpr atomic() noexcept(is_nothrow_default_constructible_v<_Ty>) : _Base() {}

    atomic(const atomic&) = delete;
    atomic& operator=(const atomic&) = delete;



#line 2200 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"


    [[nodiscard]] bool is_lock_free() const volatile noexcept {
        constexpr bool _Result = sizeof(_Ty) <= 8 && (sizeof(_Ty) & sizeof(_Ty) - 1) == 0;
        return _Result;
    }










#line 2217 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    [[nodiscard]] bool is_lock_free() const noexcept {
        return static_cast<const volatile atomic*>(this)->is_lock_free();
    }

    _Ty operator=(const _Ty _Value) volatile noexcept {
        static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
        this->store(_Value);
        return _Value;
    }

    _Ty operator=(const _Ty _Value) noexcept {
        this->store(_Value);
        return _Value;
    }

    // For the following, we do the real implementation in the non-volatile function, and const_cast
    // to call the non-volatile function in the volatile one. This is safe because all of the
    // non-volatile functions reapply volatile, as all our intrinsics accept only volatile T *.
    // We expect most atomic<T>s to be non-volatile, so making the real implementations
    // non-volatile should result in better debug codegen.
    using _Base::store;
    void store(const _Ty _Value) volatile noexcept {
        static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
        const_cast<atomic*>(this)->_Base::store(_Value);
    }

    void store(const _Ty _Value, const memory_order _Order) volatile noexcept {
        static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
        const_cast<atomic*>(this)->_Base::store(_Value, _Order);
    }

    using _Base::load;
    [[nodiscard]] _Ty load() const volatile noexcept {
        static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
        return const_cast<const atomic*>(this)->_Base::load();
    }

    [[nodiscard]] _Ty load(const memory_order _Order) const volatile noexcept {
        static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
        return const_cast<const atomic*>(this)->_Base::load(_Order);
    }

    using _Base::exchange;
    _Ty exchange(const _Ty _Value) volatile noexcept {
        static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
        return const_cast<atomic*>(this)->_Base::exchange(_Value);
    }

    _Ty exchange(const _Ty _Value, const memory_order _Order) volatile noexcept {
        static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
        return const_cast<atomic*>(this)->_Base::exchange(_Value, _Order);
    }

    using _Base::compare_exchange_strong;
    bool compare_exchange_strong(_Ty& _Expected, const _Ty _Desired) volatile noexcept {
        static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
        return const_cast<atomic*>(this)->_Base::compare_exchange_strong(_Expected, _Desired);
    }

    bool compare_exchange_strong(_Ty& _Expected, const _Ty _Desired, const memory_order _Order) volatile noexcept {
        static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
        return const_cast<atomic*>(this)->_Base::compare_exchange_strong(_Expected, _Desired, _Order);
    }

    bool compare_exchange_strong(_Ty& _Expected, const _Ty _Desired, const memory_order _Success,
        const memory_order _Failure) volatile noexcept {
        static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
        return this->compare_exchange_strong(_Expected, _Desired, _Combine_cas_memory_orders(_Success, _Failure));
    }

    bool compare_exchange_strong(
        _Ty& _Expected, const _Ty _Desired, const memory_order _Success, const memory_order _Failure) noexcept {
        return this->compare_exchange_strong(_Expected, _Desired, _Combine_cas_memory_orders(_Success, _Failure));
    }

    bool compare_exchange_weak(_Ty& _Expected, const _Ty _Desired) volatile noexcept {
        // we have no weak CAS intrinsics, even on ARM32/ARM64, so fall back to strong
        static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
        return this->compare_exchange_strong(_Expected, _Desired);
    }

    bool compare_exchange_weak(_Ty& _Expected, const _Ty _Desired) noexcept {
        return this->compare_exchange_strong(_Expected, _Desired);
    }

    bool compare_exchange_weak(_Ty& _Expected, const _Ty _Desired, const memory_order _Order) volatile noexcept {
        static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
        return this->compare_exchange_strong(_Expected, _Desired, _Order);
    }

    bool compare_exchange_weak(_Ty& _Expected, const _Ty _Desired, const memory_order _Order) noexcept {
        return this->compare_exchange_strong(_Expected, _Desired, _Order);
    }

    bool compare_exchange_weak(_Ty& _Expected, const _Ty _Desired, const memory_order _Success,
        const memory_order _Failure) volatile noexcept {
        static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
        return this->compare_exchange_strong(_Expected, _Desired, _Combine_cas_memory_orders(_Success, _Failure));
    }

    bool compare_exchange_weak(
        _Ty& _Expected, const _Ty _Desired, const memory_order _Success, const memory_order _Failure) noexcept {
        return this->compare_exchange_strong(_Expected, _Desired, _Combine_cas_memory_orders(_Success, _Failure));
    }
















#line 2339 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    operator _Ty() const volatile noexcept {
        static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
        return this->load();
    }

    operator _Ty() const noexcept {
        return this->load();
    }
};




#line 2354 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"













































































































#line 2464 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

// NONMEMBER OPERATIONS ON ATOMIC TYPES
template <class _Ty>
[[nodiscard]] bool atomic_is_lock_free(const volatile atomic<_Ty>* _Mem) noexcept {
    return _Mem->is_lock_free();
}

template <class _Ty>
[[nodiscard]] bool atomic_is_lock_free(const atomic<_Ty>* _Mem) noexcept {
    return _Mem->is_lock_free();
}

template <class _Ty>
void atomic_store(volatile atomic<_Ty>* const _Mem, const _Identity_t<_Ty> _Value) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    _Mem->store(_Value);
}

template <class _Ty>
void atomic_store(atomic<_Ty>* const _Mem, const _Identity_t<_Ty> _Value) noexcept {
    _Mem->store(_Value);
}

template <class _Ty>
void atomic_store_explicit(
    volatile atomic<_Ty>* const _Mem, const _Identity_t<_Ty> _Value, const memory_order _Order) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    _Mem->store(_Value, _Order);
}

template <class _Ty>
void atomic_store_explicit(atomic<_Ty>* const _Mem, const _Identity_t<_Ty> _Value, const memory_order _Order) noexcept {
    _Mem->store(_Value, _Order);
}

template <class _Ty>
 void atomic_init(
    volatile atomic<_Ty>* const _Mem, const typename atomic<_Ty>::value_type _Value) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    ::std:: atomic_store_explicit(_Mem, _Value, memory_order_relaxed);
}

template <class _Ty>
 void atomic_init(
    atomic<_Ty>* const _Mem, const typename atomic<_Ty>::value_type _Value) noexcept {
    ::std:: atomic_store_explicit(_Mem, _Value, memory_order_relaxed);
}

template <class _Ty>
[[nodiscard]] _Ty atomic_load(const volatile atomic<_Ty>* const _Mem) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->load();
}

template <class _Ty>
[[nodiscard]] _Ty atomic_load(const atomic<_Ty>* const _Mem) noexcept {
    return _Mem->load();
}

template <class _Ty>
[[nodiscard]] _Ty atomic_load_explicit(const volatile atomic<_Ty>* const _Mem, const memory_order _Order) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->load(_Order);
}

template <class _Ty>
[[nodiscard]] _Ty atomic_load_explicit(const atomic<_Ty>* const _Mem, const memory_order _Order) noexcept {
    return _Mem->load(_Order);
}

template <class _Ty>
_Ty atomic_exchange(volatile atomic<_Ty>* const _Mem, const _Identity_t<_Ty> _Value) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->exchange(_Value);
}

template <class _Ty>
_Ty atomic_exchange(atomic<_Ty>* const _Mem, const _Identity_t<_Ty> _Value) noexcept {
    return _Mem->exchange(_Value);
}

template <class _Ty>
_Ty atomic_exchange_explicit(
    volatile atomic<_Ty>* const _Mem, const _Identity_t<_Ty> _Value, const memory_order _Order) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->exchange(_Value, _Order);
}

template <class _Ty>
_Ty atomic_exchange_explicit(
    atomic<_Ty>* const _Mem, const _Identity_t<_Ty> _Value, const memory_order _Order) noexcept {
    return _Mem->exchange(_Value, _Order);
}

template <class _Ty>
bool atomic_compare_exchange_strong(
    volatile atomic<_Ty>* const _Mem, _Identity_t<_Ty>* const _Expected, const _Identity_t<_Ty> _Desired) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->compare_exchange_strong(*_Expected, _Desired);
}

template <class _Ty>
bool atomic_compare_exchange_strong(
    atomic<_Ty>* const _Mem, _Identity_t<_Ty>* const _Expected, const _Identity_t<_Ty> _Desired) noexcept {
    return _Mem->compare_exchange_strong(*_Expected, _Desired);
}

template <class _Ty>
bool atomic_compare_exchange_strong_explicit(volatile atomic<_Ty>* const _Mem, _Identity_t<_Ty>* const _Expected,
    const _Identity_t<_Ty> _Desired, const memory_order _Success, const memory_order _Failure) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->compare_exchange_strong(*_Expected, _Desired, _Combine_cas_memory_orders(_Success, _Failure));
}

template <class _Ty>
bool atomic_compare_exchange_strong_explicit(atomic<_Ty>* const _Mem, _Identity_t<_Ty>* const _Expected,
    const _Identity_t<_Ty> _Desired, const memory_order _Success, const memory_order _Failure) noexcept {
    return _Mem->compare_exchange_strong(*_Expected, _Desired, _Combine_cas_memory_orders(_Success, _Failure));
}

template <class _Ty>
bool atomic_compare_exchange_weak(
    volatile atomic<_Ty>* const _Mem, _Identity_t<_Ty>* const _Expected, const _Identity_t<_Ty> _Desired) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->compare_exchange_strong(*_Expected, _Desired);
}

template <class _Ty>
bool atomic_compare_exchange_weak(
    atomic<_Ty>* const _Mem, _Identity_t<_Ty>* const _Expected, const _Identity_t<_Ty> _Desired) noexcept {
    return _Mem->compare_exchange_strong(*_Expected, _Desired);
}

template <class _Ty>
bool atomic_compare_exchange_weak_explicit(volatile atomic<_Ty>* const _Mem, _Identity_t<_Ty>* const _Expected,
    const _Identity_t<_Ty> _Desired, const memory_order _Success, const memory_order _Failure) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->compare_exchange_strong(*_Expected, _Desired, _Combine_cas_memory_orders(_Success, _Failure));
}

template <class _Ty>
bool atomic_compare_exchange_weak_explicit(atomic<_Ty>* const _Mem, _Identity_t<_Ty>* const _Expected,
    const _Identity_t<_Ty> _Desired, const memory_order _Success, const memory_order _Failure) noexcept {
    return _Mem->compare_exchange_strong(*_Expected, _Desired, _Combine_cas_memory_orders(_Success, _Failure));
}

template <class _Ty>
_Ty atomic_fetch_add(volatile atomic<_Ty>* _Mem, const typename atomic<_Ty>::difference_type _Value) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->fetch_add(_Value);
}

template <class _Ty>
_Ty atomic_fetch_add(atomic<_Ty>* _Mem, const typename atomic<_Ty>::difference_type _Value) noexcept {
    return _Mem->fetch_add(_Value);
}

template <class _Ty>
_Ty atomic_fetch_add_explicit(volatile atomic<_Ty>* _Mem, const typename atomic<_Ty>::difference_type _Value,
    const memory_order _Order) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->fetch_add(_Value, _Order);
}

template <class _Ty>
_Ty atomic_fetch_add_explicit(
    atomic<_Ty>* _Mem, const typename atomic<_Ty>::difference_type _Value, const memory_order _Order) noexcept {
    return _Mem->fetch_add(_Value, _Order);
}

template <class _Ty>
_Ty atomic_fetch_sub(volatile atomic<_Ty>* _Mem, const typename atomic<_Ty>::difference_type _Value) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->fetch_sub(_Value);
}

template <class _Ty>
_Ty atomic_fetch_sub(atomic<_Ty>* _Mem, const typename atomic<_Ty>::difference_type _Value) noexcept {
    return _Mem->fetch_sub(_Value);
}

template <class _Ty>
_Ty atomic_fetch_sub_explicit(volatile atomic<_Ty>* _Mem, const typename atomic<_Ty>::difference_type _Value,
    const memory_order _Order) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->fetch_sub(_Value, _Order);
}

template <class _Ty>
_Ty atomic_fetch_sub_explicit(
    atomic<_Ty>* _Mem, const typename atomic<_Ty>::difference_type _Value, const memory_order _Order) noexcept {
    return _Mem->fetch_sub(_Value, _Order);
}

template <class _Ty>
_Ty atomic_fetch_and(volatile atomic<_Ty>* _Mem, const typename atomic<_Ty>::value_type _Value) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->fetch_and(_Value);
}

template <class _Ty>
_Ty atomic_fetch_and(atomic<_Ty>* _Mem, const typename atomic<_Ty>::value_type _Value) noexcept {
    return _Mem->fetch_and(_Value);
}

template <class _Ty>
_Ty atomic_fetch_and_explicit(
    volatile atomic<_Ty>* _Mem, const typename atomic<_Ty>::value_type _Value, const memory_order _Order) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->fetch_and(_Value, _Order);
}

template <class _Ty>
_Ty atomic_fetch_and_explicit(
    atomic<_Ty>* _Mem, const typename atomic<_Ty>::value_type _Value, const memory_order _Order) noexcept {
    return _Mem->fetch_and(_Value, _Order);
}

template <class _Ty>
_Ty atomic_fetch_or(volatile atomic<_Ty>* _Mem, const typename atomic<_Ty>::value_type _Value) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->fetch_or(_Value);
}

template <class _Ty>
_Ty atomic_fetch_or(atomic<_Ty>* _Mem, const typename atomic<_Ty>::value_type _Value) noexcept {
    return _Mem->fetch_or(_Value);
}

template <class _Ty>
_Ty atomic_fetch_or_explicit(
    volatile atomic<_Ty>* _Mem, const typename atomic<_Ty>::value_type _Value, const memory_order _Order) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->fetch_or(_Value, _Order);
}

template <class _Ty>
_Ty atomic_fetch_or_explicit(
    atomic<_Ty>* _Mem, const typename atomic<_Ty>::value_type _Value, const memory_order _Order) noexcept {
    return _Mem->fetch_or(_Value, _Order);
}

template <class _Ty>
_Ty atomic_fetch_xor(volatile atomic<_Ty>* _Mem, const typename atomic<_Ty>::value_type _Value) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->fetch_xor(_Value);
}

template <class _Ty>
_Ty atomic_fetch_xor(atomic<_Ty>* _Mem, const typename atomic<_Ty>::value_type _Value) noexcept {
    return _Mem->fetch_xor(_Value);
}

template <class _Ty>
_Ty atomic_fetch_xor_explicit(
    volatile atomic<_Ty>* _Mem, const typename atomic<_Ty>::value_type _Value, const memory_order _Order) noexcept {
    static_assert(_Deprecate_non_lock_free_volatile<_Ty>, "Never fails");
    return _Mem->fetch_xor(_Value, _Order);
}

template <class _Ty>
_Ty atomic_fetch_xor_explicit(
    atomic<_Ty>* _Mem, const typename atomic<_Ty>::value_type _Value, const memory_order _Order) noexcept {
    return _Mem->fetch_xor(_Value, _Order);
}













































#line 2775 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

// ATOMIC TYPEDEFS
using atomic_bool = atomic<bool>;

using atomic_char   = atomic<char>;
using atomic_schar  = atomic<signed char>;
using atomic_uchar  = atomic<unsigned char>;
using atomic_short  = atomic<short>;
using atomic_ushort = atomic<unsigned short>;
using atomic_int    = atomic<int>;
using atomic_uint   = atomic<unsigned int>;
using atomic_long   = atomic<long>;
using atomic_ulong  = atomic<unsigned long>;
using atomic_llong  = atomic<long long>;
using atomic_ullong = atomic<unsigned long long>;




using atomic_char16_t = atomic<char16_t>;
using atomic_char32_t = atomic<char32_t>;
using atomic_wchar_t  = atomic<wchar_t>;

using atomic_int8_t   = atomic<int8_t>;
using atomic_uint8_t  = atomic<uint8_t>;
using atomic_int16_t  = atomic<int16_t>;
using atomic_uint16_t = atomic<uint16_t>;
using atomic_int32_t  = atomic<int32_t>;
using atomic_uint32_t = atomic<uint32_t>;
using atomic_int64_t  = atomic<int64_t>;
using atomic_uint64_t = atomic<uint64_t>;

using atomic_int_least8_t   = atomic<int_least8_t>;
using atomic_uint_least8_t  = atomic<uint_least8_t>;
using atomic_int_least16_t  = atomic<int_least16_t>;
using atomic_uint_least16_t = atomic<uint_least16_t>;
using atomic_int_least32_t  = atomic<int_least32_t>;
using atomic_uint_least32_t = atomic<uint_least32_t>;
using atomic_int_least64_t  = atomic<int_least64_t>;
using atomic_uint_least64_t = atomic<uint_least64_t>;

using atomic_int_fast8_t   = atomic<int_fast8_t>;
using atomic_uint_fast8_t  = atomic<uint_fast8_t>;
using atomic_int_fast16_t  = atomic<int_fast16_t>;
using atomic_uint_fast16_t = atomic<uint_fast16_t>;
using atomic_int_fast32_t  = atomic<int_fast32_t>;
using atomic_uint_fast32_t = atomic<uint_fast32_t>;
using atomic_int_fast64_t  = atomic<int_fast64_t>;
using atomic_uint_fast64_t = atomic<uint_fast64_t>;

using atomic_intptr_t  = atomic<intptr_t>;
using atomic_uintptr_t = atomic<uintptr_t>;
using atomic_size_t    = atomic<size_t>;
using atomic_ptrdiff_t = atomic<ptrdiff_t>;
using atomic_intmax_t  = atomic<intmax_t>;
using atomic_uintmax_t = atomic<uintmax_t>;






#line 2838 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

// STRUCT atomic_flag


struct atomic_flag { // flag with test-and-set semantics








#line 2852 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

    bool test_and_set(const memory_order _Order = memory_order_seq_cst) noexcept {
        return _Storage.exchange(true, _Order) != 0;
    }

    bool test_and_set(const memory_order _Order = memory_order_seq_cst) volatile noexcept {
        return _Storage.exchange(true, _Order) != 0;
    }

    void clear(const memory_order _Order = memory_order_seq_cst) noexcept {
        _Storage.store(false, _Order);
    }

    void clear(const memory_order _Order = memory_order_seq_cst) volatile noexcept {
        _Storage.store(false, _Order);
    }

    constexpr atomic_flag() noexcept = default;

























#line 2896 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"


    atomic<long> _Storage;


#line 2902 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
};


// atomic_flag NONMEMBERS

















#line 2924 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

inline bool atomic_flag_test_and_set(atomic_flag* const _Flag) noexcept {
    return _Flag->test_and_set();
}

inline bool atomic_flag_test_and_set(volatile atomic_flag* const _Flag) noexcept {
    return _Flag->test_and_set();
}

inline bool atomic_flag_test_and_set_explicit(atomic_flag* const _Flag, const memory_order _Order) noexcept {
    return _Flag->test_and_set(_Order);
}

inline bool atomic_flag_test_and_set_explicit(volatile atomic_flag* const _Flag, const memory_order _Order) noexcept {
    return _Flag->test_and_set(_Order);
}

inline void atomic_flag_clear(atomic_flag* const _Flag) noexcept {
    _Flag->clear();
}

inline void atomic_flag_clear(volatile atomic_flag* const _Flag) noexcept {
    _Flag->clear();
}

inline void atomic_flag_clear_explicit(atomic_flag* const _Flag, const memory_order _Order) noexcept {
    _Flag->clear(_Order);
}

inline void atomic_flag_clear_explicit(volatile atomic_flag* const _Flag, const memory_order _Order) noexcept {
    _Flag->clear(_Order);
}


































































































#line 3055 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"

}














#pragma warning(pop)
#pragma pack(pop)
#line 3074 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
#line 3075 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\Tools\\MSVC\\14.28.29910\\include\\atomic"
#line 5 "C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\SharedPtr.h"

using std::atomic;

template <class Type>
class SharedPtr
{
public:
	SharedPtr() noexcept
		: m_pData( nullptr )
		, m_puiRefCount( new atomic<uint32>( 1 ) )
	{
	};

	explicit SharedPtr( Type* pData ) noexcept
		: m_pData( pData )
		, m_puiRefCount( new atomic<uint32>( 1 ) )
	{
	}

	SharedPtr( const Type* pData ) noexcept
		: m_pData( pData )
		, m_puiRefCount( new atomic<uint32>( 1 ) )
	{
	}

	SharedPtr( SharedPtr& InOriginal ) noexcept
		: m_pData( InOriginal.m_pData )
		, m_puiRefCount( InOriginal.m_puiRefCount )
	{
		AddRefIfValid();
	}

	SharedPtr* operator= ( SharedPtr& InOriginal ) noexcept
	{
		if ( InOriginal != this )
		{
			m_pData = InOriginal.m_pData;
			m_puiRefCount = InOriginal.m_puiRefCount;

			AddRefIfValid();
		}

		return this;
	}

	SharedPtr( SharedPtr&& InOriginal ) noexcept
		: m_pData( InOriginal.m_pData )
		, m_puiRefCount( InOriginal.m_puiRefCount )
	{
		InOriginal.m_pData = nullptr;
		InOriginal.m_puiRefCount = nullptr;
	}

	SharedPtr& operator=( SharedPtr&& InOriginal ) noexcept
	{
		if ( InOriginal != this )
		{
			m_pData = InOriginal.m_pData;
			m_puiRefCount = InOriginal.m_puiRefCount;

			InOriginal.m_pData = nullptr;
			InOriginal.m_puiRefCount = nullptr;
		}
	}

	template <typename DerivedType>
	SharedPtr( SharedPtr<DerivedType>& InOriginal ) noexcept
		: m_pData( InOriginal.m_pData )
		, m_puiRefCount( InOriginal.m_puiRefCount )
	{
		AddRefIfValid();
	}

	template <typename DerivedType>
	SharedPtr* operator= ( SharedPtr<DerivedType>& InOriginal ) noexcept
	{
		if ( InOriginal != this )
		{
			m_pData = InOriginal.m_pData;
			m_puiRefCount = InOriginal.m_puiRefCount;
		}

		AddRefIfValid();

		return this;
	}

	template <typename DerivedType>
	SharedPtr( SharedPtr<DerivedType>&& InOriginal ) noexcept
		: m_pData( InOriginal.m_pData )
		, m_puiRefCount( InOriginal.m_puiRefCount )
	{
		InOriginal.m_pData			= nullptr;
		InOriginal.m_puiRefCount	= nullptr;
	}

	template <typename DerivedType>
	SharedPtr& operator=( SharedPtr&& InOriginal ) noexcept
	{
		if ( InOriginal != this )
		{
			m_pData			= InOriginal.m_pData;
			m_puiRefCount	= InOriginal.m_puiRefCount;

			InOriginal.m_pData			= nullptr;
			InOriginal.m_puiRefCount	= nullptr;
		}
	}

	SharedPtr( std::nullptr_t ) noexcept
		: m_pData( nullptr )
		, m_puiRefCount( new atomic<uint32>( 1 ) )
	{
	}

	~SharedPtr() noexcept
	{
		if ( IsValid() )
		{
			RemoveRef();
		}
	};

	Type* Get() const noexcept
	{
		return m_pData;
	}

	Type operator->() const noexcept
	{
		return *m_pData;
	}

	bool IsValid() const noexcept
	{
		return ( m_pData && m_puiRefCount->load() );
	}

	bool IsEmpty() const noexcept
	{
		return ( !m_pData && m_puiRefCount->load() );
	}

	uint32 GetRefCount() const noexcept
	{
		return m_puiRefCount->load();
	}

private:
	void AddRef() noexcept
	{
		m_puiRefCount->fetch_add( 1 );
	}

	void AddRefIfValid() noexcept
	{
		if ( IsValid() )
		{
			AddRef();
		}
	}

	void RemoveRef() noexcept
	{
		if ( IsValid() )
		{
			m_puiRefCount->fetch_sub( 1 );
			if ( !m_puiRefCount )
			{
				delete m_pData;
			}
		}
	}

	Type* m_pData;
	atomic<uint32>* m_puiRefCount;
};
#line 7 "C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\Heap.h"

class HeapManager;


class HeapNode
{
	friend class HeapManager;
	sbyte* GetBuffer() const noexcept;

	~HeapNode();
private:
	HeapNode() noexcept = delete;
	HeapNode( const HeapNode& Other ) = delete;
	HeapNode( HeapNode&& Other ) = delete;
	HeapNode& operator=( const HeapNode& Other ) = delete;
	HeapNode& operator=( const HeapNode&& Other ) = delete;
	explicit HeapNode( sbyte* sbBuffer, const uint64 uSize ) noexcept;

	bool		m_bInUse;
	uint64		m_uSize;
	HeapNode*	m_pNext;

	sbyte*		m_sbBuffer;
};

static class HeapManager
{
public:
	static bool Initialize();
	static HeapNode* Allocate( uint64 uSize, sbyte* InitialContent = nullptr ) noexcept;
	static void Release( HeapNode& Node ) noexcept;
private:
	HeapNode* FindFirstFit( const uint64 uSize ) noexcept;
	HeapNode* FindBestFit( const uint64 uSize ) noexcept;
	static HeapNode*	s_pUsedMemory;
	static HeapNode*	s_pFreeMemory;
};
#line 2 "C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\Heap.cpp"
#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\malloc.h"
//
// malloc.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// The memory allocation library.
//
#pragma once






#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8)) extern "C" {



// Maximum heap request the heap manager will attempt

    


#line 29 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\malloc.h"



// Constants for _heapchk and _heapwalk routines









typedef struct _heapinfo
{
    int* _pentry;
    size_t _size;
    int _useflag;
} _HEAPINFO;






   
void* __cdecl _alloca(  size_t _Size);





    __declspec(dllimport) intptr_t __cdecl _get_heap_handle(void);

     
    __declspec(dllimport) int __cdecl _heapmin(void);

    
        __declspec(dllimport) int __cdecl _heapwalk(  _HEAPINFO* _EntryInfo);
    #line 69 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\malloc.h"

    
          __declspec(dllimport) int __cdecl _heapchk(void);
    #line 73 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\malloc.h"

    __declspec(dllimport) int __cdecl _resetstkoflw(void);

    
    
    

    
        
    

#line 85 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\malloc.h"

    static_assert((sizeof(unsigned int) <= 16), "sizeof(unsigned int) <= _ALLOCA_S_MARKER_SIZE");


    #pragma warning(push)
    #pragma warning(disable: 6540) 
                                   // of its existing __declspec annotations

    __inline void* _MarkAllocaS(   void* _Ptr, unsigned int _Marker)
    {
        if (_Ptr)
        {
            *((unsigned int*)_Ptr) = _Marker;
            _Ptr = (char*)_Ptr + 16;
        }
        return _Ptr;
    }

    __inline size_t _MallocaComputeSize(size_t _Size)
    {
        size_t _MarkedSize = _Size + 16;
        return _MarkedSize > _Size ? _MarkedSize : 0;
    }

    #pragma warning(pop)

#line 112 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\malloc.h"




// C6255: _alloca indicates failure by raising a stack overflow exception
// C6386: buffer overrun
    
        
        




    #line 126 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\malloc.h"












#line 139 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\malloc.h"




#line 144 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\malloc.h"
#line 145 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\malloc.h"

    

    #pragma warning(push)
    #pragma warning(disable: 6014) 
    __inline void __cdecl _freea(    void* _Memory)
    {
        unsigned int _Marker;
        if (_Memory)
        {
            _Memory = (char*)_Memory - 16;
            _Marker = *(unsigned int*)_Memory;
            if (_Marker == 0xDDDD)
            {
                free(_Memory);
            }
            
            else if (_Marker != 0xCCCC)
            {
                (void)( (!!((("Corrupted pointer passed to _freea" && 0)))) || (1 != _CrtDbgReportW(2, L"C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\malloc.h", 164, 0, L"%ls", L"(\"Corrupted pointer passed to _freea\" && 0)")) || (__debugbreak(), 0) );
            }
            #line 167 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\malloc.h"
        }
    }
    #pragma warning(pop)

#line 172 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\malloc.h"




    
#line 178 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\malloc.h"



} __pragma(pack(pop))

#pragma warning(pop) 
#line 185 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\malloc.h"
#line 3 "C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\Heap.cpp"
#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\memory.h"
//
// memory.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// The buffer (memory) manipulation library.
//
#pragma once




#line 14 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt\\memory.h"
#line 4 "C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\Heap.cpp"

// Heap node implementation.

sbyte*
HeapNode::GetBuffer() const noexcept
{
	return m_sbBuffer;
}

HeapNode::HeapNode( sbyte* sbBuffer, const uint64 uSize ) noexcept :
	m_bInUse( false )
	, m_uSize( uSize )
	, m_sbBuffer( sbBuffer ) 
	, m_pNext( nullptr )
{
	(void)( (!!(m_uSize)) || (_wassert(L"m_uSize", L"C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\Heap.cpp", (unsigned)(19)), 0) );
	(void)( (!!(m_sbBuffer)) || (_wassert(L"m_sbBuffer", L"C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\Heap.cpp", (unsigned)(20)), 0) );
}

HeapNode::~HeapNode()
{
	HeapManager::Release( *this );
}

// Heap implementation.
HeapNode* HeapManager::s_pUsedMemory;
HeapNode* HeapManager::s_pFreeMemory;

bool
HeapManager::Initialize()
{
	bool bInitialized	 = false;

	const uint64 HEAP_INIITAL_SIZE	= ( 64 * 1024 * 1024 ); // 64 MB.
	sbyte* pInitialHeap				= (sbyte*) malloc( HEAP_INIITAL_SIZE );
	(void)( (!!(pInitialHeap)) || (_wassert(L"pInitialHeap", L"C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\Heap.cpp", (unsigned)(39)), 0) );
	
	if ( pInitialHeap )
	{
		memset( pInitialHeap, 0, HEAP_INIITAL_SIZE );
		HeapNode* pHeapNode				= new HeapNode( pInitialHeap, HEAP_INIITAL_SIZE );
		s_pFreeMemory					= pHeapNode;
		bInitialized					= true;
	}

	return bInitialized;
}

HeapNode*
HeapManager::Allocate( uint64 uSize, sbyte* InitialContent /* = nullptr */ ) noexcept
{
	return nullptr;
}

void
HeapManager::Release( HeapNode& Node ) noexcept
{
}

HeapNode*
HeapManager::FindFirstFit( const uint64 uSize ) noexcept
{
	HeapNode* pFirstFit = nullptr;

	HeapNode* pCurrNode = s_pFreeMemory;
	while ( pCurrNode )
	{
		if ( pCurrNode->m_uSize >= uSize )
		{
			pFirstFit = pCurrNode;
			break;
		}
	}

	(void)( (!!(!pFirstFit || pFirstFit->m_sbBuffer)) || (_wassert(L"!pFirstFit || pFirstFit->m_sbBuffer", L"C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\Heap.cpp", (unsigned)(78)), 0) );
	return pFirstFit;
}

HeapNode*
HeapManager::FindBestFit( const uint64 uSize ) noexcept
{
	HeapNode* pBestFit = nullptr;

	uint64 uBestDiff		= -1;
	HeapNode* pCurrNode		= s_pFreeMemory;
	
	while ( pCurrNode )
	{
		// Best-case scenario: found an exact fit.
		// We won't find a better one than this!
		if ( pCurrNode->m_uSize == uSize )
		{
			pBestFit		= pCurrNode;
			break;
		}
		
		if ( pCurrNode->m_uSize > uSize )
		{
			if ( pBestFit )
			{
				const uint64 uDiff	= ( pCurrNode->m_uSize - uSize );
				if ( uDiff < uBestDiff )
				{
					pBestFit		= pCurrNode;
					uBestDiff		= uDiff;
				}
			}
			else
			{
				pBestFit	= pCurrNode;
				uBestDiff	= 0;
			}
		}
	}

	(void)( (!!(!pBestFit || pBestFit->m_sbBuffer)) || (_wassert(L"!pBestFit || pBestFit->m_sbBuffer", L"C:\\Users\\dino.bojadjievski\\source\\repos\\Electricity2\\Electricity2\\Heap.cpp", (unsigned)(119)), 0) );
	return pBestFit;
}
