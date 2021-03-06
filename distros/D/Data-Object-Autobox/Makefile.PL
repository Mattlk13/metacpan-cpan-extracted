# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.037.
use strict;
use warnings;

use 5.014000;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "An Autobox Implementation for Perl 5",
  "AUTHOR" => "Al Newkirk <anewkirk\@ana.io>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Data-Object-Autobox",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.014000",
  "NAME" => "Data::Object::Autobox",
  "PREREQ_PM" => {
    "Data::Object" => "0.53",
    "autobox" => "2.82"
  },
  "VERSION" => "0.14",
  "test" => {
    "TESTS" => "t/*.t t/data/object/*.t"
  }
);


my %FallbackPrereqs = (
  "Data::Object" => "0.53",
  "ExtUtils::MakeMaker" => 0,
  "autobox" => "2.82"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
