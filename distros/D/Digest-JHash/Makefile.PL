# This Makefile.PL for Digest-JHash was generated by
# Dist::Zilla::Plugin::MakeMaker::Awesome 0.38.
# Don't edit it but the dist.ini and plugins used to construct it.

use strict;
use warnings;

use 5.008;
use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Perl extension for 32 bit Jenkins Hashing Algorithm",
  "AUTHOR" => "Shlomi Fish <shlomif\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Digest-JHash",
  "LICENSE" => "artistic_2",
  "MIN_PERL_VERSION" => "5.008",
  "NAME" => "Digest::JHash",
  "PREREQ_PM" => {
    "DynaLoader" => 0,
    "Exporter" => 0,
    "strict" => 0,
    "vars" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "File::Temp" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test" => 0,
    "Test::More" => 0,
    "blib" => "1.01"
  },
  "VERSION" => "0.10",
  "test" => {
    "TESTS" => "t/*.t"
  }
);

%WriteMakefileArgs = (
    %WriteMakefileArgs,
    'OBJECT' => 'JHash.o',
);

my %FallbackPrereqs = (
  "DynaLoader" => 0,
  "Exporter" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Test" => 0,
  "Test::More" => 0,
  "blib" => "1.01",
  "strict" => 0,
  "vars" => 0,
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
