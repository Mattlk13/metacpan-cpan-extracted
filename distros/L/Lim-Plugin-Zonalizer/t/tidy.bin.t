#!perl -T

use strict;
use warnings;
use File::Spec;
use Test::More;
use English qw(-no_match_vars);

if ( not $ENV{TEST_AUTHOR} ) {
    my $msg = 'Author test.  Set $ENV{TEST_AUTHOR} to a true value to run.';
    plan( skip_all => $msg );
}

eval "use Perl::Tidy 20140711;";

if ( $EVAL_ERROR ) {
    my $msg = 'Perl::Tidy >= 20140711 required to criticise code';
    plan( skip_all => $msg );
}

eval { require Test::PerlTidy; import Test::PerlTidy; };

if ( $EVAL_ERROR ) {
    my $msg = 'Test::PerlTidy required to criticise code';
    plan( skip_all => $msg );
}

my $rcfile = File::Spec->catfile( 't', 'perltidyrc' );

foreach ( qw( zonalizer-collector zonalizer-couchdb-database ) ) {
    my $binfile = File::Spec->catfile( 'bin', $_ );
    ok( Test::PerlTidy::is_file_tidy( $binfile, $rcfile ), $binfile );
}

done_testing;
