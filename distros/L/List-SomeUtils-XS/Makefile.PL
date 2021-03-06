# This Makefile.PL for List-SomeUtils-XS was generated by
# Dist::Zilla::Plugin::DROLSKY::MakeMaker 0.95
# and Dist::Zilla::Plugin::MakeMaker::Awesome 0.42.
# Don't edit it but the dist.ini and plugins used to construct it.

use strict;
use warnings;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "XS implementation for List::SomeUtils",
  "AUTHOR" => "Dave Rolsky <autarch\@urth.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "List-SomeUtils-XS",
  "LICENSE" => "artistic_2",
  "NAME" => "List::SomeUtils::XS",
  "PREREQ_PM" => {
    "XSLoader" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Carp" => 0,
    "Exporter" => 0,
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "Scalar::Util" => 0,
    "Storable" => 0,
    "Test::Builder::Module" => 0,
    "Test::LeakTrace" => 0,
    "Test::More" => "0.96",
    "Test::Warnings" => "0.006",
    "Tie::Array" => 0,
    "base" => 0,
    "lib" => 0,
    "overload" => 0
  },
  "VERSION" => "0.58",
  "test" => {
    "TESTS" => "t/*.t"
  }
);
my $gcc_warnings = $ENV{AUTHOR_TESTING} ? q{ -Wall -Werror} : q{};
$WriteMakefileArgs{DEFINE}
    = ( $WriteMakefileArgs{DEFINE} || q{} ) . $gcc_warnings
    if $] >= 5.024000;

my %FallbackPrereqs = (
  "Carp" => 0,
  "Exporter" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "Scalar::Util" => 0,
  "Storable" => 0,
  "Test::Builder::Module" => 0,
  "Test::LeakTrace" => 0,
  "Test::More" => "0.96",
  "Test::Warnings" => "0.006",
  "Tie::Array" => 0,
  "XSLoader" => 0,
  "base" => 0,
  "lib" => 0,
  "overload" => 0,
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
