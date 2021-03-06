#!/usr/bin/env perl

use Modern::Perl '2015';

use Test::More;
use Test::Exception;

BEGIN {
    require_ok('WG::API::Error') || say "WG::API::Error loaded";
}

my $error;
my %error_params = (
    field   => 'search',
    message => 'SEARCH_NOT_SPECIFIED',
    code    => 402,
    value   => 'null',
);

can_ok( 'WG::API::Error', qw/field message code value/ );

dies_ok { $error = WG::API::Error->new() } "can't create error object without params";

lives_ok { $error = WG::API::Error->new(%error_params) } "create error object with valid params";
isa_ok( $error, 'WG::API::Error' );

subtest 'error fields' => sub {
    ok( $error->field eq $error_params{'field'},     'error->field checked' );
    ok( $error->message eq $error_params{'message'}, 'error->message checked' );
    ok( $error->code eq $error_params{'code'},       'error->code checked' );
    ok( $error->value eq $error_params{'value'},     'error->value checked' );
    ok( !ref $error->raw,                            'error->raw checked' );
};

done_testing();

