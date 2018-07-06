## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
package RPerl::DataStructure::Hash::SubTypes2D;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.022_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd)  # DEVELOPER DEFAULT 1b: allow unreachable & POD-commented code, must be after line 1
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ EXPORTS ]]]
# DEV NOTE, CORRELATION #rp051: hard-coded list of RPerl data types and data structures
use RPerl::Exporter 'import';
our @EXPORT = qw(
    integer_arrayref_hashref_CHECK
    integer_arrayref_hashref_CHECKTRACE
    integer_arrayref_hashref_to_string_compact
    integer_arrayref_hashref_to_string
    integer_arrayref_hashref_to_string_pretty
    integer_arrayref_hashref_to_string_expand
    integer_arrayref_hashref_to_string_format
    number_arrayref_hashref_CHECK
    number_arrayref_hashref_CHECKTRACE
    number_arrayref_hashref_to_string_compact
    number_arrayref_hashref_to_string
    number_arrayref_hashref_to_string_pretty
    number_arrayref_hashref_to_string_expand
    number_arrayref_hashref_to_string_format
    string_arrayref_hashref_CHECK
    string_arrayref_hashref_CHECKTRACE
    string_arrayref_hashref_to_string_compact
    string_arrayref_hashref_to_string
    string_arrayref_hashref_to_string_pretty
    string_arrayref_hashref_to_string_expand
    string_arrayref_hashref_to_string_format
);
our @EXPORT_OK = qw(
    integer_arrayref_hashref_typetest0
    integer_arrayref_hashref_typetest1
    number_arrayref_hashref_typetest0
    number_arrayref_hashref_typetest1
    string_arrayref_hashref_typetest0
    string_arrayref_hashref_typetest1
);

# [[[ INCLUDES ]]]
# for *_CHECK*() used in *_arrayref_hashref_typetest*()
use RPerl::DataType::Integer;
use RPerl::DataType::Number;
use RPerl::DataType::String;

# [[[ ARRAY REF HASH REF ]]]
# [[[ ARRAY REF HASH REF ]]]
# [[[ ARRAY REF HASH REF ]]]

# (ref to hash) of (refs to arrays)
package  # hide from PAUSE indexing
    arrayref_hashref;
use strict;
use warnings;
use parent -norequire, qw(hashref);

# [[[ INTEGER ARRAY REF HASH REF ]]]
# [[[ INTEGER ARRAY REF HASH REF ]]]
# [[[ INTEGER ARRAY REF HASH REF ]]]

# (ref to hash) of (refs to (arrays of integers))
package  # hide from PAUSE indexing
    integer_arrayref_hashref;
use strict;
use warnings;
use parent -norequire, qw(arrayref_hashref);

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE FOR EXPORT TO WORK ]]]
package RPerl::DataStructure::Hash::SubTypes2D;
use strict;
use warnings;

# [[[ TYPE-CHECKING ]]]

sub integer_arrayref_hashref_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_integer_arrayref_hashref ) = @ARG;

#    RPerl::diag('in PERLOPS_PERLTYPES integer_arrayref_hashref_CHECK(), top of subroutine', "\n");

    # DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() subroutine, but with integer-specific error codes
    if ( not( defined $possible_integer_arrayref_hashref ) ) {
        croak( "\n" . 'ERROR EIVAVRVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' . "\n" . 'integer_arrayref_hashref value expected but undefined/null value found,' . "\n" . 'croaking' );
    }

    if ( not( main::RPerl_SvHROKp($possible_integer_arrayref_hashref) ) ) {
        croak( "\n" . 'ERROR EIVAVRVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' . "\n" . 'integer_arrayref_hashref value expected but non-hashref value found,' . "\n" . 'croaking' );
    }

    my integer_arrayref $possible_integer_arrayref;
    foreach my string $key ( sort keys %{$possible_integer_arrayref_hashref} ) {
        $possible_integer_arrayref = $possible_integer_arrayref_hashref->{$key};

        # DEV NOTE: the following two if() statements are functionally equivalent to the arrayref_CHECK() subroutine, but with integer-specific error codes
        if ( not( defined $possible_integer_arrayref ) ) {
            croak( "\n" . 'ERROR EIVAVRVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                    "\n" . 'integer_arrayref value expected but undefined/null value found at key ' . q{'} . $key . q{',} . "\n" . 'croaking' );
        }

        if ( not( main::RPerl_SvAROKp($possible_integer_arrayref) ) ) {
            croak( "\n" . 'ERROR EIVAVRVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                    "\n" . 'integer_arrayref value expected but non-arrayref value found at key ' . q{'} . $key . q{',} . "\n" . 'croaking' );
        }

        my integer $possible_integer;
        for my integer $i ( 0 .. ( ( scalar @{$possible_integer_arrayref} ) - 1 ) )
        {
            $possible_integer = $possible_integer_arrayref->[$i];

            # DEV NOTE: the following two if() statements are functionally equivalent to the integer_CHECK() subroutine, but with arrayref_hashref-specific error codes
            if ( not( defined $possible_integer ) ) {
                $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
                $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
                croak( "\n" . 'ERROR EIVAVRVHVRV04, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                        "\n" . 'integer value expected but undefined/null value found at index ' . $i . ', key ' .  q{'} . $key . q{'} . ',' . "\n" . 'croaking' );
            }
            if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
                $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
                $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
                croak( "\n" . 'ERROR EIVAVRVHVRV05, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                        "\n" . 'integer value expected but non-integer value found at index ' . $i . ', key ' .  q{'} . $key . q{'} . ',' . "\n" . 'croaking' );
            }
        }
    }
    return;
}

sub integer_arrayref_hashref_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_integer_arrayref_hashref, my $variable_name, my $subroutine_name ) = @ARG;

#    RPerl::diag('in PERLOPS_PERLTYPES integer_arrayref_hashref_CHECKTRACE(), top of subroutine', "\n");

    # DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() subroutine, but with integer-specific error codes
    if ( not( defined $possible_integer_arrayref_hashref ) ) {
        croak( "\n" . 'ERROR EIVAVRVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' . "\n" . 'integer_arrayref_hashref value expected but undefined/null value found,' . 
                "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
    }

    if ( not( main::RPerl_SvHROKp($possible_integer_arrayref_hashref) ) ) {
        croak( "\n" . 'ERROR EIVAVRVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' . "\n" . 'integer_arrayref_hashref value expected but non-hashref value found,' . 
                "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
    }

    my integer_arrayref $possible_integer_arrayref;
    foreach my string $key ( sort keys %{$possible_integer_arrayref_hashref} ) {
        $possible_integer_arrayref = $possible_integer_arrayref_hashref->{$key};

        # DEV NOTE: the following two if() statements are functionally equivalent to the arrayref_CHECK() subroutine, but with integer-specific error codes
        if ( not( defined $possible_integer_arrayref ) ) {
            croak( "\n" . 'ERROR EIVAVRVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                    "\n" . 'integer_arrayref value expected but undefined/null value found at key ' . q{'} . $key . q{',} . 
                    "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
        }

        if ( not( main::RPerl_SvAROKp($possible_integer_arrayref) ) ) {
            croak( "\n" . 'ERROR EIVAVRVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                    "\n" . 'integer_arrayref value expected but non-arrayref value found at key ' . q{'} . $key . q{',} .
                    "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
        }

        my integer $possible_integer;
        for my integer $i ( 0 .. ( ( scalar @{$possible_integer_arrayref} ) - 1 ) )
        {
            $possible_integer = $possible_integer_arrayref->[$i];

            # DEV NOTE: the following two if() statements are functionally equivalent to the integer_CHECK() subroutine, but with arrayref_hashref-specific error codes
            if ( not( defined $possible_integer ) ) {
                $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
                $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
                croak( "\n" . 'ERROR EIVAVRVHVRV04, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                        "\n" . 'integer value expected but undefined/null value found at index ' . $i . ', key ' .  q{'} . $key . q{'} . ',' .
                        "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
            }
            if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
                $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
                $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
                croak( "\n" . 'ERROR EIVAVRVHVRV05, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                        "\n" . 'integer value expected but non-integer value found at index ' . $i . ', key ' .  q{'} . $key . q{'} . ',' .
                        "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
            }
        }
    }
    return;
}

# [[[ STRINGIFY ]]]

# call actual stringify routine, format level -1 (compact), indent level 0
sub integer_arrayref_hashref_to_string_compact {
    { my string $RETURN_TYPE };
    ( my $input_avref_hvref ) = @ARG;
    return integer_arrayref_hashref_to_string_format($input_avref_hvref, -1, 0);
}

# call actual stringify routine, format level 0 (normal), indent level 0, DEFAULT
sub integer_arrayref_hashref_to_string {
    { my string $RETURN_TYPE };
    ( my $input_avref_hvref ) = @ARG;
    return integer_arrayref_hashref_to_string_format($input_avref_hvref, 0, 0);
}

# call actual stringify routine, format level 1 (pretty), indent level 0
sub integer_arrayref_hashref_to_string_pretty {
    { my string $RETURN_TYPE };
    ( my $input_avref_hvref ) = @ARG;
    return integer_arrayref_hashref_to_string_format($input_avref_hvref, 1, 0);
}

# call actual stringify routine, format level 2 (expand), indent level 0
sub integer_arrayref_hashref_to_string_expand {
    { my string $RETURN_TYPE };
    ( my $input_avref_hvref ) = @ARG;
    return integer_arrayref_hashref_to_string_format($input_avref_hvref, 2, 0);
}

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing IVs))) to Perl-parsable (Perl SV containing PV)
sub integer_arrayref_hashref_to_string_format {
    { my string $RETURN_TYPE };
    ( my $input_avref_hvref, my integer $format_level, my integer $indent_level ) = @ARG;

#    RPerl::diag("in PERLOPS_PERLTYPES integer_arrayref_hashref_to_string_format(), top of subroutine\n");
#    RPerl::diag('in PERLOPS_PERLTYPES integer_arrayref_hashref_to_string_format(), received $format_level = ', $format_level, "\n");
#    RPerl::diag('in PERLOPS_PERLTYPES integer_arrayref_hashref_to_string_format(), received $indent_level = ', $indent_level, "\n");

#    integer_arrayref_hashref_CHECK($input_avref_hvref);
    integer_arrayref_hashref_CHECKTRACE( $input_avref_hvref, '$input_avref_hvref', 'integer_arrayref_hashref_to_string_format()' );

    # declare local variables, av & sv mean "array value" & "scalar value" as used in Perl core
    my %input_avref_hv;
#   my integer $input_avref_hv_length;
    my integer_arrayref $input_avref_hv_entry_value;
    my string $output_sv;
    my boolean $i_is_0 = 1;

    # dereference input hash reference
    %input_avref_hv = %{$input_avref_hvref};

    # generate indent
    my string $indent = q{    } x $indent_level;

    # compute length of (number of keys in) input hash
#   $input_avref_hv_length = scalar keys %input_avref_hv;
#   RPerl::diag("in PERLOPS_PERLTYPES integer_arrayref_hashref_to_string_format(), have \$input_avref_hv_length = $input_avref_hv_length\n");

    # pre-begin with optional indent, depending on format level
    if ($format_level >= 1) { $output_sv .= $indent; }  # pretty

    # begin output string with left-curly-brace, as required for all RPerl hashes
    $output_sv .= '{';

    # loop through all hash keys
    foreach my string $key ( sort keys %input_avref_hv ) {
        # retrieve input hash's entry value at key
        $input_avref_hv_entry_value = $input_avref_hv{$key};

# DEV NOTE: integer type-checking already done as part of integer_arrayref_hashref_CHECKTRACE()
#        integer_CHECK($input_avref_hv_entry_value);
#        integer_CHECKTRACE( $input_avref_hv_entry_value, "\$input_avref_hv_entry_value at key '$key'", 'integer_arrayref_hashref_to_string_format()' );

        # append comma to output string for all elements except index 0
        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ','; }

        # append newline-indent-tab or space, depending on format level
        if    ($format_level >= 1) { $output_sv .=  "\n" . $indent . q{    }; }  # pretty & expand
        elsif ($format_level >= 0) { $output_sv .= q{ }; }  # normal

        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character

        # DEV NOTE: emulate Data::Dumper & follow PBP by using single quotes for key strings
        $output_sv .= q{'} . $key . q{'};

        # append spaces before and after fat arrow AKA fat comma, depending on format level
        if ($format_level >= 0) { $output_sv .= ' => '; }  # normal & pretty & expand
        else                    { $output_sv .= '=>'; }    # compact

        # append newline after fat arrow AKA fat comma, depending on format level
        if ($format_level >= 2) { $output_sv .= "\n"; }  # expand

        # call *_to_string_format() for data sub-structure
        $output_sv .= ::integer_arrayref_to_string_format($input_avref_hv_entry_value, ($format_level - 1), ($indent_level + 1));  # YES UNDERSCORES
    }

    # append newline-indent or space, depending on format level
    if    ($format_level >= 1) { $output_sv .= "\n" . $indent; }  # pretty & expand
    elsif ($format_level >= 0) { $output_sv .= q{ }; }  # normal

    # end output string with right-curly-brace, as required for all RPerl hashes
    $output_sv .= '}';

#    RPerl::diag("in PERLOPS_PERLTYPES integer_arrayref_hashref_to_string_format(), after for() loop, have \$output_sv =\n$output_sv\n");
#    RPerl::diag("in PERLOPS_PERLTYPES integer_arrayref_hashref_to_string_format(), bottom of subroutine\n");
    return ($output_sv);
}

# [[[ TYPE TESTING ]]]

sub integer_arrayref_hashref_typetest0 {
    { my string $RETURN_TYPE };
    ( my integer_arrayref_hashref $lucky_integers) = @ARG;

#    integer_arrayref_hashref_CHECK($lucky_integers);
    integer_arrayref_hashref_CHECKTRACE( $lucky_integers, '$lucky_integers', 'integer_arrayref_hashref_typetest0()' );

#    foreach my string $key ( sort keys %{$lucky_integers} ) {
#        my $lucky_integer = $lucky_integers->{$key};
#        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
#        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
#
#        RPerl::diag("in PERLOPS_PERLTYPES integer_arrayref_hashref_typetest0(), have lucky integer '$key' => " . $lucky_integer . ", BARSTOOL\n");
#    }
#    RPerl::diag("in PERLOPS_PERLTYPES integer_arrayref_hashref_typetest0(), bottom of subroutine\n");
    return ( integer_arrayref_hashref_to_string($lucky_integers) . 'PERLOPS_PERLTYPES' );
}

sub integer_arrayref_hashref_typetest1 {
    { my integer_arrayref_hashref $RETURN_TYPE };
    ( my integer $my_size) = @ARG;

#    integer_CHECK($my_size);
    integer_CHECKTRACE( $my_size, '$my_size', 'integer_arrayref_hashref_typetest1()' );

    # create a square 2-D data structure
    my integer_arrayref_hashref $new_hash = {};
    my string $temp_key;
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $temp_key = 'PERLOPS_PERLTYPES_funkey' . $i;
        my integer_arrayref $temp_array = [];
        for my integer $j ( 0 .. ( $my_size - 1)) {
            $temp_array->[$j] = $i * $j;
        }
        $new_hash->{$temp_key} = $temp_array;

#        RPerl::diag("in PERLOPS_PERLTYPES integer_arrayref_hashref_typetest1(), setting entry '$temp_key' => " . Dumper($new_hash->{$temp_key}) . ", BARSTOOL\n");
    }
    return ($new_hash);
}

# [[[ NUMBER ARRAY REF HASH REF ]]]
# [[[ NUMBER ARRAY REF HASH REF ]]]
# [[[ NUMBER ARRAY REF HASH REF ]]]

# (ref to hash) of (refs to (arrays of numbers))
package  # hide from PAUSE indexing
    number_arrayref_hashref;
use strict;
use warnings;
use parent -norequire, qw(arrayref_hashref);

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE FOR EXPORT TO WORK ]]]
package RPerl::DataStructure::Hash::SubTypes2D;
use strict;
use warnings;

# [[[ TYPE-CHECKING ]]]

sub number_arrayref_hashref_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_number_arrayref_hashref ) = @ARG;

#    RPerl::diag('in PERLOPS_PERLTYPES number_arrayref_hashref_CHECK(), top of subroutine', "\n");

    # DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() subroutine, but with number-specific error codes
    if ( not( defined $possible_number_arrayref_hashref ) ) {
        croak( "\n" . 'ERROR ENVAVRVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' . "\n" . 'number_arrayref_hashref value expected but undefined/null value found,' . "\n" . 'croaking' );
    }

    if ( not( main::RPerl_SvHROKp($possible_number_arrayref_hashref) ) ) {
        croak( "\n" . 'ERROR ENVAVRVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' . "\n" . 'number_arrayref_hashref value expected but non-hashref value found,' . "\n" . 'croaking' );
    }

    my number_arrayref $possible_number_arrayref;
    foreach my string $key ( sort keys %{$possible_number_arrayref_hashref} ) {
        $possible_number_arrayref = $possible_number_arrayref_hashref->{$key};

        # DEV NOTE: the following two if() statements are functionally equivalent to the arrayref_CHECK() subroutine, but with number-specific error codes
        if ( not( defined $possible_number_arrayref ) ) {
            croak( "\n" . 'ERROR ENVAVRVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                    "\n" . 'number_arrayref value expected but undefined/null value found at key ' . q{'} . $key . q{',} . "\n" . 'croaking' );
        }

        if ( not( main::RPerl_SvAROKp($possible_number_arrayref) ) ) {
            croak( "\n" . 'ERROR ENVAVRVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                    "\n" . 'number_arrayref value expected but non-arrayref value found at key ' . q{'} . $key . q{',} . "\n" . 'croaking' );
        }

        my number $possible_number;
        for my integer $i ( 0 .. ( ( scalar @{$possible_number_arrayref} ) - 1 ) )
        {
            $possible_number = $possible_number_arrayref->[$i];

            # DEV NOTE: the following two if() statements are functionally equivalent to the number_CHECK() subroutine, but with arrayref_hashref-specific error codes
            if ( not( defined $possible_number ) ) {
                $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
                $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
                croak( "\n" . 'ERROR ENVAVRVHVRV04, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                        "\n" . 'number value expected but undefined/null value found at index ' . $i . ', key ' .  q{'} . $key . q{'} . ',' . "\n" . 'croaking' );
            }
            if (not(   main::RPerl_SvNOKp($possible_number)
                    || main::RPerl_SvIOKp($possible_number) ) ) {
                $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
                $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
                croak( "\n" . 'ERROR ENVAVRVHVRV05, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                        "\n" . 'number value expected but non-number value found at index ' . $i . ', key ' .  q{'} . $key . q{'} . ',' . "\n" . 'croaking' );
            }
        }
    }
    return;
}

sub number_arrayref_hashref_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_number_arrayref_hashref, my $variable_name, my $subroutine_name ) = @ARG;

#    RPerl::diag('in PERLOPS_PERLTYPES number_arrayref_hashref_CHECKTRACE(), top of subroutine', "\n");

    # DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() subroutine, but with number-specific error codes
    if ( not( defined $possible_number_arrayref_hashref ) ) {
        croak( "\n" . 'ERROR ENVAVRVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' . "\n" . 'number_arrayref_hashref value expected but undefined/null value found,' . 
                "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
    }

    if ( not( main::RPerl_SvHROKp($possible_number_arrayref_hashref) ) ) {
        croak( "\n" . 'ERROR ENVAVRVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' . "\n" . 'number_arrayref_hashref value expected but non-hashref value found,' . 
                "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
    }

    my number_arrayref $possible_number_arrayref;
    foreach my string $key ( sort keys %{$possible_number_arrayref_hashref} ) {
        $possible_number_arrayref = $possible_number_arrayref_hashref->{$key};

#        RPerl::diag('in PERLOPS_PERLTYPES number_arrayref_hashref_CHECKTRACE(), at $key = ', q{'}, $key, q{'}, ', have $possible_number_arrayref = ', Dumper($possible_number_arrayref), "\n");

        # DEV NOTE: the following two if() statements are functionally equivalent to the arrayref_CHECK() subroutine, but with number-specific error codes
        if ( not( defined $possible_number_arrayref ) ) {
            croak( "\n" . 'ERROR ENVAVRVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                    "\n" . 'number_arrayref value expected but undefined/null value found at key ' . q{'} . $key . q{',} . 
                    "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
        }

        if ( not( main::RPerl_SvAROKp($possible_number_arrayref) ) ) {
            croak( "\n" . 'ERROR ENVAVRVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                    "\n" . 'number_arrayref value expected but non-arrayref value found at key ' . q{'} . $key . q{',} .
                    "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
        }

        my number $possible_number;
        for my integer $i ( 0 .. ( ( scalar @{$possible_number_arrayref} ) - 1 ) )
        {
            $possible_number = $possible_number_arrayref->[$i];

#            RPerl::diag('in PERLOPS_PERLTYPES number_arrayref_hashref_CHECKTRACE(), at $key = ', q{'}, $key, q{'}, ', index $i = ', $i, ', have $possible_number = ', $possible_number, "\n");

            # DEV NOTE: the following two if() statements are functionally equivalent to the number_CHECK() subroutine, but with arrayref_hashref-specific error codes
            if ( not( defined $possible_number ) ) {
                $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
                $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
                croak( "\n" . 'ERROR ENVAVRVHVRV04, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                        "\n" . 'number value expected but undefined/null value found at index ' . $i . ', key ' .  q{'} . $key . q{'} . ',' .
                        "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
            }
            if (not(   main::RPerl_SvNOKp($possible_number)
                    || main::RPerl_SvIOKp($possible_number) ) ) {
                $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
                $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
                croak( "\n" . 'ERROR ENVAVRVHVRV05, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                        "\n" . 'number value expected but non-number value found at index ' . $i . ', key ' .  q{'} . $key . q{'} . ',' .
                        "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
            }
        }
    }
    return;
}

# [[[ STRINGIFY ]]]

# call actual stringify routine, format level -1 (compact), indent level 0
sub number_arrayref_hashref_to_string_compact {
    { my string $RETURN_TYPE };
    ( my $input_avref_hvref ) = @ARG;
    return number_arrayref_hashref_to_string_format($input_avref_hvref, -1, 0);
}

# call actual stringify routine, format level 0 (normal), indent level 0, DEFAULT
sub number_arrayref_hashref_to_string {
    { my string $RETURN_TYPE };
    ( my $input_avref_hvref ) = @ARG;
    return number_arrayref_hashref_to_string_format($input_avref_hvref, 0, 0);
}

# call actual stringify routine, format level 1 (pretty), indent level 0
sub number_arrayref_hashref_to_string_pretty {
    { my string $RETURN_TYPE };
    ( my $input_avref_hvref ) = @ARG;
    return number_arrayref_hashref_to_string_format($input_avref_hvref, 1, 0);
}

# call actual stringify routine, format level 2 (expand), indent level 0
sub number_arrayref_hashref_to_string_expand {
    { my string $RETURN_TYPE };
    ( my $input_avref_hvref ) = @ARG;
    return number_arrayref_hashref_to_string_format($input_avref_hvref, 2, 0);
}

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing NVs))) to Perl-parsable (Perl SV containing PV)
sub number_arrayref_hashref_to_string_format {
    { my string $RETURN_TYPE };
    ( my $input_avref_hvref, my integer $format_level, my integer $indent_level ) = @ARG;

#    RPerl::diag("in PERLOPS_PERLTYPES number_arrayref_hashref_to_string_format(), top of subroutine\n");
#    RPerl::diag('in PERLOPS_PERLTYPES number_arrayref_hashref_to_string_format(), received $format_level = ', $format_level, "\n");
#    RPerl::diag('in PERLOPS_PERLTYPES number_arrayref_hashref_to_string_format(), received $indent_level = ', $indent_level, "\n");

#    number_arrayref_hashref_CHECK($input_avref_hvref);
    number_arrayref_hashref_CHECKTRACE( $input_avref_hvref, '$input_avref_hvref', 'number_arrayref_hashref_to_string_format()' );

    # declare local variables, av & sv mean "array value" & "scalar value" as used in Perl core
    my %input_avref_hv;
#   my integer $input_avref_hv_length;
    my number_arrayref $input_avref_hv_entry_value;
    my string $output_sv;
    my boolean $i_is_0 = 1;

    # dereference input hash reference
    %input_avref_hv = %{$input_avref_hvref};

    # generate indent
    my string $indent = q{    } x $indent_level;

    # compute length of (number of keys in) input hash
#   $input_avref_hv_length = scalar keys %input_avref_hv;
#   RPerl::diag("in PERLOPS_PERLTYPES number_arrayref_hashref_to_string_format(), have \$input_avref_hv_length = $input_avref_hv_length\n");

    # pre-begin with optional indent, depending on format level
    if ($format_level >= 1) { $output_sv .= $indent; }  # pretty

    # begin output string with left-curly-brace, as required for all RPerl hashes
    $output_sv .= '{';

    # loop through all hash keys
    foreach my string $key ( sort keys %input_avref_hv ) {
        # retrieve input hash's entry value at key
        $input_avref_hv_entry_value = $input_avref_hv{$key};

# DEV NOTE: number type-checking already done as part of number_arrayref_hashref_CHECKTRACE()
#        number_CHECK($input_avref_hv_entry_value);
#        number_CHECKTRACE( $input_avref_hv_entry_value, "\$input_avref_hv_entry_value at key '$key'", 'number_arrayref_hashref_to_string_format()' );

        # append comma to output string for all elements except index 0
        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ','; }

        # append newline-indent-tab or space, depending on format level
        if    ($format_level >= 1) { $output_sv .=  "\n" . $indent . q{    }; }  # pretty & expand
        elsif ($format_level >= 0) { $output_sv .= q{ }; }  # normal

        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character

        # DEV NOTE: emulate Data::Dumper & follow PBP by using single quotes for key strings
        $output_sv .= q{'} . $key . q{'};

        # append spaces before and after fat arrow AKA fat comma, depending on format level
        if ($format_level >= 0) { $output_sv .= ' => '; }  # normal & pretty & expand
        else                    { $output_sv .= '=>'; }    # compact

        # append newline after fat arrow AKA fat comma, depending on format level
        if ($format_level >= 2) { $output_sv .= "\n"; }  # expand

        # call *_to_string_format() for data sub-structure
        $output_sv .= ::number_arrayref_to_string_format($input_avref_hv_entry_value, ($format_level - 1), ($indent_level + 1));  # YES UNDERSCORES
    }

    # append newline-indent or space, depending on format level
    if    ($format_level >= 1) { $output_sv .= "\n" . $indent; }  # pretty & expand
    elsif ($format_level >= 0) { $output_sv .= q{ }; }  # normal

    # end output string with right-curly-brace, as required for all RPerl hashes
    $output_sv .= '}';

#    RPerl::diag("in PERLOPS_PERLTYPES number_arrayref_hashref_to_string_format(), after for() loop, have \$output_sv =\n$output_sv\n");
#    RPerl::diag("in PERLOPS_PERLTYPES number_arrayref_hashref_to_string_format(), bottom of subroutine\n");
    return ($output_sv);
}

# [[[ TYPE TESTING ]]]

sub number_arrayref_hashref_typetest0 {
    { my string $RETURN_TYPE };
    ( my number_arrayref_hashref $lucky_numbers) = @ARG;

#    number_arrayref_hashref_CHECK($lucky_numbers);
    number_arrayref_hashref_CHECKTRACE( $lucky_numbers, '$lucky_numbers', 'number_arrayref_hashref_typetest0()' );

#    foreach my string $key ( sort keys %{$lucky_numbers} ) {
#        my $lucky_number = $lucky_numbers->{$key};
#        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
#        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
#
#        RPerl::diag("in PERLOPS_PERLTYPES number_arrayref_hashref_typetest0(), have lucky number '$key' => " . $lucky_number . ", BARSTOOL\n");
#    }
#    RPerl::diag("in PERLOPS_PERLTYPES number_arrayref_hashref_typetest0(), bottom of subroutine\n");
    return ( number_arrayref_hashref_to_string($lucky_numbers) . 'PERLOPS_PERLTYPES' );
}

sub number_arrayref_hashref_typetest1 {
    { my number_arrayref_hashref $RETURN_TYPE };
    ( my integer $my_size) = @ARG;

#    integer_CHECK($my_size);
    integer_CHECKTRACE( $my_size, '$my_size', 'number_arrayref_hashref_typetest1()' );

    # create a square 2-D data structure
    my number_arrayref_hashref $new_hash = {};
    my string $temp_key;
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $temp_key = 'PERLOPS_PERLTYPES_funkey' . $i;
        my number_arrayref $temp_array = [];
        for my integer $j ( 0 .. ( $my_size - 1)) {
            $temp_array->[$j] = $i * $j * 5.123456789;
        }
        $new_hash->{$temp_key} = $temp_array;

#        RPerl::diag("in PERLOPS_PERLTYPES number_arrayref_hashref_typetest1(), setting entry '$temp_key' => " . Dumper($new_hash->{$temp_key}) . ", BARSTOOL\n");
    }
    return ($new_hash);
}

# [[[ STRING ARRAY REF HASH REF ]]]
# [[[ STRING ARRAY REF HASH REF ]]]
# [[[ STRING ARRAY REF HASH REF ]]]

# (ref to hash) of (refs to (arrays of strings))
package  # hide from PAUSE indexing
    string_arrayref_hashref;
use strict;
use warnings;
use parent -norequire, qw(arrayref_hashref);

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE FOR EXPORT TO WORK ]]]
package RPerl::DataStructure::Hash::SubTypes2D;
use strict;
use warnings;

# [[[ TYPE-CHECKING ]]]

sub string_arrayref_hashref_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_string_arrayref_hashref ) = @ARG;

#    RPerl::diag('in PERLOPS_PERLTYPES string_arrayref_hashref_CHECK(), top of subroutine', "\n");

    # DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() subroutine, but with string-specific error codes
    if ( not( defined $possible_string_arrayref_hashref ) ) {
        croak( "\n" . 'ERROR EPVAVRVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' . "\n" . 'string_arrayref_hashref value expected but undefined/null value found,' . "\n" . 'croaking' );
    }

    if ( not( main::RPerl_SvHROKp($possible_string_arrayref_hashref) ) ) {
        croak( "\n" . 'ERROR EPVAVRVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' . "\n" . 'string_arrayref_hashref value expected but non-hashref value found,' . "\n" . 'croaking' );
    }

    my string_arrayref $possible_string_arrayref;
    foreach my string $key ( sort keys %{$possible_string_arrayref_hashref} ) {
        $possible_string_arrayref = $possible_string_arrayref_hashref->{$key};

        # DEV NOTE: the following two if() statements are functionally equivalent to the arrayref_CHECK() subroutine, but with string-specific error codes
        if ( not( defined $possible_string_arrayref ) ) {
            croak( "\n" . 'ERROR EPVAVRVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                    "\n" . 'string_arrayref value expected but undefined/null value found at key ' . q{'} . $key . q{',} . "\n" . 'croaking' );
        }

        if ( not( main::RPerl_SvAROKp($possible_string_arrayref) ) ) {
            croak( "\n" . 'ERROR EPVAVRVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                    "\n" . 'string_arrayref value expected but non-arrayref value found at key ' . q{'} . $key . q{',} . "\n" . 'croaking' );
        }

        my string $possible_string;
        for my integer $i ( 0 .. ( ( scalar @{$possible_string_arrayref} ) - 1 ) )
        {
            $possible_string = $possible_string_arrayref->[$i];

            # DEV NOTE: the following two if() statements are functionally equivalent to the string_CHECK() subroutine, but with arrayref_hashref-specific error codes
            if ( not( defined $possible_string ) ) {
                $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
                $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
                croak( "\n" . 'ERROR EPVAVRVHVRV04, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                        "\n" . 'string value expected but undefined/null value found at index ' . $i . ', key ' .  q{'} . $key . q{'} . ',' . "\n" . 'croaking' );
            }
            if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
                $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
                $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
                croak( "\n" . 'ERROR EPVAVRVHVRV05, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                        "\n" . 'string value expected but non-string value found at index ' . $i . ', key ' .  q{'} . $key . q{'} . ',' . "\n" . 'croaking' );
            }
        }
    }
    return;
}

sub string_arrayref_hashref_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_string_arrayref_hashref, my $variable_name, my $subroutine_name ) = @ARG;

#    RPerl::diag('in PERLOPS_PERLTYPES string_arrayref_hashref_CHECKTRACE(), top of subroutine', "\n");

    # DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() subroutine, but with string-specific error codes
    if ( not( defined $possible_string_arrayref_hashref ) ) {
        croak( "\n" . 'ERROR EPVAVRVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' . "\n" . 'string_arrayref_hashref value expected but undefined/null value found,' . 
                "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
    }

    if ( not( main::RPerl_SvHROKp($possible_string_arrayref_hashref) ) ) {
        croak( "\n" . 'ERROR EPVAVRVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' . "\n" . 'string_arrayref_hashref value expected but non-hashref value found,' . 
                "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
    }

    my string_arrayref $possible_string_arrayref;
    foreach my string $key ( sort keys %{$possible_string_arrayref_hashref} ) {
        $possible_string_arrayref = $possible_string_arrayref_hashref->{$key};

        # DEV NOTE: the following two if() statements are functionally equivalent to the arrayref_CHECK() subroutine, but with string-specific error codes
        if ( not( defined $possible_string_arrayref ) ) {
            croak( "\n" . 'ERROR EPVAVRVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                    "\n" . 'string_arrayref value expected but undefined/null value found at key ' . q{'} . $key . q{',} . 
                    "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
        }

        if ( not( main::RPerl_SvAROKp($possible_string_arrayref) ) ) {
            croak( "\n" . 'ERROR EPVAVRVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                    "\n" . 'string_arrayref value expected but non-arrayref value found at key ' . q{'} . $key . q{',} .
                    "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
        }

        my string $possible_string;
        for my integer $i ( 0 .. ( ( scalar @{$possible_string_arrayref} ) - 1 ) )
        {
            $possible_string = $possible_string_arrayref->[$i];

            # DEV NOTE: the following two if() statements are functionally equivalent to the string_CHECK() subroutine, but with arrayref_hashref-specific error codes
            if ( not( defined $possible_string ) ) {
                $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
                $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
                croak( "\n" . 'ERROR EPVAVRVHVRV04, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                        "\n" . 'string value expected but undefined/null value found at index ' . $i . ', key ' .  q{'} . $key . q{'} . ',' .
                        "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
            }
            if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
                $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
                $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
                croak( "\n" . 'ERROR EPVAVRVHVRV05, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:' .
                        "\n" . 'string value expected but non-string value found at index ' . $i . ', key ' .  q{'} . $key . q{'} . ',' .
                        "\n" . 'in variable ' . q{'} . $variable_name . q{'} . ' from subroutine ' . q{'} . $subroutine_name . q{',} . "\n" . 'croaking' );
            }
        }
    }
    return;
}

# [[[ STRINGIFY ]]]

# call actual stringify routine, format level -1 (compact), indent level 0
sub string_arrayref_hashref_to_string_compact {
    { my string $RETURN_TYPE };
    ( my $input_avref_hvref ) = @ARG;
    return string_arrayref_hashref_to_string_format($input_avref_hvref, -1, 0);
}

# call actual stringify routine, format level 0 (normal), indent level 0, DEFAULT
sub string_arrayref_hashref_to_string {
    { my string $RETURN_TYPE };
    ( my $input_avref_hvref ) = @ARG;
    return string_arrayref_hashref_to_string_format($input_avref_hvref, 0, 0);
}

# call actual stringify routine, format level 1 (pretty), indent level 0
sub string_arrayref_hashref_to_string_pretty {
    { my string $RETURN_TYPE };
    ( my $input_avref_hvref ) = @ARG;
    return string_arrayref_hashref_to_string_format($input_avref_hvref, 1, 0);
}

# call actual stringify routine, format level 2 (expand), indent level 0
sub string_arrayref_hashref_to_string_expand {
    { my string $RETURN_TYPE };
    ( my $input_avref_hvref ) = @ARG;
    return string_arrayref_hashref_to_string_format($input_avref_hvref, 2, 0);
}

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing NVs))) to Perl-parsable (Perl SV containing PV)
sub string_arrayref_hashref_to_string_format {
    { my string $RETURN_TYPE };
    ( my $input_avref_hvref, my integer $format_level, my integer $indent_level ) = @ARG;

#    RPerl::diag("in PERLOPS_PERLTYPES string_arrayref_hashref_to_string_format(), top of subroutine\n");
#    RPerl::diag('in PERLOPS_PERLTYPES string_arrayref_hashref_to_string_format(), received $format_level = ', $format_level, "\n");
#    RPerl::diag('in PERLOPS_PERLTYPES string_arrayref_hashref_to_string_format(), received $indent_level = ', $indent_level, "\n");

#    string_arrayref_hashref_CHECK($input_avref_hvref);
    string_arrayref_hashref_CHECKTRACE( $input_avref_hvref, '$input_avref_hvref', 'string_arrayref_hashref_to_string_format()' );

    # declare local variables, av & sv mean "array value" & "scalar value" as used in Perl core
    my %input_avref_hv;
#   my integer $input_avref_hv_length;
    my string_arrayref $input_avref_hv_entry_value;
    my string $output_sv;
    my boolean $i_is_0 = 1;

    # dereference input hash reference
    %input_avref_hv = %{$input_avref_hvref};

    # generate indent
    my string $indent = q{    } x $indent_level;

    # compute length of (number of keys in) input hash
#   $input_avref_hv_length = scalar keys %input_avref_hv;
#   RPerl::diag("in PERLOPS_PERLTYPES string_arrayref_hashref_to_string_format(), have \$input_avref_hv_length = $input_avref_hv_length\n");

    # pre-begin with optional indent, depending on format level
    if ($format_level >= 1) { $output_sv .= $indent; }  # pretty

    # begin output string with left-curly-brace, as required for all RPerl hashes
    $output_sv .= '{';

    # loop through all hash keys
    foreach my string $key ( sort keys %input_avref_hv ) {
        # retrieve input hash's entry value at key
        $input_avref_hv_entry_value = $input_avref_hv{$key};

# DEV NOTE: string type-checking already done as part of string_arrayref_hashref_CHECKTRACE()
#        string_CHECK($input_avref_hv_entry_value);
#        string_CHECKTRACE( $input_avref_hv_entry_value, "\$input_avref_hv_entry_value at key '$key'", 'string_arrayref_hashref_to_string_format()' );

        # append comma to output string for all elements except index 0
        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ','; }

        # append newline-indent-tab or space, depending on format level
        if    ($format_level >= 1) { $output_sv .=  "\n" . $indent . q{    }; }  # pretty & expand
        elsif ($format_level >= 0) { $output_sv .= q{ }; }  # normal

        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character

        # DEV NOTE: emulate Data::Dumper & follow PBP by using single quotes for key strings
        $output_sv .= q{'} . $key . q{'};

        # append spaces before and after fat arrow AKA fat comma, depending on format level
        if ($format_level >= 0) { $output_sv .= ' => '; }  # normal & pretty & expand
        else                    { $output_sv .= '=>'; }    # compact

        # append newline after fat arrow AKA fat comma, depending on format level
        if ($format_level >= 2) { $output_sv .= "\n"; }  # expand

        # call *_to_string_format() for data sub-structure
        $output_sv .= ::string_arrayref_to_string_format($input_avref_hv_entry_value, ($format_level - 1), ($indent_level + 1));  # YES UNDERSCORES
    }

    # append newline-indent or space, depending on format level
    if    ($format_level >= 1) { $output_sv .= "\n" . $indent; }  # pretty & expand
    elsif ($format_level >= 0) { $output_sv .= q{ }; }  # normal

    # end output string with right-curly-brace, as required for all RPerl hashes
    $output_sv .= '}';

#    RPerl::diag("in PERLOPS_PERLTYPES string_arrayref_hashref_to_string_format(), after for() loop, have \$output_sv =\n$output_sv\n");
#    RPerl::diag("in PERLOPS_PERLTYPES string_arrayref_hashref_to_string_format(), bottom of subroutine\n");
    return ($output_sv);
}

# [[[ TYPE TESTING ]]]

sub string_arrayref_hashref_typetest0 {
    { my string $RETURN_TYPE };
    ( my string_arrayref_hashref $lucky_strings) = @ARG;

#    string_arrayref_hashref_CHECK($lucky_strings);
    string_arrayref_hashref_CHECKTRACE( $lucky_strings, '$lucky_strings', 'string_arrayref_hashref_typetest0()' );

#    foreach my string $key ( sort keys %{$lucky_strings} ) {
#        my $lucky_string = $lucky_strings->{$key};
#        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
#        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
#
#        RPerl::diag("in PERLOPS_PERLTYPES string_arrayref_hashref_typetest0(), have lucky string '$key' => " . $lucky_string . ", BARSTOOL\n");
#    }
#    RPerl::diag("in PERLOPS_PERLTYPES string_arrayref_hashref_typetest0(), bottom of subroutine\n");
    return ( string_arrayref_hashref_to_string($lucky_strings) . 'PERLOPS_PERLTYPES' );
}

sub string_arrayref_hashref_typetest1 {
    { my string_arrayref_hashref $RETURN_TYPE };
    ( my integer $my_size) = @ARG;

#    integer_CHECK($my_size);
    integer_CHECKTRACE( $my_size, '$my_size', 'string_arrayref_hashref_typetest1()' );

    # create a square 2-D data structure
    my string_arrayref_hashref $new_hash = {};
    my string $temp_key;
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $temp_key = 'PERLOPS_PERLTYPES_funkey' . $i;
        my string_arrayref $temp_array = [];
        for my integer $j ( 0 .. ( $my_size - 1)) {
            $temp_array->[$j] = 'Jeffy Ten! (' . integer_to_string($i) . ', ' . integer_to_string($j) . ')/' . integer_to_string($my_size - 1);
        }
        $new_hash->{$temp_key} = $temp_array;

#        RPerl::diag("in PERLOPS_PERLTYPES string_arrayref_hashref_typetest1(), setting entry '$temp_key' => " . Dumper($new_hash->{$temp_key}) . ", BARSTOOL\n");
    }
    return ($new_hash);
}

# [[[ HASH REF HASH REF ]]]
# [[[ HASH REF HASH REF ]]]
# [[[ HASH REF HASH REF ]]]

# (ref to hash) of (refs to hashs)
package  # hide from PAUSE indexing
    hashref_hashref;
use strict;
use warnings;
use parent -norequire, qw(hashref);

# (ref to hash) of (refs to (hashs of integers))
package  # hide from PAUSE indexing
    integer_hashref_hashref;
use strict;
use warnings;
use parent -norequire, qw(hashref_hashref);

# (ref to hash) of (refs to (hashs of numbers))
package  # hide from PAUSE indexing
    number_hashref_hashref;
use strict;
use warnings;
use parent -norequire, qw(hashref_hashref);

# (ref to hash) of (refs to (hashs of strings))
package  # hide from PAUSE indexing
    string_hashref_hashref;
use strict;
use warnings;
use parent -norequire, qw(hashref_hashref);

# (ref to hash) of (refs to (hashs of scalars))
package  # hide from PAUSE indexing
    scalartype_hashref_hashref;
use strict;
use warnings;
use parent -norequire, qw(hashref_hashref);

# [[[ OBJECT HASH REF (2-dimensional???) ]]]
# [[[ OBJECT HASH REF (2-dimensional???) ]]]
# [[[ OBJECT HASH REF (2-dimensional???) ]]]

# (ref to hash) of objects
package  # hide from PAUSE indexing
    object_hashref;
use strict;
use warnings;
use parent -norequire, qw(hashref);

1;  # end of package
