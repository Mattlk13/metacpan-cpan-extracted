
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.020.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker ;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Software::License pack for Creative Commons' licenses",
  "AUTHOR" => "Brendan Byrd <BBYRD\@CPAN.org>",
  "CONFIGURE_REQUIRES" => {},
  "DISTNAME" => "Software-License-CCpack",
  "EXE_FILES" => [],
  "LICENSE" => "lgpl",
  "NAME" => "Software::License::CCpack",
  "PREREQ_PM" => {
    "Software::License" => 0
  },
  "TEST_REQUIRES" => {
    "Test::CheckDeps" => "0.010",
    "Test::More" => "0.94"
  },
  "VERSION" => "1.11",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Software::License" => 0,
  "Test::CheckDeps" => "0.010",
  "Test::More" => "0.94"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



