# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.012.
use strict;
use warnings;

use 5.006001;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Base module for generating SVG graphics",
  "AUTHOR" => "Leo Lapworth, Eric Johnson (kablamo)",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "SVG-TT-Graph",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006001",
  "NAME" => "SVG::TT::Graph",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Data::Dumper" => 0,
    "DateTime" => 0,
    "HTTP::Date" => 0,
    "Modern::Perl" => 0,
    "POSIX" => 0,
    "Template" => 0,
    "base" => 0,
    "strict" => 0
  },
  "TEST_REQUIRES" => {
    "Test::More" => 0,
    "lib" => 0
  },
  "VERSION" => "1.04",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Data::Dumper" => 0,
  "DateTime" => 0,
  "HTTP::Date" => 0,
  "Modern::Perl" => 0,
  "POSIX" => 0,
  "Template" => 0,
  "Test::More" => 0,
  "base" => 0,
  "lib" => 0,
  "strict" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
