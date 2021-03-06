# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.006.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "a simple sprintf-like dialect",
  "AUTHOR" => "Ricardo Signes <rjbs\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "String-Errf",
  "LICENSE" => "perl",
  "NAME" => "String::Errf",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Params::Util" => 0,
    "Scalar::Util" => 0,
    "String::Formatter" => "0.102081",
    "Sub::Exporter" => 0,
    "Time::Piece" => 0,
    "parent" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Date::Format" => 0,
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "JSON::MaybeXS" => 0,
    "Test::More" => "0.96",
    "autodie" => 0
  },
  "VERSION" => "0.008",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Date::Format" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "JSON::MaybeXS" => 0,
  "Params::Util" => 0,
  "Scalar::Util" => 0,
  "String::Formatter" => "0.102081",
  "Sub::Exporter" => 0,
  "Test::More" => "0.96",
  "Time::Piece" => 0,
  "autodie" => 0,
  "parent" => 0,
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
