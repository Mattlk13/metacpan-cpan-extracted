
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    print qq{1..0 # SKIP these tests are for testing by the author\n};
    exit
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.15

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Music/ToRoman.pm',
    't/00-compile.t',
    't/00-methods.t',
    't/01-methods.t',
    't/02-methods.t',
    't/03-methods.t',
    't/04-methods.t',
    't/05-methods.t',
    't/06-methods.t',
    't/07-methods.t',
    't/08-methods.t',
    't/09-methods.t',
    't/10-methods.t',
    't/11-methods.t',
    't/12-methods.t',
    't/13-methods.t',
    't/14-methods.t',
    't/15-methods.t',
    't/16-methods.t'
);

notabs_ok($_) foreach @files;
done_testing;
