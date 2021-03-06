# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.017.
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Profile object for Data::FormValidator",
  "AUTHOR" => "Graham TerMarsch <cpan\@howlingfrog.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Data-FormValidator-Profile",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010",
  "NAME" => "Data::FormValidator::Profile",
  "PREREQ_PM" => {
    "Data::FormValidator" => "4.5",
    "List::MoreUtils" => 0,
    "namespace::clean" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "File::Temp" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::DiagINC" => "0.002",
    "Test::Exception" => 0,
    "Test::More" => "0.96"
  },
  "VERSION" => "0.08",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Data::FormValidator" => "4.5",
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "List::MoreUtils" => 0,
  "Test::DiagINC" => "0.002",
  "Test::Exception" => 0,
  "Test::More" => "0.96",
  "namespace::clean" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
