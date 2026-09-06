#!perl
use 5.010;
use strict;
use warnings;
use Test::More;
use Punk ();
use Punk::Test;
use Punk::Plugin::Feed ();

# No sleeps anywhere in this file. A fixed sleep fails on a loaded smoker and
# proves nothing on a fast one; the build stamp is an ordinary key on the
# application hash, so ageing it is exact and instant.

our $RUNS = 0;
our @ROWS = ({ loc => '/p/1', title => 'First',
               updated => '2019-03-04T05:06:07Z' });
my $N = 0;

sub build {
    my (%o) = @_;
    my $ttl  = exists $o{ttl} ? $o{ttl} : 3600;
    my $body = $o{body} || 'sub { $main::RUNS++; @main::ROWS }';
    my $pkg  = 'FeedTtl' . ++$N;
    eval "package $pkg;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
       . "host 'https://example.com';\n"
       . "plugin 'Feed' => { title => 'Example', ttl => $ttl };\n"
       . "feed $body;\n1" or die $@;
    return ($pkg, Punk::Test->new($pkg));
}

sub age {   # push the build stamp back so the next request is past the ttl
    my ($pkg, $by) = @_;
    $pkg->punk_app->{feed_built_at} -= $by;
}

# ---- the sections run once at to_app --------------------------------------

{
    $RUNS = 0;
    my ($pkg, $t) = build();
    is($RUNS, 1, 'the section runs once, at to_app');

    $t->get_ok('/feed.xml')->status_is(200);
    $t->get_ok('/feed.xml');
    $t->get_ok('/feed.rss');
    is($RUNS, 1, 'and not again inside the ttl, however many requests arrive');
}

# ---- past the ttl it runs again -------------------------------------------

{
    $RUNS = 0;
    my ($pkg, $t) = build(ttl => 3600);
    $t->get_ok('/feed.xml');
    is($RUNS, 1, 'still one');

    age($pkg, 3601);
    $t->get_ok('/feed.xml')->status_is(200);
    is($RUNS, 2, 'past the ttl the section runs again');

    $t->get_ok('/feed.xml');
    is($RUNS, 2, '  and the rebuild reset the clock');
}

# The boundary itself is not a rebuild: the test is "ttl seconds have passed",
# not "ttl seconds have nearly passed".
{
    $RUNS = 0;
    my ($pkg, $t) = build(ttl => 3600);
    age($pkg, 3599);
    $t->get_ok('/feed.xml');
    is($RUNS, 1, 'one second short of the ttl is not a rebuild');
}

# ---- ttl => 0 rebuilds every time -----------------------------------------

{
    $RUNS = 0;
    my ($pkg, $t) = build(ttl => 0);
    my $after_boot = $RUNS;
    $t->get_ok('/feed.xml');
    $t->get_ok('/feed.xml');
    is($RUNS, $after_boot + 2, 'ttl => 0 means rebuild on every request');
}

# ---- an application with no feeds never reads the clock -------------------

{
    my $pkg = 'FeedTtlNone';
    eval "package $pkg;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
       . "host 'https://example.com';\n"
       . "plugin 'Feed' => { title => 'Example', ttl => 0 };\n"
       . "get '/' => sub { \$_[0]->text('ok') };\n1" or die $@;
    my $t = Punk::Test->new($pkg);
    $t->get_ok('/')->status_is(200);
    # No feed was declared, so no feed route exists. Registering one that could
    # only ever 404 would tell a reader the feed is broken rather than that it
    # was never offered.
    $t->get_ok('/feed.xml')->status_is(404);
    pass('an application that declared no feeds serves without a rebuild path');
}

# ---- a rebuild that fails keeps the last good feed ------------------------
#
# Replacing it with nothing would publish an empty feed, and a reader handed
# one concludes every item was deleted - the same reason an unknown feed is a
# 404 rather than an empty document. A database away for a minute must not look
# like a site that deleted its archive.

{
    our $FAIL = 0;
    $RUNS = 0;
    my ($pkg, $t) = build(ttl => 3600, body =>
        'sub { $main::RUNS++; die "the database is away\n" if $main::FAIL; @main::ROWS }');

    $t->get_ok('/feed.xml')->status_is(200);
    my $good = $t->body;
    like($good, qr{<title>First</title>}, 'the first build has the entry');

    $FAIL = 1;
    age($pkg, 3601);
    my @warn;
    {
        local $SIG{__WARN__} = sub { push @warn, $_[0] };
        $t->get_ok('/feed.xml')->status_is(200);
    }
    is($t->body, $good,
        'a rebuild whose section died serves the last good document');
    like("@warn", qr/died and contributes nothing/, '  and warns that it died');
    like("@warn", qr/keeps the entries from its last good build/,
        '  and says what it did about it');

    $FAIL = 0;
    age($pkg, 3601);
    $t->get_ok('/feed.xml')->status_is(200);
    is($t->body, $good, 'and it recovers once the section works again');
}

# On the FIRST build there is nothing to fall back on, so the feed really is
# empty - and still a valid document.
{
    my $pkg = 'FeedTtlDeadFirst';
    my @warn;
    my $t;
    {
        # to_app runs the build, and Punk::Test calls it - so the warnings are
        # captured around that, not around a to_app of our own. Punk refuses a
        # second to_app outright ("already compiled").
        local $SIG{__WARN__} = sub { push @warn, $_[0] };
        eval "package $pkg;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
           . "host 'https://example.com';\n"
           . "plugin 'Feed' => { title => 'Example' };\n"
           . "feed sub { die \"away\\n\" };\n1" or die $@;
        $t = Punk::Test->new($pkg);
    }
    $t->get_ok('/feed.xml')->status_is(200);
    like($t->body, qr{<feed xmlns=}, 'a first build that died is still valid XML');
    unlike($t->body, qr{<entry>}, '  with no entries, because there are none');
    unlike("@warn", qr/last good build/,
        '  and it does not claim to have kept anything');
}

done_testing;
