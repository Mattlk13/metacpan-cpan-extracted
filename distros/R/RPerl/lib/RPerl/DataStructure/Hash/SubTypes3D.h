////use strict;  use warnings;
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Hash__SubTypes3D_h
#define __CPP__INCLUDED__RPerl__DataStructure__Hash__SubTypes3D_h 0.001_000

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// for type-checking subroutines & macros
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

// [[[ DATA TYPES ]]]
#include <RPerl/DataType/Integer.cpp>
#include <RPerl/DataType/Number.cpp>
#include <RPerl/DataType/String.cpp>
#include <RPerl/DataStructure/Array.cpp>  // -> ???    for integer_arrayref_to_string_format() used in integer_arrayref_hashref_to_string_format()

// [[[ TYPEDEFS, 1D REPEATED ]]]
typedef std::unordered_map<string, integer> integer_hashref;
typedef std::unordered_map<string, integer>::iterator integer_hashref_iterator;
typedef std::unordered_map<string, integer>::const_iterator integer_hashref_const_iterator;
typedef std::unordered_map<string, number> number_hashref;
typedef std::unordered_map<string, number>::iterator number_hashref_iterator;
typedef std::unordered_map<string, number>::const_iterator number_hashref_const_iterator;
typedef std::unordered_map<string, string> string_hashref;
typedef std::unordered_map<string, string>::iterator string_hashref_iterator;
typedef std::unordered_map<string, string>::const_iterator string_hashref_const_iterator;

// [[[ TYPEDEFS, 2D REPEATED ]]]

// [[[ HASH REF HASH REF ]]]
typedef std::unordered_map<string, std::unordered_map<string, integer>> integer_hashref_hashref;
typedef std::unordered_map<string, std::unordered_map<string, integer>>::iterator integer_hashref_hashref_iterator;
typedef std::unordered_map<string, std::unordered_map<string, integer>>::const_iterator integer_hashref_hashref_const_iterator;
typedef std::unordered_map<string, std::unordered_map<string, number>> number_hashref_hashref;
typedef std::unordered_map<string, std::unordered_map<string, number>>::iterator number_hashref_hashref_iterator;
typedef std::unordered_map<string, std::unordered_map<string, number>>::const_iterator number_hashref_hashref_const_iterator;
typedef std::unordered_map<string, std::unordered_map<string, string>> string_hashref_hashref;
typedef std::unordered_map<string, std::unordered_map<string, string>>::iterator string_hashref_hashref_iterator;
typedef std::unordered_map<string, std::unordered_map<string, string>>::const_iterator string_hashref_hashref_const_iterator;

// [[[ ARRAY REF HASH REF ]]]
typedef std::unordered_map<string, std::vector<integer>> integer_arrayref_hashref;
typedef std::unordered_map<string, std::vector<integer>>::iterator integer_arrayref_hashref_iterator;
typedef std::unordered_map<string, std::vector<integer>>::const_iterator integer_arrayref_hashref_const_iterator;
typedef std::unordered_map<string, std::vector<number>> number_arrayref_hashref;
typedef std::unordered_map<string, std::vector<number>>::iterator number_arrayref_hashref_iterator;
typedef std::unordered_map<string, std::vector<number>>::const_iterator number_arrayref_hashref_const_iterator;
typedef std::unordered_map<string, std::vector<string>> string_arrayref_hashref;
typedef std::unordered_map<string, std::vector<string>>::iterator string_arrayref_hashref_iterator;
typedef std::unordered_map<string, std::vector<string>>::const_iterator string_arrayref_hashref_const_iterator;

// [[[ TYPEDEFS ]]]
// [[[ TYPEDEFS ]]]
// [[[ TYPEDEFS ]]]

// [[[ HASH REF HASH REF HASH REF ]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

// [[[ ARRAY REF HASH REF HASH REF ]]]
typedef std::unordered_map<string, std::unordered_map<string, std::vector<integer>>> integer_arrayref_hashref_hashref;
typedef std::unordered_map<string, std::unordered_map<string, std::vector<integer>>>::iterator integer_arrayref_hashref_hashref_iterator;
typedef std::unordered_map<string, std::unordered_map<string, std::vector<integer>>>::const_iterator integer_arrayref_hashref_hashref_const_iterator;
typedef std::unordered_map<string, std::unordered_map<string, std::vector<number>>> number_arrayref_hashref_hashref;
typedef std::unordered_map<string, std::unordered_map<string, std::vector<number>>>::iterator number_arrayref_hashref_hashref_iterator;
typedef std::unordered_map<string, std::unordered_map<string, std::vector<number>>>::const_iterator number_arrayref_hashref_hashref_const_iterator;
typedef std::unordered_map<string, std::unordered_map<string, std::vector<string>>> string_arrayref_hashref_hashref;
typedef std::unordered_map<string, std::unordered_map<string, std::vector<string>>>::iterator string_arrayref_hashref_hashref_iterator;
typedef std::unordered_map<string, std::unordered_map<string, std::vector<string>>>::const_iterator string_arrayref_hashref_hashref_const_iterator;

// [[[ HASH REF ARRAY REF HASH REF ]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

// [[[ ARRAY REF ARRAY REF HASH REF ]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE



// [[[ TYPE-CHECKING SUBROUTINES ]]]
// [[[ TYPE-CHECKING SUBROUTINES ]]]
// [[[ TYPE-CHECKING SUBROUTINES ]]]

// [[[ HASH REF HASH REF HASH REF ]]]
/* NEED IMPLEMENT IN SubTypes3D.cpp
void integer_hashref_hashref_hashref_CHECK(SV* possible_integer_hashref_hashref_hashref);
void integer_hashref_hashref_hashref_CHECKTRACE(SV* possible_integer_hashref_hashref_hashref, const char* variable_name, const char* subroutine_name);
void number_hashref_hashref_hashref_CHECK(SV* possible_number_hashref_hashref_hashref);
void number_hashref_hashref_hashref_CHECKTRACE(SV* possible_number_hashref_hashref_hashref, const char* variable_name, const char* subroutine_name);
void string_hashref_hashref_hashref_CHECK(SV* possible_string_hashref_hashref_hashref);
void string_hashref_hashref_hashref_CHECKTRACE(SV* possible_string_hashref_hashref_hashref, const char* variable_name, const char* subroutine_name);
*/

// [[[ ARRAY REF HASH REF HASH REF ]]]
void integer_arrayref_hashref_hashref_CHECK(SV* possible_integer_arrayref_hashref_hashref);
void integer_arrayref_hashref_hashref_CHECKTRACE(SV* possible_integer_arrayref_hashref_hashref, const char* variable_name, const char* subroutine_name);
void number_arrayref_hashref_hashref_CHECK(SV* possible_number_arrayref_hashref_hashref);
void number_arrayref_hashref_hashref_CHECKTRACE(SV* possible_number_arrayref_hashref_hashref, const char* variable_name, const char* subroutine_name);
void string_arrayref_hashref_hashref_CHECK(SV* possible_string_arrayref_hashref_hashref);
void string_arrayref_hashref_hashref_CHECKTRACE(SV* possible_string_arrayref_hashref_hashref, const char* variable_name, const char* subroutine_name);

// [[[ HASH REF ARRAY REF HASH REF ]]]
/* NEED IMPLEMENT IN SubTypes3D.cpp
void integer_hashref_arrayref_hashref_CHECK(SV* possible_integer_hashref_arrayref_hashref);
void integer_hashref_arrayref_hashref_CHECKTRACE(SV* possible_integer_hashref_arrayref_hashref, const char* variable_name, const char* subroutine_name);
void number_hashref_arrayref_hashref_CHECK(SV* possible_number_hashref_arrayref_hashref);
void number_hashref_arrayref_hashref_CHECKTRACE(SV* possible_number_hashref_arrayref_hashref, const char* variable_name, const char* subroutine_name);
void string_hashref_arrayref_hashref_CHECK(SV* possible_string_hashref_arrayref_hashref);
void string_hashref_arrayref_hashref_CHECKTRACE(SV* possible_string_hashref_arrayref_hashref, const char* variable_name, const char* subroutine_name);
*/

// [[[ ARRAY REF ARRAY REF HASH REF ]]]
/* NEED IMPLEMENT IN SubTypes3D.cpp
void integer_arrayref_arrayref_hashref_CHECK(SV* possible_integer_arrayref_arrayref_hashref);
void integer_arrayref_arrayref_hashref_CHECKTRACE(SV* possible_integer_arrayref_arrayref_hashref, const char* variable_name, const char* subroutine_name);
void number_arrayref_arrayref_hashref_CHECK(SV* possible_number_arrayref_arrayref_hashref);
void number_arrayref_arrayref_hashref_CHECKTRACE(SV* possible_number_arrayref_arrayref_hashref, const char* variable_name, const char* subroutine_name);
void string_arrayref_arrayref_hashref_CHECK(SV* possible_string_arrayref_arrayref_hashref);
void string_arrayref_arrayref_hashref_CHECKTRACE(SV* possible_string_arrayref_arrayref_hashref, const char* variable_name, const char* subroutine_name);
*/

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataStructure__Hash__SubTypes3D__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
integer RPerl__DataStructure__Hash__SubTypes3D__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

# ifdef __CPP__TYPES
// [[[ HASH REF HASH REF HASH REF ]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

// [[[ ARRAY REF HASH REF HASH REF ]]]
integer_arrayref_hashref_hashref XS_unpack_integer_arrayref_hashref_hashref(SV* input_avref_hvref_hvref);
void XS_pack_integer_arrayref_hashref_hashref(SV* output_avref_hvref_hvref, integer_arrayref_hashref_hashref input_vector_unordered_map_unordered_map);
number_arrayref_hashref_hashref XS_unpack_number_arrayref_hashref_hashref(SV* input_avref_hvref_hvref);
void XS_pack_number_arrayref_hashref_hashref(SV* output_avref_hvref_hvref, number_arrayref_hashref_hashref input_vector_unordered_map_unordered_map);
string_arrayref_hashref_hashref XS_unpack_string_arrayref_hashref_hashref(SV* input_avref_hvref_hvref);
void XS_pack_string_arrayref_hashref_hashref(SV* output_avref_hvref_hvref, string_arrayref_hashref_hashref input_vector_unordered_map_unordered_map);

// [[[ HASH REF ARRAY REF HASH REF ]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

// [[[ ARRAY REF ARRAY REF HASH REF ]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE
# endif


// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES
// [[[ HASH REF HASH REF HASH REF]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

// [[[ ARRAY REF HASH REF HASH REF ]]]
SV* integer_arrayref_hashref_hashref_to_string_compact(SV* input_avref_hvref_hvref);
SV* integer_arrayref_hashref_hashref_to_string(SV* input_avref_hvref_hvref);
SV* integer_arrayref_hashref_hashref_to_string_pretty(SV* input_avref_hvref_hvref);
SV* integer_arrayref_hashref_hashref_to_string_extend(SV* input_avref_hvref_hvref);
SV* integer_arrayref_hashref_hashref_to_string_format(SV* input_avref_hvref_hvref, SV* format_level, SV* indent_level);
SV* number_arrayref_hashref_hashref_to_string_compact(SV* input_avref_hvref_hvref);
SV* number_arrayref_hashref_hashref_to_string(SV* input_avref_hvref_hvref);
SV* number_arrayref_hashref_hashref_to_string_pretty(SV* input_avref_hvref_hvref);
SV* number_arrayref_hashref_hashref_to_string_extend(SV* input_avref_hvref_hvref);
SV* number_arrayref_hashref_hashref_to_string_format(SV* input_avref_hvref_hvref, SV* format_level, SV* indent_level);
SV* string_arrayref_hashref_hashref_to_string_compact(SV* input_avref_hvref_hvref);
SV* string_arrayref_hashref_hashref_to_string(SV* input_avref_hvref_hvref);
SV* string_arrayref_hashref_hashref_to_string_pretty(SV* input_avref_hvref_hvref);
SV* string_arrayref_hashref_hashref_to_string_extend(SV* input_avref_hvref_hvref);
SV* string_arrayref_hashref_hashref_to_string_format(SV* input_avref_hvref_hvref, SV* format_level, SV* indent_level);

// [[[ HASH REF ARRAY REF HASH REF ]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

// [[[ ARRAY REF ARRAY REF HASH REF ]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

# elif defined __CPP__TYPES

// [[[ HASH REF HASH REF HASH REF]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

// [[[ ARRAY REF HASH REF HASH REF ]]]
string integer_arrayref_hashref_hashref_to_string_compact(integer_arrayref_hashref_hashref input_vector_unordered_map_unordered_map);
string integer_arrayref_hashref_hashref_to_string(integer_arrayref_hashref_hashref input_vector_unordered_map_unordered_map);
string integer_arrayref_hashref_hashref_to_string_pretty(integer_arrayref_hashref_hashref input_vector_unordered_map_unordered_map);
string integer_arrayref_hashref_hashref_to_string_expand(integer_arrayref_hashref_hashref input_vector_unordered_map_unordered_map);
string integer_arrayref_hashref_hashref_to_string_format(integer_arrayref_hashref_hashref input_vector_unordered_map_unordered_map, integer format_level, integer indent_level);
string number_arrayref_hashref_hashref_to_string_compact(number_arrayref_hashref_hashref input_vector_unordered_map_unordered_map);
string number_arrayref_hashref_hashref_to_string(number_arrayref_hashref_hashref input_vector_unordered_map_unordered_map);
string number_arrayref_hashref_hashref_to_string_pretty(number_arrayref_hashref_hashref input_vector_unordered_map_unordered_map);
string number_arrayref_hashref_hashref_to_string_expand(number_arrayref_hashref_hashref input_vector_unordered_map_unordered_map);
string number_arrayref_hashref_hashref_to_string_format(number_arrayref_hashref_hashref input_vector_unordered_map_unordered_map, integer format_level, integer indent_level);
string string_arrayref_hashref_hashref_to_string_compact(string_arrayref_hashref_hashref input_vector_unordered_map_unordered_map);
string string_arrayref_hashref_hashref_to_string(string_arrayref_hashref_hashref input_vector_unordered_map_unordered_map);
string string_arrayref_hashref_hashref_to_string_pretty(string_arrayref_hashref_hashref input_vector_unordered_map_unordered_map);
string string_arrayref_hashref_hashref_to_string_expand(string_arrayref_hashref_hashref input_vector_unordered_map_unordered_map);
string string_arrayref_hashref_hashref_to_string_format(string_arrayref_hashref_hashref input_vector_unordered_map_unordered_map, integer format_level, integer indent_level);

// [[[ HASH REF ARRAY REF HASH REF ]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

// [[[ ARRAY REF ARRAY REF HASH REF ]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE
# endif

// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES
// [[[ HASH REF HASH REF HASH REF]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

// [[[ ARRAY REF HASH REF HASH REF ]]]
SV* integer_arrayref_hashref_hashref_typetest0(SV* lucky_integer_arrayref_hashrefs);
SV* integer_arrayref_hashref_hashref_typetest1(SV* my_size);
SV* number_arrayref_hashref_hashref_typetest0(SV* lucky_number_arrayref_hashrefs);
SV* number_arrayref_hashref_hashref_typetest1(SV* my_size);
SV* string_arrayref_hashref_hashref_typetest0(SV* lucky_string_arrayref_hashrefs);
SV* string_arrayref_hashref_hashref_typetest1(SV* my_size);

// [[[ HASH REF ARRAY REF HASH REF ]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

// [[[ ARRAY REF ARRAY REF HASH REF ]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

# elif defined __CPP__TYPES
// [[[ HASH REF HASH REF HASH REF]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

// [[[ ARRAY REF HASH REF HASH REF ]]]
string integer_arrayref_hashref_hashref_typetest0(integer_arrayref_hashref_hashref lucky_integer_arrayref_hashrefs);
integer_arrayref_hashref_hashref integer_arrayref_hashref_hashref_typetest1(integer my_size);
string number_arrayref_hashref_hashref_typetest0(number_arrayref_hashref_hashref lucky_number_arrayref_hashrefs);
number_arrayref_hashref_hashref number_arrayref_hashref_hashref_typetest1(integer my_size);
string string_arrayref_hashref_hashref_typetest0(string_arrayref_hashref_hashref lucky_string_arrayref_hashrefs);
string_arrayref_hashref_hashref string_arrayref_hashref_hashref_typetest1(integer my_size);

// [[[ HASH REF ARRAY REF HASH REF ]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

// [[[ ARRAY REF ARRAY REF HASH REF ]]]

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE
# endif

#endif

