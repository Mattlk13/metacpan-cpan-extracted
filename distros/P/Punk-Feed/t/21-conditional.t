#!perl
use 5.010;
use strict;
use warnings;
use Test::More;
use Punk ();
use Punk::Test;
use Punk::Plugin::Feed ();

# A reader is a fetcher on a schedule: it asks for this URL every few minutes
# for years, and between rebuilds the answer is bytes that already exist.

our @ROWS = ({ loc => '/p/1', title => 'First',
               updated => '2019-03-04T05:06:07Z' });
my $N = 0;

sub build {
    my (%o) = @_;
    my $pkg = 'FeedCond' . ++$N;
    my $ttl = exists $o{ttl} ? $o{ttl} : 3600;
    eval "package $pkg;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
       . "host 'https://example.com';\n"
       . "plugin 'Feed' => { title => 'Example', ttl => $ttl };\n"
       . "feed sub { \@main::ROWS };\n1" or die $@;
    return Punk::Test->new($pkg);
}

# ---- what a 200 carries ----------------------------------------------------

my ($etag, $lastmod);
{
    my $t = build();
    $t->get_ok('/feed.xml')->status_is(200);

    $etag = $t->header('ETag');
    like($etag, qr/\A"[^"]+"\z/, 'a 200 carries a quoted strong ETag');

    $lastmod = $t->header('Last-Modified');
    is($lastmod, 'Mon, 04 Mar 2019 05:06:07 GMT',
        'and a Last-Modified in IMF-fixdate, which is the only form HTTP takes');
    unlike($lastmod, qr/\+0000/,
        '  not RSS spelling - a strict client rejects +0000 in an HTTP date');

    is($t->header('Cache-Control'), 'max-age=3600',
        'and a max-age from the ttl, because a client told to come back sooner '
      . 'can only produce a 304');
}

# Last-Modified is the newest entry's date, so it agrees with the document.
{
    my $t = build();
    $t->get_ok('/feed.xml');
    like($t->body, qr{<updated>2019-03-04T05:06:07Z</updated>},
        'the document and the Last-Modified describe the same instant');
}

# ---- If-None-Match ---------------------------------------------------------

{
    my $t = build();
    $t->get_ok('/feed.xml');
    my $tag = $t->header('ETag');

    $t->get_ok('/feed.xml', headers => { 'If-None-Match' => $tag })
      ->status_is(304);
    is($t->body, '', 'a 304 has no body');
    is($t->header('ETag'), $tag, '  but still carries the validator');
    is($t->header('Content-Length'), undef,
        '  and no Content-Length, rather than a Content-Length of 0');
}

{
    my $t = build();
    $t->get_ok('/feed.xml', headers => { 'If-None-Match' => '"nonsense"' })
      ->status_is(200);
    ok(length $t->body, 'a stale ETag gets the document');
}

{
    my $t = build();
    $t->get_ok('/feed.xml');
    my $tag = $t->header('ETag');
    (my $weak = $tag) =~ s/\A/W\//;
    $t->get_ok('/feed.xml', headers => { 'If-None-Match' => $weak })
      ->status_is(304);
    pass('a weak validator matches - for a whole document they mean the same');
}

{
    my $t = build();
    $t->get_ok('/feed.xml', headers => { 'If-None-Match' => '*' })
      ->status_is(304);
    pass('a * matches anything that exists');
}

# The two formats must not validate against each other.
{
    my $t = build();
    $t->get_ok('/feed.xml');
    my $atom_tag = $t->header('ETag');
    $t->get_ok('/feed.rss', headers => { 'If-None-Match' => $atom_tag })
      ->status_is(200);
    pass("the Atom ETag does not tell a client the RSS feed is unchanged");
}

# ---- If-Modified-Since -----------------------------------------------------
#
# Some readers only ever send a date, which is why one goes out at all.

{
    my $t = build();
    $t->get_ok('/feed.xml', headers =>
        { 'If-Modified-Since' => 'Mon, 04 Mar 2019 05:06:07 GMT' })
      ->status_is(304);
    is($t->body, '', 'an exactly-equal date is not modified');
}

{
    my $t = build();
    $t->get_ok('/feed.xml', headers =>
        { 'If-Modified-Since' => 'Tue, 05 Mar 2019 00:00:00 GMT' })
      ->status_is(304);
    pass('a later date is not modified either');
}

{
    my $t = build();
    $t->get_ok('/feed.xml', headers =>
        { 'If-Modified-Since' => 'Sun, 03 Mar 2019 05:06:07 GMT' })
      ->status_is(200);
    ok(length $t->body, 'a date older than the feed gets the document');
}

# An unparseable date is a 200, which is correct and merely less efficient.
# Guessing at it would serve a 304 for a document the client does not have.
{
    my $t = build();
    $t->get_ok('/feed.xml', headers => { 'If-Modified-Since' => 'yesterday' })
      ->status_is(200);
    ok(length $t->body, 'an unparseable If-Modified-Since is ignored, not guessed at');
}

# ---- the tag wins ----------------------------------------------------------
#
# RFC 9110: when both are present the entity tag is used and the date ignored.

{
    my $t = build();
    $t->get_ok('/feed.xml', headers => {
        'If-None-Match'     => '"nonsense"',
        'If-Modified-Since' => 'Tue, 05 Mar 2019 00:00:00 GMT',
    })->status_is(200);
    ok(length $t->body,
        'a stale tag beside a fresh date is a 200 - the tag decides');
}

{
    my $t = build();
    $t->get_ok('/feed.xml');
    my $tag = $t->header('ETag');
    $t->get_ok('/feed.xml', headers => {
        'If-None-Match'     => $tag,
        'If-Modified-Since' => 'Sun, 03 Mar 2019 05:06:07 GMT',
    })->status_is(304);
    pass('and a fresh tag beside a stale date is a 304, the same way');
}

# ---- ttl feeds through to max-age -----------------------------------------

{
    my $t = build(ttl => 60);
    $t->get_ok('/feed.xml');
    is($t->header('Cache-Control'), 'max-age=60', 'a shorter ttl shortens max-age');
}

done_testing;
