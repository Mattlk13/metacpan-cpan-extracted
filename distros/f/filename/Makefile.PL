# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.012.
use strict;
use warnings;

use 5.012000;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Perl module to load files at compile-time, without BEGIN blocks.",
  "AUTHOR" => "Bob Kleemann <bobk\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "filename",
  "LICENSE" => "artistic_2",
  "MIN_PERL_VERSION" => "5.012000",
  "NAME" => "filename",
  "PREREQ_PM" => {
    "Array::RefElem" => 0,
    "Carp" => "1.50",
    "File::Spec" => 0,
    "Scalar::Util" => 0,
    "locale" => 0,
    "parent" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "FindBin" => 0,
    "Test2::V0" => 0
  },
  "VERSION" => "v0.20.060",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Array::RefElem" => 0,
  "Carp" => "1.50",
  "File::Spec" => 0,
  "FindBin" => 0,
  "Scalar::Util" => 0,
  "Test2::V0" => 0,
  "locale" => 0,
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
