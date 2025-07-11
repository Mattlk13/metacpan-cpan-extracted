BEGIN {
  use strict; use warnings;
  unless(eval q{ use 5.008001; 1}) {
    print "Perl 5.008001 or better required\n";
    exit;
  }
}
# This file was automatically generated by Dist::Zilla::Plugin::Author::Plicease::MakeMaker v2.42.
use strict;
use warnings;
use 5.008001;
use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT"           => "Setup a faux home directory for tests",
  "AUTHOR"             => "Graham Ollis <plicease\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME"         => "Test2-Plugin-FauxHomeDir",
  "LICENSE"          => "perl",
  "MIN_PERL_VERSION" => "5.008001",
  "NAME"             => "Test2::Plugin::FauxHomeDir",
  "PM"               => {
    "lib/Test2/Plugin/FauxHomeDir.pm" => "\$(INST_LIB)/Test2/Plugin/FauxHomeDir.pm"
  },
  "PREREQ_PM" => {
    "Test2::API"  => "1.302015",
    "Test2::Mock" => "0.000060"
  },
  "TEST_REQUIRES" => {
    "Test2::V0" => "0.000060"
  },
  "VERSION" => "0.06",
  "test"    => {
    "TESTS" => "t/*.t"
  }
);

my %FallbackPrereqs = (
  "Test2::API"  => "1.302015",
  "Test2::Mock" => "0.000060",
  "Test2::V0"   => "0.000060"
);

unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);