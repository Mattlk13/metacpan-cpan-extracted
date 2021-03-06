
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.019.
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Deploy to Heroku",
  "AUTHOR" => "Glen Hinkle",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Mojolicious-Command-deploy-heroku",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Mojolicious::Command::deploy::heroku",
  "PREREQ_PM" => {
    "File::Path" => "2.08",
    "File::Slurp" => "9999.19",
    "IPC::Cmd" => "0.78",
    "Mojolicious" => "4.50",
    "Mojolicious::Command::deploy" => "0.01",
    "Net::Heroku" => "0.08"
  },
  "VERSION" => "0.11",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "File::Path" => "2.08",
  "File::Slurp" => "9999.19",
  "IPC::Cmd" => "0.78",
  "Mojolicious" => "4.50",
  "Mojolicious::Command::deploy" => "0.01",
  "Net::Heroku" => "0.08"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



