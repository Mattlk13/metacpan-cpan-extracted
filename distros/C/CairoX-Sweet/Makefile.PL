# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.007.
use strict;
use warnings;

use 5.010000;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Wraps Cairo for easier drawing",
  "AUTHOR" => "Erik Carlsson <info\@code301.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "CairoX-Sweet",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010000",
  "NAME" => "CairoX::Sweet",
  "PREREQ_PM" => {
    "Cairo" => "1.000",
    "Eponymous::Hash" => 0,
    "List::SomeUtils" => "0.53",
    "List::Util" => "1.45",
    "Moose" => "2.1803",
    "MooseX::AttributeShortcuts" => "0.028",
    "MooseX::StrictConstructor" => "0.19",
    "Path::Tiny" => "0.072",
    "Type::Tiny" => "1.000005",
    "Types::Path::Tiny" => "0.005",
    "namespace::autoclean" => "0.22"
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => "0.96",
    "Test::Requires" => "0.08"
  },
  "VERSION" => "0.0200",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Cairo" => "1.000",
  "Eponymous::Hash" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "List::SomeUtils" => "0.53",
  "List::Util" => "1.45",
  "Moose" => "2.1803",
  "MooseX::AttributeShortcuts" => "0.028",
  "MooseX::StrictConstructor" => "0.19",
  "Path::Tiny" => "0.072",
  "Test::More" => "0.96",
  "Test::Requires" => "0.08",
  "Type::Tiny" => "1.000005",
  "Types::Path::Tiny" => "0.005",
  "namespace::autoclean" => "0.22"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
