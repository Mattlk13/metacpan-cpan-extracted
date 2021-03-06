# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.010.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Server-side client library for any Google App API. Based on Moose",
  "AUTHOR" => "Pavel Serikov <pavelsr\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Moo-Google",
  "EXE_FILES" => [
    "bin/goauth"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "Moo::Google",
  "PREREQ_PM" => {
    "Config::JSON" => 0,
    "Crypt::JWT" => 0,
    "Data::Dumper" => 0,
    "Data::Printer" => 0,
    "Hash::Slice" => 0,
    "List::Util" => 0,
    "Mojo::UserAgent" => 0,
    "Mojo::Util" => 0,
    "Mojolicious::Commands" => 0,
    "Mojolicious::Lite" => 0,
    "Mojolicious::Plugin::OAuth2" => 0,
    "Moo" => 0,
    "MooX::Singleton" => 0,
    "Moose" => 0,
    "Net::EmptyPort" => 0,
    "Tie::File" => 0,
    "feature" => 0
  },
  "TEST_REQUIRES" => {
    "Test::More" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.03",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Config::JSON" => 0,
  "Crypt::JWT" => 0,
  "Data::Dumper" => 0,
  "Data::Printer" => 0,
  "Hash::Slice" => 0,
  "List::Util" => 0,
  "Mojo::UserAgent" => 0,
  "Mojo::Util" => 0,
  "Mojolicious::Commands" => 0,
  "Mojolicious::Lite" => 0,
  "Mojolicious::Plugin::OAuth2" => 0,
  "Moo" => 0,
  "MooX::Singleton" => 0,
  "Moose" => 0,
  "Net::EmptyPort" => 0,
  "Test::More" => 0,
  "Tie::File" => 0,
  "feature" => 0,
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
