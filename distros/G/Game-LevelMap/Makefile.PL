#!perl
use 5.24.0;
use warnings;
use ExtUtils::MakeMaker;

sub merge_key_into {
    my ( $href, $target, $source ) = @_;
    %{ $href->{$target} } = ( %{ $href->{$target} }, %{ delete $href->{$source} } );
}

my %params = (
    NAME         => 'Game::LevelMap',
    ABSTRACT     => 'level map representation',
    AUTHOR       => 'Jeremy Mates <jmates@cpan.org>',
    VERSION_FROM => 'lib/Game/LevelMap.pm',

    MIN_PERL_VERSION => '5.24.0',

    LICENSE  => 'bsd',
    PL_FILES => {},

    CONFIGURE_REQUIRES => {
        'strict'              => 0,
        'ExtUtils::MakeMaker' => '6.48',
    },
    BUILD_REQUIRES => {},
    TEST_REQUIRES  => {
        'Test::More' => '0.88',    # done_testing
        'Test::Most' => 0,
        'lib'        => 0,
    },
    PREREQ_PM => {
        'Carp'             => 0,
        'List::Util'       => 0,
        'Moo'              => 0,
        'namespace::clean' => 0,
        'strict'           => 0,
    },

    META_MERGE =>
      { resources => { repository => 'https://github.com/thrig/Game-LevelMap' } },

    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'Game-LevelMap-*' },
);

(   my $mm_version = ExtUtils::MakeMaker->VERSION(
        $params{CONFIGURE_REQUIRES}{'ExtUtils::MakeMaker'}
    )
) =~ tr/_//d;

if ( $mm_version < 6.67_04 ) {
    *ExtUtils::MM_Any::_add_requirements_to_meta_v1_4 =
      \&ExtUtils::MM_Any::_add_requirements_to_meta_v2;
}

if ( $mm_version < 6.63_03 ) {
    merge_key_into \%params, 'BUILD_REQUIRES', 'TEST_REQUIRES';
}

if ( $mm_version < 6.55_01 ) {
    merge_key_into \%params, 'CONFIGURE_REQUIRES', 'BUILD_REQUIRES';
}

if ( $mm_version < 6.51_03 ) {
    merge_key_into \%params, 'PREREQ_PM', 'CONFIGURE_REQUIRES';
}

WriteMakefile( ( MM->can('signature_target') ? ( SIGN => 1 ) : () ), %params );
