use 5.010;
use strict;
use warnings;
use ExtUtils::MakeMaker;
use ExtUtils::Depends;

my @PROVIDERS = ( [ 'Punk' => '../Punk/include' ] );

my $INC = '-Iinclude';
{
    my $dep;
    if (eval { $dep = ExtUtils::Depends->new('Punk::Feed',
                          map { $_->[0] } @PROVIDERS); 1 } && $dep) {
        # Only INC. get_makefile_vars also returns a PM map that REPLACES
        # MakeMaker's autodetected one, and lib/ then stops being installed.
        my %v = $dep->get_makefile_vars;
        $INC .= ' ' . $v{INC} if $v{INC};
    }
    else {
        require Cwd;
        my @missing = grep { !-d $_->[1] } @PROVIDERS;
        die "Punk::Feed needs " . join(', ', map { $_->[0] } @missing)
          . " installed, or present as sibling directories.\n" if @missing;
        $INC .= join '', map { ' -I' . (Cwd::abs_path($_->[1]) || $_->[1]) }
                              @PROVIDERS;
    }
}

my %WriteMakefileArgs = (
    NAME             => 'Punk::Feed',
    AUTHOR           => ['LNATION <email@lnation.org>'],
    VERSION_FROM     => 'lib/Punk/Feed.pm',
    ABSTRACT_FROM    => 'lib/Punk/Feed.pm',
    LICENSE          => 'artistic_2',
    MIN_PERL_VERSION => '5.010',
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '0',
        'ExtUtils::Depends'   => '0.404',
        'Punk'                => '0.43',
    },
    TEST_REQUIRES => {
        'Test::More' => '0',
        'POSIX'      => '0',    # t/02-date.t checks the formatters against it
    },
    PREREQ_PM => {
        'Punk' => '0.43',
    },
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources   => {
            license => ['http://www.opensource.org/licenses/artistic-license-2.0'],
        },
    },
    INC    => $INC,
    macro  => { TARFLAGS => "--format=ustar -c -v -f" },
    dist   => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean  => { FILES => 'Punk-Feed-*' },
    depend => {
        'Feed.c'         => join(' ', glob('xs/*.xs')),
        'Feed$(OBJ_EXT)' => join(' ', glob('include/pfeed/*.h')),
    },
);

# Compatibility with old versions of ExtUtils::MakeMaker
unless (eval { ExtUtils::MakeMaker->VERSION('6.64'); 1 }) {
    my $test_requires = delete $WriteMakefileArgs{TEST_REQUIRES} || {};
    @{$WriteMakefileArgs{PREREQ_PM}}{keys %$test_requires} = values %$test_requires;
}
delete $WriteMakefileArgs{META_MERGE}
    unless eval { ExtUtils::MakeMaker->VERSION('6.46'); 1 };
delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
    unless eval { ExtUtils::MakeMaker->VERSION('6.52'); 1 };
delete $WriteMakefileArgs{MIN_PERL_VERSION}
    unless eval { ExtUtils::MakeMaker->VERSION('6.48'); 1 };
delete $WriteMakefileArgs{LICENSE}
    unless eval { ExtUtils::MakeMaker->VERSION('6.31'); 1 };

WriteMakefile(%WriteMakefileArgs);
