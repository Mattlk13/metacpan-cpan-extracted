# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.010.
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "(DEPRECATED) Critic CPAN module abstract",
  "AUTHOR" => "perlancar <perlancar\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "CPAN-Critic-Module-Abstract",
  "EXE_FILES" => [
    "script/critique-cpan-module-abstract"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010001",
  "NAME" => "CPAN::Critic::Module::Abstract",
  "PREREQ_PM" => {
    "Data::Sah::Compiler::perl::TH::str" => 0,
    "Exporter" => "5.57",
    "Log::ger" => "0.027",
    "Package::Stash" => 0,
    "Perinci::CmdLine::Any" => 0,
    "Perinci::CmdLine::Base" => "1.816",
    "Perinci::CmdLine::Classic" => "1.770",
    "Perinci::Sub::Dep::pm" => 0,
    "Perinci::Sub::DepChecker" => "0.07",
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => "0.98"
  },
  "VERSION" => "0.092",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Data::Sah::Compiler::perl::TH::str" => 0,
  "Exporter" => "5.57",
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Log::ger" => "0.027",
  "Package::Stash" => 0,
  "Perinci::CmdLine::Any" => 0,
  "Perinci::CmdLine::Base" => "1.816",
  "Perinci::CmdLine::Classic" => "1.770",
  "Perinci::Sub::Dep::pm" => 0,
  "Perinci::Sub::DepChecker" => "0.07",
  "Test::More" => "0.98",
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
