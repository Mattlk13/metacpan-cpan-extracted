use strict;
use warnings;

use 5.008001;

use ExtUtils::MakeMaker;

my %RUN_DEPS = (
    "Getopt::Long"              => "2.43",
    "Getopt::Long::Descriptive" => "0.099",
    "MRO::Compat"               => 0,
    "Module::Runtime"           => 0,
    "Moo"                       => "1.003",
    "strictures"                => 2,
    "MooX::Locale::Passthrough" => 0,
    "Path::Class"               => "0.32",
    "Pod::Usage"                => 0,
    "Text::LineFold"            => 0,
);

my %CONFIGURE_DEPS = ( 'ExtUtils::MakeMaker' => 0, );

my %BUILD_DEPS = ();

my %TEST_DEPS = (
    "Test::More" => 0.90,
    "Test::Trap" => 0,
);

WriteMakefile1(
    MIN_PERL_VERSION => "5.008001",
    META_ADD         => {
        "meta-spec"    => { version => 2 },
        dynamic_config => 0,
        resources      => {
            homepage   => "https://metacpan.org/celogeek/MooX-Options",
            repository => {
                url  => "https://github.com/celogeek/MooX-Options.git",
                web  => "https://github.com/celogeek/MooX-Options",
                type => "git",
            },
            bugtracker => {
                web =>
                    "http://rt.cpan.org/Public/Dist/Display.html?Name=MooX-Options",
                mailto => 'bug-MooX-Options@rt.cpan.org',
            },
            license => "http://dev.perl.org/licenses/",
        },
        prereqs => {
            develop => {
                requires => {
                    "Test::CPAN::Changes"                 => 0,
                    "Test::CheckManifest"                 => 0,
                    "Module::CPANTS::Analyse"             => "0.96",
                    "Test::Kwalitee"                      => 0,
                    "Test::Perl::Critic"                  => 0,
                    "Test::PerlTidy"                      => 0,
                    "Test::Pod"                           => 0,
                    "Test::Pod::Coverage"                 => 0,
                    "Test::Pod::Spelling::CommonMistakes" => 0,
                    "Test::Spelling"                      => 0,
                },
            },
            configure => { requires => {%CONFIGURE_DEPS}, },
            build     => { requires => {%BUILD_DEPS} },
            test      => {
                requires   => {%TEST_DEPS},
                recommends => {
                    "Data::Record"   => 0,
                    "JSON::MaybeXS"  => 0,
                    "Regexp::Common" => 0,
                },
                suggests => {
                    "Mo"                           => "0.36",
                    "MooX::Cmd"                    => "0.012",
                    "MooX::ConfigFromFile"         => 0,
                    "Moose"                        => 0,
                    "MooX::Locale::TextDomain::OO" => 0,
                }
            },
            runtime => {
                requires   => { %RUN_DEPS, perl => "5.8.1", },
                recommends => {
                    "Data::Record"   => 0,
                    "JSON::MaybeXS"  => 0,
                    "Regexp::Common" => 0,
                },
            },
        },
    },
    NAME          => "MooX::Options",
    VERSION_FROM  => "lib/MooX/Options.pm",
    ABSTRACT_FROM => "lib/MooX/Options.pm",
    LICENSE       => "perl",
    AUTHOR =>
        [ q{celogeek <me@celogeek.com>}, q{Jens Rehsack <rehsack@cpan.org>} ],
    PREREQ_PM          => \%RUN_DEPS,
    CONFIGURE_REQUIRES => \%CONFIGURE_DEPS,
    BUILD_REQUIRES     => \%BUILD_DEPS,
    TEST_REQUIRES      => \%TEST_DEPS,
    test               => { TESTS => "t/*.t xt/*.t" },
);

sub WriteMakefile1
{ # originally written by Alexandr Ciornii, version 0.21. Added by eumm-upgrade.
    my %params       = @_;
    my $eumm_version = $ExtUtils::MakeMaker::VERSION;
    $eumm_version = eval $eumm_version;
    die "EXTRA_META is deprecated" if ( exists( $params{EXTRA_META} ) );
    die "License not specified"    if ( !exists( $params{LICENSE} ) );
    $params{TEST_REQUIRES}
        and $eumm_version < 6.6303
        and $params{BUILD_REQUIRES} = {
        %{ $params{BUILD_REQUIRES} || {} },
        %{ delete $params{TEST_REQUIRES} }
        };

    #EUMM 6.5502 has problems with BUILD_REQUIRES
    $params{BUILD_REQUIRES}
        and $eumm_version < 6.5503
        and $params{PREREQ_PM}
        = { %{ $params{PREREQ_PM} || {} },
        %{ delete $params{BUILD_REQUIRES} } };
    ref $params{AUTHOR}
        and "ARRAY" eq ref $params{AUTHOR}
        and $eumm_version < 6.5702
        and $params{AUTHOR} = join( ", ", @{ $params{AUTHOR} } );
    delete $params{CONFIGURE_REQUIRES}    if ( $eumm_version < 6.52 );
    delete $params{MIN_PERL_VERSION}      if ( $eumm_version < 6.48 );
    delete $params{META_MERGE}            if ( $eumm_version < 6.46 );
    delete $params{META_ADD}{prereqs}     if ( $eumm_version < 6.58 );
    delete $params{META_ADD}{"meta-spec"} if ( $eumm_version < 6.58 );
    delete $params{META_ADD}              if ( $eumm_version < 6.46 );
    delete $params{LICENSE}               if ( $eumm_version < 6.31 );
    delete $params{AUTHOR}                if ( $] < 5.005 );
    delete $params{ABSTRACT_FROM}         if ( $] < 5.005 );
    delete $params{BINARY_LOCATION}       if ( $] < 5.005 );

    # more or less taken from Moose' Makefile.PL
    if ( $params{CONFLICTS} ) {
        my $ok = CheckConflicts(%params);
        exit(0) if ( $params{PREREQ_FATAL} and not $ok );
        my $cpan_smoker
            = grep { $_ =~ m/(?:CR_SMOKER|CPAN_REPORTER|AUTOMATED_TESTING)/ }
            keys %ENV;
        unless ( $cpan_smoker || $ENV{PERL_MM_USE_DEFAULT} ) {
            sleep 4 unless ($ok);
        }
        delete $params{CONFLICTS};
    }

    WriteMakefile(%params);
}
