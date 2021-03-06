use strict;
use warnings;
use Test::More;
use HTTP::Request;
use Moxy;
use File::Spec;
use FindBin;
use HTTP::Session::Store::Test;
use HTTP::Session::State::Test;

plan tests => 3;

my $c = Moxy->new(
    {
        plugins => [
            { module => 'Pictogram' },
        ]
    }
);
&check_request;
&check_response;

# -------------------------------------------------------------------------

sub check_request {
    my $response = $c->run_hook_and_get_response(
        'url_handle' => {
            request => HTTP::Request->new( 'GET', 'http://pictogram.moxy/E/EC69.gif' ),
        }
    );
    is $response->code,         200;
    is $response->content_type, 'image/gif';
}

# -------------------------------------------------------------------------

sub check_response {
    my $response= HTTP::Response->new(200);
    $response->header('Content-Type' => 'text/html');
    $response->content('&#xE001;');
    $response->request( HTTP::Request->new('GET', '/') );
    $c->run_hook(
        'response_filter' => {
            response         => $response,
            mobile_attribute => HTTP::MobileAttribute->new(
                'KDDI-KC3B UP.Browser/6.2.0.7.3.129 (GUI) MMP/2.0'),
            session => HTTP::Session->new(
                state => HTTP::Session::State::Test->new(
                    session_id => 'fkldsaaljasdfafaa',
                ),
                store   => HTTP::Session::Store::Test->new,
                request => CGI->new(),
            ),
        }
    );
    is $response->content, qq{<img src='http://pictogram.moxy/E/E001.gif' style='width:1em; height:1em; border: none;' alt="E001" />\n};
}

