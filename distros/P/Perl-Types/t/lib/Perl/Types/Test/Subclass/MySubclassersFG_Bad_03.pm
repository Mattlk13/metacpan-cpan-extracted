# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: TRACE >>>
# <<< PRECOMPILE_ERROR: 'ERROR ECOCODE04' >>>
# <<< PRECOMPILE_ERROR: "Failed to find package file 'Perl::Types/Test/Subclass/MySubclasserF_Bad_03.pm' in @INC, included from file 'lib/Perl::Types/Test/Subclass/MySubclassersFG_Bad_03.pm'" >>>

# [[[ HEADER ]]]
use Perl::Types;
package Perl::Types::Test::Subclass::MySubclassersFG_Bad_03;
use strict;
use warnings;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
use parent qw(Perl::Types::Test);
use Perl::Types::Test;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ OO PROPERTIES ]]]
our hashref $properties = { bax => my integer $TYPED_bax = 123 };

# [[[ SUBROUTINES & OO METHODS ]]]

sub multiply_bax_FG {
    { my void::method $RETURN_TYPE };
    ( my Perl::Types::Test::Subclass::MySubclassersFG_Bad_03 $self, my integer $multiplier ) = @ARG;
    $self->{bax} = $self->{bax} * $multiplier;
    return;
}

sub multiply_return_FG {
    { my number $RETURN_TYPE };
    ( my integer $multiplicand, my number $multiplier ) = @ARG;
    return $multiplicand * $multiplier;
}

1;    # end of class


# [[[ HEADER ]]]
use Perl::Types;
package Perl::Types::Test::Subclass::MySubclasserF_Bad_03;
use strict;
use warnings;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
use parent -norequire, qw(Perl::Types::Test::Subclass::MySubclassersFG_Bad_03);
INIT { Perl::Types::Test::Subclass::MySubclassersFG_Bad_03->import(); }

# [[[ OO PROPERTIES ]]]
our hashref $properties = { xab => my integer $TYPED_xab = 321 };

# [[[ SUBROUTINES & OO METHODS ]]]

sub multiply_bax_F {
    { my void::method $RETURN_TYPE };
    ( my Perl::Types::Test::Subclass::MySubclasserF_Bad_03 $self, my integer $multiplier ) = @ARG;
    $self->{bax} = $self->{bax} * $multiplier;
    return;
}

sub multiply_return_F {
    { my number $RETURN_TYPE };
    ( my integer $multiplicand, my number $multiplier ) = @ARG;
    return $multiplicand * $multiplier;
}

1;    # end of class


# [[[ HEADER ]]]
use Perl::Types;
package Perl::Types::Test::Subclass::MySubclasserG_Bad_03;
use strict;
use warnings;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
use parent -norequire, qw(Perl::Types::Test::Subclass::MySubclasserF_Bad_03);
use Perl::Types::Test::Subclass::MySubclasserF_Bad_03;

# [[[ OO PROPERTIES ]]]
our hashref $properties = { xba => my integer $TYPED_xba = 312 };

# [[[ SUBROUTINES & OO METHODS ]]]

sub multiply_bax_G {
    { my void::method $RETURN_TYPE };
    ( my Perl::Types::Test::Subclass::MySubclasserG_Bad_03 $self, my integer $multiplier ) = @ARG;
    $self->{bax} = $self->{bax} * $multiplier;
    return;
}

sub multiply_return_G {
    { my number $RETURN_TYPE };
    ( my integer $multiplicand, my number $multiplier ) = @ARG;
    return $multiplicand * $multiplier;
}

1;    # end of class
