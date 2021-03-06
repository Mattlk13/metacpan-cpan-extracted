# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.015.
use strict;
use warnings;

use 5.008005;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "a modular policy daemon for postfix",
  "AUTHOR" => "Markus Benning <ich\@markusbenning.de>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Mail-MtPolicyd",
  "EXE_FILES" => [
    "bin/mtpolicyd",
    "bin/policyd-client"
  ],
  "LICENSE" => "gpl",
  "MIN_PERL_VERSION" => "5.008005",
  "NAME" => "Mail::MtPolicyd",
  "PREREQ_PM" => {
    "BerkeleyDB" => 0,
    "BerkeleyDB::Hash" => 0,
    "Cache::Memcached" => 0,
    "Config::General" => 0,
    "DBI" => 0,
    "Data::Dumper" => 0,
    "File::Slurp" => 0,
    "Geo::IP" => 0,
    "Getopt::Long" => 0,
    "HTTP::Request::Common" => 0,
    "IO::Handle" => 0,
    "IO::Socket::INET" => 0,
    "IO::Socket::UNIX" => 0,
    "JSON" => 0,
    "LWP::UserAgent" => 0,
    "Mail::RBL" => 0,
    "Mail::SPF" => 0,
    "Moose" => 0,
    "Moose::Role" => 0,
    "Moose::Util::TypeConstraints" => 0,
    "MooseX::Getopt" => 0,
    "MooseX::Role::Parameterized" => 0,
    "MooseX::Singleton" => 0,
    "Net::DNS::Resolver" => 0,
    "Net::LDAP" => 0,
    "Net::LDAP::Util" => 0,
    "Net::SMTP::Verify" => 0,
    "Net::Server::PreFork" => 0,
    "NetAddr::IP" => 0,
    "Redis" => 0,
    "Storable" => 0,
    "Tie::IxHash" => 0,
    "Time::HiRes" => 0,
    "Time::Piece" => 0,
    "Time::Seconds" => 0,
    "namespace::autoclean" => 0,
    "strict" => 0
  },
  "TEST_REQUIRES" => {
    "DBD::SQLite" => 0,
    "File::Find" => 0,
    "File::ReadBackwards" => 0,
    "File::Temp" => 0,
    "IO::File" => 0,
    "String::Random" => 0,
    "Template" => 0,
    "Test::BDD::Cucumber::Harness::TestBuilder" => 0,
    "Test::BDD::Cucumber::Loader" => 0,
    "Test::Deep" => 0,
    "Test::Exception" => 0,
    "Test::Mock::Net::Server::Mail" => 0,
    "Test::MockObject" => 0,
    "Test::More" => 0,
    "Test::Net::LDAP::Mock" => 0,
    "Test::Pod" => 0,
    "Test::RedisDB" => 0
  },
  "VERSION" => "2.05",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "BerkeleyDB" => 0,
  "BerkeleyDB::Hash" => 0,
  "Cache::Memcached" => 0,
  "Config::General" => 0,
  "DBD::SQLite" => 0,
  "DBI" => 0,
  "Data::Dumper" => 0,
  "File::Find" => 0,
  "File::ReadBackwards" => 0,
  "File::Slurp" => 0,
  "File::Temp" => 0,
  "Geo::IP" => 0,
  "Getopt::Long" => 0,
  "HTTP::Request::Common" => 0,
  "IO::File" => 0,
  "IO::Handle" => 0,
  "IO::Socket::INET" => 0,
  "IO::Socket::UNIX" => 0,
  "JSON" => 0,
  "LWP::UserAgent" => 0,
  "Mail::RBL" => 0,
  "Mail::SPF" => 0,
  "Moose" => 0,
  "Moose::Role" => 0,
  "Moose::Util::TypeConstraints" => 0,
  "MooseX::Getopt" => 0,
  "MooseX::Role::Parameterized" => 0,
  "MooseX::Singleton" => 0,
  "Net::DNS::Resolver" => 0,
  "Net::LDAP" => 0,
  "Net::LDAP::Util" => 0,
  "Net::SMTP::Verify" => 0,
  "Net::Server::PreFork" => 0,
  "NetAddr::IP" => 0,
  "Redis" => 0,
  "Storable" => 0,
  "String::Random" => 0,
  "Template" => 0,
  "Test::BDD::Cucumber::Harness::TestBuilder" => 0,
  "Test::BDD::Cucumber::Loader" => 0,
  "Test::Deep" => 0,
  "Test::Exception" => 0,
  "Test::Mock::Net::Server::Mail" => 0,
  "Test::MockObject" => 0,
  "Test::More" => 0,
  "Test::Net::LDAP::Mock" => 0,
  "Test::Pod" => 0,
  "Test::RedisDB" => 0,
  "Tie::IxHash" => 0,
  "Time::HiRes" => 0,
  "Time::Piece" => 0,
  "Time::Seconds" => 0,
  "namespace::autoclean" => 0,
  "strict" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
