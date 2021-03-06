# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.010.
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Create and parse tables in Markdown",
  "AUTHOR" => "Renee Baecker <reneeb\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Markdown-Table",
  "LICENSE" => "artistic_2",
  "MIN_PERL_VERSION" => "5.010",
  "NAME" => "Markdown::Table",
  "PREREQ_PM" => {
    "Moo" => "2.0",
    "Text::ASCIITable" => "0.22"
  },
  "TEST_REQUIRES" => {
    "Pod::Coverage::TrustPod" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.04",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Moo" => "2.0",
  "Pod::Coverage::TrustPod" => 0,
  "Test::More" => 0,
  "Text::ASCIITable" => "0.22"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
