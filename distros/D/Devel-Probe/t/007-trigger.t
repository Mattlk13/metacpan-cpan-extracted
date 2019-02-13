use strict;
use warnings;

use Test::More;

use Devel::Probe;

my @triggered;
my $trigger_file = 't/007-trigger.t'; # this file
my %trigger_lines = (
    default   => [qw/ 22 /], # probe 1
    Devel::Probe::ONCE      ,=> [qw/ 23 /], # probe 2
    Devel::Probe::PERMANENT ,=> [qw/ 24 /], # probe 3
);

exit main();

sub run {
    my ($run) = @_;

    @triggered = ();
    my $x = 1;          # probe 1
    my $y = 2;          # probe 2
    my $z = $x + $y;    # probe 3

    my @got = sort { $a->[0] cmp $b->[0] || $a->[1] <=> $b->[1] } @triggered;

    my @expected;
    if ($run != 0 && $run != 4) {
        foreach my $type (keys %trigger_lines) {
            if (($run == 1) || ($run > 1 && $type eq Devel::Probe::PERMANENT)) {
                push @expected, map { [ $trigger_file, $_ ] } @{ $trigger_lines{$type} };
            }
        }
        @expected = sort { $a->[0] cmp $b->[0] || $a->[1] <=> $b->[1] } @expected;
    }

    is_deeply(\@got, \@expected, sprintf("probe triggered for run %d in all %d expected lines and nowhere else", $run, scalar @expected));
}

sub config {
    # set trigger handler
    Devel::Probe::trigger(sub {
        my ($file, $line) = @_;
        push @triggered, [ $file, $line ]; # store triggered lines in @triggered
    });

    # generate config file
    my @defines;
    foreach my $type (keys %trigger_lines) {
        my %define = (
            action => 'define',
            file => $trigger_file,
            lines => $trigger_lines{$type},
        );
        $define{type} = $type unless $type eq 'default';
        push @defines, \%define;
    }
    my %config = (
        actions => [
            { action => 'disable' },
            { action => 'clear' },
            @defines,
            { action => 'enable' },
        ],
    );
    Devel::Probe::config(\%config);
}

sub clear {
    Devel::Probe::clear();
}

sub main {
    foreach my $run (0..4) {
        run($run);
        config() if $run == 0; # run 0 has no probes enabled
        clear() if $run == 3; # run 0 has no probes enabled
    }

    done_testing;
    return 0;
}
