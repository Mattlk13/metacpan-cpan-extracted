BEGIN {
  use strict; use warnings;
  unless(eval q{ use 5.008001; 1}) {
    print "Perl 5.008001 or better required\n";
    exit;
  }
}
# This file was automatically generated by Dist::Zilla::Plugin::Author::Plicease::MakeMaker v2.36.
use strict;
use warnings;
use 5.008001;
use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT"       => "Build and make available bz2",
  "AUTHOR"         => "Graham Ollis <plicease\@cpan.org>",
  "BUILD_REQUIRES" => {
    "Alien::Build"        => "0.32",
    "Alien::Build::MM"    => "1.25",
    "ExtUtils::MakeMaker" => "6.52"
  },
  "CONFIGURE_REQUIRES" => {
    "Alien::Build"        => "0.32",
    "Alien::Build::MM"    => "1.25",
    "ExtUtils::CBuilder"  => 0,
    "ExtUtils::MakeMaker" => "6.52"
  },
  "DISTNAME"         => "Alien-Libbz2",
  "LICENSE"          => "perl",
  "MIN_PERL_VERSION" => "5.008001",
  "NAME"             => "Alien::Libbz2",
  "PM"               => {
    "lib/Alien/Libbz2.pm" => "\$(INST_LIB)/Alien/Libbz2.pm",
    "lib/Alien/bz2.pm"    => "\$(INST_LIB)/Alien/bz2.pm"
  },
  "PREREQ_PM" => {
    "Alien::Base" => "1.25"
  },
  "TEST_REQUIRES" => {
    "Test2::V0"   => "0.000060",
    "Test::Alien" => "0.12"
  },
  "VERSION" => "0.24",
  "test"    => {
    "TESTS" => "t/*.t"
  }
);

my %FallbackPrereqs = (
  "Alien::Base"         => "1.25",
  "Alien::Build"        => "0.32",
  "Alien::Build::MM"    => "1.25",
  "ExtUtils::MakeMaker" => "6.52",
  "Test2::V0"           => "0.000060",
  "Test::Alien"         => "0.12"
);

# BEGIN code inserted by Dist::Zilla::Plugin::AlienBuild
use Alien::Build::MM;
my $abmm = Alien::Build::MM->new;
%WriteMakefileArgs = $abmm->mm_args(%WriteMakefileArgs);

# END code inserted by Dist::Zilla::Plugin::AlienBuild

unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

# BEGIN code inserted by Dist::Zilla::Plugin::AlienBuild
{ package
    MY;

  sub postamble {
    $abmm->mm_postamble(@_);
  }

  sub install {
    $abmm->can('mm_install')
      ? $abmm->mm_install(@_)
      : shift->SUPER::install(@_);
  }
}

# END code inserted by Dist::Zilla::Plugin::AlienBuild