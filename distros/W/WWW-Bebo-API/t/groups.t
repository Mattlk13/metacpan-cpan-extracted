#######################################################################
# $Date: 2007-06-28 13:05:21 -0700 (Thu, 28 Jun 2007) $
# $Revision: 120 $
# $Author: david.romano $
# ex: set ts=8 sw=4 et
#########################################################################
use Test::More;
use WWW::Bebo::API;
use strict;
use warnings;

BEGIN {
    if ( 3 != grep defined,
        @ENV{qw/WBA_API_KEY_TEST WBA_SECRET_TEST WBA_SESSION_KEY_TEST/} )
    {
        plan skip_all => 'Live tests require API key, secret, and session';
    }
    plan tests => 2;
}

my $api = WWW::Bebo::API->new( app_path => 'test' );

my $groups = $api->groups->get;
is ref $groups, 'ARRAY', 'get returns array ref';

SKIP: {
    skip 'No groups to get members from' => 1 unless $groups->[0]->{'gid'};
    is keys %{$api->groups->get_members(gid => $groups->[0]->{'gid'})}, 4,
    'four lists, as per API';
}
