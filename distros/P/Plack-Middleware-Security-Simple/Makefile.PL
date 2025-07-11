# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.032.
use strict;
use warnings;

use 5.014000;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "A simple security filter for Plack",
  "AUTHOR" => "Robert Rothenberg <rrwo\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Plack-Middleware-Security-Simple",
  "LICENSE" => "artistic_2",
  "MIN_PERL_VERSION" => "5.014000",
  "NAME" => "Plack::Middleware::Security::Simple",
  "PREREQ_PM" => {
    "Exporter::Tiny" => 0,
    "HTTP::Status" => 0,
    "Hash::Match" => 0,
    "Plack::Middleware" => 0,
    "Plack::Response" => 0,
    "Plack::Util::Accessor" => 0,
    "Ref::Util" => 0,
    "Regexp::Common" => 0,
    "parent" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "HTTP::Exception" => 0,
    "HTTP::Request::Common" => 0,
    "Log::Dispatch" => "2.68",
    "Log::Dispatch::Array" => 0,
    "Module::Metadata" => 0,
    "Plack::Builder" => 0,
    "Plack::Test" => 0,
    "Test2::V0" => 0,
    "Test::More" => 0,
    "Test::Vars" => "0.015",
    "strict" => 0
  },
  "VERSION" => "v0.13.0",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Exporter::Tiny" => 0,
  "File::Spec" => 0,
  "HTTP::Exception" => 0,
  "HTTP::Request::Common" => 0,
  "HTTP::Status" => 0,
  "Hash::Match" => 0,
  "Log::Dispatch" => "2.68",
  "Log::Dispatch::Array" => 0,
  "Module::Metadata" => 0,
  "Plack::Builder" => 0,
  "Plack::Middleware" => 0,
  "Plack::Response" => 0,
  "Plack::Test" => 0,
  "Plack::Util::Accessor" => 0,
  "Ref::Util" => 0,
  "Regexp::Common" => 0,
  "Test2::V0" => 0,
  "Test::More" => 0,
  "Test::Vars" => "0.015",
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
