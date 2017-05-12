use strict;
use warnings;
package App::DubiousHTTP::Tests::Range;
use App::DubiousHTTP::Tests::Common;

SETUP(
    'range',
    "unexpected range header",
    <<'DESC',
These tests try to trick browsers into accepting partial data (and requesting rest)
by using Range headers in response, even if no range was requested.
It seems, that this does not work - but at least wget tries to automatically
resume a broken request with a partial request.
DESC

    # ---------------- Tests ----------------------------------------
    [ "VALID: all data at once" ],
    [ MUSTBE_VALID, 'full' => 'simple response code 200' ],

    [ "INVALID: range without requested" ],
    [ UNCOMMON_INVALID, 'range,full' => 'all data, but with code 206 and range header' ],
    [ INVALID, 'range',"send partial response even if full was requested" ],
    [ INVALID, 'range,incomplete',"use incomplete response to trigger partial request for rest of data" ],
);


sub make_response {
    my ($self,$page,$spec,$rqhdr) = @_;
    return make_index_page() if $page eq '';
    my ($hdr,$data) = content($page,$self->ID."-".$spec) or die "unknown page $page";
    my $version = '1.1';
    my %spec = map { $_ => 1 } split(',',$spec);
    my $resp = "";
    if ( $spec{range} ) {
	my $total = length($data);
	if ($rqhdr && $rqhdr =~m{^Range:\s*bytes=(\d+)-(\d*)}mi ) {
	    # send requested range
	    my ($start,$end) = ($1,$2);
	    $end = length($data) if $end eq '';
	    $data = substr($data,$start,$end);
	    $resp = sprintf "HTTP/$version 206 partial content\r\n".
		"Content-length: %d\r\n".
		"Accept-Ranges: bytes\r\n".
		"Content-Range: bytes %d-%d/%d\r\n",
		length($data),$start,$end-1,$total;
	} elsif ( $spec{full} ) {
	    $resp = sprintf "HTTP/$version 206 partial content\r\n".
		"Content-length: %d\r\n".
		"Accept-Ranges: bytes\r\n".
		"Content-Range: bytes 0-%d/%d\r\n",
		length($data),length($data)-1,$total;
	} elsif ( $spec{incomplete} ) {
	    $resp = "HTTP/$version 200 ok\r\n".
		"Content-length: ".length($data)."\r\n";
	    $data = substr($data,0,1);
	} else {
	    # only send first byte
	    $data = substr($data,0,1);
	    $resp = sprintf "HTTP/$version 206 partial content\r\n".
		"Content-length: %d\r\n".
		"Accept-Ranges: bytes\r\n".
		"Content-Range: bytes 0-0/%d\r\n",
		length($data),$total;
	}
	$resp .= $hdr;
    } else {
	$resp = sprintf "HTTP/$version 200 ok\r\n".
	    "Content-length: %d\r\n%s",
	    length($data),$hdr;
    }
    return $resp."\r\n".$data;
}

1;
