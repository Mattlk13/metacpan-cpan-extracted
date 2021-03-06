# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.012.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Make async calls to Consul via IO::Async",
  "AUTHOR" => "Rob N \x{2605} <robn\@robn.io>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Net-Async-Consul",
  "LICENSE" => "perl",
  "NAME" => "Net::Async::Consul",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Consul" => "0.016",
    "HTTP::Headers" => "6.07",
    "HTTP::Request" => 0,
    "Hash::MultiValue" => 0,
    "List::Util" => "1.29",
    "Net::Async::HTTP" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "IO::Async::Loop" => 0,
    "IO::Async::Test" => 0,
    "Test::Consul" => 0,
    "Test::Exception" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.003",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Consul" => "0.016",
  "HTTP::Headers" => "6.07",
  "HTTP::Request" => 0,
  "Hash::MultiValue" => 0,
  "IO::Async::Loop" => 0,
  "IO::Async::Test" => 0,
  "List::Util" => "1.29",
  "Net::Async::HTTP" => 0,
  "Test::Consul" => 0,
  "Test::Exception" => 0,
  "Test::More" => 0,
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
