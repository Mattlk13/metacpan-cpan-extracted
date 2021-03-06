
use strict;
use warnings;

use 5.010_000;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Rotate numbered backup directories",
  "AUTHOR" => "Dominik Schulz <dominik.schulz\@gauner.org>",
  "BUILD_REQUIRES" => {
    "File::Blarf" => 0,
    "File::Temp" => 0,
    "Test::MockObject::Universal" => 0,
    "Test::MockTime" => 0,
    "Test::More" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Sys-RotateBackup",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Sys::RotateBackup",
  "PREREQ_PM" => {
    "Log::Tree::RequiredLogger" => 0,
    "Moose" => 0,
    "Sys::FS" => 0,
    "Sys::Run" => 0,
    "feature" => 0,
    "mro" => 0,
    "namespace::autoclean" => 0
  },
  "VERSION" => "0.12",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



