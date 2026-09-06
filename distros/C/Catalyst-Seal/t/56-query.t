#!/usr/bin/env perl
use strict;
use warnings;

use FindBin ();
use lib "$FindBin::Bin/lib";

use Test::More;
use Encode ();

BEGIN { $ENV{CATALYST_DEBUG} = 0; $ENV{CATALYST_SEAL} = 1 }

require SealTest;
require TestApp;
my $app = TestApp->psgi_app;

ok(Catalyst::Engine->can('prepare_query_parameters')
     == \&Catalyst::Seal::Prepare::_prepare_query_parameters,
   'the query parser was replaced');

# ---- the decoder answers exactly what Encode answers ------------------------
#
# Including the spelling. Encode::decode returns a string flagged UTF-8 whatever
# it was given - ASCII and empty included - and a value that came back flagged
# differently would be the same string that reports itself differently.

my $enc   = Encode::find_encoding('UTF-8');
my $check = Encode::FB_CROAK() | Encode::LEAVE_SRC();

my @valid = (
    [ 'empty',      ''                     ],
    [ 'ascii',      'hello'                ],
    [ 'two-byte',   "caf\xc3\xa9"          ],
    [ 'three-byte', "\xe2\x98\x83"         ],
    [ 'four-byte',  "\xf0\x9f\x92\xa9"     ],
    [ 'mixed',      "a\xc3\xa9b\xf0\x9f\x92\xa9c" ],
    [ 'max',        "\xf4\x8f\xbd\xbd"     ],   # U+10FFFD, the last usable one
    [ 'nul',        "a\x00b"               ],
);

for my $case (@valid) {
    my ($name, $bytes) = @$case;
    my $want = $enc->decode($bytes, $check);
    my $got  = Catalyst::Seal::_decode_param($bytes, 0, 1);
    is($got, $want, "$name: decoded the same as Encode");
    is(utf8::is_utf8($got) ? 1 : 0, utf8::is_utf8($want) ? 1 : 0,
       "$name: ... and spelled the same way");
    is(length $got, length $want, "$name: ... and the same number of characters");
}

# Everything Encode's strict UTF-8 refuses, this refuses too - by answering
# with nothing, which is what sends the bytes to Encode to be refused there.
my @invalid = (
    [ 'surrogate',      "\xed\xa0\x80"     ],
    [ 'overlong-2',     "\xc0\xaf"         ],
    [ 'overlong-3',     "\xe0\x80\xaf"     ],
    [ 'above-10ffff',   "\xf5\x80\x80\x80" ],
    [ 'truncated',      "\xc3"             ],
    [ 'truncated-4',    "\xf0\x9f\x92"     ],
    [ 'lone-continuation', "\x80"          ],
    [ 'bare-fe',        "\xfe"             ],
    [ 'c1',             "\xc1\x81"         ],
);

for my $case (@invalid) {
    my ($name, $bytes) = @$case;
    my $ok = eval { $enc->decode($bytes, $check); 1 };
    ok(!$ok, "$name: Encode refuses it");
    my @got = Catalyst::Seal::_decode_param($bytes, 0, 1);
    is(scalar @got, 0, "$name: ... and so does the decoder");
}

# ---- the two validators agree, code point by code point ---------------------
#
# The boundary of every branch, then a sweep. The boundaries are the test - a
# sweep on its own would step straight over the sixty-six noncharacters, which
# are the ones a validator written from a specification gets wrong.

{
    my @boundaries = (
        0x00, 0x7F, 0x80, 0x7FF, 0x800, 0xD7FF, 0xE000,
        0xFDCF, 0xFDD0, 0xFDEF, 0xFDF0,
        0xFFFD, 0xFFFE, 0xFFFF, 0x10000,
        0x1FFFD, 0x1FFFE, 0x1FFFF, 0x20000,
        0xFFFFD, 0xFFFFE, 0xFFFFF, 0x100000,
        0x10FFFD, 0x10FFFE, 0x10FFFF,
    );
    my @sweep = map { $_ * 0x1111 } 1 .. 0xF;
    push @sweep, map { 0xFDD0 + $_ } 0 .. 0x1F;

    my ($checked, $disagreed) = (0, 0);
    for my $cp (@boundaries, @sweep) {
        next if $cp >= 0xD800 && $cp <= 0xDFFF;   # not expressible at all
        my $chars = chr $cp;
        utf8::encode($chars);
        my $encode_ok = eval { $enc->decode($chars, $check); 1 } ? 1 : 0;
        my $ours_ok   = (Catalyst::Seal::_decode_param($chars, 0, 1))[0];
        $ours_ok = defined $ours_ok ? 1 : 0;
        $checked++;
        next if $encode_ok == $ours_ok;
        $disagreed++;
        diag sprintf 'U+%04X: Encode says %d, the decoder says %d',
            $cp, $encode_ok, $ours_ok;
    }
    is($disagreed, 0, "the decoder agrees with Encode on all $checked code points");
}

# ---- percent-decoding is Catalyst's, down to what it leaves alone -----------

for my $case (['a+b', 'a b'], ['%41', 'A'], ['%4a', 'J'], ['%zz', '%zz'],
              ['%4', '%4'], ['%', '%'], ['a%2Bb', 'a+b'], ['', '']) {
    my ($in, $want) = @$case;
    is(Catalyst::Seal::_decode_param($in, 1, 0), $want, "unescape '$in'");
}

# ---- the parser -------------------------------------------------------------

sub parse { my ($h, $kw) = Catalyst::Seal::_parse_query($_[0], 1); return ($h, $kw) }

{
    my ($h) = parse('a=1');
    is_deeply($h, { a => 1 }, 'one pair');

    ($h) = parse('a=1&a=2&a=3');
    is_deeply($h, { a => [1, 2, 3] }, 'a repeated name is an array, in order');

    ($h) = parse('&&a=1;;b=2');
    is_deeply($h, { a => 1, b => 2 }, 'separators lead, repeat and mix');

    ($h) = parse('a=');
    is_deeply($h, { a => '' }, 'an empty value');

    ($h) = parse('=v');
    is_deeply($h, { '' => 'v' }, 'an empty name');

    my $kw;
    ($h, $kw) = parse('isidx&b=2');
    is_deeply($h, { isidx => undef, b => 2 }, 'a bare first name has no value');
    is($kw, 'isidx', '...and is the isindex keyword');

    ($h, $kw) = parse('a=1&bare');
    is($kw, undef, 'a bare name that is not first is not the keyword');

    ($h) = parse('');
    is_deeply($h, {}, 'an empty query string is an empty hash');

    my @none = Catalyst::Seal::_parse_query('a=%ED%A0%80', 1);
    is(scalar @none, 0, 'a query with a bad sequence is refused whole');
}

# ---- and through a real request ---------------------------------------------

{
    my $res = SealTest::response($app, PATH_INFO => '/query',
                                 QUERY_STRING => 'a=caf%C3%A9&a=two&b=one+two');
    my $body = join '', @{ $res->[2] };
    like($body, qr/a=caf/, 'a request sees the decoded parameters');
    like($body, qr/b=one two/, '...with plus signs as spaces');
}

# A query the C parser will not touch still arrives, because the stock parser
# gets it: this one is bytes that are not UTF-8.
{
    my $res = SealTest::response($app, PATH_INFO => '/query', QUERY_STRING => 'a=%FF');
    ok($res->[0], 'a query the parser refuses still produces a response');
}

done_testing;
