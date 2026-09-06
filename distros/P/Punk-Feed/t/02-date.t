#!perl
use 5.010;
use strict;
use warnings;
use Test::More;
use POSIX ();
use Punk::Feed ();

*rfc3339 = \&Punk::Plugin::Feed::_rfc3339;
*rfc822  = \&Punk::Plugin::Feed::_rfc822;
*epoch   = \&Punk::Plugin::Feed::_epoch;

$ENV{TZ} = 'UTC';
POSIX::tzset();

# The names the specifications fix in English. Declared here so the assertion
# runs against a second copy of the table rather than against the one under
# test - strftime's %a and %b are locale-dependent and cannot be the reference.
my @DOW = qw(Sun Mon Tue Wed Thu Fri Sat);
my @MON = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);

# Instants worth checking: an ordinary one, both epoch boundaries, a leap day,
# a date before 1970 and one past the 2038 signed-32-bit wrap.
my @WHEN = (
    0,
    1,
    -1,
    1_700_000_000,
    951_782_400,        # inside 2000, the century-leap-year case
    4_102_444_800,      # past 2038
    -2_208_988_800,     # well before the epoch
);

for my $t (@WHEN) {
    my @g = gmtime $t;

    # Every field cross-checked against POSIX::strftime with locale-independent
    # conversions only: %Y %m %d %H %M %S and %w. An independent implementation,
    # not a constant typed from memory.
    my $want = POSIX::strftime('%Y-%m-%dT%H:%M:%SZ', @g);
    is(rfc3339($t), $want, "RFC 3339 for $t agrees with strftime");

    my $w   = POSIX::strftime('%w', @g);        # 0..6, Sunday first
    my $mon = POSIX::strftime('%m', @g);
    my $exp = sprintf('%s, %s %s %s %s +0000',
                      $DOW[$w],
                      POSIX::strftime('%d', @g),
                      $MON[$mon - 1],
                      POSIX::strftime('%Y', @g),
                      POSIX::strftime('%H:%M:%S', @g));
    is(rfc822($t), $exp, "RFC 822 for $t agrees, with English names");
}

# The floored division, which C's / is not for negative operands: one second
# before the epoch is the day BEFORE it, not the day after.
is(rfc3339(-1), '1969-12-31T23:59:59Z', 'the second before the epoch');
is(rfc3339(0),  '1970-01-01T00:00:00Z', 'the epoch itself');

# Leap day, and the year-2000 century rule that a naive /4 gets wrong.
is(rfc3339(951_782_400), '2000-02-29T00:00:00Z',
    '2000 was a leap year, which the 100/400 rule has to get right');

# Past the signed 32-bit time_t wrap, which is why this does not use gmtime.
like(rfc3339(4_102_444_800), qr/^2100-/,
    'a date past 2038 formats rather than wrapping');

# ---- names do not follow the process locale --------------------------------

SKIP: {
    my $have = POSIX::setlocale(POSIX::LC_TIME(), 'tr_TR.UTF-8')
            || POSIX::setlocale(POSIX::LC_TIME(), 'de_DE.UTF-8')
            || POSIX::setlocale(POSIX::LC_TIME(), 'fr_FR.UTF-8');
    skip 'no non-English LC_TIME locale on this box to prove it against', 2
        unless $have;

    my $strf = POSIX::strftime('%a %b', gmtime 1_700_000_000);
    is(rfc822(1_700_000_000),
       'Tue, 14 Nov 2023 22:13:20 +0000',
       "RFC 822 stays English under LC_TIME=$have");
    isnt($strf, 'Tue Nov',
        "  and the locale really was in force (strftime said '$strf')");

    POSIX::setlocale(POSIX::LC_TIME(), 'C');
}

# ---- the parser ------------------------------------------------------------

is(epoch(1_700_000_000), 1_700_000_000, 'an integer is an epoch');
is(epoch('1700000000'),  1_700_000_000, 'a string of digits is an epoch');
is(epoch('-86400'),      -86400,        'a negative epoch is an epoch');
is(epoch(0),             0,             'epoch 0 parses, and is not "no date"');
ok(defined epoch(0), '  reported as defined rather than as a false value');

# Round-trip: everything the parser accepts must come back out the same
# instant, which is the property the record builder depends on.
for my $s ('2026-09-05T14:03:00Z',
           '2026-09-05T14:03:00',
           '2026-09-05 14:03:00',
           '2026-09-05t14:03:00z',
           '2026-09-05T14:03:00.250Z',
           '2026-09-05T16:03:00+02:00',
           '2026-09-05T12:03:00-02:00',
           '2026-09-05T16:03:00+0200') {
    is(rfc3339(epoch($s)), '2026-09-05T14:03:00Z', "'$s' is that instant");
}

is(rfc3339(epoch('2026-09-05')), '2026-09-05T00:00:00Z',
    'a bare date is midnight UTC');

# A leap second belongs to the minute it ends, not to the next one.
is(rfc3339(epoch('2016-12-31T23:59:60Z')), '2016-12-31T23:59:59Z',
    'a leap second folds back into :59 rather than being refused');

# A bare integer is an epoch, and four digits are a bare integer - so a column
# holding the year 2026 reads as half past midnight in 1970 rather than as a
# date the parser refuses. That is the cost of accepting epochs at all, and the
# alternative - calling four digits ambiguous - would refuse real epochs from
# 1970 and be a rule nobody could predict.
is(epoch('2026'), 2026, 'four digits are an epoch, not a year');

for my $bad ('yesterday', '', '2026-09', '2026-13-01', '2026-00-01',
             '2026-09-32', '2026-09-05T24:00:00Z', '2026-09-05T14:03',
             '2026-09-05T14:03:00+99:00', '2026-09-05T14:03:00X',
             '2026-09-05T14:03:00Z junk', '2026/09/05') {
    is(epoch($bad), undef, "'$bad' is not a date");
}

is(epoch(undef), undef, 'undef is not a date');

done_testing;
