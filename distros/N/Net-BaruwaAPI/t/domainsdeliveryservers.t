#!/usr/bin/env perl
use warnings;
use strict;
use utf8;
use Test::More;
use FindBin '$Bin';
use lib "$Bin/lib";
use Test::Net::BaruwaAPI;

diag( "Testing Net::BaruwaAPI domain delivery server methods" );

my $do = Test::Net::BaruwaAPI->new(api_token => 'xxxxxxxasasswqefdff', api_url => 'https://baruwa.example.com');
isa_ok($do, 'Net::BaruwaAPI');

my $res;
my $page = 1;

my $data = {
    address => "192.168.1.151",
    protocol => 1,
    port => 25,
    enabled => 1,
    require_tls => 1,
    verification_only => 1,
};

my $serverid = 12;
my $domainid = 1;

set_expected_response('get_deliveryservers');

$res = $do->get_deliveryservers($domainid);

# ok($res, 'the get_deliveryservers response is defined');
is(get_last_request_method(), 'GET', 'the request method is correct');
is(get_last_request_path(), "/api/v1/deliveryservers/$domainid", 'the request uri is correct');

$res = $do->get_deliveryservers($domainid, $page);

is(get_last_request_method(), 'GET', 'the request method is correct');
is(get_last_request_path(), "/api/v1/deliveryservers/$domainid?page=$page", 'the request uri is correct');

set_expected_response('get_deliveryserver');

$res = $do->get_deliveryserver($domainid, $serverid);

# ok($res, 'the get_deliveryserver response is defined');
is(get_last_request_method(), 'GET', 'the request method is correct');
is(get_last_request_path(), "/api/v1/deliveryservers/$domainid/$serverid", 'the request uri is correct');

set_expected_response('create_deliveryserver');

$res = $do->create_deliveryserver($domainid, $data);

# ok($res, 'the create_deliveryserver response is defined');
is(get_last_request_method(), 'POST', 'the request method is correct');
is(get_last_request_path(), "/api/v1/deliveryservers/$domainid", 'the request uri is correct');

set_expected_response('update_deliveryserver');

$res = $do->update_deliveryserver($domainid, $serverid, $data);

# ok($res, 'the update_deliveryserver response is defined');
is(get_last_request_method(), 'PUT', 'the request method is correct');
is(get_last_request_path(), "/api/v1/deliveryservers/$domainid/$serverid", 'the request uri is correct');

set_expected_response('delete_deliveryserver');

$res = $do->delete_deliveryserver($domainid, $serverid, $data);

# ok($res, 'the delete_deliveryserver response is defined');
is(get_last_request_method(), 'DELETE', 'the request method is correct');
is(get_last_request_path(), "/api/v1/deliveryservers/$domainid/$serverid", 'the request uri is correct');

done_testing;
