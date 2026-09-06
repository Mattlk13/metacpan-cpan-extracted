#!/usr/bin/perl
use 5.016;
use strict;

use Test::More;

use WWW::Noss::Forker;

for my $i (1 .. 10) {
    subtest "WWW::Noss::Forker->new($i) ok" => sub {
        my $forker = WWW::Noss::Forker->new($i);
        isa_ok($forker, 'WWW::Noss::Forker');
        $forker->run_on_finish(sub {
            my ($pid, $code, $data) = @_;
            is($code >> 8, $i, 'code ok');
            is($pid, $$data, 'data ok');
        });
        FORKLOOP: for my $j (1 .. $i * 2) {
            $forker->start and next FORKLOOP;
            $forker->finish($i, \$$);
        }
        $forker->wait_all_children;
        is(wait, -1, 'all children gone');
    };
}

is(wait, -1, 'all children gone');

done_testing;

# vim: expandtab shiftwidth=4
