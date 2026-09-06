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

# An application with one feed returning @main::ROWS, compiled and built.
sub app {
    my ($rows, %opts) = @_;
    local @ROWS = @$rows;
    local %OPTS = (title => 'Example', %opts);
    my $pkg = 'FeedAtom' . ++$N;
    my $extra = delete $OPTS{_extra} || '';
    eval "package $pkg;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
       . "host 'https://example.com';\n"
       . "plugin 'Feed' => { \%main::OPTS };\n"
       . "feed sub { \@main::ROWS };\n"
       . "$extra\n1" or die $@;
    $pkg->to_app;
    return $pkg->punk_app;
}

sub atom { Punk::Plugin::Feed::_doc($_[0], $_[1], 'atom') }

my @ONE = ({ loc => '/p/1', title => 'First', updated => '2019-03-04T05:06:07Z' });

# ---- the document's frame --------------------------------------------------

{
    my $d = atom(app(\@ONE));

    is(index($d, '<?xml version="1.0" encoding="UTF-8"?>'), 0,
        'the prolog is the very first bytes - a BOM or a leading newline '
      . 'makes the document invalid');
    like($d, qr{<feed xmlns="http://www\.w3\.org/2005/Atom">},
        'the Atom namespace');
    like($d, qr{</feed>\s*\z}, 'and it closes');

    # everything Atom makes mandatory, at the feed level
    like($d, qr{<id>https://example\.com/feed\.xml</id>}, 'a feed id');
    like($d, qr{<title>Example</title>},                  'a feed title');
    like($d, qr{<updated>2019-03-04T05:06:07Z</updated>}, 'a feed updated');

    like($d, qr{<link rel="self" type="application/atom\+xml" href="https://example\.com/feed\.xml"/>},
        'a self link, naming the format it is');
    like($d, qr{<link rel="alternate" type="text/html" href="https://example\.com/"/>},
        'an alternate link to the site');
    like($d, qr{<generator uri="[^"]+" version="[^"]+">Punk::Feed</generator>},
        'a generator');

    # and at the entry level
    like($d, qr{<entry>.*<id>https://example\.com/p/1</id>.*</entry>}s,
        'an entry id, defaulting to the absolute URL');
    like($d, qr{<title>First</title>},                    'an entry title');
    like($d, qr{<entry>.*<updated>2019-03-04T05:06:07Z</updated>.*</entry>}s,
        'an entry updated');
}

# ---- the feed date is the newest entry's, never now -----------------------

{
    my $d = atom(app([
        { loc => '/old', title => 'o', updated => '2018-01-01T00:00:00Z' },
        { loc => '/new', title => 'n', updated => '2019-03-04T05:06:07Z' },
    ]));
    my ($feed_updated) = $d =~ m{<updated>([^<]+)</updated>};
    is($feed_updated, '2019-03-04T05:06:07Z',
        'the feed updated is the newest entry, not the build time');

    my $now_year = POSIX::strftime('%Y', gmtime);
    isnt(substr($feed_updated, 0, 4), $now_year,
        "  and demonstrably not now (this year is $now_year)");
}

# A rebuild that found nothing new must produce the same bytes, or every reader
# records a change on every TTL.
{
    my $a = atom(app(\@ONE));
    my $b = atom(app(\@ONE));
    is($a, $b, 'two builds of the same entries are byte-identical');
    is(Punk::Plugin::Feed::_etag(app(\@ONE), undef, 'atom'),
       Punk::Plugin::Feed::_etag(app(\@ONE), undef, 'atom'),
       '  and so are their ETags');
}

{
    my $x = Punk::Plugin::Feed::_etag(app(\@ONE), undef, 'atom');
    my $y = Punk::Plugin::Feed::_etag(
        app([ { loc => '/p/1', title => 'Changed',
                updated => '2019-03-04T05:06:07Z' } ]), undef, 'atom');
    isnt($x, $y, 'a changed entry changes the ETag');
    like($x, qr/\A"[0-9a-f]+-[0-9a-f]{8}"\z/, 'the ETag is a quoted strong tag');
}

# ---- escaping through the document ----------------------------------------

{
    my $d = atom(app([{
        loc     => '/p/1?a=1&b=2',
        title   => 'Tom & Jerry <b>',
        updated => 1,
        content => '<p>a ]]> b</p>',
        summary => q{it's "quoted"},
    }]));
    like($d, qr{<title>Tom &amp; Jerry &lt;b&gt;</title>},
        'a title is escaped');
    # The query survives as a query - encoding the '?' would fold it into the
    # path and ask for a file called "1?a=1&b=2". Its '&' is then escaped to
    # &amp;, which in XML *is* the character '&', so the URL a reader
    # reconstructs is the one the application wrote.
    like($d, qr{href="https://example\.com/p/1\?a=1&amp;b=2"},
        'a query string stays a query string, with its & escaped not encoded');
    like($d, qr{<content type="html">&lt;p&gt;a \]\]&gt; b&lt;/p&gt;</content>},
        'content is escaped html, and the ]]> has nothing to break out of');
    unlike($d, qr/CDATA/, 'there is no CDATA anywhere');
    like($d, qr{<summary type="text">it&apos;s &quot;quoted&quot;</summary>},
        'a summary is escaped, both quote characters included');
}

# ---- optional entry parts --------------------------------------------------

{
    my $d = atom(app([{
        loc       => '/p/1',
        title     => 'T',
        updated   => '2019-03-04T05:06:07Z',
        published => '2018-01-01T00:00:00Z',
        id        => 'tag:example.com,2018:1',
        author    => 'Someone Else',
        category  => ['perl', 'xs'],
        enclosure => { url => 'https://example.com/a.mp3',
                       type => 'audio/mpeg', length => 12 },
    }]));
    like($d, qr{<id>tag:example\.com,2018:1</id>},
        'a supplied id replaces the URL, which is what outlives a rename');
    like($d, qr{<published>2018-01-01T00:00:00Z</published>},
        'published is separate from updated, which only Atom can say');
    like($d, qr{<entry>.*<author><name>Someone Else</name></author>.*</entry>}s,
        'an entry author overrides the feed author');
    like($d, qr{<category term="perl"/>.*<category term="xs"/>}s,
        'every category, in order');
    like($d, qr{<link rel="enclosure" type="audio/mpeg" length="12" href="https://example\.com/a\.mp3"/>},
        'an enclosure is a link with a rel, which is Atom\'s spelling');
}

# The feed's author stands in for an entry that has none - Atom wants an author
# reachable for every entry.
{
    my $d = atom(app(\@ONE, author => 'Feed Author'));
    like($d, qr{<entry>.*<author><name>Feed Author</name></author>.*</entry>}s,
        'the feed author is repeated onto an entry with none');
}

# ---- names, paths and overrides -------------------------------------------

{
    my $app = app(\@ONE, _extra => "feed news => sub { \@main::ROWS };");
    my $d = atom($app, 'news');
    like($d, qr{href="https://example\.com/feed/news\.xml"},
        'a named feed knows its own URL');
    is_deeply(Punk::Plugin::Feed::_feeds($app), ['', 'news'],
        '  and sits beside the default one');
}

{
    my $app = app(\@ONE,
        _extra => "feed news => { title => 'Just news', entries => sub { \@main::ROWS } };");
    like(atom($app, 'news'), qr{<title>Just news</title>},
        'a per-feed title overrides the plugin title');
    like(atom($app, ''), qr{<title>Example</title>},
        '  without touching the default feed');
}

{
    my $d = atom(app(\@ONE, path => '/atom'));
    like($d, qr{href="https://example\.com/atom\.xml"},
        'path moves the stem');
}

# ---- format ----------------------------------------------------------------

{
    my $app = app(\@ONE, format => 'atom');
    ok(length atom($app),                     'format => atom renders Atom');
    is(Punk::Plugin::Feed::_doc($app, undef, 'rss'), undef,
        '  and does not render RSS at all');
}

# ---- an empty feed is still a valid feed ----------------------------------

{
    my $d = atom(app([]));
    like($d, qr{<id>},      'an empty feed still has an id');
    like($d, qr{<title>},   '  a title');
    like($d, qr{<updated>}, '  and an updated, falling back to the build time');
    unlike($d, qr{<entry>}, 'but no entries');
}

done_testing;
