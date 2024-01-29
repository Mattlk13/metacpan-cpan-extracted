
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
    'lib/Net/Statsd/Lite.pm',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/01-basic.t',
    't/author-clean-namespaces.t',
    't/author-critic.t',
    't/author-eof.t',
    't/author-eol.t',
    't/author-minimum-version.t',
    't/author-no-tabs.t',
    't/author-pod-coverage.t',
    't/author-pod-linkcheck.t',
    't/author-pod-syntax.t',
    't/author-portability.t',
    't/author-vars.t',
    't/data/counter.dat',
    't/data/gauge.dat',
    't/data/histogram.dat',
    't/data/meter.dat',
    't/data/multiple.dat',
    't/data/set.dat',
    't/data/timing.dat',
    't/etc/perlcritic.rc',
    't/lib/Net/Statsd/Lite/Dog.pm',
    't/lib/Net/Statsd/Lite/Test.pm',
    't/release-dist-manifest.t',
    't/release-fixme.t',
    't/release-kwalitee.t',
    't/release-trailing-space.t'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
