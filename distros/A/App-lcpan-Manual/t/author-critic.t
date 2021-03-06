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

my $filenames = ['lib/App/lcpan/Manual.pm','lib/App/lcpan/Manual/Cookbook.pod','lib/App/lcpan/Manual/FAQ.pod','lib/App/lcpan/Manual/Internals.pod','lib/App/lcpan/Manual/Tips.pod','lib/App/lcpan/Manual/Tutorial.pod','lib/App/lcpan/Manual/Tutorial/100_WhatIsLcpan.pod','lib/App/lcpan/Manual/Tutorial/200_SettingUpAMiniCPAN.pod','lib/App/lcpan/Manual/Tutorial/700_SettingUpADarkPAN.pod','lib/App/lcpan/Manual/Tutorial/800_WritingASubcommand.pod'];
unless ($filenames && @$filenames) {
    $filenames = -d "blib" ? ["blib"] : ["lib"];
}

all_critic_ok(@$filenames);
