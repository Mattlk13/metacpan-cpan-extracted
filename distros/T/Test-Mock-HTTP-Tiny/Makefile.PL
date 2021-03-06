# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.037.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker 6.17;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Record and replay HTTP requests/responses with HTTP::Tiny",
  "AUTHOR" => "Michal Wojciechowski <odyniec\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.17"
  },
  "DISTNAME" => "Test-Mock-HTTP-Tiny",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "Test::Mock::HTTP::Tiny",
  "PREREQ_PM" => {
    "Data::Dumper" => 0,
    "HTTP::Tiny" => 0,
    "Test::Deep::NoTest" => 0,
    "URI::Escape" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "File::Temp" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.002",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Data::Dumper" => 0,
  "ExtUtils::MakeMaker" => "6.17",
  "File::Spec" => 0,
  "File::Temp" => 0,
  "HTTP::Tiny" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Test::Deep::NoTest" => 0,
  "Test::More" => 0,
  "URI::Escape" => 0,
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
