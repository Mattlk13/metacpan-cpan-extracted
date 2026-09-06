package Blog::Posts;

use strict;
use warnings;

our $VERSION = '0.01';

# Stand-in for whatever a real application reads its rows out of. A feed
# section is handed rows and turns them into entries; where they came from is
# not this distribution's business, so the demo does not drag in a database to
# make the point.

my @POSTS = (
    {
        slug      => 'why-feeds',
        title     => 'Why bother with a feed?',
        published => '2026-01-14T09:00:00Z',
        updated   => '2026-01-14T09:00:00Z',
        excerpt   => 'A feed is the one way to follow a site that nobody owns.',
        body      => '<p>A feed is the one way to follow a site that nobody '
                   . 'owns - no account, no algorithm, no company in the '
                   . 'middle deciding what you see.</p>',
        tags      => [ 'meta' ],
    },
    {
        slug      => 'escaping-and-encoding',
        title     => 'Encoding & escaping, in that order',
        published => '2026-02-02T11:30:00Z',
        updated   => '2026-02-09T16:45:00Z',   # edited after publication
        excerpt   => q{A path holding a space is not a URL, and a title },
        body      => '<p>An ampersand in a title has to reach the reader as '
                   . '<code>&amp;amp;</code>, and a space in a path as '
                   . '<code>%20</code>. Doing them in the wrong order '
                   . 'produces a well-formed document full of URLs that do '
                   . 'not work.</p>',
        tags      => [ 'xml', 'urls' ],
    },
    {
        slug      => 'stale-by-design',
        title     => 'Stale by design',
        published => '2026-03-21T08:15:00Z',
        updated   => '2026-03-21T08:15:00Z',
        excerpt   => 'A reader learning about a post an hour late is a reader '
                   . 'behaving normally.',
        body      => '<p>The document is rebuilt when its TTL has passed, so '
                   . 'it is stale by up to that long. That is worth saying '
                   . 'rather than engineering away.</p>',
        tags      => [ 'caching' ],
    },
);

my @RELEASES = (
    {
        slug      => 'v0-01',
        title     => 'Punk::Feed 0.01',
        published => '2026-04-01T12:00:00Z',
        updated   => '2026-04-01T12:00:00Z',
        excerpt   => 'First release: Atom 1.0 and RSS 2.0 from one set of entries.',
        body      => '<p>First release.</p>',
        tags      => [ 'release' ],
    },
);

sub all      { @POSTS }
sub releases { @RELEASES }

sub find {
    my ($class, $slug) = @_;
    for my $p (@POSTS, @RELEASES) { return $p if $p->{slug} eq $slug }
    return undef;
}

1;

__END__
