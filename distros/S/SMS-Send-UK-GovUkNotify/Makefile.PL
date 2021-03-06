use strict;
use warnings;
use ExtUtils::MakeMaker;
 
WriteMakefile(
    NAME                => 'SMS::Send::UK::GovUkNotify',
    AUTHOR              => 'Andrew Isherwood <andrew.isherwood@ptfs-europe.com>',
    VERSION_FROM        => 'lib/SMS/Send/UK/GovUkNotify.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'          => 0,
        'LWP::UserAgent'      => 0,
        'SMS::Send::Driver'   => 0,
        'JSON'                => 0,
        'URI::Escape'         => 0,
        'Crypt::JWT'          => 0
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'SMS-Send-UK-GovUkNotify-*' },
);
