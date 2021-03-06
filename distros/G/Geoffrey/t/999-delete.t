use Test::More tests => 2;

use FindBin;
use strict;
use warnings;
use File::Path qw(remove_tree);
use Test::Exception;

require_ok( 'FindBin' );
use_ok 'FindBin';

my $file = File::Spec->catfile( $FindBin::Bin, '..', '.tmp.sqlite' );
unlink $file or warn "Could not unlink $file: $!";
my $path = File::Spec->catfile( $FindBin::Bin, '..', '.tmp' );
#remove_tree $path or warn "Could not remove $path: $!";