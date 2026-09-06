#!perl
use 5.010;
use strict;
use warnings;
use FindBin ();
use lib "$FindBin::Bin/../lib";
use lib "$FindBin::Bin/../../../blib/lib", "$FindBin::Bin/../../../blib/arch";
use Test::More;

# Unpacked from the tarball with nothing installed and nothing built, this
# example has no Punk::Feed to run against. Say so plainly rather than dying
# with a require error - and say it BEFORE any assertion, or the plan and the
# count disagree.
BEGIN {
    plan skip_all => 'Punk::Feed is not installed, and there is no blib beside '
                   . 'this example to run it from'
        unless eval { require Punk::Feed; require Punk::Plugin::Feed; 1 };
}

use Punk::Test;

# The application is compiled once, at to_app, so a test that builds the app is
# testing the same frozen coderef the server runs.
chdir "$FindBin::Bin/.." or die "cannot chdir to the application root: $!\n";

my $t = Punk::Test->new('Blog');

# ---- the pages -------------------------------------------------------------

$t->get_ok('/')->status_is(200)->content_like(qr/A Punk Blog/);
$t->get_ok('/posts/why-feeds')->status_is(200)
  ->content_like(qr/Why bother with a feed/);
$t->get_ok('/posts/no-such-post')->status_is(404);

# The autodiscovery tags a reader needs to find the feeds from the page.
$t->get_ok('/');
like($t->body, qr{<link rel="alternate" type="application/atom\+xml"[^>]*href="https://blog\.example\.com/feed\.xml">},
    'the page advertises its Atom feed');
like($t->body, qr{<link rel="alternate" type="application/rss\+xml"[^>]*href="https://blog\.example\.com/feed\.rss">},
    '  and its RSS feed');
like($t->body, qr{href="https://blog\.example\.com/feed/releases\.xml"},
    '  and the named one');

# ---- the feeds -------------------------------------------------------------

$t->get_ok('/feed.xml')->status_is(200)
  ->header_is('Content-Type' => 'application/atom+xml; charset=utf-8')
  ->content_like(qr{<feed xmlns="http://www\.w3\.org/2005/Atom">});

$t->get_ok('/feed.rss')->status_is(200)
  ->header_is('Content-Type' => 'application/rss+xml; charset=utf-8')
  ->content_like(qr{<rss version="2\.0"});

$t->get_ok('/feed/releases.xml')->status_is(200);
like($t->body, qr{<title>A Punk Blog: releases</title>},
    'the named feed carries its own title');
unlike($t->body, qr{Why bother with a feed},
    '  and its own entries, not the default feed\'s');

$t->get_ok('/feed/nope.xml')->status_is(404);

# ---- the things the demo is meant to show ---------------------------------

{
    $t->get_ok('/feed.xml');
    my $atom = $t->body;

    like($atom, qr{<title>Encoding &amp; escaping, in that order</title>},
        'an ampersand in a title is escaped');
    like($atom, qr{<id>tag:blog\.example,2026:post/why-feeds</id>},
        'a supplied id is used instead of the URL');
    like($atom, qr{<link rel="alternate" type="text/html" href="https://blog\.example\.com/posts/why-feeds"/>},
        'entries link to absolute URLs on the declared host');

    # The edited post has both dates; only Atom can say so.
    like($atom, qr{<updated>2026-02-09T16:45:00Z</updated>.*?<published>2026-02-02T11:30:00Z</published>}s,
        'an edited post keeps published and updated apart');

    # The feed timestamp is the newest entry's date, not the build time - the
    # releases feed is separate, so the newest here is the March post.
    my ($feed_updated) = $atom =~ m{<updated>([^<]+)</updated>};
    is($feed_updated, '2026-03-21T08:15:00Z',
        'the feed timestamp is the newest entry, not now');
}

{
    $t->get_ok('/feed.rss');
    my $rss = $t->body;
    like($rss, qr{<pubDate>Mon, 02 Feb 2026 11:30:00 \+0000</pubDate>},
        'RSS shows the publication date, having nowhere to put the other one');
    unlike($rss, qr{2026-02-09}, '  and no ISO dates anywhere');
}

# ---- conditional GET, which is the point of the ETag ----------------------

{
    $t->get_ok('/feed.xml')->status_is(200);
    my $etag = $t->header('ETag');
    ok($etag, 'a feed response carries an ETag');
    ok($t->header('Last-Modified'), '  and a Last-Modified');

    $t->get_ok('/feed.xml', headers => { 'If-None-Match' => $etag })
      ->status_is(304);
    is($t->body, '', 'asking again with the ETag is a 304 with no body');
}

done_testing();
