use strictures 2;

use Test::More;
use Test::Pod;

my @poddirs = qw( blib script );
all_pod_files_ok( all_pod_files( @poddirs ) );
