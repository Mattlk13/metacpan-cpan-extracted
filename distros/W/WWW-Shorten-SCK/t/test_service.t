use strict;
use warnings;

use Carp;
use Test::More tests => 4;    # last test to print
use WWW::Shorten 'SCK';
use URI::Escape;

my $long_url  = "http://blog.celogeek.com";
my $short_url = "https://sck.pm/shO";

is( makeashorterlink($long_url), $short_url, "Shorter works" );
is( makealongerlink($short_url), $long_url,  "Longer works" );

my $url           = "http://blog.celogeek.com/?%E2%9C%93utf8";
my $long_url_utf8 = uri_unescape($url);
utf8::decode($long_url_utf8);
my $short_url_utf8 = "https://sck.pm/IWn";

is( makeashorterlink($long_url_utf8), $short_url_utf8, "Shorter works" );
is( makealongerlink($short_url_utf8), $url,            "Longer works" );

done_testing;
