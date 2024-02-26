package Algorithm::Backoff::MIMD;

use strict;
use warnings;

use parent qw(Algorithm::Backoff);

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2024-02-24'; # DATE
our $DIST = 'Algorithm-Backoff'; # DIST
our $VERSION = '0.010'; # VERSION

our %SPEC;

$SPEC{new} = {
    v => 1.1,
    is_class_meth => 1,
    is_func => 0,
    args => {
        %Algorithm::Backoff::attr_consider_actual_delay,
        %Algorithm::Backoff::attr_max_actual_duration,
        %Algorithm::Backoff::attr_max_attempts,
        %Algorithm::Backoff::attr_jitter_factor,
        %Algorithm::Backoff::attr_max_delay,
        %Algorithm::Backoff::attr_min_delay,
        %Algorithm::Backoff::attr_initial_delay,
        %Algorithm::Backoff::attr_delay_multiple_on_failure,
        %Algorithm::Backoff::attr_delay_multiple_on_success,
    },
    result_naked => 1,
    result => {
        schema => 'obj*',
    },
};

sub _success {
    my ($self, $timestamp) = @_;

    unless (defined $self->{_prev_delay}) {
        return $self->{_prev_delay} = $self->{initial_delay};
    }

    my $delay = $self->{_prev_delay} * $self->{delay_multiple_on_success};

    $delay;
}

sub _failure {
    my ($self, $timestamp) = @_;

    unless (defined $self->{_prev_delay}) {
        return $self->{_prev_delay} = $self->{initial_delay};
    }

    my $delay = $self->{_prev_delay} * $self->{delay_multiple_on_failure};

    $delay;
}

1;
# ABSTRACT: Multiplicative Increment, Multiplicative Decrement (MIMD) backoff

__END__

=pod

=encoding UTF-8

=head1 NAME

Algorithm::Backoff::MIMD - Multiplicative Increment, Multiplicative Decrement (MIMD) backoff

=head1 VERSION

This document describes version 0.010 of Algorithm::Backoff::MIMD (from Perl distribution Algorithm-Backoff), released on 2024-02-24.

=head1 SYNOPSIS

 use Algorithm::Backoff::MIMD;

 # 1. instantiate

 my $ab = Algorithm::Backoff::MIMD->new(
     #consider_actual_delay => 1, # optional, default 0
     #max_actual_duration   => 0, # optional, default 0 (retry endlessly)
     #max_attempts          => 0, # optional, default 0 (retry endlessly)
     #jitter_factor         => 0.25, # optional, default 0
     min_delay              => 2, # optional, default 0
     #max_delay             => 100, # optional
     initial_delay              => 3,   # required
     delay_multiple_on_failure  => 2,   # required
     delay_multiple_on_success  => 0.5, # required
 );

 # 2. log success/failure and get a new number of seconds to delay, timestamp is
 # optional but must be monotonically increasing.

 # for example, using the parameters initial_delay=3,
 # delay_multiple_on_failure=2, delay_multiple_on_success=0.5, min_delay=2:

 my $secs;
 $secs = $ab->failure();   # => 3    (= initial_delay)
 $secs = $ab->failure();   # => 6    (3 * 2)
 $secs = $ab->failure();   # => 12   (6 * 2)
 $secs = $ab->success();   # => 6    (12 * 0.5)
 $secs = $ab->success();   # => 3    (6 * 0.5)
 $secs = $ab->success();   # => 2    (max(3*0.5, min_delay=2))
 $secs = $ab->failure();   # => 4    (2 * 2)

Illustration using CLI L<show-backoff-delays> (4 failures followed by 5
successes, followed by 3 failures):

 % show-backoff-delays -a MIMD --initial-delay 3 --min-delay 2 \
     --delay-multiple-on-failure 2 --delay-multiple-on-success 0.5 \
     0 0 0 0   1 1 1 1 1   0 0 0
 3
 6
 12
 24
 12
 6
 3
 2
 2
 4
 8
 16

=head1 DESCRIPTION

Upon failure, this backoff algorithm calculates the next delay as:

 D1 = initial_delay
 D2 = max(min(D1 * delay_multiple_on_failure, max_delay), min_delay)
 ...

Upon success, the next delay is calculated as:

 D1 = initial_delay
 D2 = max(min(D1 * delay_multiple_on_success, max_delay), min_delay)
 ...

C<initial_delay>, C<delay_multiple_on_failure>, and C<delay_multiple_on_success>
are required. C<initial_delay> and C<min_delay> should be larger than zero;
otherwise the next delays will all be zero.

There are limits on the number of attempts (`max_attempts`) and total duration
(`max_actual_duration`).

It is recommended to add a jitter factor, e.g. 0.25 to add some randomness to
avoid "thundering herd problem".

=head1 METHODS


=head2 new

Usage:

 new(%args) -> obj

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<consider_actual_delay> => I<bool> (default: 0)

Whether to consider actual delay.

If set to true, will take into account the actual delay (timestamp difference).
For example, when using the Constant strategy of delay=2, you log failure()
again right after the previous failure() (i.e. specify the same timestamp).
failure() will then return ~2+2 = 4 seconds. On the other hand, if you waited 2
seconds before calling failure() again (i.e. specify the timestamp that is 2
seconds larger than the previous timestamp), failure() will return 2 seconds.
And if you waited 4 seconds or more, failure() will return 0.

=item * B<delay_multiple_on_failure>* => I<ufloat>

How much to multiple previous delay, upon failure (e.g. 1.5).

=item * B<delay_multiple_on_success>* => I<ufloat>

How much to multiple previous delay, upon success (e.g. 0.5).

=item * B<initial_delay>* => I<ufloat>

Initial delay for the first attempt after failure, in seconds.

=item * B<jitter_factor> => I<float>

How much to add randomness.

If you set this to a value larger than 0, the actual delay will be between a
random number between original_delay * (1-jitter_factor) and original_delay *
(1+jitter_factor). Jitters are usually added to avoid so-called "thundering
herd" problem.

The jitter will be applied to delay on failure as well as on success.

=item * B<max_actual_duration> => I<ufloat> (default: 0)

Maximum number of seconds for all of the attempts (0 means unlimited).

If set to a positive number, will limit the number of seconds for all of the
attempts. This setting is used to limit the amount of time you are willing to
spend on a task. For example, when using the Exponential strategy of
initial_delay=3 and max_attempts=10, the delays will be 3, 6, 12, 24, ... If
failures are logged according to the suggested delays, and max_actual_duration
is set to 21 seconds, then the third failure() will return -1 instead of 24
because 3+6+12 >= 21, even though max_attempts has not been exceeded.

=item * B<max_attempts> => I<uint> (default: 0)

Maximum number consecutive failures before giving up.

0 means to retry endlessly without ever giving up. 1 means to give up after a
single failure (i.e. no retry attempts). 2 means to retry once after a failure.
Note that after a success, the number of attempts is reset (as expected). So if
max_attempts is 3, and if you fail twice then succeed, then on the next failure
the algorithm will retry again for a maximum of 3 times.

=item * B<max_delay> => I<ufloat>

Maximum delay time, in seconds.

=item * B<min_delay> => I<ufloat> (default: 0)

Maximum delay time, in seconds.


=back

Return value:  (obj)

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Algorithm-Backoff>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Algorithm-Backoff>.

=head1 SEE ALSO

L<Algorithm::Backoff::LILD>

L<Algorithm::Backoff::LIMD>

L<Algorithm::Backoff::MILD>

L<Algorithm::Backoff>

Other C<Algorithm::Backoff::*> classes.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 CONTRIBUTING


To contribute, you can send patches by email/via RT, or send pull requests on
GitHub.

Most of the time, you don't need to build the distribution yourself. You can
simply modify the code, then test via:

 % prove -l

If you want to build the distribution (e.g. to try to install it locally on your
system), you can install L<Dist::Zilla>,
L<Dist::Zilla::PluginBundle::Author::PERLANCAR>,
L<Pod::Weaver::PluginBundle::Author::PERLANCAR>, and sometimes one or two other
Dist::Zilla- and/or Pod::Weaver plugins. Any additional steps required beyond
that are considered a bug and can be reported to me.

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2024, 2019 by perlancar <perlancar@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Algorithm-Backoff>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=cut
