#!perl
use 5.010;
use strict;
use warnings;
use Test::More;
use POSIX ();
use Punk ();
use Punk::Plugin::Feed ();

our @ROWS;
our $HOST = 'https://example.com';
my $N = 0;

# Compile an application whose one feed returns @main::ROWS, run to_app so the
# sections run, and hand back what the build recorded. Warnings from the build
# are collected rather than printed - most of these cases are meant to warn.
sub entries {
    my (@rows) = @_;
    local @ROWS = @rows;
    my @warn;
    my $pkg = 'FeedEnt' . ++$N;
    my $app;
    {
        local $SIG{__WARN__} = sub { push @warn, $_[0] };
        local $@;
        eval "package $pkg;\n"
           . "use Punk;\n"
           . "host \$main::HOST;\n"
           . "plugin 'Feed' => { title => 'x' };\n"
           . "feed(sub { \@main::ROWS });\n"
           . "1" or die $@;
        $app = $pkg->punk_app;
        $pkg->to_app;
    }
    return (Punk::Plugin::Feed::_entries($app), \@warn);
}

sub locs { [ map { $_->{loc} } @{ $_[0] } ] }

# ---- the origin ------------------------------------------------------------

{
    my ($e) = entries();
    my $pkg = 'FeedEnt' . $N;
    is(Punk::Plugin::Feed::_base($pkg->punk_app), 'https://example.com',
        'the base comes from the application host');
}

# ---- the three required fields --------------------------------------------

{
    my ($e, $w) = entries(
        { loc => '/a', title => 'A', updated => 1_700_000_000 },
        {               title => 'B', updated => 1_700_000_000 },
    );
    is_deeply(locs($e), ['/a'], 'an entry with no loc is dropped');
    like($w->[0], qr/entry with no loc/, '  and warns saying so');
}

{
    my ($e, $w) = entries(
        { loc => '/a', title => 'A', updated => 1_700_000_000 },
        { loc => '/b',               updated => 1_700_000_000 },
    );
    is_deeply(locs($e), ['/a'], 'an entry with no title is dropped');
    like($w->[0], qr{'/b' with no title}, '  and the warning names it');
}

{
    my ($e, $w) = entries(
        { loc => '/a', title => 'A', updated => 1_700_000_000 },
        { loc => '/b', title => 'B' },
    );
    is_deeply(locs($e), ['/a'], 'an entry with no date is dropped');
    like($w->[0], qr/no usable updated date/, '  and the warning says which');
}

{
    my ($e, $w) = entries(
        { loc => '/a', title => 'A', updated => 1_700_000_000 },
        'just a string',
    );
    is_deeply(locs($e), ['/a'], 'a bare string is not an entry');
    like($w->[0], qr/not a hashref/, '  and warns');
}

# An epoch of 0 is a real date - 1970-01-01 - and a column defaulting to zero
# holds it. It must not be mistaken for "no date".
{
    my ($e) = entries({ loc => '/a', title => 'A', updated => 0 });
    is_deeply(locs($e), ['/a'], 'epoch 0 is a date, not a missing one');
    is($e->[0]{updated}, 0, '  and is kept as 0');
}

# ---- loc validation --------------------------------------------------------

{
    my @bad = ('//evil.example/x', 'relative', '/users/:id', "/a\\b", "/a\nb",
               '/a*');
    my ($e, $w) = entries(
        { loc => '/ok', title => 'T', updated => 1 },
        map +{ loc => $_, title => 'T', updated => 1 }, @bad,
    );
    is_deeply(locs($e), ['/ok'], 'every unsafe loc is dropped');
    is(scalar(@$w), scalar(@bad), '  one warning each');
    like($w->[0], qr/not a rooted, same-origin path/, '  saying why');
}

{
    my ($e) = entries(
        { loc => 'https://example.com/post', title => 'T', updated => 1 },
    );
    is_deeply(locs($e), ['/post'],
        'an absolute URL on our own base is accepted and reduced to its path');
}

{
    my ($e) = entries(
        { loc => 'https://elsewhere.example/post', title => 'T', updated => 1 },
    );
    is_deeply(locs($e), [], 'an absolute URL on another host is not');
}

# ---- dates in --------------------------------------------------------------

# Cross-checked against POSIX::strftime under TZ=UTC: an independent
# implementation, rather than a constant typed from memory that would either
# fail for the wrong reason or pass vacuously.
{
    local $ENV{TZ} = 'UTC';
    POSIX::tzset();

    my @cases = (
        ['2026-09-05T14:03:00Z',      'an RFC 3339 instant'],
        ['2026-09-05T14:03:00',       'no zone means UTC'],
        ['2026-09-05 14:03:00',       'a space for the T, as databases return'],
        ['2026-09-05T14:03:00.250Z',  'a fraction is accepted and dropped'],
        ['2026-09-05T16:03:00+02:00', 'a positive offset is folded away'],
        ['2026-09-05T12:03:00-02:00', 'a negative offset is folded away'],
        ['2026-09-05T16:03:00+0200',  'an offset written without its colon'],
    );
    my $want = 0;
    {
        my ($e) = entries({ loc => '/x', title => 'T',
                            updated => '2026-09-05T14:03:00Z' });
        $want = $e->[0]{updated};
    }
    is(POSIX::strftime('%Y-%m-%dT%H:%M:%SZ', gmtime $want),
        '2026-09-05T14:03:00Z',
        'the parsed instant round-trips through POSIX::strftime');

    for my $c (@cases) {
        my ($in, $why) = @$c;
        my ($e) = entries({ loc => '/x', title => 'T', updated => $in });
        # No SKIP here: an input this list says is accepted and that comes back
        # empty is a failure, and a skip would report it as a pass.
        is(scalar(@$e) && $e->[0]{updated}, $want, $why);
    }

    my ($e) = entries({ loc => '/x', title => 'T', updated => '2026-09-05' });
    is(POSIX::strftime('%Y-%m-%dT%H:%M:%SZ', gmtime $e->[0]{updated}),
        '2026-09-05T00:00:00Z', 'a bare date is midnight UTC, not local');
}

{
    my ($e) = entries({ loc => '/x', title => 'T', updated => '1969-07-20' });
    ok($e->[0]{updated} < 0, 'a date before the epoch is negative, not refused');
}

for my $bad ('yesterday', '2026-13-01', '2026-09-05T99:00:00Z', '2026-09') {
    my ($e) = entries({ loc => '/x', title => 'T', updated => $bad });
    is_deeply($e, [], "'$bad' is not a date and the entry is dropped");
}

# ---- order and limit -------------------------------------------------------

{
    my ($e) = entries(
        { loc => '/old',  title => 'T', updated => 100 },
        { loc => '/new',  title => 'T', updated => 300 },
        { loc => '/mid',  title => 'T', updated => 200 },
    );
    is_deeply(locs($e), ['/new', '/mid', '/old'], 'newest first');
}

{
    my ($e) = entries(
        { loc => '/c', title => 'T', updated => 100 },
        { loc => '/a', title => 'T', updated => 100 },
        { loc => '/b', title => 'T', updated => 100 },
    );
    is_deeply(locs($e), ['/a', '/b', '/c'],
        'entries sharing a date are ordered by loc, so a rebuild is stable');
}

{
    my @rows = map +{ loc => "/p$_", title => 'T', updated => $_ }, 1 .. 60;
    my ($e) = entries(@rows);
    is(scalar(@$e), 50, 'limit defaults to 50 and truncates');
    is($e->[0]{loc}, '/p60', '  keeping the newest');
    is($e->[-1]{loc}, '/p11', '  and dropping the oldest');
}

# The hard ceiling, which `limit` cannot raise. A section walking a table that
# grew is how this becomes an out-of-memory at boot rather than a large feed,
# so collection stops before the sort rather than after it.
{
    my @rows = map +{ loc => "/p$_", title => 'T', updated => $_ }, 1 .. 5_010;
    my ($e, $w) = entries(@rows);
    like("@$w", qr/returned more than 5000 entries and is truncated/,
        'collection stops at the 5000-entry ceiling, and says so rather than '
      . 'silently losing the rest');
    # The ceiling bounds what is COLLECTED, before the sort; `limit` then
    # bounds what is published. With the default limit of 50 that is what
    # survives - the ceiling is a memory bound, not a feed length.
    is(scalar(@$e), 50, '  and limit still decides how many are published');
}

# ---- optional fields -------------------------------------------------------

{
    my ($e) = entries({
        loc       => '/full',
        title     => 'Full',
        updated   => 1_700_000_000,
        published => '2020-01-01',
        id        => 'tag:example.com,2020:1',
        summary   => 'a summary',
        content   => '<p>hi</p>',
        author    => 'Someone',
        category  => 'perl',
        enclosure => { url => 'https://example.com/a.mp3',
                       type => 'audio/mpeg', length => 12 },
        extra_column_from_the_row => 'ignored',
    });
    my $r = $e->[0];
    is($r->{id},        'tag:example.com,2020:1', 'id is kept');
    is($r->{summary},   'a summary',              'summary is kept');
    is($r->{content},   '<p>hi</p>',              'content is kept unescaped');
    is($r->{author},    'Someone',                'author is kept');
    is_deeply($r->{category}, ['perl'], 'a single category becomes a list');
    is($r->{enclosure}{url}, 'https://example.com/a.mp3', 'the enclosure is kept');
    ok(defined $r->{published}, 'published is parsed');
    ok(!exists $r->{extra_column_from_the_row},
        'a field the feed has no use for is ignored, not refused');
}

{
    my ($e) = entries({ loc => '/c', title => 'T', updated => 1,
                        category => ['a', 'b'] });
    is_deeply($e->[0]{category}, ['a', 'b'], 'a category list is kept in order');
}

{
    my ($e, $w) = entries({ loc => '/c', title => 'T', updated => 1,
                            enclosure => { type => 'audio/mpeg' } });
    ok(!exists $e->[0]{enclosure}, 'an enclosure with no url is dropped');
    like($w->[0], qr/enclosure with no url/, '  and warns');
    is($e->[0]{loc}, '/c', '  while the entry itself survives');
}

# An unparseable `published` costs a reader nothing; losing the item would.
{
    my ($e) = entries({ loc => '/c', title => 'T', updated => 1,
                        published => 'nonsense' });
    is($e->[0]{loc}, '/c', 'an unparseable published does not drop the entry');
    ok(!exists $e->[0]{published}, '  the date is simply absent');
}

# ---- a section that dies ---------------------------------------------------

{
    my $pkg = 'FeedDie' . ++$N;
    my @warn;
    my $app;
    {
        local $SIG{__WARN__} = sub { push @warn, $_[0] };
        eval "package $pkg;\nuse Punk;\nhost \$main::HOST;\n"
           . "plugin 'Feed' => { title => 'x' };\n"
           . "feed(sub { die \"the database is away\\n\" });\n1" or die $@;
        $app = $pkg->punk_app;
        $pkg->to_app;
    }
    is_deeply(Punk::Plugin::Feed::_entries($app), [],
        'a section that dies contributes nothing');
    like($warn[0], qr/died and contributes nothing/, '  and warns');
    like($warn[0], qr/the database is away/,         '  carrying the reason');
}

done_testing;
