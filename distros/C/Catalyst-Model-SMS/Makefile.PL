# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.007.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Easy SMS sending from Catalyst Apps.",
  "AUTHOR" => "Martin Atukunda <matlads\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Catalyst-Model-SMS",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "Catalyst::Model::SMS",
  "PREREQ_PM" => {
    "Catalyst::Model::Adaptor" => 0,
    "Moose" => 0,
    "SMS::Send" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Catalyst" => 0,
    "Catalyst::Controller" => 0,
    "Catalyst::ScriptRunner" => 0,
    "Catalyst::Test" => 0,
    "FindBin" => 0,
    "Test::More" => 0,
    "Test::Pod" => "1.14",
    "Test::Pod::Coverage" => "1.04",
    "Test::WWW::Mechanize::Catalyst" => 0,
    "base" => 0,
    "lib" => 0,
    "namespace::autoclean" => 0,
    "ok" => 0
  },
  "VERSION" => "0.5",
  "test" => {
    "TESTS" => "t/*.t t/author/*.t"
  }
);


my %FallbackPrereqs = (
  "Catalyst" => 0,
  "Catalyst::Controller" => 0,
  "Catalyst::Model::Adaptor" => 0,
  "Catalyst::ScriptRunner" => 0,
  "Catalyst::Test" => 0,
  "FindBin" => 0,
  "Moose" => 0,
  "SMS::Send" => 0,
  "Test::More" => 0,
  "Test::Pod" => "1.14",
  "Test::Pod::Coverage" => "1.04",
  "Test::WWW::Mechanize::Catalyst" => 0,
  "base" => 0,
  "lib" => 0,
  "namespace::autoclean" => 0,
  "ok" => 0,
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
