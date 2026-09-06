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
our %OPTS;
my $N = 0;

sub build {
    my (%o) = @_;
    my $pkg = 'FeedRoute' . ++$N;
    local %OPTS = (title => 'Example', %o);
    my $extra = delete $OPTS{_extra} || '';
    my $host  = exists $OPTS{_host} ? delete $OPTS{_host}
                                    : "host 'https://example.com';";
    eval "package $pkg;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
       . "$host\n"
       . "plugin 'Feed' => { \%main::OPTS };\n"
       . "feed sub { \@main::ROWS };\n"
       . "$extra\n1" or die $@;
    return $pkg;
}

# ---- what is served --------------------------------------------------------

{
    my $t = Punk::Test->new(build());

    $t->get_ok('/feed.xml')->status_is(200)
      ->header_is('Content-Type' => 'application/atom+xml; charset=utf-8')
      ->content_like(qr{<feed xmlns="http://www\.w3\.org/2005/Atom">});
    is($t->header('Content-Length'), length($t->body),
        'the Content-Length matches the bytes');

    $t->get_ok('/feed.rss')->status_is(200)
      ->header_is('Content-Type' => 'application/rss+xml; charset=utf-8')
      ->content_like(qr{<rss version="2\.0"});
    is($t->header('Content-Length'), length($t->body),
        'and again for RSS');
}

# Not text/xml, which makes some readers offer the file for download, and not
# application/xml, which tells autodiscovery nothing.
{
    my $t = Punk::Test->new(build());
    $t->get_ok('/feed.xml');
    unlike($t->header('Content-Type'), qr{^(?:text|application)/xml},
        'the content type names the feed format, not just "some XML"');
}

# ---- named feeds -----------------------------------------------------------

{
    my $t = Punk::Test->new(build(
        _extra => "feed news => sub { \@main::ROWS };"));

    $t->get_ok('/feed/news.xml')->status_is(200)
      ->header_is('Content-Type' => 'application/atom+xml; charset=utf-8');
    $t->get_ok('/feed/news.rss')->status_is(200)
      ->header_is('Content-Type' => 'application/rss+xml; charset=utf-8');

    # A feed nobody declared is 404 and not an empty document: handed an empty
    # but valid feed, a reader concludes every item was deleted.
    $t->get_ok('/feed/nope.xml')->status_is(404);
    $t->get_ok('/feed/news.txt')->status_is(404);
    $t->get_ok('/feed/news')->status_is(404);
}

# The capture is a whole segment, so it must be parsed rather than matched
# loosely - a loose parse serves a document for a URL nobody published.
{
    my $t = Punk::Test->new(build(
        _extra => "feed news => sub { \@main::ROWS };"));
    $t->get_ok('/feed/news.xml.evil')->status_is(404);
    $t->get_ok('/feed/newsXxml')->status_is(404);
}

# With nothing named, the route that could only ever 404 is not registered.
{
    my $t = Punk::Test->new(build());
    $t->get_ok('/feed/anything.xml')->status_is(404);
}

# ---- format ----------------------------------------------------------------

{
    my $t = Punk::Test->new(build(format => 'atom'));
    $t->get_ok('/feed.xml')->status_is(200);
    $t->get_ok('/feed.rss')->status_is(404);
}

{
    my $t = Punk::Test->new(build(format => 'rss'));
    $t->get_ok('/feed.rss')->status_is(200);
    $t->get_ok('/feed.xml')->status_is(404);
}

# ---- path ------------------------------------------------------------------

{
    my $t = Punk::Test->new(build(path => '/atom'));
    $t->get_ok('/atom.xml')->status_is(200);
    $t->get_ok('/feed.xml')->status_is(404);
}

# ---- a feed URL has no business in a sitemap -------------------------------
#
# Sitemap lists every GET route with no capture and no guard, and /feed.xml is
# one. A feed in a sitemap is a crawler fetching XML it will not index, on a
# schedule, for as long as the site exists.

SKIP: {
    skip 'Punk::Plugin::Sitemap not available', 3
        unless eval { require Punk::Plugin::Sitemap; 1 };

    my $pkg = 'FeedSitemap';
    eval "package $pkg;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
       . "host 'https://example.com';\n"
       . "plugin 'Sitemap';\n"
       . "plugin 'Feed' => { title => 'Example' };\n"
       . "get '/about' => sub { \$_[0]->text('about') };\n"
       . "feed sub { \@main::ROWS };\n1" or die $@;

    my $t = Punk::Test->new($pkg);
    $t->get_ok('/sitemap.xml')->status_is(200);
    my $sm = $t->body;
    like($sm, qr{<loc>https://example\.com/about</loc>},
        'the sitemap lists an ordinary page');
    unlike($sm, qr{/feed\.(?:xml|rss)},
        'but not the feed routes, which opt themselves out');
}

# ---- autodiscovery ---------------------------------------------------------

{
    my $pkg = build(_extra =>
        "get '/' => sub { \$_[0]->html(\$_[0]->feed_links) };");
    my $t = Punk::Test->new($pkg);
    $t->get_ok('/')->status_is(200);
    my $html = $t->body;
    like($html, qr{<link rel="alternate" type="application/atom\+xml" title="Example" href="https://example\.com/feed\.xml">},
        'feed_links gives the Atom autodiscovery tag');
    like($html, qr{<link rel="alternate" type="application/rss\+xml" title="Example" href="https://example\.com/feed\.rss">},
        '  and the RSS one');
}

{
    my $pkg = build(format => 'atom', _extra =>
        "get '/' => sub { \$_[0]->html(\$_[0]->feed_links) };");
    my $t = Punk::Test->new($pkg);
    $t->get_ok('/');
    unlike($t->body, qr{rss\+xml},
        'feed_links advertises only the formats that are served');
}

{
    my $pkg = build(_extra =>
        "feed news => { title => 'News & co', entries => sub { \@main::ROWS } };\n"
      . "get '/' => sub { \$_[0]->html(\$_[0]->feed_links) };");
    my $t = Punk::Test->new($pkg);
    $t->get_ok('/');
    like($t->body, qr{title="News &amp; co" href="https://example\.com/feed/news\.xml"},
        'a named feed is advertised too, with its title escaped');
}

done_testing;
