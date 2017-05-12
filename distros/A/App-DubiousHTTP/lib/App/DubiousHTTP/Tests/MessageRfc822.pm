use strict;
use warnings;
package App::DubiousHTTP::Tests::MessageRfc822;
use App::DubiousHTTP::Tests::Common;
use Compress::Raw::Zlib;
use Compress::Zlib;
use MIME::Base64;

SETUP( 
    'messagerfc822',
    "RFC822 message transfered with HTTP",
    <<'DESC',
This test tries to transfer RFC822 encoded messages with attachments.
DESC

    # ------------------------- Tests ----------------------------------------

    # these should be fine
    [ 'VALID: plain data' ],
    [ MUSTBE_VALID, 'ok' => 'simple response with content-length'],
    [ SHOULDBE_VALID, 'ce:gzip' => 'simple response with content-length and content-encoding gzip'],

    # packed inside message/rfc822
    [ 'INVALID: packed inside message/rfc822' ],
    [ INVALID, 'rfc822' => 'content served inside message/rfc822' ],
    [ INVALID, 'cte:base64;rfc822' => 'content served with content-transfer-encoding base64 inside message/rfc822' ],
    [ INVALID, 'ce:gzip;rfc822' => 'content served inside message/rfc822, additionally content-encoding gzip' ],
);

sub make_response {
    my ($self,$page,$spec) = @_;
    return make_index_page() if $page eq '';
    my ($hdr,$data) = content($page,$self->ID."-".$spec) or die "unknown page $page";
    my $version = '1.0';
    for (split(';',$spec)) {
	if ( $_ eq 'ce:gzip' ) {
	    $hdr .= "Content-Encoding: gzip\r\n";
	    $data = Compress::Zlib::memGzip($data);
	} elsif ( $_ eq 'cte:base64' ) {
	    $hdr .= "Content-Transfer-Encoding: base64\r\n";
	    $data = encode_base64($data)."\r\n";
	} elsif ( $_ eq 'rfc822' ) {
	    $hdr .= "Content-length: ".length($data)."\r\n";
	    $data = "$hdr\r\n$data\r\n";
	    $hdr = "Content-type: message/rfc822\r\n";
	} elsif ( $_ eq 'ok') {
	} else {
	    die $_
	}
    }
    $hdr .= "Content-length: ".length($data)."\r\n";
    return "HTTP/$version 200 ok\r\n$hdr\r\n$data";
}

1;
