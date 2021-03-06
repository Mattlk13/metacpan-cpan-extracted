# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.036.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "helpers to compute BBAN key and generate an BBAN.",
  "AUTHOR" => "Marc Chantreux <khatar\@phear.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "business-bban",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "business::bban",
  "PREREQ_PM" => {
    "Carp" => 0
  },
  "TEST_REQUIRES" => {
    "Test::Pod" => "1.22",
    "Test::Pod::Coverage" => "1.10"
  },
  "VERSION" => "0.0",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "ExtUtils::MakeMaker" => 0,
  "Test::Pod" => "1.22",
  "Test::Pod::Coverage" => "1.10"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
