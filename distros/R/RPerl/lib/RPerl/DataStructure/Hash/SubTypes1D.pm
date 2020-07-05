## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
package RPerl::DataStructure::Hash::SubTypes1D;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.018_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd)  # DEVELOPER DEFAULT 1b: allow unreachable & POD-commented code, must be after line 1
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ EXPORTS ]]]
# DEV NOTE, CORRELATION #rp051: hard-coded list of RPerl data types and data structures
use RPerl::Exporter 'import';
our @EXPORT = qw(
    integer_hashref_CHECK
    integer_hashref_CHECKTRACE
    number_hashref_CHECK
    number_hashref_CHECKTRACE
    string_hashref_CHECK
    string_hashref_CHECKTRACE
    integer_hashref_to_string_compact
    integer_hashref_to_string
    integer_hashref_to_string_pretty
    integer_hashref_to_string_expand
    integer_hashref_to_string_format
    number_hashref_to_string_compact
    number_hashref_to_string
    number_hashref_to_string_pretty
    number_hashref_to_string_expand
    number_hashref_to_string_format
    string_hashref_to_string_compact
    string_hashref_to_string
    string_hashref_to_string_pretty
    string_hashref_to_string_expand
    string_hashref_to_string_format
);
our @EXPORT_OK = qw(
    integer_hashref_typetest0
    integer_hashref_typetest1
    number_hashref_typetest0
    number_hashref_typetest1
    string_hashref_typetest0
    string_hashref_typetest1
);

# [[[ INCLUDES ]]]
use RPerl::DataType::Integer;  # for integer_CHECKTRACE(), used in *_hashref_typetest1()

# [[[ INTEGER HASH REF ]]]
# [[[ INTEGER HASH REF ]]]
# [[[ INTEGER HASH REF ]]]

# (ref to hash) of integers
package  # hide from PAUSE indexing
    integer_hashref;
use strict;
use warnings;
use parent -norequire, qw(hashref);
use Carp;

package  # hide from PAUSE indexing
    integer_hashref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE FOR EXPORT TO WORK ]]]
package RPerl::DataStructure::Hash::SubTypes1D;
use strict;
use warnings;

# [[[ TYPE-CHECKING ]]]

sub integer_hashref_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_integer_hashref ) = @ARG;

# DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() subroutine, but with integer-specific error codes
    if ( not( defined $possible_integer_hashref ) ) {
        croak( "\nERROR EIVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_hashref value expected but undefined/null value found,\ncroaking" );
    }

    if ( not( main::RPerl_SvHROKp($possible_integer_hashref) ) ) {
        croak( "\nERROR EIVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_hashref value expected but non-hashref value found,\ncroaking" );
    }

    my integer $possible_integer;
    foreach my string $key ( sort keys %{$possible_integer_hashref} ) {
        $possible_integer = $possible_integer_hashref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the integer_CHECK() subroutine, but with hash-specific error codes
        if ( not( defined $possible_integer ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak( "\nERROR EIVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but undefined/null value found at key '$key',\ncroaking" );
        }
        if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak( "\nERROR EIVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but non-integer value found at key '$key',\ncroaking" );
        }
    }
    return;
}

sub integer_hashref_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_integer_hashref, my $variable_name, my $subroutine_name )
        = @ARG;

# DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECKTRACE() subroutine, but with integer-specific error codes
    if ( not( defined $possible_integer_hashref ) ) {
        croak( "\nERROR EIVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_hashref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
    }

    if ( not( main::RPerl_SvHROKp($possible_integer_hashref) ) ) {
        croak(
            "\nERROR EIVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_hashref value expected but non-hashref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" ); }

    my integer $possible_integer;
    foreach my string $key ( sort keys %{$possible_integer_hashref} ) {
        $possible_integer = $possible_integer_hashref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the integer_CHECKTRACE() subroutine, but with hash-specific error codes
        if ( not( defined $possible_integer ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak( "\nERROR EIVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but undefined/null value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        }
        if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak( "\nERROR EIVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but non-integer value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        }
    }
    return;
}

# [[[ STRINGIFY ]]]

# DEV NOTE: 1-D format levels are 1 less than 2-D format levels

# call actual stringify routine, format level -2 (compact), indent level 0
sub integer_hashref_to_string_compact {
    { my string $RETURN_TYPE };
    ( my $input_hvref ) = @ARG;
    return integer_hashref_to_string_format($input_hvref, -2, 0);
}

# call actual stringify routine, format level -1 (normal), indent level 0, DEFAULT
sub integer_hashref_to_string {
    { my string $RETURN_TYPE };
    ( my $input_hvref ) = @ARG;
    return integer_hashref_to_string_format($input_hvref, -1, 0);
}

# call actual stringify routine, format level 0 (pretty), indent level 0
sub integer_hashref_to_string_pretty {
    { my string $RETURN_TYPE };
    ( my $input_hvref ) = @ARG;
    return integer_hashref_to_string_format($input_hvref, 0, 0);
}

# call actual stringify routine, format level 1 (expand), indent level 0
sub integer_hashref_to_string_expand {
    { my string $RETURN_TYPE };
    ( my $input_hvref ) = @ARG;
    return integer_hashref_to_string_format($input_hvref, 1, 0);
}

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing IVs))) to Perl-parsable (Perl SV containing PV)
sub integer_hashref_to_string_format {
    { my string $RETURN_TYPE };
    ( my $input_hvref, my integer $format_level, my integer $indent_level ) = @ARG;

#    RPerl::diag("in PERLOPS_PERLTYPES integer_hashref_to_string_format(), top of subroutine\n");

#    integer_hashref_CHECK($input_hvref);
    integer_hashref_CHECKTRACE( $input_hvref, '$input_hvref', 'integer_hashref_to_string()' );

    # declare local variables, av & sv mean "array value" & "scalar value" as used in Perl core
    my %input_hv;
    #	my integer $input_hv_length;
    my integer $input_hv_entry_value;
    my string $output_sv = q{};
    my boolean $i_is_0 = 1;

    # dereference input hash reference
    %input_hv = %{$input_hvref};

    # generate indent
    my string $indent = q{    } x $indent_level;

    # compute length of (number of keys in) input hash
#    $input_hv_length = scalar keys %input_hv;
#    RPerl::diag("in PERLOPS_PERLTYPES integer_hashref_to_string_format(), have \$input_hv_length = $input_hv_length\n");

    # pre-begin with optional indent, depending on format level
    if ($format_level >= 1) { $output_sv .= $indent; }

    # begin output string with left-curly-brace, as required for all RPerl hashes
    $output_sv .= '{';

    # loop through all hash keys
    foreach my string $key ( sort keys %input_hv ) {
        # retrieve input hash's entry value at key
        $input_hv_entry_value = $input_hv{$key};

# DEV NOTE: integer type-checking already done as part of integer_hashref_CHECKTRACE()
#        integer_CHECK($input_hv_entry_value);
#        integer_CHECKTRACE( $input_hv_entry_value, "\$input_hv_entry_value at key '$key'", 'integer_hashref_to_string()' );

        # append comma to output string for all elements except index 0
        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ','; }

        # append newline-indent-tab or space, depending on format level
        if    ($format_level >=  1) { $output_sv .= "\n" . $indent . q{    }; }
        elsif ($format_level >= -1) { $output_sv .= q{ }; }

        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character

        # DEV NOTE: emulate Data::Dumper & follow PBP by using single quotes for key strings
        $output_sv .= q{'} . $key. q{'};

        # append spaces before and after fat arrow AKA fat comma, depending on format level
        if ($format_level >= -1) { $output_sv .= ' => '; }
        else                     { $output_sv .= '=>'; }

#        $output_sv .= $input_hv_entry_value;  # NO UNDERSCORES
        $output_sv .= ::integer_to_string($input_hv_entry_value);  # YES UNDERSCORES
    }

    # append newline-indent or space, depending on format level
    if    ($format_level >=  1) { $output_sv .= "\n" . $indent; }
    elsif ($format_level >= -1) { $output_sv .= q{ }; }

    # end output string with right-curly-brace, as required for all RPerl hashes
    $output_sv .= '}';

#    RPerl::diag("in PERLOPS_PERLTYPES integer_hashref_to_string_format(), after for() loop, have \$output_sv =\n$output_sv\n");
#    RPerl::diag("in PERLOPS_PERLTYPES integer_hashref_to_string_format(), bottom of subroutine\n");
    return ($output_sv);
}

# [[[ TYPE TESTING ]]]

sub integer_hashref_typetest0 {
    { my string $RETURN_TYPE };
    ( my integer_hashref $lucky_integers) = @ARG;

    #    integer_hashref_CHECK($lucky_integers);
    integer_hashref_CHECKTRACE( $lucky_integers, '$lucky_integers',
        'integer_hashref_typetest0()' );

#    foreach my string $key ( sort keys %{$lucky_integers} ) {
#        my $lucky_integer = $lucky_integers->{$key};
#        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
#        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
#
#        RPerl::diag("in PERLOPS_PERLTYPES integer_hashref_typetest0(), have lucky integer '$key' => " . $lucky_integer . ", BARSTOOL\n");
#    }
#    RPerl::diag("in PERLOPS_PERLTYPES integer_hashref_typetest0(), bottom of subroutine\n");
    return (
        integer_hashref_to_string($lucky_integers) . 'PERLOPS_PERLTYPES' );
}

sub integer_hashref_typetest1 {
    { my integer_hashref $RETURN_TYPE };
    ( my integer $my_size) = @ARG;

    #    integer_CHECK($my_size);
    integer_CHECKTRACE( $my_size, '$my_size',
        'integer_hashref_typetest1()' );
    my integer_hashref $new_hash = {};
    my string $temp_key;
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $temp_key = 'PERLOPS_PERLTYPES_funkey' . $i;
        $new_hash->{$temp_key} = $i * 5;

#        RPerl::diag("in PERLOPS_PERLTYPES integer_hashref_typetest1(), setting entry '$temp_key' => " . $new_hash->{$temp_key} . ", BARSTOOL\n");
    }
    return ($new_hash);
}

# [[[ NUMBER HASH REF ]]]
# [[[ NUMBER HASH REF ]]]
# [[[ NUMBER HASH REF ]]]

# (ref to hash) of numbers
package  # hide from PAUSE indexing
    number_hashref;
use strict;
use warnings;
use parent -norequire, qw(hashref);
use Carp;

package  # hide from PAUSE indexing
    number_hashref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE FOR EXPORT TO WORK ]]]
package RPerl::DataStructure::Hash::SubTypes1D;
use strict;
use warnings;

# [[[ TYPE-CHECKING ]]]

sub number_hashref_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_number_hashref ) = @ARG;

# DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() subroutine, but with number-specific error codes
    if ( not( defined $possible_number_hashref ) ) {
        croak( "\nERROR ENVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_hashref value expected but undefined/null value found,\ncroaking" );
    }

    if ( not( main::RPerl_SvHROKp($possible_number_hashref) ) ) {
        croak( "\nERROR ENVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_hashref value expected but non-hashref value found,\ncroaking" );
    }

    my number $possible_number;
    foreach my string $key ( sort keys %{$possible_number_hashref} ) {
        $possible_number = $possible_number_hashref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the number_CHECK() subroutine, but with hash-specific error codes
        if ( not( defined $possible_number ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak( "\nERROR ENVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but undefined/null value found at key '$key',\ncroaking" );
        }
        if (not(   main::RPerl_SvNOKp($possible_number)
                || main::RPerl_SvIOKp($possible_number) )
            )
        {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak( "\nERROR ENVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but non-number value found at key '$key',\ncroaking" );
        }
    }
    return;
}

sub number_hashref_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_number_hashref, my $variable_name, my $subroutine_name )
        = @ARG;

# DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECKTRACE() subroutine, but with number-specific error codes
    if ( not( defined $possible_number_hashref ) ) {
        croak( "\nERROR ENVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_hashref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
    }

    if ( not( main::RPerl_SvHROKp($possible_number_hashref) ) ) {
        croak( "\nERROR ENVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_hashref value expected but non-hashref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
    }

    my number $possible_number;
    foreach my string $key ( sort keys %{$possible_number_hashref} ) {
        $possible_number = $possible_number_hashref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the number_CHECKTRACE() subroutine, but with hash-specific error codes
        if ( not( defined $possible_number ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak( "\nERROR ENVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but undefined/null value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        }
        if (not(   main::RPerl_SvNOKp($possible_number)
                || main::RPerl_SvIOKp($possible_number) )
            )
        {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak( "\nERROR ENVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but non-number value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        }
    }
    return;
}

# [[[ STRINGIFY ]]]

# DEV NOTE: 1-D format levels are 1 less than 2-D format levels

# call actual stringify routine, format level -2 (compact), indent level 0
sub number_hashref_to_string_compact {
    { my string $RETURN_TYPE };
    ( my $input_hvref ) = @ARG;
    return number_hashref_to_string_format($input_hvref, -2, 0);
}

# call actual stringify routine, format level -1 (normal), indent level 0, DEFAULT
sub number_hashref_to_string {
    { my string $RETURN_TYPE };
    ( my $input_hvref ) = @ARG;
    return number_hashref_to_string_format($input_hvref, -1, 0);
}

# call actual stringify routine, format level 0 (pretty), indent level 0
sub number_hashref_to_string_pretty {
    { my string $RETURN_TYPE };
    ( my $input_hvref ) = @ARG;
    return number_hashref_to_string_format($input_hvref, 0, 0);
}

# call actual stringify routine, format level 1 (expand), indent level 0
sub number_hashref_to_string_expand {
    { my string $RETURN_TYPE };
    ( my $input_hvref ) = @ARG;
    return number_hashref_to_string_format($input_hvref, 1, 0);
}

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing NVs))) to Perl-parsable (Perl SV containing PV)
sub number_hashref_to_string_format {
    { my string $RETURN_TYPE };
    ( my $input_hvref, my integer $format_level, my integer $indent_level ) = @ARG;

#    RPerl::diag("in PERLOPS_PERLTYPES number_hashref_to_string_format(), top of subroutine\n");

#    number_hashref_CHECK($input_hvref);
    number_hashref_CHECKTRACE( $input_hvref, '$input_hvref', 'number_hashref_to_string()' );

    # declare local variables, av & sv mean "array value" & "scalar value" as used in Perl core
    my %input_hv;
#    my integer $input_hv_length;
    my number $input_hv_entry_value;
    my string $output_sv = q{};
    my boolean $i_is_0 = 1;

    # dereference input hash reference
    %input_hv = %{$input_hvref};

    # generate indent
    my string $indent = q{    } x $indent_level;

    # compute length of (number of keys in) input hash
#    $input_hv_length = scalar keys %input_hv;
#    RPerl::diag("in PERLOPS_PERLTYPES number_hashref_to_string_format(), have \$input_hv_length = $input_hv_length\n");

    # pre-begin with optional indent, depending on format level
    if ($format_level >= 1) { $output_sv .= $indent; }

    # begin output string with left-curly-brace, as required for all RPerl hashes
    $output_sv .= '{';

    # loop through all hash keys
    foreach my string $key ( sort keys %input_hv ) {
        # retrieve input hash's entry value at key
        $input_hv_entry_value = $input_hv{$key};

# DEV NOTE: number type-checking already done as part of number_hashref_CHECKTRACE()
#        number_CHECK($input_hv_entry_value);
#        number_CHECKTRACE( $input_hv_entry_value, "\$input_hv_entry_value at key '$key'", 'number_hashref_to_string()' );

        # append comma to output string for all elements except index 0
        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ','; }

        # append newline-indent-tab or space, depending on format level
        if    ($format_level >=  1) { $output_sv .= "\n" . $indent . q{    }; }
        elsif ($format_level >= -1) { $output_sv .= q{ }; }

        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character

        # DEV NOTE: emulate Data::Dumper & follow PBP by using single quotes for key strings
        $output_sv .= q{'} . $key. q{'};

        # append spaces before and after fat arrow AKA fat comma, depending on format level
        if ($format_level >= -1) { $output_sv .= ' => '; }
        else                     { $output_sv .= '=>'; }

#        $output_sv .= $input_hv_entry_value;  # NO UNDERSCORES
        $output_sv .= RPerl::DataType::Number::number_to_string($input_hv_entry_value);  # YES UNDERSCORES
    }

    # append newline-indent or space, depending on format level
    if    ($format_level >=  1) { $output_sv .= "\n" . $indent; }
    elsif ($format_level >= -1) { $output_sv .= q{ }; }

    # end output string with right-curly-brace, as required for all RPerl hashes
    $output_sv .= '}';

#    RPerl::diag("in PERLOPS_PERLTYPES number_hashref_to_string_format(), after for() loop, have \$output_sv =\n$output_sv\n");
#    RPerl::diag("in PERLOPS_PERLTYPES number_hashref_to_string_format(), bottom of subroutine\n");
    return ($output_sv);
}

# [[[ TYPE TESTING ]]]

sub number_hashref_typetest0 {
    { my string $RETURN_TYPE };
    ( my number_hashref $lucky_numbers) = @ARG;

    #    number_hashref_CHECK($lucky_numbers);
    number_hashref_CHECKTRACE( $lucky_numbers, '$lucky_numbers',
        'number_hashref_typetest0()' );

#    foreach my string $key ( sort keys %{$lucky_numbers} ) {
#        my $lucky_number = $lucky_numbers->{$key};
#        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
#        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
#        RPerl::diag("in PERLOPS_PERLTYPES number_hashref_typetest0(), have lucky number '$key' => " . $lucky_number . ", BARSTOOL\n");
#    }
    return (
        number_hashref_to_string($lucky_numbers) . 'PERLOPS_PERLTYPES' );
}

sub number_hashref_typetest1 {
    { my number_hashref $RETURN_TYPE };
    ( my integer $my_size) = @ARG;

    #    integer_CHECK($my_size);
    integer_CHECKTRACE( $my_size, '$my_size',
        'number_hashref_typetest1()' );
    my number_hashref $new_hash = {};
    my string $temp_key;
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $temp_key = 'PERLOPS_PERLTYPES_funkey' . $i;
        $new_hash->{$temp_key} = $i * 5.123456789;

#        RPerl::diag("in PERLOPS_PERLTYPES number_hashref_typetest1(), setting entry '$temp_key' => " . $new_hash->{$temp_key} . ", BARSTOOL\n");
    }
    return ($new_hash);
}

# [[[ CHARACTER HASH REF ]]]
# [[[ CHARACTER HASH REF ]]]
# [[[ CHARACTER HASH REF ]]]

# (ref to hash) of chars
package  # hide from PAUSE indexing
    character_hashref;
use strict;
use warnings;
use parent -norequire, qw(hashref);

package  # hide from PAUSE indexing
    character_hashref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# [[[ STRING HASH REF ]]]
# [[[ STRING HASH REF ]]]
# [[[ STRING HASH REF ]]]

# (ref to hash) of strings
package  # hide from PAUSE indexing
    string_hashref;
use strict;
use warnings;
use parent -norequire, qw(hashref);
use Carp;

package  # hide from PAUSE indexing
    string_hashref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE FOR EXPORT TO WORK ]]]
package RPerl::DataStructure::Hash::SubTypes1D;
use strict;
use warnings;

# [[[ TYPE-CHECKING ]]]

sub string_hashref_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_string_hashref ) = @ARG;

# DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() subroutine, but with string-specific error codes
    if ( not( defined $possible_string_hashref ) ) {
        croak( "\nERROR EPVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_hashref value expected but undefined/null value found,\ncroaking" );
    }

    if ( not( main::RPerl_SvHROKp($possible_string_hashref) ) ) {
        croak( "\nERROR EPVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_hashref value expected but non-hashref value found,\ncroaking" );
    }

    my string $possible_string;
    foreach my string $key ( sort keys %{$possible_string_hashref} ) {
        $possible_string = $possible_string_hashref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the string_CHECK() subroutine, but with hash-specific error codes
        if ( not( defined $possible_string ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak( "\nERROR EPVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but undefined/null value found at key '$key',\ncroaking" );
        }
        if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak( "\nERROR EPVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but non-string value found at key '$key',\ncroaking" );
        }
    }
    return;
}

sub string_hashref_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_string_hashref, my $variable_name, my $subroutine_name )
        = @ARG;

# DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECKTRACE() subroutine, but with string-specific error codes
    if ( not( defined $possible_string_hashref ) ) {
        croak( "\nERROR EPVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_hashref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
    }

    if ( not( main::RPerl_SvHROKp($possible_string_hashref) ) ) {
        croak( "\nERROR EPVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_hashref value expected but non-hashref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
    }

    my string $possible_string;
    foreach my string $key ( sort keys %{$possible_string_hashref} ) {
        $possible_string = $possible_string_hashref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the string_CHECKTRACE() subroutine, but with hash-specific error codes
        if ( not( defined $possible_string ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak( "\nERROR EPVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but undefined/null value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        }
        if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak( "\nERROR EPVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but non-string value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        }
    }
    return;
}

# [[[ STRINGIFY ]]]

# DEV NOTE: 1-D format levels are 1 less than 2-D format levels

# call actual stringify routine, format level -2 (compact), indent level 0
sub string_hashref_to_string_compact {
    { my string $RETURN_TYPE };
    ( my $input_hvref ) = @ARG;
    return string_hashref_to_string_format($input_hvref, -2, 0);
}

# call actual stringify routine, format level -1 (normal), indent level 0, DEFAULT
sub string_hashref_to_string {
    { my string $RETURN_TYPE };
    ( my $input_hvref ) = @ARG;
    return string_hashref_to_string_format($input_hvref, -1, 0);
}

# call actual stringify routine, format level 0 (pretty), indent level 0
sub string_hashref_to_string_pretty {
    { my string $RETURN_TYPE };
    ( my $input_hvref ) = @ARG;
    return string_hashref_to_string_format($input_hvref, 0, 0);
}

# call actual stringify routine, format level 1 (expand), indent level 0
sub string_hashref_to_string_expand {
    { my string $RETURN_TYPE };
    ( my $input_hvref ) = @ARG;
    return string_hashref_to_string_format($input_hvref, 1, 0);
}

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing PVs))) to Perl-parsable (Perl SV containing PV)
sub string_hashref_to_string_format {
    { my string $RETURN_TYPE };
    ( my $input_hvref, my integer $format_level, my integer $indent_level ) = @ARG;

#    RPerl::diag("in PERLOPS_PERLTYPES string_hashref_to_string_format(), top of subroutine\n");

#    string_hashref_CHECK($input_hvref);
    string_hashref_CHECKTRACE( $input_hvref, '$input_hvref', 'string_hashref_to_string()' );

    # declare local variables, av & sv mean "array value" & "scalar value" as used in Perl core
    my %input_hv;
#    my integer $input_hv_length;
    my string $input_hv_entry_value;
    my string $output_sv = q{};
    my boolean $i_is_0 = 1;

    # dereference input hash reference
    %input_hv = %{$input_hvref};

    # generate indent
    my string $indent = q{    } x $indent_level;

    # compute length of (number of keys in) input hash
#    $input_hv_length = scalar keys %input_hv;
#    RPerl::diag("in PERLOPS_PERLTYPES string_hashref_to_string_format(), have \$input_hv_length = $input_hv_length\n");

    # pre-begin with optional indent, depending on format level
    if ($format_level >= 1) { $output_sv .= $indent; }

    # begin output string with left-curly-brace, as required for all RPerl hashes
    $output_sv .= '{';

    # loop through all hash keys
    foreach my string $key ( sort keys %input_hv ) {
        # retrieve input hash's entry value at key
        $input_hv_entry_value = $input_hv{$key};

# DEV NOTE: string type-checking already done as part of string_hashref_CHECKTRACE()
#        string_CHECK($input_hv_entry_value);
#        string_CHECKTRACE( $input_hv_entry_value, "\$input_hv_entry_value at key '$key'", 'string_hashref_to_string()' );

        # append comma to output string for all elements except index 0
        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ','; }

        # append newline-indent-tab or space, depending on format level
        if    ($format_level >=  1) { $output_sv .= "\n" . $indent . q{    }; }
        elsif ($format_level >= -1) { $output_sv .= q{ }; }

        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character

        # DEV NOTE: emulate Data::Dumper & follow PBP by using single quotes for key strings
        $output_sv .= q{'} . $key. q{'};

        # append spaces before and after fat arrow AKA fat comma, depending on format level
        if ($format_level >= -1) { $output_sv .= ' => '; }
        else                     { $output_sv .= '=>'; }

        $input_hv_entry_value =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $input_hv_entry_value =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
        $output_sv .= q{'} . $input_hv_entry_value . q{'};
    }

    # append newline-indent or space, depending on format level
    if    ($format_level >=  1) { $output_sv .= "\n" . $indent; }
    elsif ($format_level >= -1) { $output_sv .= q{ }; }

    # end output string with right-curly-brace, as required for all RPerl hashes
    $output_sv .= '}';

#    RPerl::diag("in PERLOPS_PERLTYPES string_hashref_to_string_format(), after for() loop, have \$output_sv =\n$output_sv\n");
#    RPerl::diag("in PERLOPS_PERLTYPES string_hashref_to_string_format(), bottom of subroutine\n");
    return ($output_sv);
}

# [[[ TYPE TESTING ]]]

sub string_hashref_typetest0 {
    { my string $RETURN_TYPE };
    ( my string_hashref $people) = @ARG;

    #    string_hashref_CHECK($lucky_numbers);
    string_hashref_CHECKTRACE( $people, '$people',
        'string_hashref_typetest0()' );

#    foreach my string $key ( sort keys %{$people} ) {
#        my $person = $people->{$key};
#        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
#        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
#        RPerl::diag("in PERLOPS_PERLTYPES string_hashref_typetest0(), have person '$key' => '" . $person . "', STARBOOL\n");
#    }
    return ( string_hashref_to_string($people) . 'PERLOPS_PERLTYPES' );
}

sub string_hashref_typetest1 {
    { my string_hashref $RETURN_TYPE };
    ( my integer $my_size) = @ARG;

    #    integer_CHECK($my_size);
    integer_CHECKTRACE( $my_size, '$my_size',
        'string_hashref_typetest1()' );
    my string_hashref $people = {};
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $people->{ 'PERLOPS_PERLTYPES_Luker_key' . $i }
            = q{Jeffy Ten! } . $i . q{/} . ( $my_size - 1 );

#        RPerl::diag("in PERLOPS_PERLTYPES string_hashref_typetest1(), bottom of for() loop, have i = $i, just set another Jeffy!\n");
    }
    return ($people);
}

# [[[ SCALAR HASH REF ]]]
# [[[ SCALAR HASH REF ]]]
# [[[ SCALAR HASH REF ]]]

# (ref to hash) of scalartypes
package  # hide from PAUSE indexing
    scalartype_hashref;
use strict;
use warnings;
use parent -norequire, qw(hashref);

package  # hide from PAUSE indexing
    scalartype_hashref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

1;  # end of package
