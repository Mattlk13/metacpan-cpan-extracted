use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Poker::Robot',
    AUTHOR           => q{Nathaniel Graham <ngraham@cpan.org>},
    VERSION_FROM     => 'lib/Poker/Robot.pm',
    ABSTRACT_FROM    => 'lib/Poker/Robot.pm',
    LICENSE          => 'Artistic_2_0',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        'Mojo' => 0,
        'AnyEvent::ReadLine::Gnu' => 0,
        'Moo' => 0,
        'EV' => 0,
        'DBD::SQLite' => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Poker-Robot-*' },
);
