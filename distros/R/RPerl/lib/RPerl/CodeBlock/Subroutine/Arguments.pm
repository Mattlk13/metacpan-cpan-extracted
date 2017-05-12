# [[[ HEADER ]]]
package RPerl::CodeBlock::Subroutine::Arguments;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use Storable qw(dclone);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

#    RPerl::diag( 'in Subroutine::Arguments->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $lparen_my               = $self->{children}->[0];
    my object $type0                   = $self->{children}->[1];
    my object $name0                   = $self->{children}->[2];
    my object $arguments_star          = $self->{children}->[3];
    my string $rparen                  = $self->{children}->[4];
    my string $equal                   = $self->{children}->[5];
    my string $at_underscore_semicolon = $self->{children}->[6];

    # CREATE SYMBOL TABLE ENTRY
    $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{$modes->{_symbol_table}->{_subroutine}}->{$name0} = {isa => 'RPerl::CodeBlock::Subroutine::Arguments', type => $type0->{children}->[0]};

    $rperl_source_group->{PMC} .= $lparen_my . q{ };
    $rperl_source_group->{PMC} .= $type0->{children}->[0] . q{ } . $name0;

    # (OP21_LIST_COMMA MY Type VARIABLE_SYMBOL)*
    # NEED FIX: destructive to AST!!!
    while ( exists $arguments_star->{children}->[0] ) {
        my object $comma = shift @{ $arguments_star->{children} };
        my object $my    = shift @{ $arguments_star->{children} };
        my object $type  = shift @{ $arguments_star->{children} };
        my object $name  = shift @{ $arguments_star->{children} };
        # strings inside of STAR grammar production becomes TERMINAL object, must retrieve data from attr property

        # CREATE SYMBOL TABLE ENTRY
        $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{$modes->{_symbol_table}->{_subroutine}}->{$name} = {isa => 'RPerl::CodeBlock::Subroutine::Arguments', type => $type->{children}->[0]};

        $rperl_source_group->{PMC} .= $comma->{attr} . q{ } . $my->{attr} . q{ } . $type->{children}->[0] . q{ } . $name->{attr};
    }

    $rperl_source_group->{PMC} .= q{ } . $rparen . q{ } . $equal . q{ } . $at_underscore_semicolon . "\n";
    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::CB::S::A __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

#    RPerl::diag( 'in Subroutine::Arguments->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my object $type0 = $self->{children}->[1];
    my string $name0 = $self->{children}->[2];
    my object $arguments_star = $self->{children}->[3];

    substr $name0, 0, 1, q{};            # remove leading $ sigil

#    RPerl::diag( 'in Subroutine::Arguments->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $type0 = ' . "\n" . RPerl::Parser::rperl_ast__dump($type0) . "\n" );
#    RPerl::diag( 'in Subroutine::Arguments->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $name0 = ' . "\n" . RPerl::Parser::rperl_ast__dump($name0) . "\n" );
#    RPerl::diag( 'in Subroutine::Arguments->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $arguments_star = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments_star) . "\n" );

    # CREATE SYMBOL TABLE ENTRY
    $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{$modes->{_symbol_table}->{_subroutine}}->{$name0} = {isa => 'RPerl::CodeBlock::Subroutine::Arguments', type => $type0->{children}->[0]};

    my string_arrayref $arguments = [];
    push @{$arguments}, ( $type0->{children}->[0] . q{ } . $name0 );

    # (OP21_LIST_COMMA MY Type VARIABLE_SYMBOL)*
    my object $arguments_star_dclone = dclone($arguments_star);
    while ( exists $arguments_star_dclone->{children}->[0] ) {
        shift @{ $arguments_star_dclone->{children} };    # discard $comma
        shift @{ $arguments_star_dclone->{children} };    # discard $my
        my object $type = shift @{ $arguments_star_dclone->{children} };
        my object $name = shift @{ $arguments_star_dclone->{children} };
        $name = $name->{attr};  # strings inside of STAR grammar production becomes TERMINAL object, must retrieve data from attr property
        substr $name, 0, 1, q{};            # remove leading $ sigil
#        RPerl::diag( 'in Subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $name = ' . "\n" . RPerl::Parser::rperl_ast__dump($name) . "\n" );

        # CREATE SYMBOL TABLE ENTRY
        $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{$modes->{_symbol_table}->{_subroutine}}->{$name} = {isa => 'RPerl::CodeBlock::Subroutine::Arguments', type => $type->{children}->[0]};

        $type->{children}->[0] =~ s/^constant_/const\ /gxms;  # 'constant_foo' becomes 'const foo'
        $type->{children}->[0] =~ s/::/__/gxms;  # 'Class::Subclass' becomes 'Class__Subclass'
        push @{$arguments}, ( $type->{children}->[0] . q{ } . $name );
    }
    $cpp_source_group->{CPP} .= join ', ', @{$arguments};
    return $cpp_source_group;
};

1;    # end of class
