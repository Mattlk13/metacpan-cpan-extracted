#######################################################################
# $Date$
# $Revision$
# $Author$
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
    plan tests => 34;
}


my $api = WWW::Bebo::API->new( api_key => 1, secret => 1,
session_uid => '', session_key => '', session_expires => '' );
isa_ok $api, 'WWW::Bebo::API';

for ( qw/require_frame require_login/ ) {
    eval { $api->$_ };
    like $@, qr/^Can't call method "param"/, "need query for $_";
}

# Test global environment settings
{
    local %ENV = %ENV;
    @ENV{ map { "WBA_$_" } qw/API_KEY SECRET DESKTOP/} = qw/3 2 1/;

    ## no warnings 'redefine' still warns... :-(
    local %WWW::Bebo::API::;
    delete @INC{ grep { m[^WWW/Bebo/API]xms } keys %INC};
    require WWW::Bebo::API;
    
    my $api = WWW::Bebo::API->new( app_path => 'hey' );
    is $api->api_key, 3, 'WBA_API_KEY ok';
    is $api->secret, 2, 'WBA_SECRET ok';
    is $api->desktop, 1, 'WBA_DESKTOP ok';
}

# Test app-specific environment settings
{
    local %ENV = %ENV;
    @ENV{ map { "WBA_${_}_TEST_ME" } qw/API_KEY SECRET DESKTOP/} = qw/3 2 1/;
    my $api = WWW::Bebo::API->new( app_path => 'test-me' );
    is $api->api_key, 3, 'WBA_API_KEY_TEST_ME ok';
    is $api->secret, 2, 'WBA_SECRET_TEST_ME ok';
    is $api->desktop, 1, 'WBA_DESKTOP_TEST_ME ok';
}

is $api->$_, '', "$_ init ok" for qw(session_uid session_key session_expires);

my %final_session = (
    uid     => 22343,
    expires => 2343423,
    key     => 'cd324235fe34353',
);
$api->session(%final_session);
for ( keys %final_session ) {
    is eval "\$api->session_$_", $final_session{$_}, "session_$_ set ok";
}

my @escaped = ( '\"hell\nhath\nno\nfury\"' => qq("hell\nhath\nno\nfury") );
is $api->unescape_string( $escaped[0] ), $escaped[1], 'unescape_string ok';

is $api->get_bebo_url, 'http://www.bebo.com', 'get_bebo_url ok';
is $api->get_bebo_url('apps'), 'http://apps.bebo.com',
    'get_bebo_url arg ok';

is $api->_add_url_params, '?api_key=1&v=1.0', '_add_url_params ok';
is $api->_add_url_params( auth_token => 'efdb34342ef' ),
    '?api_key=1&v=1.0&auth_token=efdb34342ef', '_add_url_params arg ok';
is $api->_add_url_params( next => '" woot "' ),
    '?api_key=1&v=1.0&next=%22%20woot%20%22',
    '_add_url_params next escapes ok';

is $api->get_add_url, 'http://www.bebo.com/add.php?api_key=1&v=1.0',
    'get_add_url ok';
is $api->get_login_url, 'http://www.bebo.com/login.php?api_key=1&v=1.0',
    'get_login_url ok';

is $api->apps_uri, 'http://apps.bebo.com/', 'apps_uri ok';
is $api->app_path, '', 'app_path ok';
$api->app_path('foo');
is $api->app_path, 'foo', 'app_path set ok';
is $api->get_app_url, 'http://apps.bebo.com/foo/', 'get_app_url ok';

# test for passing undef (shouldn't reset value)
$api->app_path(undef);
is $api->app_path, 'foo', 'app_path not reset';

## sig stuff
my %sig_params = ( params => { method => 'hi' }, secret => 'cool' );
my $sig = '54b12be659505fa965d7fcee080c32ee';
is $api->generate_sig( %sig_params ), $sig, 'sig generate ok';
is $api->verify_sig( sig => $sig, %sig_params ), 1, 'sig verify 1 ok';
$api->secret(delete $sig_params{'secret'});
is $api->verify_sig( sig => $sig, %sig_params ), 1, 'sig verify 2 ok';
$api->secret('');
is $api->verify_sig( sig => $sig, %sig_params ), '', 'sig verify 3 nok';

# call method
{
    no warnings 'redefine';
    local $WWW::Bebo::API::{_post_request} = sub { q{} };
    my $args = { params => { method => 'hello', secret => 'foo' } };
    $api->call( 'hey', %$args );
    is $args->{'params'}->{'method'}, 'bebo.hello', 'call method changed';

    $args = { ids => [3,4,5,6] };
    my $ids = q{};
    $WWW::Bebo::API::{_post_request} = sub { $ids = $_[1]->{'ids'}; q{} };
    $api->call('method', %$args );
    is $ids, '3,4,5,6', 'Array refs flattened';

}

sub redirect_fh {
    my $old = select shift;
    my $new = IO::String->new;
    return ( $old, $new );
}
