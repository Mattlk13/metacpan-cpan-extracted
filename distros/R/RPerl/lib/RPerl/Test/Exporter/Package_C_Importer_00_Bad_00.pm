# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'Subroutine exported redefined' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Exporter::Package_C_Importer_00_Bad_00;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Exporter::Package_C_Exporter_00_Good;

# [[[ SUBROUTINES ]]]

sub exported {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in Package_C_Importer_00_Bad_00::exported(), received $arg = ', $arg, "\n";
    return ($arg * -120);
}

sub not_exported_ok {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in Package_C_Importer_00_Bad_00::not_exported_ok(), received $arg = ', $arg, "\n";
    return ($arg * -420);
}

1;    # end of class

