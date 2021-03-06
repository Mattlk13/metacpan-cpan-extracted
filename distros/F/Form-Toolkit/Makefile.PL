
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.009.
use strict;
use warnings;

use 5.010_000;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Data centric form(s) toolkit",
  "AUTHOR" => "Jerome Eteve <jerome.eteve\@gmail.com>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Form-Toolkit",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Form::Toolkit",
  "PREREQ_PM" => {
    "Class::Load" => 0,
    "DateTime" => 0,
    "DateTime::Format::ISO8601" => 0,
    "JSON" => 0,
    "MIME::Base64" => "3.13",
    "Mail::RFC822::Address" => 0,
    "Module::Pluggable::Object" => 0,
    "Moose" => 0,
    "Moose::Role" => 0,
    "Moose::Util" => 0,
    "MooseX::Clone" => 0,
    "Scalar::Util" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "DBD::SQLite" => 0,
    "DBI" => 0,
    "DBIx::Class::Schema::Loader" => 0,
    "Data::Dumper" => 0,
    "Test::Exception" => 0,
    "Test::More" => 0,
    "base" => 0
  },
  "VERSION" => "0.008",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Class::Load" => 0,
  "DBD::SQLite" => 0,
  "DBI" => 0,
  "DBIx::Class::Schema::Loader" => 0,
  "Data::Dumper" => 0,
  "DateTime" => 0,
  "DateTime::Format::ISO8601" => 0,
  "JSON" => 0,
  "MIME::Base64" => "3.13",
  "Mail::RFC822::Address" => 0,
  "Module::Pluggable::Object" => 0,
  "Moose" => 0,
  "Moose::Role" => 0,
  "Moose::Util" => 0,
  "MooseX::Clone" => 0,
  "Scalar::Util" => 0,
  "Test::Exception" => 0,
  "Test::More" => 0,
  "base" => 0,
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



