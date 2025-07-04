#!/usr/bin/env perl

use Test::Most;

use autodie;
use feature qw(say);

use Path::Class qw(file);

use Bio::MUST::Core::Utils qw(secure_outfile :filenames);

my @filenames = (
    [ file( qw(home denis Documents), 'AtHMA4.ali' ),
        file( qw(home denis Documents), 'AtHMA4.clus.ali' ),
        file( qw(home denis Documents), 'AtHMA4.bak' ),
        file( qw(home denis Documents), 'AtHMA4.ali.bak' ),
    ],
    [ file( qw(~ Documents), 'AtHMA4.hmm.ali' ),
        file( qw(~ Documents), 'AtHMA4.hmm.clus.ali' ),
        file( qw(~ Documents), 'AtHMA4.hmm.bak' ),
        file( qw(~ Documents), 'AtHMA4.hmm.ali.bak' ),
    ],
    [ file( q{~}, 'AtHMA4_hmm.ali' ),
        file( q{~}, 'AtHMA4_hmm.clus.ali' ),
        file( q{~}, 'AtHMA4_hmm.bak' ),
        file( q{~}, 'AtHMA4_hmm.ali.bak' ),
    ],
    [ file( q{.}, 'AtHMA4.ali' ),
        file( q{.}, 'AtHMA4.clus.ali' ),
        file( q{.}, 'AtHMA4.bak' ),
        file( q{.}, 'AtHMA4.ali.bak' ),
    ],
    [ 'AtHMA4',
        file( q{.}, 'AtHMA4.clus' ),
        file( q{.}, 'AtHMA4.bak' ),
        file( q{.}, 'AtHMA4.bak' ),
    ],
);

for my $exp_row (@filenames) {
    my $infile = $exp_row->[0];
    my $got_row = [
        $infile,
        insert_suffix($infile, '.clus'),
        change_suffix($infile, '.bak'),
        append_suffix($infile, '.bak'),
    ];
    is_deeply $got_row, $exp_row, 'rightly inserted/changed/appended suffix';
}

{
    my $infile = file('test', 'secure.ali');
    my $bakfile = file('test', 'secure.ali.bak');

    if (-e $bakfile) { (file($bakfile))->remove; }
    my $outfile1 = secure_outfile($infile);
    open my $out, '>', $outfile1;
    is $outfile1, file('test', 'secure.ali'), 'got expected outfile1 name';
    ok -e $bakfile, 'got expected .bak file';

    if (-e $bakfile) { (file($bakfile))->remove; }
    my $outfile2 = secure_outfile($infile, '.out');
    is $outfile2, file('test', 'secure.out.ali'), 'got expected outfile2 name';
    ok !(-e $bakfile), 'got expected lack of .bak file';
}

done_testing;
