# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.014.
use strict;
use warnings;

use 5.013002;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Dancer2 colored console logger.",
  "AUTHOR" => "BURNERSK <burnersk\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Dancer2-Logger-Console-Colored",
  "LICENSE" => "mit",
  "MIN_PERL_VERSION" => "5.013002",
  "NAME" => "Dancer2::Logger::Console::Colored",
  "PREREQ_PM" => {
    "Dancer2" => "0.166001_01",
    "Dancer2::Core::Types" => 0,
    "Dancer2::Logger::Console" => 0,
    "Encode" => 0,
    "Moo" => 0,
    "Term::ANSIColor" => "3.00",
    "namespace::clean" => 0
  },
  "TEST_REQUIRES" => {
    "Capture::Tiny" => 0,
    "Dancer2" => "0.166001_01",
    "File::Spec" => 0,
    "HTTP::Request::Common" => 0,
    "Module::Metadata" => 0,
    "Plack::Test" => 0,
    "Test::More" => 0,
    "open" => 0
  },
  "VERSION" => "0.008",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Capture::Tiny" => 0,
  "Dancer2" => "0.166001_01",
  "Dancer2::Core::Types" => 0,
  "Dancer2::Logger::Console" => 0,
  "Encode" => 0,
  "File::Spec" => 0,
  "HTTP::Request::Common" => 0,
  "Module::Metadata" => 0,
  "Moo" => 0,
  "Plack::Test" => 0,
  "Term::ANSIColor" => "3.00",
  "Test::More" => 0,
  "namespace::clean" => 0,
  "open" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
