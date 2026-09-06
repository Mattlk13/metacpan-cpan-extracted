#!perl
use 5.010;
use strict;
use warnings;
use Test::More;
use Punk ();
use Punk::Test;
use Punk::Plugin::Feed ();

# A document says encoding="UTF-8", and a byte that is not UTF-8 makes it not
# well-formed. That is fatal rather than cosmetic: a reader rejects the WHOLE
# document, exactly as it does for an unescaped ampersand.
#
# Perl offers three shapes for the same text and all three arrive here:
#
#   "Caf\x{e9}"        a character string, stored UNFLAGGED as the byte E9
#   "Caf\x{e9}\x{263a}" a character string, flagged, because of the astral char
#   "Caf\xc3\xa9"      a byte string that already is UTF-8, flag off
#
# The first two are the same string to Perl. Only their storage differs, and
# only the second one is UTF-8 already.

our @ROWS;
my $N = 0;

sub doc {
    my (@rows) = @_;
    local @ROWS = @rows;
    my $pkg = 'FeedEnc' . ++$N;
    eval "package $pkg;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
       . "host 'https://example.com';\n"
       . "plugin 'Feed' => { title => 'Example' };\n"
       . "feed sub { \@main::ROWS };\n1" or die $@;
    $pkg->to_app;
    return ($pkg, Punk::Plugin::Feed::_doc($pkg->punk_app, undef, 'atom'));
}

sub hex_of { join ' ', map { sprintf '%02X', ord } split //, shift }
sub valid_utf8 { my $c = shift; return utf8::decode($c) ? 1 : 0 }

my $CAFE_U8 = '43 61 66 C3 A9';        # "Café" as UTF-8 bytes

# ---- all three shapes come out as the same UTF-8 --------------------------

{
    my (undef, $d) = doc({ loc => '/a', updated => 1,
                           title => "Caf\x{e9}" });
    my ($t) = $d =~ m{<entry>.*?<title>([^<]*)</title>}s;
    is(hex_of($t), $CAFE_U8,
        'an unflagged character string is upgraded, not emitted as latin-1');
    ok(valid_utf8($d), '  and the document is valid UTF-8');
}

{
    my (undef, $d) = doc({ loc => '/a', updated => 1,
                           title => "Caf\x{e9}\x{263a}" });
    my ($t) = $d =~ m{<entry>.*?<title>([^<]*)</title>}s;
    is(hex_of($t), "$CAFE_U8 E2 98 BA",
        'a flagged character string is emitted as its UTF-8 bytes');
    ok(valid_utf8($d), '  and the document is valid UTF-8');
}

{
    my (undef, $d) = doc({ loc => '/a', updated => 1,
                           title => "Caf\xc3\xa9" });
    my ($t) = $d =~ m{<entry>.*?<title>([^<]*)</title>}s;
    is(hex_of($t), $CAFE_U8,
        'a byte string that already is UTF-8 passes through unchanged - '
      . 'upgrading it would double-encode what frj and Stencil hand back');
    ok(valid_utf8($d), '  and the document is valid UTF-8');
}

# The two indistinguishable-by-flag shapes must agree, or the same visible text
# would produce two different feeds depending on how it was built.
{
    my (undef, $a) = doc({ loc => '/a', updated => 1, title => "Caf\x{e9}" });
    my (undef, $b) = doc({ loc => '/a', updated => 1, title => "Caf\xc3\xa9" });
    is($a, $b, 'latin-1 characters and UTF-8 bytes produce identical documents');
}

# ---- mixed within one document --------------------------------------------
#
# The real hazard: appending a flagged SV to a byte buffer upgrades the buffer
# and re-encodes everything already in it.

{
    my (undef, $d) = doc(
        { loc => '/a', updated => 2, title => "Caf\x{e9}\x{263a}" },  # flagged
        { loc => '/b', updated => 1, title => "Caf\xc3\xa9",
          summary => "plain ascii" },                                 # bytes
    );
    ok(valid_utf8($d), 'a document mixing flagged and byte entries is valid UTF-8');
    my @titles = $d =~ m{<entry>.*?<title>([^<]*)</title>}gs;
    is(hex_of($titles[1]), $CAFE_U8,
        '  and the byte entry is not double-encoded by the flagged one');
    like($d, qr/plain ascii/, '  and ASCII beside them is untouched');
}

# ---- URLs ------------------------------------------------------------------

{
    my (undef, $d) = doc({ loc => "/caf\x{e9}", updated => 1, title => 'T' });
    my ($h) = $d =~ m{<entry>.*?<link rel="alternate"[^>]*href="([^"]*)"}s;
    is($h, 'https://example.com/caf%C3%A9',
        'a non-ASCII path is UTF-8 encoded THEN percent-encoded - %E9 would '
      . 'be a link that 404s');
}

{
    my (undef, $d) = doc({ loc => "/caf\x{e9}\x{263a}", updated => 1, title => 'T' });
    my ($h) = $d =~ m{<entry>.*?<link rel="alternate"[^>]*href="([^"]*)"}s;
    is($h, 'https://example.com/caf%C3%A9%E2%98%BA',
        'and the same for a flagged path');
}

# ---- the whole document is bytes ------------------------------------------

{
    my (undef, $d) = doc({ loc => '/a', updated => 1, title => "Caf\x{e9}" });
    ok(!utf8::is_utf8($d),
        'the document is a byte string, so nothing downstream re-encodes it');
}

# Content-Length must be the byte count. Characters would under-count and the
# response would be truncated mid-document.
{
    my $pkg = 'FeedEncLen';
    our @R = ({ loc => '/a', updated => 1, title => "Caf\x{e9}\x{263a}" });
    eval "package $pkg;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
       . "host 'https://example.com';\n"
       . "plugin 'Feed' => { title => 'Example' };\n"
       . "feed sub { \@main::R };\n1" or die $@;
    my $t = Punk::Test->new($pkg);
    $t->get_ok('/feed.xml')->status_is(200);
    my $body = $t->body;
    is($t->header('Content-Length'), length($body),
        'Content-Length counts bytes, not characters');
    ok(!utf8::is_utf8($body), '  because the body is bytes');
    ok(valid_utf8($body),     '  and valid UTF-8');
}

# ---- escaping still applies to non-ASCII text -----------------------------

{
    my (undef, $d) = doc({ loc => '/a', updated => 1,
                           title => "Caf\x{e9} & Bar" });
    like($d, qr/Caf\xc3\xa9 &amp; Bar/,
        'escaping and encoding compose, in that order');
}

done_testing;
