use Perlmazing;
use URI::Escape;
our @ISA = qw(Perlmazing::Listable);

my $htmlEscapes = '\x26\x22\x3c\x3e\x60\x80\x91\x92\x93\x94\x96\x97\x99\xA0\xA1\xA2\xA3\xA5\xA7\xA9\xAB\xAE\xB1\xB4\xB5\xB6\xB7\xBB\xBF\xC0\xC1\xC2\xC3\xC4\xC5\xC6\xC7\xC8\xC9\xCA\xCB\xCC\xCD\xCE\xCF\xD1\xD2\xD3\xD4\xD5\xD6\xD8\xD9\xDA\xDB\xDC\xDF\xE0\xE1\xE2\xE3\xE4\xE5\xE6\xE7\xE8\xE9\xEA\xEB\xEC\xED\xEE\xEF\xF1\xF2\xF3\xF4\xF5\xF6\xF7\xF8\xF9\xFA\xFB\xFC\xFF';
sub main {
	$_[0] =~ s/([$htmlEscapes])/'&#'.ord($1).';'/eg if defined $_[0];
}

1;