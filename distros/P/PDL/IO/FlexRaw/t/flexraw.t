# flexraw's read/write tests, copied from fastraw's tests.
# There are still many tests to write; see the notes at the bottom
# of this document.

use PDL::LiteF;
# PDL::Core::set_debugging(1);
kill INT,$$  if $ENV{UNDER_DEBUGGER}; # Useful for debugging.

use strict;
use warnings;

use Test::More;
use PDL;
use File::Temp qw(tempdir);
use File::Spec::Functions;
use PDL::IO::FlexRaw;

$PDL::debug = 0;

# Get a temporary directory and file name, which obviously we'll need for testing
# saving and reading of data.
my $tmpdir = tempdir( CLEANUP=>1 );
my $name = catfile($tmpdir, "tmp0");

# Set up the working filename and make sure we're working with a clean slate:

# **TEST 2** save an ndarray to disk
my $x = pdl [2,3],[4,5],[6,7];
my $header = eval { writeflex($name, $x) };
ok((-f $name), "writeflex should create a file");

# **TEST 3** save a header to disk
eval { writeflexhdr($name, $header) };
ok(-f "$name.hdr", "writeflexhdr should create a header file");

# **TEST 4** read it back, and make sure it gives the same ndarray
my $y = eval { readflex($name) };
ok(all(approx($x,$y)), "A ndarray and its saved copy should be about equal");

# **TEST 5** save two ndarrays to disk
my $c = pdl [[0,0,0,0],[0,0,0,0]];
my $d = pdl [1,1,1];
my $cdname = $name . 'cd';
$header = eval { writeflex($cdname, $c, $d) };
ok((-f $cdname), "writeflex saves 2 pdls to a file");

# **TEST 6** save a header to disk
eval { writeflexhdr($cdname, $header) };
ok(-f "$cdname.hdr", "writeflexhdr create a header file");

# **TEST 7** read it back, and make sure it gives the same ndarray
# This is sf.net bug #3375837 "_read_flexhdr state machine fails"
my (@cd) = eval { no warnings; readflex($cdname) };
ok( (scalar(@cd)==2 and all(approx($cd[0],$c)) and all(approx($cd[1],$d)) ), 'sf.net bug 3375837');

# Clean up for another test
unlink $cdname, $cdname . '.hdr';	# just to be absolutely sure

# some mapflex tests
SKIP: {

   my $c = eval { mapflex($name) };
   if ($@) {
      diag("$@");
      if ($@ =~ m/mmap not supported/) {
         skip('no mmap support', 5);
      }
   }

   # **TEST 8** compare mapfraw ndarray with original ndarray	
   ok(all(approx($x,$c)), "A ndarray and its mapflex representation should be about equal");

   # **TEST 9** modifications should be saved when $c goes out of scope
   # THIS TEST FAILS.
   # This failure is recorded in sf.net bug 3031068.
   # Presently, making $c go out of scope does not free the memory
   # mapping associated with mapflex, so this modification is never
   # saved to the file (or at least it's not saved immediately).
   $c += 1;
   undef $c;
   $y = readflex($name);
   ok(all(approx($x+1,$y)), "Modifications to mapfraw should be saved to disk no later than when the ndarray ceases to exist");

   # We're starting a new test, so we'll remove the files we've created so far
   # and clean up the memory, just to be super-safe
   unlink $name, $name . '.hdr';
   undef $x;
   undef $y;

   # **TEST 10** test creating a pdl via mapfraw
   # First create and modify the ndarray
   $header = [{NDims => 2, Dims => [3,2], Type => 'float'}];
   # Fix this specification.
   $x = mapflex($name, $header, {Creat => 1});
   writeflexhdr($name, $header);
   ok(defined($x), 'mapflex create ndarray');

   skip('no mapflex ndarray to check', 2) unless defined $x;
   $x += xvals $x;
   $x += 0.1 * yvals $x;
   # save the contents
   undef $x;
   # Load it back up and see if the values are what we expect
   $y = readflex($name);
   # **TEST 11**
   ok(all(approx($y, PDL->pdl([[0,1,2],[0.1,1.1,2.1]]))),
      "mapfraw should be able to create new ndarrays");

   # **TEST 12** test the created type
   ok($y->type->[0] == (&float)->[0], 'type should be of the type we specified (float)');

}

# Clean things up a bit
unlink $name, $name . '.hdr';

# Test the file header options:

# Tests to write still:
# Test using file handles instead of file names
# test read_flexhdr
# test gzip stuff

done_testing;
