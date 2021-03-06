# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.010.
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Load GVG files from a Game::Asset archive and convert to OpenGL",
  "AUTHOR" => "Timm Murray <tmurray\@wumpus-cave.net>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Game-Asset-GVG-OpenGL",
  "LICENSE" => "bsd",
  "MIN_PERL_VERSION" => "5.010",
  "NAME" => "Game::Asset::GVG::OpenGL",
  "PREREQ_PM" => {
    "Graphics::GVG" => "0.4",
    "Graphics::GVG::OpenGLRenderer" => "0.2",
    "Moose" => "2.1806",
    "YAML" => "1.20",
    "namespace::autoclean" => "0.28"
  },
  "TEST_REQUIRES" => {
    "Test::Pod" => 0
  },
  "VERSION" => "0.2",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Graphics::GVG" => "0.4",
  "Graphics::GVG::OpenGLRenderer" => "0.2",
  "Moose" => "2.1806",
  "Test::Pod" => 0,
  "YAML" => "1.20",
  "namespace::autoclean" => "0.28"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
