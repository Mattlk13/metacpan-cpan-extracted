# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubExpression::HashDereference;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::SubExpression);
use RPerl::Operation::Expression::SubExpression;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my object $rperl_source_subgroup;

#    RPerl::diag( 'in HashDereference->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap HashDereference_229 and HashDereference_230 from SubExpression_156 and HashEntry_219
    if (   ( $self_class eq 'SubExpression_156' )  # SubExpression -> HashDereference
        or ( $self_class eq 'HashEntry_219' ) )  # HashEntry -> HashDereference
    {
        $self = $self->{children}->[0];
    }

    $self_class = ref $self;
    if ( $self_class eq 'HashDereference_229' ) {  # HashDereference -> '%{' Variable '}'
        my string $percent_left_brace = $self->{children}->[0];
        my object $variable      = $self->{children}->[1];
        my string $right_brace   = $self->{children}->[2];

        $rperl_source_group->{PMC} .= $percent_left_brace . q{ };
        $rperl_source_subgroup = $variable->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_brace;
    }
    elsif ( $self_class eq 'HashDereference_230' ) {  # HashDereference -> '%{' OPTIONAL-51 HashReference '}'
        my string $percent_left_brace       = $self->{children}->[0];
        my object $type_inner_optional = $self->{children}->[1];
        my object $hash_reference     = $self->{children}->[2];
        my string $right_brace         = $self->{children}->[3];

        $rperl_source_group->{PMC} .= $percent_left_brace . q{ };
        if ( exists $type_inner_optional->{children}->[0] ) {
            $rperl_source_subgroup = $type_inner_optional->{children}->[0]
                ->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group,
                $rperl_source_subgroup );
            $rperl_source_group->{PMC} .= q{ };
        }
        $rperl_source_subgroup
            = $hash_reference->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_brace;
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where HashDereference_229 or HashDereference_230 expected, dying'
        ) . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::E::SE::HD __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::E::SE::HD __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
}

1;    # end of class
