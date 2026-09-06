#!perl
use 5.010;
use strict;
use warnings;
use Test::More;
use Punk ();
use Punk::Plugin::Feed ();

# Real Punk classes, not a hand-rolled Punk::App: `register` installs a keyword
# through $app->install_kw, and install_kw wants an application class behind the
# registrar. A stand-in object gets as far as the option check and then croaks
# for a reason that has nothing to do with the options.

our %OPTS;
my $N = 0;

sub build {
    my (%o) = @_;
    my $pkg = 'FeedOpt' . ++$N;
    local %OPTS = %o;
    local $@;
    my $ok = eval "package $pkg; use Punk; plugin 'Feed' => { \%main::OPTS }; 1";
    return $ok ? ($pkg->punk_app, undef) : (undef, $@);
}

sub opts_of { $_[0] && $_[0]->{feed_opts} }

# ---- what is required ------------------------------------------------------

{
    my (undef, $err) = build();
    like($err, qr/`title` is required/, 'a feed with no title croaks');
}

{
    my (undef, $err) = build(title => '');
    like($err, qr/`title` is required/, '  and an empty title is no title');
}

# ---- a typo must not pass silently ----------------------------------------

{
    my (undef, $err) = build(title => 'x', descrption => 'oops');
    like($err, qr/unknown option 'descrption'/, 'a misspelled option croaks');
    like($err, qr/known: .*description/,        '  and says what was available');
}

# ---- defaults --------------------------------------------------------------

{
    my ($app, $err) = build(title => 'Example');
    is($err, undef, 'title alone is enough to register')
        or diag $err;
    my $o = opts_of($app);
    is($o->{title},  'Example', 'the title is kept');
    is($o->{path},   '/feed',   'path defaults to /feed');
    is($o->{format}, 'both',    'format defaults to both');
    is($o->{ttl},    3600,      'ttl defaults to an hour');
    is($o->{limit},  50,        'limit defaults to 50');
    is($o->{link},   '/',       'the site link defaults to the root');
    ok(!exists $o->{author},    'and nothing invents an author');
}

# ---- format ----------------------------------------------------------------

for my $f (qw(atom rss both)) {
    my ($app, $err) = build(title => 'x', format => $f);
    is($err, undef, "format => '$f' is accepted") or next;
    is(opts_of($app)->{format}, $f, "  and kept as '$f'");
}

{
    my (undef, $err) = build(title => 'x', format => 'json');
    like($err, qr/`format` must be 'atom', 'rss' or 'both'/,
        'a format nothing can serve croaks rather than defaulting');
}

# ---- path ------------------------------------------------------------------

{
    my ($app) = build(title => 'x', path => '/atom/');
    is(opts_of($app)->{path}, '/atom',
        'a trailing slash comes off the path, which would make /atom/.xml');
}

for my $bad ('feed', '//evil.example/feed', '/feed/:name', "/feed\n") {
    my (undef, $err) = build(title => 'x', path => $bad);
    (my $shown = $bad) =~ s/\n/\\n/;
    like($err, qr/`path` must be a rooted, concrete path/,
        "path '$shown' is refused");
}

# ---- ttl and limit ---------------------------------------------------------

{
    my (undef, $err) = build(title => 'x', ttl => -1);
    like($err, qr/`ttl` must not be negative/, 'a negative ttl croaks');
}

{
    my (undef, $err) = build(title => 'x', limit => 0);
    like($err, qr/`limit` must be at least 1/, 'a limit of 0 croaks');
}

{
    my (undef, $err) = build(title => 'x', limit => 100_000);
    like($err, qr/`limit` may not exceed 5000/,
        'a limit past the ceiling croaks rather than being silently clamped');
}

{
    my ($app) = build(title => 'x', ttl => 0);
    is(opts_of($app)->{ttl}, 0, 'ttl => 0 is allowed - it means rebuild always');
}

# ---- description and subtitle are the same sentence ------------------------

{
    my ($app) = build(title => 'x', subtitle => 'from Atom');
    is(opts_of($app)->{description}, 'from Atom',
        'subtitle is accepted as description');
}

{
    my ($app) = build(title => 'x', description => 'wins', subtitle => 'loses');
    is(opts_of($app)->{description}, 'wins',
        '  and description wins when both are given');
}

done_testing;
