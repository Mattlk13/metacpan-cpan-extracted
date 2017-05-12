# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Foo;
use strict;
use warnings;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# DEV NOTE: below this line copied from RPerl::CompileUnit::Module::Class::Template
# [[[ CONSTANTS ]]]
use constant PI  => my number $TYPED_PI  = 3.141_59;
use constant PIE => my string $TYPED_PIE = 'pecan';

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    plugh => my integer $TYPED_plugh         = 23,
    xyzzy => my string $TYPED_xyzzy          = 'twenty-three',
    thud  => my integer_arrayref $TYPED_thud = [ 2, 4, 6, 8 ],
    yyz => my number_hashref $TYPED_yyz = { a => 3.1, b => 6.2, c => 9.3 }
};

# [[[ SUBROUTINES & OO METHODS ]]]

our void::method $quux = sub {
    ( my object $self) = @ARG;
    $self->{plugh} = $self->{plugh} + 2;
    $self->{plugh} = $self->{plugh} - 3;
    $self->{plugh} = $self->{plugh} * 4;  # ensure integer outcome
    $self->{plugh} = $self->{plugh} / 2;  # ensure integer outcome
    $self->{plugh} = $self->{plugh} % 5;
    $self->{plugh} = -($self->{plugh});
    $self->{plugh}++;
    $self->{plugh}--;
};

our integer::method $quince = sub {
    my string $quince_def
        = '...Cydonia vulgaris ... Cydonia, a city in Crete ... [1913 Webster]';
    print $quince_def;
    return (length $quince_def);
};

our string_hashref::method $qorge = sub {
    ( my object $self, my integer $qorge_input ) = @ARG;
    return {
        a => $self->{xyzzy} x $qorge_input,
        b => 'howdy',
        c => q{-23.42}
    };
};

our RPerl::Test::Foo_arrayref::method $qaft = sub {
    ( my object $self, my integer $foo, my number $bar, my string $bat, my string_hashref $baz ) = @ARG;
    my RPerl::Test::Foo_arrayref $retval = [];
    $retval->[0] = RPerl::Test::Foo->new();
    $retval->[0]->{xyzzy} = 'larry';
    $retval->[1] = RPerl::Test::Foo->new();
    $retval->[1]->{xyzzy} = 'curly';
    $retval->[2] = RPerl::Test::Foo->new();
    $retval->[2]->{xyzzy} = 'moe';
    return $retval;
};

our void $tnurg = sub {
    print 'PIE() = ' . PIE() . "\n";
};

our number $tluarg = sub {
    ( my integer $tluarg_input ) = @ARG;
    $tluarg_input++;
    $tluarg_input--;
    $tluarg_input = $tluarg_input**2;
    return $tluarg_input**PI();
};

our number_arrayref $ylprag = sub {
    ( my integer $ylprag_input, my number_arrayref $ylprag_array ) = @ARG;
    my integer $ylprag_input_size = scalar @{$ylprag_array};
    my integer $unylprag_size_typed = scalar @{my integer_arrayref $TYPED_unylprag = [4, 6, 8, 10]};
#    my integer $unylprag_size_untyped = scalar @{[4, 6, 8, 10]};  missing type_inner, not supported in CPPOPS_CPPTYPES
    my number_arrayref $ylprag_output = [
        $ylprag_input * $ylprag_array->[0],
        $ylprag_input * $ylprag_array->[1],
        $ylprag_input * $ylprag_array->[2]
    ];
    return $ylprag_output;
};

our string_hashref $ecrog = sub {
    ( my integer $al, my number $be, my string $ga, my string_hashref $de)
        = @ARG;
    return {
        alpha => integer_to_string($al),
        beta  => number_to_string($be),
        gamma => $ga,
        delta => %{$de}
    };
};

1;    # end of class
