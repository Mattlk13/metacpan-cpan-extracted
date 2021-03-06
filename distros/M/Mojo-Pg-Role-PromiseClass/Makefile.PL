# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.012.
use strict;
use warnings;

use 5.014;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Choose the Mojo::Promise class used by Mojo::Pg objects",
  "AUTHOR" => "Roger Crew <wrog\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Mojo-Pg-Role-PromiseClass",
  "LICENSE" => "artistic_2",
  "MIN_PERL_VERSION" => "5.014",
  "NAME" => "Mojo::Pg::Role::PromiseClass",
  "PREREQ_PM" => {
    "Class::Method::Modifiers" => 0,
    "Mojo::Base::Role::PromiseClass" => "0.008",
    "Mojo::Pg" => "4.15",
    "Mojolicious" => "8.23",
    "Role::Tiny" => "2.000001"
  },
  "VERSION" => "0.002",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Class::Method::Modifiers" => 0,
  "Mojo::Base::Role::PromiseClass" => "0.008",
  "Mojo::Pg" => "4.15",
  "Mojolicious" => "8.23",
  "Role::Tiny" => "2.000001"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
