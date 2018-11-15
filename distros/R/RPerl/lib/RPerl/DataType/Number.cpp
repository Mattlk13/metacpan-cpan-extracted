using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__Number_cpp
#define __CPP__INCLUDED__RPerl__DataType__Number_cpp 0.008_000

// [[[ INCLUDES ]]]
#include <RPerl/DataType/Number.h>  // -> NULL (relies on native C type)
#include <RPerl/DataType/Boolean.cpp>  // -> Boolean.h
#include <RPerl/DataType/UnsignedInteger.cpp>  // -> UnsignedInteger.h
#include <RPerl/DataType/Integer.cpp>  // -> Integer.h
#include <RPerl/DataType/Character.cpp>  // -> Character.h
#include <RPerl/DataType/String.cpp>  // -> String.h

// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]

// TYPE-CHECKING SUBROUTINES DEPRECATED IN FAVOR OF EQUIVALENT MACROS
/*
void number_CHECK(SV* possible_number) {
    if (not(SvOK(possible_number))) {
    	croak("\nERROR ENV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but undefined/null value found,\ncroaking");
    }
	if (not(SvNOKp(possible_number) || SvIOKp(possible_number))) {
    	croak("\nERROR ENV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but non-number value found,\ncroaking");
    }
};
void number_CHECKTRACE(SV* possible_number, const char* variable_name, const char* subroutine_name) {
    if (not(SvOK(possible_number))) {
    	croak("\nERROR ENV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking",
    			variable_name, subroutine_name);
    }
	if (not(SvNOKp(possible_number) || SvIOKp(possible_number))) {
    	croak("\nERROR ENV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but non-number value found,\nin variable %s from subroutine %s,\ncroaking",
    			variable_name, subroutine_name);
    }
};
*/

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

// DEV NOTE, CORRELATION #rp010: the pack/unpack subs (below) are called by *_to_string_CPPTYPES(), moved outside #ifdef blocks
//# ifdef __CPP__TYPES

// convert from (Perl SV containing number) to (C number)
number XS_unpack_number(SV* input_sv) {
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number(), top of subroutine\n");
//	number_CHECK(input_sv);
	number_CHECKTRACE(input_sv, "input_sv", "XS_unpack_number()");

//	number output_number;

//	if (SvNOKp(input_sv)) { output_number = SvNV(input_sv); } else { croak("in CPPOPS_CPPTYPES XS_unpack_number(), input_sv was not a number"); }
//	output_number = SvNV(input_sv);

//fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number(), bottom of subroutine\n");

	return (number)SvNV(input_sv);
//	return output_number;
}

// convert from (C number) to (Perl SV containing number)
void XS_pack_number(SV* output_sv, number input_number) {
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number(), top of subroutine\n");
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number(), received unformatted input_number = %"NUMBER"\n", input_number);

	sv_setsv(output_sv, sv_2mortal(newSVnv(input_number)));

//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number(), have output_sv = '%s'\n", SvPV_nolen(output_sv));
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number(), bottom of subroutine\n");
}

//# endif







// [[[ BOOLEANIFY ]]]
// [[[ BOOLEANIFY ]]]
// [[[ BOOLEANIFY ]]]

# ifdef __PERL__TYPES

SV* number_to_boolean(SV* input_number) {
//  number_CHECK(input_number);
    number_CHECKTRACE(input_number, "input_number", "number_to_boolean()");
    if (SvNV(input_number) == 0) { return input_number; }
    else { return newSViv(1); }
}

# elif defined __CPP__TYPES

boolean number_to_boolean(number input_number) {
    if (input_number == 0) { return (boolean) input_number; }
    else { return 1; }
}

# endif

// [[[ UNSIGNED INTEGERIFY ]]]
// [[[ UNSIGNED INTEGERIFY ]]]
// [[[ UNSIGNED INTEGERIFY ]]]

# ifdef __PERL__TYPES

SV* number_to_unsigned_integer(SV* input_number) {
//  number_CHECK(input_number);
    number_CHECKTRACE(input_number, "input_number", "number_to_unsigned_integer()");
    if (SvIV(input_number) < 0) { return newSViv(SvIV(input_number) * -1); }
    else { return input_number; }
}

# elif defined __CPP__TYPES

unsigned_integer number_to_unsigned_integer(number input_number) {
    if (input_number < 0) { return (unsigned_integer) (input_number * -1); }
    else { return (unsigned_integer) input_number; }
}

# endif

// [[[ INTEGERIFY ]]]
// [[[ INTEGERIFY ]]]
// [[[ INTEGERIFY ]]]

# ifdef __PERL__TYPES

SV* number_to_integer(SV* input_number) {
//  number_CHECK(input_number);
    number_CHECKTRACE(input_number, "input_number", "number_to_integer()");
    return newSViv((integer) floor(SvNV(input_number)));
}

# elif defined __CPP__TYPES

integer number_to_integer(number input_number) {
    return (integer) floor(input_number);
}

# endif

// [[[ CHARACTERIFY ]]]
// [[[ CHARACTERIFY ]]]
// [[[ CHARACTERIFY ]]]

# ifdef __PERL__TYPES

/* DISABLE UNTIL COMPLETE, TO AVOID C++ COMPILER WARNINGS
SV* number_to_character(SV* input_number) {
//  number_CHECK(input_number);
    number_CHECKTRACE(input_number, "input_number", "number_to_character()");
    // NEED ADD CODE
}
*/

# elif defined __CPP__TYPES

character number_to_character(number input_number) {
    // NEED OPTIMIZE: remove call to number_to_string_CPPTYPES()
    return (character) number_to_string_CPPTYPES(input_number).at(0);
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

// DEV NOTE, CORRELATION #rp010: wrapper PERLTYPES sub
SV* number_to_string(SV* input_number)
{
//	number_CHECK(input_number);
	number_CHECKTRACE(input_number, "input_number", "number_to_string()");
//fprintf(stderr, "in CPPOPS_PERLTYPES number_to_string(), top of subroutine, received unformatted input_number = %"NUMBER"\n", (number)SvNV(input_number));
//fprintf(stderr, "in CPPOPS_PERLTYPES number_to_string()...\n");

	// DEV NOTE: disable old stringify w/out underscores
/*    std::ostringstream output_stream;
    output_stream.precision(std::numeric_limits<double>::digits10);
    output_stream << (double)SvNV(input_number);
    return(newSVpv((const char *)((output_stream.str()).c_str()), 0)); */

	return newSVpv((const char *)((number_to_string_CPPTYPES((double)SvNV(input_number))).c_str()), 0);

	// DEV NOTE: none of these fprintf(stderr, )-type solutions count significant digits both before and after the decimal point,
	// so we fall back to utilizing C++ ostringstream which stringifies floating point numbers exactly the same as Perl (AFAICTSF)
//	return newSVpvf("%16.32Lf", (double)SvNV(input_number));
//	return newSVpvf("%"NVff"", SvNV(input_number));
//	return newSVpvf("%"NVff"", 3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);
}

# elif defined __CPP__TYPES

// DEV NOTE, CORRELATION #rp010: shim CPPTYPES sub
string number_to_string(number input_number) {
    return number_to_string_CPPTYPES(input_number);
}

# endif

// DEV NOTE, CORRELATION #rp009: must use return type 'string' instead of 'std::string' for proper typemap pack/unpack function name alignment;
// can cause silent failure, falling back to __PERL__TYPES implementation and NOT failure of tests!
// DEV NOTE, CORRELATION #rp010: the real CPPTYPES sub (below) is called by the wrapper PERLTYPES sub and shim CPPTYPES subs (above), moved outside #ifdef blocks
string number_to_string_CPPTYPES(number input_number)
{
//fprintf(stderr, "in CPPOPS_CPPTYPES number_to_string_CPPTYPES(), top of subroutine, received unformatted input_number = %f\n", input_number);
//fprintf(stderr, "in CPPOPS_CPPTYPES number_to_string_CPPTYPES()...\n");

    std::ostringstream output_stream;
    output_stream.precision(std::numeric_limits<double>::digits10);
    output_stream << input_number;

    // DEV NOTE: disable old stringify w/out underscores
//  return(output_stream.str());

    boolean is_negative = 0;
    if (input_number < 0) { is_negative = 1; }

    string input_number_stringified = output_stream.str();

    std::stringstream input_number_stringified_stream(input_number_stringified);
    string whole_part;
    std::getline(input_number_stringified_stream, whole_part, '.');
    string decimal_part;
    std::getline(input_number_stringified_stream, decimal_part, '.');

//    fprintf(stderr, "in CPPOPS_CPPTYPES number_to_string_CPPTYPES(), have whole_part = %s\n", whole_part.c_str());
//    fprintf(stderr, "in CPPOPS_CPPTYPES number_to_string_CPPTYPES(), have decimal_part = %s\n", decimal_part.c_str());

    std::reverse(whole_part.begin(), whole_part.end());

//    fprintf(stderr, "in CPPOPS_CPPTYPES number_to_string_CPPTYPES(), have reversed whole_part = %s\n", whole_part.c_str());
    if (is_negative) { whole_part.pop_back(); }  // remove negative sign

    string whole_part_underscores = "";
    for(std::string::size_type i = 0; i < whole_part.size(); ++i) {
//        fprintf(stderr, "in CPPOPS_CPPTYPES number_to_string_CPPTYPES(), inside whole_part underscore loop, have i = %"INTEGER", whole_part[i] = %c\n", (int)i, whole_part[i]);
        whole_part_underscores += whole_part[i];
        if (((i % 3) == 2) && (i > 0) && (i != (whole_part.size() - 1))) {
//            fprintf(stderr, "in CPPOPS_CPPTYPES number_to_string_CPPTYPES(), AND UNDERSCORE \n");
            whole_part_underscores += '_';
        }
    }

//    fprintf(stderr, "in CPPOPS_CPPTYPES number_to_string_CPPTYPES(), have reversed whole_part_underscores = %s\n", whole_part_underscores.c_str());

    std::reverse(whole_part_underscores.begin(), whole_part_underscores.end());

    if (whole_part_underscores == "") {
        whole_part_underscores = "0";
    }

//    fprintf(stderr, "in CPPOPS_CPPTYPES number_to_string_CPPTYPES(), have unreversed whole_part_underscores = %s\n", whole_part_underscores.c_str());

    string decimal_part_underscores = "";
    for(std::string::size_type i = 0; i < decimal_part.size(); ++i) {
//        fprintf(stderr, "in CPPOPS_CPPTYPES number_to_string_CPPTYPES(), inside decimal_part underscore loop, have i = %"INTEGER", decimal_part[i] = %c\n", (int)i, decimal_part[i]);
        decimal_part_underscores += decimal_part[i];
        if (((i % 3) == 2) && (i > 0) && (i != (decimal_part.size() - 1))) {
//            fprintf(stderr, "in CPPOPS_CPPTYPES number_to_string_CPPTYPES(), AND UNDERSCORE \n");
            decimal_part_underscores += '_';
        }
    }

    if (decimal_part_underscores != "") {
        whole_part_underscores += '.' + decimal_part_underscores;
    }

    if (is_negative) { whole_part_underscores = '-' + whole_part_underscores; }

    return whole_part_underscores;
}

// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* number_typetest0() {
	SV* retval = newSVnv((22.0 / 7.0) + SvIV(RPerl__DataType__Number__MODE_ID()));
//fprintf(stderr, "in CPPOPS_PERLTYPES number_typetest0(), have unformatted retval = %"NUMBER"\n", (number)SvNV(retval));
	return retval;
}

SV* number_typetest1(SV* lucky_number) {
//	number_CHECK(lucky_number);
	number_CHECKTRACE(lucky_number, "lucky_number", "number_typetest1()");
//fprintf(stderr, "in CPPOPS_PERLTYPES number_typetest1(), have received lucky_number = %"NUMBER"\n", (number)SvNV(lucky_number));
	return newSVnv((SvNV(lucky_number) * 2.0) + SvIV(RPerl__DataType__Number__MODE_ID()));
}

# elif defined __CPP__TYPES

number number_typetest0() {
	number retval = (22.0 / 7.0) + RPerl__DataType__Number__MODE_ID();
//fprintf(stderr, "in CPPOPS_CPPTYPES number_typetest0(), have unformatted retval = %"NUMBER"\n", retval);
	return retval;
}

number number_typetest1(number lucky_number) {
	//fprintf(stderr, "in CPPOPS_CPPTYPES number_typetest1(), received unformatted lucky_number = %"NUMBER"\n", lucky_number);
	return (lucky_number * 2.0) + RPerl__DataType__Number__MODE_ID();
}

# endif

#endif
