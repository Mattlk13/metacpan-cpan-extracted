
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.020.
use strict;
use warnings;



use ExtUtils::MakeMaker ;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Get POD from distributions via MetaCPAN",
  "AUTHOR" => "Renee Baecker <module\@renee-baecker.de>, Boris Daeppen <boris_daeppen\@bluewin.ch>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "EPublisher-Source-Plugin-MetaCPAN",
  "EXE_FILES" => [],
  "LICENSE" => "artistic_2",
  "NAME" => "EPublisher::Source::Plugin::MetaCPAN",
  "PREREQ_PM" => {
    "EPublisher" => "0.6",
    "File::Basename" => 0,
    "File::Find" => 0,
    "File::Glob" => 0,
    "File::Spec" => 0,
    "File::Temp" => 0,
    "MetaCPAN::API" => "0.34",
    "Test::More" => 0,
    "Test::Pod" => "1.14",
    "Test::Pod::Coverage" => "1.08"
  },
  "VERSION" => "0.24",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "EPublisher" => "0.6",
  "File::Basename" => 0,
  "File::Find" => 0,
  "File::Glob" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "MetaCPAN::API" => "0.34",
  "Test::More" => 0,
  "Test::Pod" => "1.14",
  "Test::Pod::Coverage" => "1.08"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



