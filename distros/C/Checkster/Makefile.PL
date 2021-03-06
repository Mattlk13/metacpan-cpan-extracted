
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.028.
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Checkster is a check perl module",
  "AUTHOR" => "Daniel Vinciguerra <daniel.vinciguerra\@bivee.com.br>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Checkster",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010",
  "NAME" => "Checkster",
  "PREREQ_PM" => {
    "Exporter" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "FindBin" => 0,
    "Test::More" => 0,
    "lib" => 0
  },
  "VERSION" => "0.001",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Exporter" => 0,
  "ExtUtils::MakeMaker" => 0,
  "FindBin" => 0,
  "Test::More" => 0,
  "lib" => 0,
  "strict" => 0,
  "warnings" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



