#!/usr/bin/env perl

use t::lib::Test;

use Devel::StatProfiler::Report;
use Devel::StatProfiler::NameMap;
use Time::HiRes qw(usleep);
use Storable;

my $profile_file;
BEGIN { $profile_file = temp_profile_file(); }

use Devel::StatProfiler -file => $profile_file, -interval => 1000, -source => 'all_evals';

my $first_eval_name = eval "sub f { (caller 0)[1] } f()";
my ($first_eval_n) = $first_eval_name =~ /^\(eval (\d+)\)$/;

sub _e { sprintf 'qeval:%s/(eval %d)', $_[0], $_[1] }

sub bar {
    usleep(50000);
}

{
    no warnings 'redefine';
    eval <<'EOT' or die; # the one explicity mentioned below
sub foo {
    usleep(50000);
}
# CODE(0x1234567890abcdef)
foo();
EOT

    eval <<'EOT' or die;
sub foo {
    usleep(50000);
}
# CODE(0xfedcba9876543210)
foo();
EOT

    eval <<'EOT' or die;
usleep(55000); # REF(0x18aa6d0)
EOT
}

bar();

Devel::StatProfiler::stop_profile();

my $process_id = get_process_id($profile_file);

my $r1 = Devel::StatProfiler::Report->new(
    sources       => 1,
    flamegraph    => 1,
);
$r1->add_trace_file($profile_file);

my $r2 = Devel::StatProfiler::Report->new(
    mapper        => Devel::StatProfiler::NameMap->new(
        source => Devel::StatProfiler::EvalSource->new,
    ),
    sources       => 1,
    flamegraph    => 1,
);
$r2->add_trace_file($profile_file);

my $a1 = $r1->{aggregate};
my $a2 = $r2->{aggregate};

## test files

{
    my $f1 = $a1->{files};
    my $f2 = $a2->{files};

    my $f1e1 = $f1->{_e($process_id, $first_eval_n + 1)};
    my $f1e2 = $f1->{_e($process_id, $first_eval_n + 2)};
    my $f2e1 = $f2->{'eval:a2dab4a2c2b28c7a5e41eb03c43b1338a7f31bc4'};

    is($f1e1->{name}, _e($process_id, $first_eval_n + 1));
    is($f1e2->{name}, _e($process_id, $first_eval_n + 2));
    ok($f2e1->{name} eq _e($process_id, $first_eval_n + 1) ||
       $f2e1->{name} eq _e($process_id, $first_eval_n + 2));

    for my $i (0 .. 5) {
        is($f2e1->{lines}{inclusive}[$i] // 0,
           ($f1e1->{lines}{inclusive}[$i] // 0) + ($f1e2->{lines}{inclusive}[$i] // 0));
    }
}

## test subs

{
    my $s1 = $a1->{subs};
    my $s2 = $a2->{subs};

    my $s1e1foo = $s1->{_e($process_id, $first_eval_n + 1) . ':main::foo:2'};
    my $s1e2foo = $s1->{_e($process_id, $first_eval_n + 2) . ':main::foo:2'};
    my $s2e1foo = $s2->{'eval:a2dab4a2c2b28c7a5e41eb03c43b1338a7f31bc4:main::foo:2'};

    is($s2e1foo->{exclusive}, $s1e1foo->{exclusive} + $s1e2foo->{exclusive});
    is($s2e1foo->{inclusive}, $s1e1foo->{inclusive} + $s1e2foo->{inclusive});

    {
        my $s1cs1 = $s1e1foo->{call_sites}{_e($process_id, $first_eval_n + 1) . ':5'};
        my $s1cs2 = $s1e2foo->{call_sites}{_e($process_id, $first_eval_n + 2) . ':5'};
        my $s2cs = $s2e1foo->{call_sites}{'eval:a2dab4a2c2b28c7a5e41eb03c43b1338a7f31bc4:5'};

        is($s2cs->{caller}, 'eval:a2dab4a2c2b28c7a5e41eb03c43b1338a7f31bc4:eval');
        is($s2cs->{file}, 'eval:a2dab4a2c2b28c7a5e41eb03c43b1338a7f31bc4');
        is($s2cs->{inclusive}, $s1cs1->{inclusive} + $s1cs2->{inclusive});
        is($s2cs->{exclusive}, $s1cs1->{exclusive} + $s1cs2->{exclusive});
   }

    {
        my $s1c1 = $s1e1foo->{callees}{2}{'(unknown):Time::HiRes::usleep'};
        my $s1c2 = $s1e2foo->{callees}{2}{'(unknown):Time::HiRes::usleep'};
        my $s2c = $s2e1foo->{callees}{2}{'(unknown):Time::HiRes::usleep'};

        is($s2c->{inclusive}, $s1c1->{inclusive} + $s1c2->{inclusive});
   }
}

{
    my $s1 = $a1->{subs};
    my $s2 = $a2->{subs};

    my $s1e1foo = $s1->{_e($process_id, $first_eval_n + 1) . ':eval'};
    my $s1e2foo = $s1->{_e($process_id, $first_eval_n + 2) . ':eval'};
    my $s2e1foo = $s2->{'eval:a2dab4a2c2b28c7a5e41eb03c43b1338a7f31bc4:eval'};

    is($s2e1foo->{exclusive}, $s1e1foo->{exclusive} + $s1e2foo->{exclusive});
    is($s2e1foo->{inclusive}, $s1e1foo->{inclusive} + $s1e2foo->{inclusive});

    ok($s1e1foo->{call_sites}{__FILE__ . ':26'});
    ok($s1e2foo->{call_sites}{__FILE__ . ':34'});
    eq_or_diff($s2e1foo->{call_sites}{__FILE__ . ':26'},
               $s1e1foo->{call_sites}{__FILE__ . ':26'});
    eq_or_diff($s2e1foo->{call_sites}{__FILE__ . ':34'},
               $s1e2foo->{call_sites}{__FILE__ . ':34'});

    {
        my $s1c1 = $s1e1foo->{callees}{5}{_e($process_id, $first_eval_n + 1) . ':main::foo:2'};
        my $s1c2 = $s1e2foo->{callees}{5}{_e($process_id, $first_eval_n + 2) . ':main::foo:2'};
        my $s2c = $s2e1foo->{callees}{5}{'eval:a2dab4a2c2b28c7a5e41eb03c43b1338a7f31bc4:main::foo:2'};

        is($s2c->{callee}, 'eval:a2dab4a2c2b28c7a5e41eb03c43b1338a7f31bc4:main::foo:2');
        is($s2c->{inclusive}, $s1c1->{inclusive} + $s1c2->{inclusive});
    }
}

## test flames

{
    my ($merged, @src) = map __FILE__ . ":main;$_:eval;$_:main::foo:2;(unknown):Time::HiRes::usleep",
        'eval:a2dab4a2c2b28c7a5e41eb03c43b1338a7f31bc4',
        _e($process_id, $first_eval_n + 1), _e($process_id, $first_eval_n + 2);

    my $f1 = $a1->{flames};
    my $f2 = $a2->{flames};

    ok($f2->{$merged} && $f1->{$src[0]} && $f1->{$src[1]}); # sanity
    is($f2->{$merged},
       $f1->{$src[0]} + $f1->{$src[1]});
}

done_testing();
