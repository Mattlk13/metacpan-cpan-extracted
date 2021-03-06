use Test::More;

BEGIN {
    require 't/test-psgi-lib.pm';
}

my $maintests = 10;

init(
    'Lemonldap::NG::Handler::Server',
    {
        logLevel     => 'error',
        vhostOptions => {
            'test1.example.com' => {
                vhostHttps           => 0,
                vhostPort            => 80,
                vhostMaintenance     => 0,
                vhostServiceTokenTTL => -1,
            },
        },
        exportedHeaders => {
            'test1.example.com' => {
                'Auth-User' => '$uid',
            },
        }
    }
);

# Inject an on-line access token session
Lemonldap::NG::Common::Session->new( {
        storageModule        => 'Apache::Session::File',
        storageModuleOptions => { Directory => 't/sessions' },
        id =>
          'f0fd4e85000ce35d062f97f5b466fc00abc2fad0406e03e086605f929ec4a249',
        force => 1,
        kind  => 'OIDCI',
        info  => {
            "user_session_id" => $sessionId,
            "_type"           => "access_token",
            "_utime"          => time,
            "rp"              => "rp-example2",
            "scope"           => "openid email"
        }
    }
);

# Inject an offline access token session
Lemonldap::NG::Common::Session->new( {
        storageModule        => 'Apache::Session::File',
        storageModuleOptions => { Directory => 't/sessions' },
        id                   => '999888777',
        force                => 1,
        kind                 => 'OIDCI',
        info                 => {
            "offline_session_id" => '000999000',
            "_type"              => "refresh_token",
            "_utime"             => time,
            "rp"                 => "rp-example",
            "scope"              => "openid email"
        }
    }
);

# Inject the refresh token containing user attributes
Lemonldap::NG::Common::Session->new( {
        storageModule        => 'Apache::Session::File',
        storageModuleOptions => { Directory => 't/sessions' },
        id                   => '000999000',
        force                => 1,
        kind                 => 'OIDCI',
        info                 => {
            "_type"   => "refresh_token",
            "_utime"  => time,
            "rp"      => "rp-example2",
            "scope"   => "openid email",
            'groups'  => 'users; timelords',
            'uid'     => 'dwho',
            'cn'      => 'Doctor Who',
            'hGroups' => {
                'users'     => {},
                'timelords' => {}
            },
            'ipAddr'              => '127.0.0.1',
            'mail'                => 'dwho@badwolf.org',
            'authenticationLevel' => 1,
        }
    }
);

# Request without Access Token
ok(
    $res = $client->_get(
        '/test', undef, 'test1.example.com', '', VHOSTTYPE => 'OAuth2',
    ),
    'Unauthenticated request to OAuth2 URL'
);

# Check headers
%h = @{ $res->[1] };
is( $h{'WWW-Authenticate'}, 'Bearer', 'Got WWW-Authenticate: Bearer' );

# Request with invalid Access Token
ok(
    $res = $client->_get(
        '/test',             undef,
        'test1.example.com', '',
        VHOSTTYPE          => 'OAuth2',
        HTTP_AUTHORIZATION => 'Bearer 123',
    ),
    'Invalid access token'
);

# Check headers
%h = @{ $res->[1] };
like(
    $h{'WWW-Authenticate'},
    qr#Bearer.*error="invalid_token"#,
    'Got invalid token error'
);

# Request with valid Access Token
ok(
    $res = $client->_get(
        '/test',             undef,
        'test1.example.com', '',
        VHOSTTYPE => 'OAuth2',
        HTTP_AUTHORIZATION =>
'Bearer f0fd4e85000ce35d062f97f5b466fc00abc2fad0406e03e086605f929ec4a249',
    ),
    'Invalid access token'
);

# Check headers
%h = @{ $res->[1] };
is( $res->[0], 200, "Request accepted" );
ok( $h{'Auth-User'} eq 'dwho', 'Header Auth-User is set to "dwho"' )
  or explain( \%h, 'Auth-User => "dwho"' );

# Request with Access token from offline session
ok(
    $res = $client->_get(
        '/test',             undef,
        'test1.example.com', '',
        VHOSTTYPE          => 'OAuth2',
        HTTP_AUTHORIZATION => 'Bearer 999888777',
    ),
    'Invalid access token'
);

# Check headers
%h = @{ $res->[1] };
is( $res->[0], 200, "Request accepted" );
ok( $h{'Auth-User'} eq 'dwho', 'Header Auth-User is set to "dwho"' )
  or explain( \%h, 'Auth-User => "dwho"' );

count($maintests);
done_testing( count() );
clean();
