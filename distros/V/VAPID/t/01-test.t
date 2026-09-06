use Test::More;
use MIME::Base64 ();
use Crypt::PK::ECC ();
use VAPID qw/all/;

ok(my ($pub, $priv) = generate_vapid_keys());

ok(validate_subject('mailto:thisusedtobeanemail@gmail.com'));
ok(validate_public_key($pub));
ok(validate_private_key($priv));
ok(validate_expiration(time + 60));

ok(my $header = generate_vapid_header(
	'https://fcm.googleapis.com',
	'mailto:thisusedtobeanemail@gmail.com',
	$pub,
	$priv,
	time + 60
));

# Test validate_subscription
my $valid_subscription = {
	endpoint => 'https://fcm.googleapis.com/fcm/send/test-endpoint',
	keys => {
		p256dh => $pub,
		auth => 'dGVzdGF1dGhrZXkxMjM0NQ'
	}
};

ok(validate_subscription($valid_subscription), 'validate_subscription with valid subscription');

# Test invalid subscriptions
eval { validate_subscription() };
ok($@ =~ /No subscription/, 'validate_subscription dies without subscription');

eval { validate_subscription('not a hash') };
ok($@ =~ /must be a hash/, 'validate_subscription dies with non-hash');

eval { validate_subscription({}) };
ok($@ =~ /must have an endpoint/, 'validate_subscription dies without endpoint');

eval { validate_subscription({ endpoint => 'https://example.com' }) };
ok($@ =~ /must have keys/, 'validate_subscription dies without keys');

eval { validate_subscription({ endpoint => 'https://example.com', keys => {} }) };
ok($@ =~ /must have a p256dh/, 'validate_subscription dies without p256dh');

eval { validate_subscription({ endpoint => 'https://example.com', keys => { p256dh => 'test' } }) };
ok($@ =~ /must have an auth/, 'validate_subscription dies without auth');

# Test encrypt_payload
my ($enc_pub, $enc_priv) = generate_vapid_keys();
my $test_subscription = {
	endpoint => 'https://fcm.googleapis.com/fcm/send/test',
	keys => {
		p256dh => $enc_pub,
		auth => 'dGVzdGF1dGhrZXkxMjM0NQ'
	}
};

ok(my $encrypted = encrypt_payload('Test message', $test_subscription), 'encrypt_payload works');
ok(!ref $encrypted, 'encrypt_payload returns the body as one string');
is(length($encrypted), 86 + length('Test message') + 1 + 16,
	'header + plaintext + delimiter + tag');
is(substr($encrypted, 16, 4), pack('N', 4096), 'the record size is in the header');
is(unpack('C', substr($encrypted, 20, 1)), 65, 'and the key id length');

# Test encrypt_payload validation
eval { encrypt_payload() };
ok($@ =~ /No payload/, 'encrypt_payload dies without payload');

# Test build_push_request
ok(my $req = build_push_request(
	subscription => $test_subscription,
	payload => 'Hello World',
	vapid_public => $pub,
	vapid_private => $priv,
	subject => 'mailto:test@example.com',
	ttl => 120
), 'build_push_request works');

isa_ok($req, 'HTTP::Request', 'build_push_request returns HTTP::Request');
is($req->method, 'POST', 'request method is POST');
ok($req->header('Authorization'), 'request has Authorization header');
ok($req->header('TTL'), 'request has TTL header');
is($req->header('TTL'), 120, 'TTL header has correct value');
# build_push_request now defaults to RFC 8291, which carries the salt and the
# sender key inside the body - so there is no Encryption: header any more, and
# an Authorization in the RFC 8292 single-header form.
is($req->header('Content-Encoding'), 'aes128gcm',
	'the default encoding is aes128gcm');
ok(!$req->header('Encryption'),
	'aes128gcm carries the salt in the body, not in a header');
ok(!$req->header('Crypto-Key'),
	'and the sender key in the body, not in a header');
ok($req->header('Authorization') =~ /^vapid t=\S+, k=\S+$/,
	'and the RFC 8292 single-header Authorization');

# aesgcm was removed in 2.00; asking for it dies rather than being ignored.
{
	local $@;
	eval { build_push_request(
		subscription => $test_subscription,
		payload => 'Hello World',
		vapid_public => $pub,
		vapid_private => $priv,
		subject => 'mailto:test@example.com',
		encoding => 'aesgcm',
	) };
	like($@, qr/Unsupported encoding 'aesgcm'/, 'encoding => aesgcm is refused');
	like($@, qr/aes128gcm only/, '  and says what is sent instead');
}

# Test build_push_request without payload
ok(my $req_no_payload = build_push_request(
	subscription => $test_subscription,
	vapid_public => $pub,
	vapid_private => $priv,
	subject => 'mailto:test@example.com'
), 'build_push_request works without payload');

is($req_no_payload->header('Content-Length'), 0, 'Content-Length is 0 without payload');

# Test enc parameter for vapid header
ok(my $enc_header = generate_vapid_header(
	'https://fcm.googleapis.com',
	'mailto:thisusedtobeanemail@gmail.com',
	$pub,
	$priv,
	time + 60,
	1
), 'generate_vapid_header with enc parameter');
# RFC 8292 section 3 names the scheme "vapid". This asserted "vapit" until
# 2.00, which is how the typo survived a release: nothing ever checked it
# against the RFC.
ok($enc_header->{Authorization} =~ /^vapid t=/, 'enc mode uses the RFC 8292 vapid scheme');
unlike($enc_header->{Authorization}, qr/^vapit/, '  and not the old typo');

# ---- the audience keeps a non-default port --------------------------------
#
# It was dropped before 2.00. No push service uses one today, which is exactly
# why that would go unnoticed until one did.

{
	require Crypt::JWT;
	my %common = (
		payload => 'x', vapid_public => $pub, vapid_private => $priv,
		subject => 'mailto:test@example.com',
	);

	my $keys = { p256dh => $test_subscription->{keys}{p256dh},
	             auth   => $test_subscription->{keys}{auth} };

	my $r = build_push_request(%common,
		subscription => { endpoint => 'https://push.example.net:8443/p/1', keys => $keys });
	my ($t) = $r->header('Authorization') =~ /t=([^,]+)/;
	my $c = Crypt::JWT::decode_jwt(token => $t, key => \$pub, ignore_signature => 1);
	is($c->{aud}, 'https://push.example.net:8443', 'a non-default port is kept in the audience');

	my $r2 = build_push_request(%common,
		subscription => { endpoint => 'https://push.example.net/p/1', keys => $keys });
	my ($t2) = $r2->header('Authorization') =~ /t=([^,]+)/;
	my $c2 = Crypt::JWT::decode_jwt(token => $t2, key => \$pub, ignore_signature => 1);
	is($c2->{aud}, 'https://push.example.net', '  and the default port is not');
}

# ---- the export list matches what exists ----------------------------------
#
# validate_expiration_key was exported and never defined until 2.00.

ok(!VAPID->can('validate_expiration_key'),
	'validate_expiration_key is gone from the export list, as it never existed');
ok(VAPID->can('validate_expiration'),
	'  and validate_expiration, which the POD documents, is there');

# ---- keys are padded with NUL, not with the character "0" -----------------

{
	my ($p2, $s2) = generate_vapid_keys();
	is(length(MIME::Base64::decode_base64url($p2)), 65, 'public key is 65 bytes');
	is(length(MIME::Base64::decode_base64url($s2)), 32, 'private key is 32 bytes');
	# a key that round-trips through import_key_raw proves the padding is not
	# 0x30 - a mispadded scalar is simply a different, wrong key
	my $k = Crypt::PK::ECC->new->import_key_raw(
		MIME::Base64::decode_base64url($s2), 'prime256v1');
	is(MIME::Base64::encode_base64url($k->export_key_raw('public')), $p2,
		'the private key derives back to its own public key');
}

done_testing();
