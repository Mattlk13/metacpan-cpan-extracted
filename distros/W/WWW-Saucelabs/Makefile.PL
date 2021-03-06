# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.036.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "An incomplete, wip perl client to the Saucelabs REST API",
  "AUTHOR" => "Daniel Gempesaw <gempesaw\@gmail.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "WWW-Saucelabs",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "WWW::Saucelabs",
  "PREREQ_PM" => {
    "Carp" => 0,
    "JSON" => 0,
    "Moo" => 0,
    "Net::HTTP::Knork" => 0,
    "namespace::clean" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Test::Fatal" => 0,
    "Test::LWP::UserAgent" => 0,
    "Test::Spec" => 0
  },
  "VERSION" => "0.0201",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "ExtUtils::MakeMaker" => 0,
  "JSON" => 0,
  "Moo" => 0,
  "Net::HTTP::Knork" => 0,
  "Test::Fatal" => 0,
  "Test::LWP::UserAgent" => 0,
  "Test::Spec" => 0,
  "namespace::clean" => 0,
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
