#!perl
use 5.010;
use strict;
use warnings;
use Test::More;
use Punk::Feed ();

*esc = \&Punk::Plugin::Feed::_xml_escape;
*pct = \&Punk::Plugin::Feed::_pct_encode;
*url = \&Punk::Plugin::Feed::_url;

# ---- the five entities -----------------------------------------------------

is(esc('&'),  '&amp;',  'an ampersand');
is(esc('<'),  '&lt;',   'a less-than');
is(esc('>'),  '&gt;',   'a greater-than');
is(esc('"'),  '&quot;', 'a double quote');
is(esc("'"),  '&apos;', 'a single quote');

# Both quotes, so one function is safe in an attribute as well as in text.
is(esc(q{a "b" 'c'}), 'a &quot;b&quot; &apos;c&apos;',
    'both quote characters go, which is what makes this safe in an attribute');

is(esc('AT&T <b>x</b>'), 'AT&amp;T &lt;b&gt;x&lt;/b&gt;',
    'a run with several, in place');

# ---- the fast path ---------------------------------------------------------
#
# The escaper's common case is a `continue` per byte with no copy, and a bug
# there is silent: the string still comes back, just wrong. Assert the
# untouched case byte for byte.

is(esc('nothing to do here'), 'nothing to do here',
    'a string with nothing to escape comes back unchanged');
is(esc(''), '', 'and the empty string is the empty string');

{
    my $long = ('x' x 5000) . '&' . ('y' x 5000);
    is(esc($long), ('x' x 5000) . '&amp;' . ('y' x 5000),
        'one entity in the middle of a long run keeps both sides intact');
}

is(esc('&&&'), '&amp;&amp;&amp;', 'adjacent entities do not swallow each other');
is(esc('&x'),  '&amp;x',  'an entity at the start');
is(esc('x&'),  'x&amp;',  'an entity at the end');

# ---- already-escaped text is escaped again --------------------------------
#
# It has to be. The alternative is guessing whether a '&' begins an entity,
# and a title reading "Tom & Jerry &amp; friends" has both.

is(esc('&amp;'), '&amp;amp;',
    'an ampersand is escaped even when it looks like an entity already');

# ---- the CDATA decision, made testable ------------------------------------

is(esc(']]>'), ']]&gt;',
    "a ']]>' in content is escaped rather than carried inside CDATA");
like(esc('<script>a ]]> b</script>'), qr/\A&lt;script&gt;/,
    '  and content is escaped whole, so there is no CDATA to break out of');

# ---- percent-encoding ------------------------------------------------------

is(pct('/posts/1'), '/posts/1', 'an ordinary path is left alone');
is(pct('/a b'),     '/a%20b',   'a space is encoded');
is(pct('/a&b'),     '/a%26b',   'a sub-delimiter is encoded');
is(pct('/a-b_c.d~e'), '/a-b_c.d~e', 'the unreserved set survives');
is(pct('/'),        '/',        'the separator is kept, or it would not be a path');
is(pct("/a\x00b"),  '/a%00b',   'a NUL is encoded, not truncated at');

{
    my $utf8 = "/caf\xc3\xa9";           # café as UTF-8 bytes
    is(pct($utf8), '/caf%C3%A9', 'non-ASCII bytes become %XX, uppercase hex');
}

# ---- encode, then escape ---------------------------------------------------
#
# The order is the point of the header. A '%' produced by the encoder must not
# then be escaped, and an '&' in the path must be encoded rather than turned
# into &amp; - those are different URLs.

is(url('https://example.com', '/a b'), 'https://example.com/a%20b',
    'a space in a path is encoded, and the % it produced is left alone');

is(url('https://example.com', '/a&b'), 'https://example.com/a%26b',
    'an ampersand in a path is ENCODED, not escaped - &amp; would be a '
  . 'different URL');

is(url('https://example.com', '/<x>'), 'https://example.com/%3Cx%3E',
    'angle brackets in a path are encoded, so nothing reaches the escaper');

is(url('https://example.com', '/posts/1'), 'https://example.com/posts/1',
    'an ordinary URL is joined and left alone');

# ---- a query string must survive as one ------------------------------------
#
# Path rules applied to a query encode the '?' and fold the query into the
# path, so /article?id=5 asks for a file literally named "article?id=5" - a 404
# for every subscriber, from a link that looks right in the document.

is(url('https://example.com', '/article?id=5'),
   'https://example.com/article?id=5',
   'the query separator is not encoded');

is(url('https://example.com', '/a?x=1&y=2'),
   'https://example.com/a?x=1&amp;y=2',
   "a query's & is ESCAPED to &amp; - which in XML is the character '&' - "
 . 'rather than encoded to %26, which would be a different URL');

is(url('https://example.com', '/a?q=hello world'),
   'https://example.com/a?q=hello%20world',
   'a space in a query is still encoded');

is(url('https://example.com', '/a#frag'), 'https://example.com/a%23frag',
   'a bare fragment with no query is path-encoded');

is(url('https://example.com', '/a?x=1#frag'),
   'https://example.com/a?x=1#frag',
   'a fragment after a query survives');

# The path half keeps its conservative rules: over-encoding there is safe
# because the server decodes it back to the same path.
is(url('https://example.com', '/a&b?x=1'), 'https://example.com/a%26b?x=1',
   'an & before the ? is still encoded, because that half is a path');

# The base is configuration and is not encoded - encoding it would turn the
# "://" into something no reader would follow.
is(url('https://example.com', '/x'), 'https://example.com/x',
    'the scheme separator in the base survives');

done_testing;
