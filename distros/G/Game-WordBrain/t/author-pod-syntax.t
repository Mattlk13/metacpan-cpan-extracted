#!perl

BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

# This file was automatically generated by Dist::Zilla::Plugin::PodSyntaxTests.
use strict; use warnings;
use Test::More;
use Test::Pod 1.41;

all_pod_files_ok();
