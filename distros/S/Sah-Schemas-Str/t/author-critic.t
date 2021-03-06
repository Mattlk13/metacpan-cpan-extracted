#!perl

BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    print qq{1..0 # SKIP these tests are for testing by the author\n};
    exit
  }
}


use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Perl::Critic::Subset 3.001.005

use Test::Perl::Critic (-profile => "") x!! -e "";

my $filenames = ['lib/Sah/Schema/hexstr.pm','lib/Sah/Schema/latin_alpha.pm','lib/Sah/Schema/latin_alphanum.pm','lib/Sah/Schema/latin_letter.pm','lib/Sah/SchemaR/hexstr.pm','lib/Sah/SchemaR/latin_alpha.pm','lib/Sah/SchemaR/latin_alphanum.pm','lib/Sah/SchemaR/latin_letter.pm','lib/Sah/Schemas/Str.pm'];
unless ($filenames && @$filenames) {
    $filenames = -d "blib" ? ["blib"] : ["lib"];
}

all_critic_ok(@$filenames);
