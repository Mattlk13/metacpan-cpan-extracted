#!/usr/bin/perl

use v5.14;
use warnings;

use Test2::V0;

use List::Util 1.29 qw( pairgrep );

use Net::Prometheus;

my $client = Net::Prometheus->new;

my $app = $client->psgi_app;

ok( defined $app, 'defined $client->psgi_app' );
is( ref $app, "CODE", '$app is CODE' );

ok( my $resp = $app->({ REQUEST_METHOD => "GET" }),
   '$app->() returns a response' );

is( $resp->[0], 200, '$resp->[0] is 200' );
is( ( pairgrep { $a eq "Content-Type" } @{ $resp->[1] } )[1],
   "text/plain; version=0.0.4; charset=utf-8",
   '$resp->[1] contains response headers' );
# TODO: test  join "", @{ $resp->[2] }

done_testing;
