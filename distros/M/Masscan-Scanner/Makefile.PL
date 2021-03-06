# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.012.
use strict;
use warnings;

use 5.020000;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "A Perl module which helps in using the masscan port scanner.",
  "AUTHOR" => "Sarah Fuller <averna\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Masscan-Scanner",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.020000",
  "NAME" => "Masscan::Scanner",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Data::Dumper" => 0,
    "Data::Validate::Domain" => 0,
    "Data::Validate::IP" => 0,
    "File::Spec" => 0,
    "File::Temp" => 0,
    "IPC::Open3" => 0,
    "JSON" => 0,
    "Log::Log4perl" => 0,
    "Log::Log4perl::Appender::ScreenColoredLevels::UsingMyColors" => 0,
    "Moose" => 0,
    "MooseX::AttributeShortcuts" => 0,
    "MooseX::StrictConstructor" => 0,
    "MooseX::Types::Moose" => 0,
    "MooseX::Types::Structured" => 0,
    "Net::DNS" => 0,
    "Symbol" => 0,
    "Try::Catch" => 0,
    "namespace::autoclean" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Test::More" => 0
  },
  "VERSION" => "20200329.150259",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Data::Dumper" => 0,
  "Data::Validate::Domain" => 0,
  "Data::Validate::IP" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "IPC::Open3" => 0,
  "JSON" => 0,
  "Log::Log4perl" => 0,
  "Log::Log4perl::Appender::ScreenColoredLevels::UsingMyColors" => 0,
  "Moose" => 0,
  "MooseX::AttributeShortcuts" => 0,
  "MooseX::StrictConstructor" => 0,
  "MooseX::Types::Moose" => 0,
  "MooseX::Types::Structured" => 0,
  "Net::DNS" => 0,
  "Symbol" => 0,
  "Test::More" => 0,
  "Try::Catch" => 0,
  "namespace::autoclean" => 0,
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
