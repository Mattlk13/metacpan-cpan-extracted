# [[[ HEADER ]]]
package RPerl::CompileUnit::Module::Header;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.006_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = {};

    #    RPerl::diag('in Header->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n");
    #    RPerl::diag('in Header->ast_to_rperl__generate(), received $modes = ' . "\n" . Dumper($modes) . "\n");
    #    die 'tmp debug';

    #    my $class = ref $self;
    #    RPerl::diag('in Header->ast_to_rperl__generate(), have symtab entries for ' . $class . "\n" . RPerl::analyze_class_symtab_entries($class) . "\n");

    # ModuleHeader -> Critic? USE_RPERL? 'package' WordScoped ';' Header
    my object $critic_optional    = $self->{children}->[0];
    my string $use_rperl_optional = $self->{children}->[1];                    # PERLOPS only
    my string $package_keyword    = $self->{children}->[2];                    # PERLOPS only
    my object $package_name       = $self->{children}->[3]->{children}->[0];
    my string $package_semicolon  = $self->{children}->[4];                    # PERLOPS only

    # Header -> 'use strict;' 'use warnings;' USE_RPERL_AFTER? 'our' VERSION_NUMBER_ASSIGN;
    my string $use_strict               = $self->{children}->[5]->{children}->[0];    # PERLOPS only
    my string $use_warnings             = $self->{children}->[5]->{children}->[1];    # PERLOPS only
    my string $use_rperl_after_optional = $self->{children}->[5]->{children}->[2];    # PERLOPS only
    my string $our_keyword              = $self->{children}->[5]->{children}->[3];    # PERLOPS only
    my string $version_number           = $self->{children}->[5]->{children}->[4];

    # DEV NOTE, CORRELATION #rp045: identifiers containing underscores may be reserved by C++
    # DEV NOTE: all fully-scoped package & class names are naturally global in scope, 
    # so we do not check the symbol table for any namespace or subroutine in the first conditional block below (ECOGEASCP184a), 
    # thus there is no differentiation between ECOGEASRP184a and ECOGEASRP184b, so ECOGEASRP184b is disabled & unused below
    if ((substr $package_name, 0, 1) eq '_') {
        die 'ERROR ECOGEASRP184a, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n" . 'package or class name ' . q{'} . $package_name . q{'} .
            ' must not start with an underscore, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }
#    elsif ($package_name =~ m/^_[A-Z]/gxms) {
#        die 'ERROR ECOGEASRP184b, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n" . 'package or class name ' . q{'} . $package_name . q{'} .
#            ' must not start with an underscore followed by an uppercase letter, forbidden by C++ specification as a reserved identifier, dying' . "\n";
#    }
    elsif ($package_name =~ m/__/gxms) {
        die 'ERROR ECOGEASRP184c, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n" . 'package or class name ' . q{'} . $package_name . q{'} .
            ' must not include a double-underscore, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }

    # CREATE SYMBOL TABLE ENTRY
    $modes->{_symbol_table}->{_namespace} = $package_name . '::';  # set current namespace
    
#    RPerl::diag( 'in Header->ast_to_cpp__generate_begin__PERLOPS_PERLTYPES(), have $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n" );

    $rperl_source_group->{PMC} = q{};
    if ( ( exists $critic_optional->{children}->[0] ) and ( defined $critic_optional->{children}->[0] ) ) {
        my string_hashref $rperl_source_subgroup = $critic_optional->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    if ( $modes->{label} eq 'ON' ) {
        $rperl_source_group->{PMC} .= '# [[[ HEADER ]]]' . "\n";
    }
    if ( ( exists $use_rperl_optional->{children}->[0] ) and ( defined $use_rperl_optional->{children}->[0] ) ) {
        $rperl_source_group->{PMC} .= $use_rperl_optional->{children}->[0]->{attr} . "\n";
    }
    $rperl_source_group->{PMC} .= $package_keyword . ' ' . $package_name . $package_semicolon . "\n";
    $rperl_source_group->{PMC} .= $use_strict . "\n";
    $rperl_source_group->{PMC} .= $use_warnings . "\n";
    if ( ( exists $use_rperl_after_optional->{children}->[0] ) and ( defined $use_rperl_after_optional->{children}->[0] ) ) {
        chomp $use_rperl_after_optional->{children}->[0]->{attr};
        $rperl_source_group->{PMC} .= $use_rperl_after_optional->{children}->[0]->{attr} . "\n";
    }

    # DEV NOTE, CORRELATION #rp014: the hard-coded ' $VERSION = ' & ';' below are the only discarded tokens in the RPerl grammar,
    # due to the need to differentiate between v-numbers and otherwise-identical normal numbers
    $rperl_source_group->{PMC} .= $our_keyword . ' $VERSION = ' . $version_number . q{;} . "\n";

    my string $package_name_underscores = $package_name;
    $package_name_underscores =~ s/::/__/gxms;
    $rperl_source_group->{_package_name} = $package_name;
    $rperl_source_group->{_package_name_underscores} = $package_name_underscores;
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::CU::M::H __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate_begin__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = {};

    #RPerl::diag( 'in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    #RPerl::diag('in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), received $modes = ' . "\n" . Dumper($modes) . "\n");
#    RPerl::diag( 'in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n" );

#my $class = ref $self;
#RPerl::diag('in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), have symtab entries for ' . $class . "\n" . RPerl::analyze_class_symtab_entries($class) . "\n");

#RPerl::diag('in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), have $self->{children}->[3]->{children}->[0] = ' . "\n" . Dumper($self->{children}->[3]->{children}->[0]) . "\n");


    my object $package_name   = $self->{children}->[3]->{children}->[0];
    my string $version_number = $self->{children}->[5]->{children}->[4];

    # DEV NOTE, CORRELATION #rp045: identifiers containing underscores may be reserved by C++
    # DEV NOTE: all fully-scoped package & class names are naturally global in scope, 
    # so we do not check the symbol table for any namespace or subroutine in the first conditional block below (ECOGEASCP184a), 
    # thus there is no differentiation between ECOGEASCP184a and ECOGEASCP184b, so ECOGEASCP184b is disabled & unused below
    if ((substr $package_name, 0, 1) eq '_') {
        die 'ERROR ECOGEASCP184a, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n" . 'package or class name ' . q{'} . $package_name . q{'} .
            ' must not start with an underscore, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }
#    elsif ($package_name =~ m/^_[A-Z]/gxms) {
#        die 'ERROR ECOGEASCP184b, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n" . 'package or class name ' . q{'} . $package_name . q{'} .
#            ' must not start with an underscore followed by an uppercase letter, forbidden by C++ specification as a reserved identifier, dying' . "\n";
#    }
    elsif ($package_name =~ m/__/gxms) {
        die 'ERROR ECOGEASCP184c, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n" . 'package or class name ' . q{'} . $package_name . q{'} .
            ' must not include a double-underscore, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }

    # CREATE SYMBOL TABLE ENTRY
    $modes->{_symbol_table}->{_namespace} = $package_name . '::';  # set current namespace
 
#    RPerl::diag( 'in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), have $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n" );

    $cpp_source_group->{H}   = q{};
    $cpp_source_group->{CPP} = q{};

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H}   .= '// [[[ HEADER ]]]' . "\n";
        $cpp_source_group->{CPP} .= '// [[[ HEADER ]]]' . "\n";
    }

    # only include rperlstandalone.h if actually necessary
    if (($modes->{subcompile} ne 'OFF') and ($modes->{subcompile} ne 'DYNAMIC')) {
        $cpp_source_group->{CPP} .= '#include <rperlstandalone.h>' . "\n";
    }

    $cpp_source_group->{H}   .= 'using std::cout;  using std::cerr;  using std::endl;' . "\n\n";
    $cpp_source_group->{CPP} .= 'using std::cout;  using std::cerr;  using std::endl;' . "\n\n";

    my string $package_name_underscores = $package_name;
    $package_name_underscores =~ s/::/__/gxms;
    $cpp_source_group->{H}   .= '#ifndef __CPP__INCLUDED__' . $package_name_underscores . '_h' . "\n";
    $cpp_source_group->{H}   .= '#define __CPP__INCLUDED__' . $package_name_underscores . '_h ' . $version_number . "\n\n";
    $cpp_source_group->{CPP} .= '#ifndef __CPP__INCLUDED__' . $package_name_underscores . '_cpp' . "\n";
    $cpp_source_group->{CPP} .= '#define __CPP__INCLUDED__' . $package_name_underscores . '_cpp ' . $version_number . "\n\n";

#    RPerl::diag( 'in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), have $package_name = ' . $package_name . "\n" );
#    RPerl::diag( 'in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), have $package_name_underscores = ' . $package_name_underscores . "\n" );
#    RPerl::diag( 'in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), have $cpp_source_group->{_package_names} = ' . "\n" . Dumper($cpp_source_group->{_package_names}) . "\n" );
#    RPerl::diag( 'in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), have $cpp_source_group->{_package_names_underscores} = ' . "\n" . Dumper($cpp_source_group->{_package_names_underscores}) . "\n" );

    $cpp_source_group->{_package_name} = $package_name;
    $cpp_source_group->{_package_name_underscores} = $package_name_underscores;
    if ((not exists $cpp_source_group->{_package_names}) or (not defined $cpp_source_group->{_package_names})) {
        $cpp_source_group->{_package_names} = q{};
    }
    $cpp_source_group->{_package_names} .= $package_name . "\n";
    if ((not exists $cpp_source_group->{_package_names_underscores}) or (not defined $cpp_source_group->{_package_names_underscores})) {
        $cpp_source_group->{_package_names_underscores} = q{};
    }
    $cpp_source_group->{_package_names_underscores} .= $package_name_underscores . "\n";
    return $cpp_source_group;
}

sub ast_to_cpp__generate_end__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = {};

    #RPerl::diag( 'in Header->ast_to_cpp__generate_end__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    #RPerl::diag('in Header->ast_to_cpp__generate_end__CPPOPS_CPPTYPES(), received $modes = ' . "\n" . Dumper($modes) . "\n");
#    RPerl::diag( 'in Header->ast_to_cpp__generate_end__CPPOPS_CPPTYPES(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n" );

    $cpp_source_group->{H}   = '#endif' . "\n";
    $cpp_source_group->{CPP} = '#endif' . "\n";
    return $cpp_source_group;
}

1;    # end of class
