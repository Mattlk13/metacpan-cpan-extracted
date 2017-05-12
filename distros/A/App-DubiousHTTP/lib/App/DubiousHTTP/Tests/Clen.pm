use strict;
use warnings;
package App::DubiousHTTP::Tests::Clen;
use App::DubiousHTTP::Tests::Common;

SETUP(
    'clen',
    "playing with content-length",
    <<'DESC',
These tests look at the behavior if the content-length mismatches the content,
e.g. content is short or longer then specified length or contradicting 
content-lenth headers are given.
DESC

    # ------------------------ Tests -----------------------------------
    [ 'VALID: single or no content-length' ],
    [ MUSTBE_VALID, 'close,clen,content' => 'single content-length with connection close'],
    #[ VALID, 'keep-alive,clen,content' => 'single content-length with keep-alive'],
    [ MUSTBE_VALID, 'close,content' => 'no content-length with connection close'],
    [ UNCOMMON_INVALID, 'close,clen,content,junk' => 'single content-length, content followed by junk, then connection close'],
    [ UNCOMMON_INVALID, 'close,clen,clen,content,junk' => 'correct content-length twice, content followed by junk, then connection close'],

    [ 'INVALID: content-length does not match content' ],
    [ INVALID, 'close,clen200,content' => 'content-length double real content, close after real content' ],
    [ INVALID, 'close,clen50,content' => 'content-length half real content, close after real content' ],

    [ 'INVALID: multiple conflicting content-length' ],
    [ INVALID, 'close,clen50,clen,content' => 'content-length half and full' ],
    [ INVALID, 'close,clen,clen50,content' => 'content-length full and half' ],
    [ INVALID, 'close,clen200,clen,content,junk' => 'content-length double and full, content followed by junk and close' ],
    [ INVALID, 'close,clen,clen200,content,junk' => 'content-length full and double, content followed by junk and close' ],
    [ INVALID, 'close,clen-folding100,clen200,content,junk' => 'content-length full (folded) and double' ],
    [ INVALID, 'close,xte,clen50,clen,content' => 'content-length half and full, invalid Transfer-Encoding' ],
    [ INVALID, 'close,xte,clen,clen50,content' => 'content-length full and half, invalid Transfer-Encoding' ],
    [ INVALID, 'close,xte,clen200,clen,content,junk' => 'content-length double and full, invalid Transfer-Encoding' ],
    [ INVALID, 'close,xte,clen,clen200,content,junk' => 'content-length full and double, invalid Transfer-Encoding' ],
    [ INVALID, 'close,xte,clen-folding100,clen200,content,junk' => 'content-length full (folded) and double, invalid Transfer-Encoding' ],

    [ 'INVALID: content-length header containing two numbers' ],
    [ INVALID, 'close,clen50-folding100,content' => 'content-length half but full after line folding, close after real content' ],
    [ INVALID, 'close,clen50-100,content' => 'content-length half and full on same line, close after real content' ],
    [ INVALID, 'close,clen50-(100),content' => 'content-length half and full on same line, but full as MIME comment, close after real content' ],
    [ INVALID, 'close,clen100-folding50,content' => 'content-length full but half after line folding, close after real content' ],
    [ INVALID, 'close,clen100-50,content' => 'content-length full and half on same line, close after real content' ],
    [ INVALID, 'close,clen(100)-50,content' => 'content-length full and half on same line, but full as MIME comment, close after real content' ],
    [ INVALID, 'close,clen100-folding200,content,junk' => 'content-length full but double after line folding, close after real content+junk' ],
    [ INVALID, 'close,clen100-(200),content,junk' => 'content-length full and double on same line, but double as MIME comment, close after real content+junk' ],
    [ INVALID, 'close,clen200-folding100,content,junk' => 'content-length double but full after line folding, close after real content+junk' ],
    [ INVALID, 'close,clen(200)-100,content,junk' => 'content-length double and full on same line, but double as MIME comment, close after real content+junk' ],

    [ INVALID, 'close,\073(clen),content,junk' => '"Content-length: ;len", body content+junk' ],
    [ INVALID, 'close,(clen)\073,content,junk' => '"Content-length: len;", body content+junk' ],
    [ INVALID, 'close,\054(clen),content,junk' => '"Content-length: ,len", body content+junk' ],
    [ INVALID, 'close,(clen)\054,content,junk' => '"Content-length: len,", body content+junk' ],
    [ INVALID, 'close,(clen)\054(clen),content,junk' => '"Content-length: len,len", body content+junk' ],
    [ INVALID, 'close,\042(clen)\042,content,junk' => "'Content-length: \"len\"', body content+junk" ],
    [ INVALID, 'close,(clen)A,content,junk' => '"Content-length: lenA", body content+junk' ],
    [ INVALID, 'close,A(clen),content,junk' => '"Content-length: Alen", body content+junk' ],
    [ INVALID, 'close,(clen)\040A,content,junk' => '"Content-length: len A", body content+junk' ],
    [ INVALID, 'close,A\040(clen),content,junk' => '"Content-length: A len", body content+junk' ],
    [ INVALID, 'close,\240(clen),content,junk' => '"Content-length: \240len", body content+junk' ],
    [ INVALID, 'close,(clen)\240,content,junk' => '"Content-length: len\240", body content+junk' ],
    [ INVALID, 'close,(clen).0,content,junk' => '"Content-length: len.0", body content+junk' ],
    [ INVALID, 'close,(clen).9,content,junk' => '"Content-length: len.9", body content+junk' ],
);


sub make_response {
    my ($self,$page,$spec) = @_;
    return make_index_page() if $page eq '';
    my ($hdr,$data) = content($page,$self->ID."-".$spec) or die "unknown page $page";
    my $version = '1.1';
    my $body;
    my $te;
    for (split(',',$spec)) {
	if ( ! $_ || $_ eq 'close' ) {
	    $hdr .= "Connection: close\r\n";
	} elsif ( s{^clen(\(?)(\d*)(\)?)}{} ) {
	    $hdr .= "Content-length: ";
	    $hdr .= $1;
	    $hdr .= int((($2||100)/100)*length($data)) if $2 || $_ eq '';
	    $hdr .= $3;
	    while (s{^-(folding)?(\(?)(\d+)(\)?)}{}) {
		$hdr .= "\r\n" if $1;
		$hdr .= $2;
		$hdr .= " ".int(($3/100)*length($data));
		$hdr .= $4;
	    }
	    $hdr .= "\r\n";
	} elsif ( m{\(clen\)}) {
	    s{\\([0-7]{3})}{ chr(oct($1)) }esg;
	    s{\(clen\)}{ length($data) }esg;
	    $hdr .= "Content-length: $_\r\n";
	    $body = $data;
	} elsif ( $_ eq 'content' ) {
	    $body = $data;
	} elsif ( $_ eq 'junk' ) {
	    $body .= 'X' x length($data);
	} elsif ( $_ eq 'xte' ) {
	    $hdr .= "Transfer-Encoding: lalala\r\n";
	} else {
	    die $_
	}
    }
    $hdr = "HTTP/$version 200 ok\r\n$hdr";
    return "$hdr\r\n$body";
}


1;
