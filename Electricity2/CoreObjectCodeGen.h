#pragma once

#define INIT_CORE_OBJECT \
private: \
	static inline ObjectID		s_NextID = 0; \
	static inline ClassID		s_ClassId = Electricity::UUID::NewUUID(); \
public: \
	class Initializer; \
	static ClassID GetClassId() noexcept { return s_ClassId; } // Can't be virtual to properly populate inheritance chain.

#ifdef _DEBUG
	#define __DECL_OBJ_CONSTRUCTOR_PARAMS__ const char* szFile, size_t nLineNo
	#define __DECL_ALLOC_TEMPLATE_PARAMS__ const char*, size_t

	#define __DECL_NEW_FRIEND__  \
	friend void* operator new( size_t n, const char* szFile, size_t nLineNo ); \
	friend void* operator new[]( size_t n, const char* szFile, size_t nLineNo );

	#define __DECL_CONSTRUCTOR_BODY__(ClassType) \
	{ \
		auto uTypeId = ClassType::GetClassId(); \
		if ( m_suInheritanceChain.find( uTypeId ) == m_suInheritanceChain.end() ) \
		{ \
			m_suInheritanceChain.insert( uTypeId ); \
			ClassType::s_apInstances.push_back(SharedPtr<ClassType>(this)); \
		} \
	}

	#define __DECL_CONSTRUCTORS__(ClassType) \
	ClassType() __DECL_CONSTRUCTOR_BODY__(ClassType) \
	ClassType ( __DECL_OBJ_CONSTRUCTOR_PARAMS__ ) __DECL_CONSTRUCTOR_BODY__(ClassType)
#else
	#define __DECL_OBJ_CONSTRUCTOR_PARAMS__ 
	#define __DECL_ALLOC_TEMPLATE_PARAMS__ 
	
	#define __DECL_NEW_FRIEND__ \
	friend void* operator new( size_t n); \
	friend void* operator new[]( size_t n, const char* szFile, size_t nLineNo );

	#define __DECL_CONSTRUCTORS__(ClassType) \
	ClassType() __DECL_CONSTRUCTOR_BODY__(ClassType)
#endif // _DEBUG

#define INIT_CLASS(ClassType) \
INIT_CORE_OBJECT \
__DECL_NEW_FRIEND__ \
friend SharedPtr<ClassType> __GCNew__<ClassType> ( __DECL_ALLOC_TEMPLATE_PARAMS__ ); \
public: \
virtual ~ClassType() \
{\
	s_apInstances.erase( std::find( s_apInstances.begin(), s_apInstances.end(), SharedPtr<ClassType>(this) ) ); \
	Deinitialize(); \
} \
protected: \
__DECL_CONSTRUCTORS__(ClassType) \
private: \
	static inline std::vector<SharedPtr<ClassType>> s_apInstances;
