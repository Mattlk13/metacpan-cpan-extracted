use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Acme::BOATES',
    AUTHOR              => q{Brian Oates <boates@cpan.org>},
    VERSION_FROM        => 'lib/Acme/BOATES.pm',
    ABSTRACT_FROM       => 'lib/Acme/BOATES.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Acme-BOATES-*' },
);
