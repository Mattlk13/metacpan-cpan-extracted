#!perl
use strict;
use warnings;
use Test::More;
use MIME::Base64 qw/encode_base64url decode_base64url/;
use Crypt::PK::ECC;
use Crypt::JWT qw(decode_jwt);
use VAPID qw/encrypt_payload generate_vapid_header/;

# The published worked examples, transcribed from the RFC texts:
#
#   RFC 8291 section 5 and appendix A  - Web Push Message Encryption
#   RFC 8292 section 2.4               - VAPID for Web Push
#
# These are the only honest test of this code. A round trip proves the module
# agrees with itself, which two mistakes that cancel would also do; the vectors
# prove it agrees with the specification. Every constant below comes from the
# RFC text, not from running this module and recording what it produced.

# ---- RFC 8291 appendix A ---------------------------------------------------

my %V = (
    plaintext   => 'V2hlbiBJIGdyb3cgdXAsIEkgd2FudCB0byBiZSBhIHdhdGVybWVsb24',
    as_public   => 'BP4z9KsN6nGRTbVYI_c7VJSPQTBtkgcy27mlmlMoZIIg'
                 . 'Dll6e3vCYLocInmYWAmS6TlzAC8wEqKK6PBru3jl7A8',
    as_private  => 'yfWPiYE-n46HLnH0KqZOF1fJJU3MYrct3AELtAQ-oRw',
    ua_public   => 'BCVxsr7N_eNgVRqvHtD0zTZsEc6-VV-JvLexhqUzORcx'
                 . 'aOzi6-AYWXvTBHm4bjyPjs7Vd8pZGH6SRpkNtoIAiw4',
    ua_private  => 'q1dXpw3UpT5VOmu_cf_v6ih07Aems3njxI-JWgLcM94',
    salt        => 'DGv6ra1nlYgDCS1FRnbzlw',
    auth_secret => 'BTBZMqHH6r4Tts7J_aSIgg',
);

# RFC 8291 section 5: the complete body, base64url, line wrapping removed.
my $EXPECTED_BODY =
    'DGv6ra1nlYgDCS1FRnbzlwAAEABBBP4z9KsN6nGRTbVYI_c7VJSPQTBtkgcy27ml'
  . 'mlMoZIIgDll6e3vCYLocInmYWAmS6TlzAC8wEqKK6PBru3jl7A_yl95bQpu6cVPT'
  . 'pK4Mqgkf1CXztLVBSt2Ks3oZwbuwXPXLWyouBWLVWGNWQexSgSxsj_Qulcy4a-fN';

my $subscription = {
    endpoint => 'https://push.example.net/push/JzLQ3raZJfFBR0aqvOMsLrt54w4rJUsV',
    keys     => { p256dh => $V{ua_public}, auth => $V{auth_secret} },
};

my $body = encrypt_payload(
    'When I grow up, I want to be a watermelon',
    $subscription,
    salt      => decode_base64url($V{salt}),
    local_key => decode_base64url($V{as_private}),
);

is(encode_base64url($body), $EXPECTED_BODY,
    'RFC 8291 section 5: the encrypted body matches the published example');

# The RFC's own example prints "Content-Length: 145" above a body that is 144
# octets: 86 header + 41 plaintext + 1 delimiter + 16 tag. The body above is
# byte-identical to the RFC's, so the header line is what disagrees. Asserted
# here so nobody re-derives that from scratch.
is(length $body, 144, 'the body is 86 + 41 + 1 + 16 octets');

# ---- the record header, field by field -------------------------------------

my $header = substr $body, 0, 86;
is(substr($header, 0, 16), decode_base64url($V{salt}),
    'the header opens with the 16-byte salt');
is(unpack('N', substr($header, 16, 4)), 4096,
    'then the record size, big endian');
is(unpack('C', substr($header, 20, 1)), 65,
    'then the key id length');
is(substr($header, 21, 65), decode_base64url($V{as_public}),
    'then the sender public key');

# ---- the delimiter is 0x02, not a length prefix ----------------------------
#
# The superseded aesgcm draft prefixed the plaintext with a two-byte padding
# length. RFC 8188 appends a delimiter instead, and 0x02 marks the last record.
# Decrypt with the receiver's key to see it.

SKIP: {
    my $ua = eval {
        Crypt::PK::ECC->new->import_key_raw(decode_base64url($V{ua_private}), 'prime256v1');
    };
    skip 'could not import the RFC receiver key', 2 unless $ua;

    require Crypt::KeyDerivation;
    require Crypt::AuthEnc::GCM;

    my $as = Crypt::PK::ECC->new->import_key_raw(decode_base64url($V{as_public}), 'prime256v1');
    my $ecdh = $ua->shared_secret($as);
    my $ikm  = Crypt::KeyDerivation::hkdf($ecdh, decode_base64url($V{auth_secret}),
        'SHA256', 32,
        "WebPush: info\x00" . decode_base64url($V{ua_public}) . decode_base64url($V{as_public}));
    my $cek   = Crypt::KeyDerivation::hkdf($ikm, decode_base64url($V{salt}),
        'SHA256', 16, "Content-Encoding: aes128gcm\x00");
    my $nonce = Crypt::KeyDerivation::hkdf($ikm, decode_base64url($V{salt}),
        'SHA256', 12, "Content-Encoding: nonce\x00");

    # Copied into plain scalars first: substr passed straight into a function
    # call yields an lvalue-magic scalar, which the XS refuses with
    # "ciphertext must be string/buffer scalar".
    my $sealed = substr $body, 86;
    my $ct  = substr($sealed, 0, length($sealed) - 16);
    my $tag = substr($sealed, -16);
    my $plain = Crypt::AuthEnc::GCM::gcm_decrypt_verify(
        'AES', $cek, $nonce, '', $ct, $tag,
    );
    ok(defined $plain, 'the receiver can decrypt it with its own private key');
    is($plain, 'When I grow up, I want to be a watermelon' . "\x02",
        '  and the plaintext ends with the 0x02 delimiter');
}

# ---- a fresh send differs every time ---------------------------------------
#
# The ephemeral key and salt are per message. Two sends of the same payload to
# the same subscription must not produce the same bytes, or the relationship
# between them leaks.

{
    my $a = encrypt_payload('same', $subscription);
    my $b = encrypt_payload('same', $subscription);
    isnt($a, $b, 'two sends of one payload differ - the key and salt are fresh');
    is(length($a), length($b), '  but are the same length');
}

# ---- RFC 8292 section 2.4 --------------------------------------------------
#
# ES256 signatures are randomised, so the token this module produces cannot be
# compared against the RFC's byte for byte. What can be checked is that the
# RFC's own token verifies against the RFC's own key, and decodes to the values
# the RFC prints - which pins the claim set and the algorithm.

my $RFC_JWT =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiJ9.eyJhdWQiOiJodHRwczovL3'
  . 'B1c2guZXhhbXBsZS5uZXQiLCJleHAiOjE0NTM1MjM3NjgsInN1YiI6Im1ha'
  . 'Wx0bzpwdXNoQGV4YW1wbGUuY29tIn0.i3CYb7t4xfxCDquptFOepC9GAu_H'
  . 'LGkMlMuCGSK2rpiUfnK9ojFwDXb1JrErtmysazNjjvW2L9OkSSHzvoD1oA';

my $RFC_JWK = {
    crv => 'P-256', kty => 'EC',
    x   => 'DUfHPKLVFQzVvnCPGyfucbECzPDa7rWbXriLcysAjEc',
    y   => 'F6YK5h4SDYic-dRuU_RCPCfA5aq9ojSwk5Y2EmClBPs',
};

my $claims = eval {
    decode_jwt(token => $RFC_JWT, key => $RFC_JWK, verify_exp => 0)
};
is($@, '', 'RFC 8292 section 2.4: the published token verifies against its key')
    or diag $@;
is($claims->{aud}, 'https://push.example.net', '  aud is the push service origin');
is($claims->{exp}, 1453523768,                 '  exp is the published value');
is($claims->{sub}, 'mailto:push@example.com',  '  sub is the contact address');

# ---- and what this module generates ----------------------------------------
#
# VAPID's own suite checked only that a header was truthy, which is exactly how
# the "vapit" scheme name survived into a release. Decode it and verify it.

{
    my ($pub, $priv) = VAPID::generate_vapid_keys();
    my $exp = time + 3600;
    my $h = generate_vapid_header(
        'https://push.example.net', 'mailto:ops@example.com',
        $pub, $priv, $exp, 1,
    );

    my ($scheme, $t, $k) = $h->{Authorization}
        =~ /^(\S+)\s+t=([^,]+),\s*k=(\S+)$/;
    is($scheme, 'vapid', 'the scheme is spelled vapid, per RFC 8292 section 3');
    is($k, $pub, 'the k parameter is the signing public key');

    my $key = Crypt::PK::ECC->new->import_key_raw(decode_base64url($pub), 'prime256v1');
    my $got = eval { decode_jwt(token => $t, key => $key) };
    is($@, '', 'the token this module produced verifies with its own key') or diag $@;
    is($got->{aud}, 'https://push.example.net', '  aud is the audience it was given');
    is($got->{sub}, 'mailto:ops@example.com',   '  sub is the subject');
    is($got->{exp}, $exp,                       '  exp is the expiry it was given');
}

done_testing();
