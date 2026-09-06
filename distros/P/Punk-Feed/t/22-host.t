#!perl
use 5.010;
use strict;
use warnings;
use Test::More;
use Punk ();
use Punk::Test;
use Punk::Plugin::Feed ();

our @ROWS = ({ loc => '/p/1', title => 'First',
               updated => '2019-03-04T05:06:07Z' });
my $N = 0;

sub src {
    my ($host, $plugin) = @_;
    my $pkg = 'FeedHost' . ++$N;
    local $@;
    my $ok = eval "package $pkg;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
       . "$host\n$plugin\n"
       . "feed sub { \@main::ROWS };\n1";
    return $ok ? ($pkg, undef) : (undef, $@);
}

# ---- where the origin comes from -------------------------------------------

{
    my ($pkg) = src("host 'https://example.com';",
                    "plugin 'Feed' => { title => 'x' };");
    $pkg->to_app;
    is(Punk::Plugin::Feed::_base($pkg->punk_app), 'https://example.com',
        'the base comes from the application host');
}

{
    my ($pkg) = src('', "plugin 'Feed' => { title => 'x', base => 'https://b.example' };");
    $pkg->to_app;
    is(Punk::Plugin::Feed::_base($pkg->punk_app), 'https://b.example',
        'an explicit base needs no host at all');
}

{
    my ($pkg) = src("host 'https://example.com';",
                    "plugin 'Feed' => { title => 'x', base => 'https://b.example' };");
    $pkg->to_app;
    is(Punk::Plugin::Feed::_base($pkg->punk_app), 'https://b.example',
        'and an explicit base wins over the host');
}

# `host` may be declared on either side of the plugin line, which is the whole
# reason the origin is resolved at to_app rather than at registration.
{
    my ($pkg) = src("plugin 'Feed' => { title => 'x' };",
                    "host 'https://later.example';");
    $pkg->to_app;
    is(Punk::Plugin::Feed::_base($pkg->punk_app), 'https://later.example',
        'host declared AFTER the plugin still resolves');
}

# ---- with neither, it croaks - and at to_app, not before -------------------

{
    my ($pkg, $err) = src('', "plugin 'Feed' => { title => 'x' };");
    is($err, undef, 'declaring the plugin with no origin does not croak yet');
    local $@;
    ok(!eval { $pkg->to_app; 1 }, '  but to_app does');
    like($@, qr/no origin to build URLs on/, '  saying what is missing');
    like($@, qr/Host is not a safe source/, '  and why the request cannot supply it');
}

{
    my ($pkg, $err) = src('', "plugin 'Feed' => { title => 'x', base => 'example.com' };");
    local $@;
    ok(!eval { $pkg->to_app; 1 }, 'a base with no scheme croaks');
    like($@, qr/absolute http or https URL/, '  saying what it needed');
}

{
    my ($pkg) = src('', "plugin 'Feed' => { title => 'x', base => 'https://b.example/' };");
    $pkg->to_app;
    is(Punk::Plugin::Feed::_base($pkg->punk_app), 'https://b.example',
        'a trailing slash comes off, or every URL would have two');
}

# ---- the Host header is never reflected ------------------------------------
#
# A request carrying Host: evil.example must not produce a feed naming that
# host. The owner's own request produces a correct one, so nothing looks wrong,
# and every reader that fetched the poisoned copy keeps it for as long as
# somebody stays subscribed.

{
    my ($pkg) = src("host 'https://example.com';",
                    "plugin 'Feed' => { title => 'x' };");
    my $t = Punk::Test->new($pkg);

    $t->get_ok('/feed.xml', headers => { Host => 'evil.example' })
      ->status_is(200);
    my $doc = $t->body;
    unlike($doc, qr/evil\.example/,
        'a Host nobody configured appears nowhere in the document');
    like($doc, qr{<id>https://example\.com/feed\.xml</id>},
        '  which is served as the canonical document instead');

    $t->get_ok('/feed.rss', headers => { Host => 'evil.example' });
    unlike($t->body, qr/evil\.example/, 'and the same for RSS');
}

# feed_links is the other place an origin is written into a page.
{
    my ($pkg) = src("host 'https://example.com';",
        "plugin 'Feed' => { title => 'x' };\n"
      . "get '/' => sub { \$_[0]->html(\$_[0]->feed_links) };");
    my $t = Punk::Test->new($pkg);
    $t->get_ok('/', headers => { Host => 'evil.example' });
    unlike($t->body, qr/evil\.example/,
        'feed_links does not reflect an unknown Host either');
}

# ---- an allowlisted tenant gets a document naming itself -------------------

{
    my ($pkg) = src("host 'https://example.com', allow => ['*.example.com'];",
                    "plugin 'Feed' => { title => 'x' };");
    my $t = Punk::Test->new($pkg);

    $t->get_ok('/feed.xml')->status_is(200);
    my $canonical = $t->body;
    my $canon_tag = $t->header('ETag');

    $t->get_ok('/feed.xml', headers => { Host => 'shop.example.com' })
      ->status_is(200);
    my $tenant = $t->body;
    my $tenant_tag = $t->header('ETag');

    like($tenant, qr/shop\.example\.com/,
        'an allowlisted tenant is named in its own document');
    isnt($tenant, $canonical, '  which is not the canonical one');
    isnt($tenant_tag, $canon_tag,
        '  and carries its own ETag - handing over the canonical tag would '
      . 'say a document it has never seen is unchanged');

    # A host on neither the origin nor the allowlist is handed the canonical
    # document, because the alternative is the injection above.
    $t->get_ok('/feed.xml', headers => { Host => 'nowhere.example' });
    is($t->body, $canonical, 'an unlisted host gets the canonical document');
}

# The sections run once however many hosts ask: the tenant document is
# rendered from the records the build already collected.
{
    our $RUNS = 0;
    my $pkg = 'FeedHostRuns';
    eval "package $pkg;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
       . "host 'https://example.com', allow => ['*.example.com'];\n"
       . "plugin 'Feed' => { title => 'x', ttl => 3600 };\n"
       . "feed sub { \$main::RUNS++; \@main::ROWS };\n1" or die $@;
    my $t = Punk::Test->new($pkg);
    $RUNS = 0;
    $t->get_ok('/feed.xml');
    $t->get_ok('/feed.xml', headers => { Host => 'a.example.com' });
    $t->get_ok('/feed.xml', headers => { Host => 'b.example.com' });
    is($RUNS, 0,
        'three requests across three hosts run the section no extra times - '
      . 'a tenant document is rendered from the records, not from the database');
}

done_testing;
