
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    print qq{1..0 # SKIP these tests are for testing by the author\n};
    exit
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.19

use Test::More 0.88;
use Test::EOL;

my @files = (
    'lib/JavaScript/Minifier/XS.pm',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/01-loads.t',
    't/02-minify.t',
    't/03-minifies-to-nothing.t',
    't/04-not-javascript.t'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
