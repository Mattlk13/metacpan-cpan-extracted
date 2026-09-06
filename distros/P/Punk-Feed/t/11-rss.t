#!perl
use 5.010;
use strict;
use warnings;
use Test::More;
use POSIX ();
use Punk ();
use Punk::Plugin::Feed ();

our @ROWS;
our %OPTS;
my $N = 0;

sub app {
    my ($rows, %opts) = @_;
    local @ROWS = @$rows;
    local %OPTS = (title => 'Example', %opts);
    my $pkg = 'FeedRss' . ++$N;
    my $extra = delete $OPTS{_extra} || '';
    eval "package $pkg;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
       . "host 'https://example.com';\n"
       . "plugin 'Feed' => { \%main::OPTS };\n"
       . "feed sub { \@main::ROWS };\n"
       . "$extra\n1" or die $@;
    $pkg->to_app;
    return $pkg->punk_app;
}

sub rss { Punk::Plugin::Feed::_doc($_[0], $_[1], 'rss') }

my @ONE = ({ loc => '/p/1', title => 'First', updated => '2019-03-04T05:06:07Z' });

# ---- the document's frame --------------------------------------------------

{
    my $d = rss(app(\@ONE, description => 'A description', language => 'en',
                    copyright => '(c) 2019'));

    is(index($d, '<?xml version="1.0" encoding="UTF-8"?>'), 0,
        'the prolog is the very first bytes');
    like($d, qr{<rss version="2\.0" xmlns:atom="http://www\.w3\.org/2005/Atom">},
        'the rss element, with the atom namespace it needs for the self link');
    like($d, qr{<channel>}, 'a channel');
    like($d, qr{</channel>\s*</rss>\s*\z}, 'and both close');

    like($d, qr{<title>Example</title>},              'a channel title');
    like($d, qr{<link>https://example\.com/</link>},  'a channel link');
    like($d, qr{<description>A description</description>}, 'a description');
    like($d, qr{<language>en</language>},             'a language, RSS-only');
    like($d, qr{<copyright>\(c\) 2019</copyright>},   'a copyright');
    like($d, qr{<generator>Punk::Feed [^<]+</generator>}, 'a generator');
    like($d, qr{<atom:link rel="self" type="application/rss\+xml" href="https://example\.com/feed\.rss"/>},
        'a self link, which RSS can only say by borrowing Atom');
}

# <description> is required on a channel, so it falls back rather than being
# left out - an invalid channel is worse than a repetition.
{
    my $d = rss(app(\@ONE));
    like($d, qr{<description>Example</description>},
        'with no description the title stands in, because the element is '
      . 'required');
}

# ---- lastBuildDate is the newest item's, never now ------------------------

{
    my $d = rss(app([
        { loc => '/old', title => 'o', updated => '2018-01-01T00:00:00Z' },
        { loc => '/new', title => 'n', updated => '2019-03-04T05:06:07Z' },
    ]));
    my ($lbd) = $d =~ m{<lastBuildDate>([^<]+)</lastBuildDate>};
    is($lbd, 'Mon, 04 Mar 2019 05:06:07 +0000',
        'lastBuildDate is the newest item, despite what its name invites');

    my $now_year = POSIX::strftime('%Y', gmtime);
    unlike($lbd, qr/\b$now_year\b/,
        "  and demonstrably not now (this year is $now_year)");
}

{
    my $a = rss(app(\@ONE));
    my $b = rss(app(\@ONE));
    is($a, $b, 'two builds of the same entries are byte-identical');
}

# ---- items -----------------------------------------------------------------

{
    my $d = rss(app(\@ONE));
    like($d, qr{<item>},                              'an item');
    like($d, qr{<title>First</title>},                'an item title');
    like($d, qr{<link>https://example\.com/p/1</link>}, 'an item link');
    like($d, qr{<pubDate>Mon, 04 Mar 2019 05:06:07 \+0000</pubDate>},
        'a pubDate in RFC 822, which is the format RSS takes');
}

# guid isPermaLink says whether a reader may fetch it.
{
    my $d = rss(app(\@ONE));
    like($d, qr{<guid isPermaLink="true">https://example\.com/p/1</guid>},
        'the guid defaults to the item URL and is therefore fetchable');
}

{
    my $d = rss(app([{ loc => '/p/1', title => 'T', updated => 1,
                       id => 'tag:example.com,2018:1' }]));
    like($d, qr{<guid isPermaLink="false">tag:example\.com,2018:1</guid>},
        'a supplied id flips isPermaLink, because a tag: URI is not fetchable');
}

# RSS has one date element, so publication wins where there is one.
{
    my $d = rss(app([{ loc => '/p/1', title => 'T',
                       updated   => '2019-03-04T05:06:07Z',
                       published => '2018-01-01T00:00:00Z' }]));
    like($d, qr{<pubDate>Mon, 01 Jan 2018 00:00:00 \+0000</pubDate>},
        'pubDate is the publication date when there is one');
    unlike($d, qr{<published>}, 'and there is no published element to put it in');
}

# RSS core has no content element, so a summary is preferred and content
# stands in when there is none.
{
    my $d = rss(app([{ loc => '/p/1', title => 'T', updated => 1,
                       summary => 'the summary', content => '<p>the content</p>' }]));
    like($d, qr{<description>the summary</description>},
        'a summary becomes the description');
    unlike($d, qr{the content}, '  and the content is left out, having nowhere to go');
}

{
    my $d = rss(app([{ loc => '/p/1', title => 'T', updated => 1,
                       content => '<p>the content</p>' }]));
    like($d, qr{<description>&lt;p&gt;the content&lt;/p&gt;</description>},
        'content stands in as the description when there is no summary, escaped');
}

{
    my $d = rss(app([{ loc => '/p/1', title => 'T', updated => 1,
                       author => 'Someone', category => ['perl', 'xs'],
                       enclosure => { url => 'https://example.com/a.mp3',
                                      type => 'audio/mpeg', length => 12 } }]));
    like($d, qr{<author>Someone</author>},
        'an author name, which every reader accepts even though the spec '
      . 'says email - emitting the email would publish it');
    like($d, qr{<category>perl</category>.*<category>xs</category>}s,
        'every category');
    like($d, qr{<enclosure url="https://example\.com/a\.mp3" type="audio/mpeg" length="12"/>},
        'an enclosure is an element with attributes, which is RSS\'s spelling');
}

# ---- escaping --------------------------------------------------------------

{
    my $d = rss(app([{ loc => '/p/1?a=1&b=2', title => 'Tom & Jerry',
                       updated => 1 }]));
    like($d, qr{<title>Tom &amp; Jerry</title>}, 'a title is escaped');
    like($d, qr{<link>https://example\.com/p/1\?a=1&amp;b=2</link>},
        'and a query string survives as one');
    unlike($d, qr/CDATA/, 'there is no CDATA anywhere');
}

# ---- names and format ------------------------------------------------------

{
    my $app = app(\@ONE, _extra => "feed news => sub { \@main::ROWS };");
    like(rss($app, 'news'), qr{href="https://example\.com/feed/news\.rss"},
        'a named feed knows its own RSS URL');
}

{
    my $app = app(\@ONE, format => 'rss');
    ok(length rss($app), 'format => rss renders RSS');
    is(Punk::Plugin::Feed::_doc($app, undef, 'atom'), undef,
        '  and does not render Atom at all');
}

{
    my $app = app(\@ONE);
    ok(length rss($app),                                     'both renders RSS');
    ok(length Punk::Plugin::Feed::_doc($app, undef, 'atom'), '  and Atom');
    isnt(rss($app), Punk::Plugin::Feed::_doc($app, undef, 'atom'),
        '  and they are different documents');
    isnt(Punk::Plugin::Feed::_etag($app, undef, 'rss'),
         Punk::Plugin::Feed::_etag($app, undef, 'atom'),
        '  with different ETags, so a reader cannot be told one is the other');
}

# ---- an empty feed is still a valid channel -------------------------------

{
    my $d = rss(app([]));
    like($d, qr{<title>},         'an empty channel still has a title');
    like($d, qr{<link>},          '  a link');
    like($d, qr{<description>},   '  and a description');
    unlike($d, qr{<item>},        'but no items');
}

done_testing;
