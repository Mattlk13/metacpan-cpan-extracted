#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::LWP::UserAgent;
use Test::Exception;
use HTTP::Response;
use Finance::Nadex;
use Finance::Nadex::Contract;
use Finance::Nadex::Order;
use Finance::Nadex::Position;

my $gooduseragent = Test::LWP::UserAgent->new;

$gooduseragent->cookie_jar( { autosave => 1, ignore_discard => 1 } );
$gooduseragent->map_response(
    qr{iDeal/v2/security/authenticate}, 
    HTTP::Response->new('200', 'OK', ['Content-Type' => 'application/json;charset=UTF-8', 'X-SECURITY-TOKEN' => 123456, 'Set-Cookie' => 'JSESSIONID=12345'], ''));

$gooduseragent->map_response(
    qr{iDeal/dma/workingorders}, 
    HTTP::Response->new('200', 'OK', ['Content-Type' => 'application/json;charset=UTF-8', 'X-SECURITY-TOKEN' => 123456, 'Set-Cookie' => 'JSESSIONID=12345'], '{ "dealReference" : "1" }'));

$gooduseragent->map_response(
    qr{iDeal/markets/navigation$}, 
    HTTP::Response->new('200', 'OK', ['Content-Type' => 'application/json;charset=UTF-8', 'X-SECURITY-TOKEN' => 123456, 'Set-Cookie' => 'JSESSIONID=12345'], '{ "hierarchy" : [ { "id": "157259", "name": "Forex (Binaries)" } ] }'));

$gooduseragent->map_response(
    qr{iDeal/markets/navigation/157259$}, 
    HTTP::Response->new('200', 'OK', ['Content-Type' => 'application/json;charset=UTF-8', 'X-SECURITY-TOKEN' => 123456, 'Set-Cookie' => 'JSESSIONID=12345'], '{ "hierarchy" : [ { "id": "157280", "name": "GBP/USD" } ] }'));

$gooduseragent->map_response(
    qr{iDeal/markets/navigation/157280$}, 
    HTTP::Response->new('200', 'OK', ['Content-Type' => 'application/json;charset=UTF-8', 'X-SECURITY-TOKEN' => 123456, 'Set-Cookie' => 'JSESSIONID=12345'], '{ "hierarchy" : [ { "id": "158963", "name": "Daily (3pm)" } ] }'));
     

my $baduseragent = Test::LWP::UserAgent->new;

$baduseragent->cookie_jar( { autosave => 1, ignore_discard => 1 } );
$baduseragent->map_response(
    qr{iDeal/v2/security/authenticate}, 
    HTTP::Response->new('200', 'OK', ['Content-Type' => 'application/json;charset=UTF-8'], ''));

BAD_LOGIN: {
   my $client = Finance::Nadex->new();
   $client->{user_agent} = $baduseragent;
   dies_ok { $client->create_order() } 'must be logged in to get a time series';
}

my $client = Finance::Nadex->new();
$client->{user_agent} = $gooduseragent;

$client->login( username => 'someusername', password => 'somepassword');

dies_ok {  $client->get_time_series() } 'must supply all required arguments to retrieve a time series';
dies_ok {  $client->get_time_series( instrument => 'GBP/USD'  ) } 'must specify a named argument "market"';
dies_ok {  $client->get_time_series(  market => 'Forex (Binaries)' ) } 'must specify a named argument "instrument"';

my @time_series;
ok (  @time_series = $client->get_time_series( instrument => 'GBP/USD', market => 'Forex (Binaries)' ), 'time series retrieved when all arguments provided');

ok ( $time_series[0] eq 'Daily (3pm)', "time series returns the name of a trading period");
done_testing();
