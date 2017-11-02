# [[[ PREPROCESSOR ]]]

# <<< PARSE_ERROR: "ERROR ESUXP01, Subroutine Exporter: Failed to export requested subroutine 'foo()' from package 'RPerl::Test::Exporter::Package_A_Exporter_00_Good' into requesting package 'RPerl::Test::Exporter::Package_A_Importer_00_Bad_01', subroutine does not exist" >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Exporter::Package_A_Importer_00_Bad_01;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Exporter::Package_A_Exporter_00_Good qw(foo);

# [[[ SUBROUTINES ]]]

sub not_exported {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in Package_A_Importer_00_Bad_01::not_exported(), received $arg = ', $arg, "\n";
    return ($arg * -12);
}

sub exported_ok {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in Package_A_Importer_00_Bad_01::exported_ok(), received $arg = ', $arg, "\n";
    return ($arg * -42);
}

1;    # end of class

