#!/usr/bin/env perl

use t::lib::Test ':spawn';
use t::lib::Slowops;

use Devel::StatProfiler::Aggregator;
use Time::HiRes qw(time);

my ($profile_dir, $template);
BEGIN { ($profile_dir, $template) = temp_profile_dir(); }

use Devel::StatProfiler -template => $template, -interval => 1000, -source => 'all_evals';

# uses named subs to avoid a segfault in Perl 5.20.1
# (and maybe other versions)
eval "sub a { 1 } # in parent process"; # N

spawn(sub {
    eval "sub b { 1 } # in child before spawn"; # N + 1

    spawn(sub {
        eval "sub c { 1 } # in grandchild"; # N + 2
    })->join;

    eval "sub {}";
    eval "sub d { 1 } # in child, after spawn"; # N + 3
})->join;

eval "sub {}"; eval "sub {}";
eval "sub { 1 } # in parent, after spawn"; # N + 4

Devel::StatProfiler::stop_profile();

my @files = glob "$template.*";

my $r1 = Devel::StatProfiler::Report->new(
    sources       => 1,
    mixed_process => 1,
);
$r1->add_trace_file($_) for @files;

my $a1 = Devel::StatProfiler::Aggregator->new(
    root_directory  => File::Spec::Functions::catdir($profile_dir, 'aggr1'),
    parts_directory => File::Spec::Functions::catdir($profile_dir, 'aggr1p'),
    shard           => 'shard1',
    mixed_process   => 1,
);
$a1->process_trace_files(@files);
$a1->save_part;
my $r2 = $a1->merge_report('__main__', with_metadata => 1);

my $a2 = Devel::StatProfiler::Aggregator->new(
    root_directory  => File::Spec::Functions::catdir($profile_dir, 'aggr1'),
    parts_directory => File::Spec::Functions::catdir($profile_dir, 'aggr1p'),
    shard           => 'shard1',
);
my $r3 = $a2->merge_report('__main__', with_metadata => 1);

my ($parent_id, $tree) = get_process_tree(@files);
my ($child_id) = get_childs($tree, $parent_id);
my ($grandchild_id) = get_childs($tree, $child_id);

my $rs1 = $r1->{source};
my $rs2 = $r2->{source};
my $rs3 = $r3->{source};

my ($first_eval_name) = sort keys %{$rs1->{all}{$parent_id}{1}{sparse}};
my ($first_eval_n) = $first_eval_name =~ /^\(eval (\d+)\)$/ or
    die "Unparsable '$first_eval_name'";
my $has_test2 = Test::Builder->VERSION >= '1.302015';

$first_eval_n += $has_test2;

my @hashes = map unpack("H*", $_), keys %{$rs1->{hashed}};

is(scalar @hashes, 6 + $has_test2);

numify($_) for $rs1, $rs2, $rs3;

eq_or_diff($rs2->{seen_in_process}, $rs1->{seen_in_process});
# those two are different "by design" (one is packed, the other is not)
# eq_or_diff($rs2->{all}, $rs1->{all});
eq_or_diff($rs2->{genealogy}, $rs1->{genealogy});

eq_or_diff($rs3->{seen_in_process}, $rs1->{seen_in_process});
eq_or_diff($rs3->{all}, $rs2->{all});
eq_or_diff($rs3->{genealogy}, $rs1->{genealogy});

for my $rs ($rs1, $rs2, $rs3) {
    for my $hash (@hashes) {
        is($rs->get_source_by_hash($hash), $rs1->{hashed}{pack "H*", $hash},
           "Source code for $hash");
    }
}

sub _e { sprintf '(eval %d)', $_[0] }

for my $rs ($rs1, $rs2, $rs3) {
    # same process
    is($rs->get_source_by_name($parent_id, _e($first_eval_n)),
       'sub a { 1 } # in parent process', 'direct hit');
    is($rs->get_source_by_name($parent_id, _e($first_eval_n + 1)),
       'sub {}', 'direct hit, empty source');
    is($rs->get_source_by_name($parent_id, _e($first_eval_n + 2)),
       'sub {}', 'direct hit, empty source');
    is($rs->get_source_by_name($parent_id, _e($first_eval_n + 3)),
       'sub { 1 } # in parent, after spawn', 'direct hit');
    is($rs->get_source_by_name($parent_id, _e($first_eval_n)),
       'sub a { 1 } # in parent process', 'same process, subsequent ordinal');
    is($rs->get_source_by_name($child_id, _e($first_eval_n + 3)),
       'sub d { 1 } # in child, after spawn', 'same process, subsequent ordinal');
    is($rs->get_source_by_name($grandchild_id, _e($first_eval_n + 2)),
       'sub c { 1 } # in grandchild', 'same process, subsequent ordinal');

    # same process but previous ordinal
    is($rs->get_source_by_name($parent_id, _e($first_eval_n + 4)),
       '', 'same process, previous ordinal');

    # follow genealogy, found in ancestor
    is($rs->get_source_by_name($child_id, _e($first_eval_n)),
       'sub a { 1 } # in parent process', 'parent process');
    is($rs->get_source_by_name($grandchild_id, _e($first_eval_n)),
       'sub a { 1 } # in parent process', 'grandparent process');

    # in ancestor, but after spawn point
    is($rs->get_source_by_name($child_id, _e($first_eval_n + 4)),
       '', 'after spawn point');
    is($rs->get_source_by_name($grandchild_id, _e($first_eval_n + 4)),
       '', 'after spawn point');
    is($rs->get_source_by_name($grandchild_id, _e($first_eval_n + 3)),
       '', 'after spawn point');
}

# test packing worked as expected
for my $process_id (keys %{$rs1->{all}}) {
    for my $ordinal (keys %{$rs1->{all}{$process_id}}) {
        my $rs1e = $rs1->{all}{$process_id}{$ordinal};
        my $rs2e = $rs2->{all}{$process_id}{$ordinal};

        note("checking $process_id - $ordinal");
        ok( scalar %{$rs1e->{sparse}} && !$rs1e->{first});
        ok(!scalar %{$rs2e->{sparse}} &&  $rs2e->{first});

        is(length($rs2e->{packed}) / 20, scalar keys %{$rs1e->{sparse}});

        # stored hashes are tested by the code above
    }
}

done_testing();
