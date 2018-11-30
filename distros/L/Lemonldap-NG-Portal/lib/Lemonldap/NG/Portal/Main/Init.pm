##@class Lemonldap::NG::Portal::Main::Init
# Initialization part of Lemonldap::NG portal
#
# 2 public methods:
#  - init():       launch at startup. Load 'portal' section of lemonldap-ng.ini,
#                  initialize default route and launch reloadConf()
#  - reloadConf(): (re)load configuration using localConf (ie 'portal' section
#                  of lemonldap-ng.ini) and underlying handler configuration
package Lemonldap::NG::Portal::Main::Init;

our $VERSION = '2.0.0';

package Lemonldap::NG::Portal::Main;

use strict;
use Mouse;
use Regexp::Assemble;

# PROPERTIES

# Configuration storage
has localConfig => ( is => 'rw', default => sub { {} } );
has conf        => ( is => 'rw', default => sub { {} } );
has menu        => ( is => 'rw', default => sub { {} } );
has trOver      => ( is => 'rw', default => sub { { all => {} } } );

# Sub modules
has _authentication => ( is => 'rw' );
has _userDB         => ( is => 'rw' );
has _passwordDB     => ( is => 'rw' );
has _sfEngine       => ( is => 'rw' );

has loadedModules => ( is => 'rw' );

# Macros and groups
has _macros     => ( is => 'rw' );
has _groups     => ( is => 'rw' );
has _jsRedirect => ( is => 'rw' );

# TrustedDomain regexp
has trustedDomainsRe => ( is => 'rw' );

# Lists to store plugins entry-points
my @entryPoints;

BEGIN {
    @entryPoints = (

        # Auth process entrypoints
        qw(beforeAuth betweenAuthAndData afterData endAuth),

        # Authenticated users entrypoint
        'forAuthUser',

        # Logout entrypoint
        'beforeLogout',

        # Special endpoint
        'authCancel',    # Clean pdata when user click on "cancel"
    );

    foreach (@entryPoints) {
        has $_ => (
            is      => 'rw',
            isa     => 'ArrayRef',
            default => sub { [] }
        );
    }
}

has spRules => (
    is      => 'rw',
    default => sub { {} }
);

# Custom template parameters
has customParameters => ( is => 'rw', default => sub { {} } );

# Content-Security-Policy header
has csp => ( is => 'rw' );

# INITIALIZATION

sub init {
    my ( $self, $args ) = @_;
    $args ||= {};
    $self->localConfig(
        {
            %{ Lemonldap::NG::Common::Conf->new( $args->{configStorage} )
                  ->getLocalConf('portal')
            },
            %$args
        }
    );
    foreach my $k ( keys %{ $self->localConfig } ) {
        if ( $k =~ /tpl_(.*)/ ) {
            $self->customParameters->{$1} = $self->localConfig->{$k};
        }
        elsif ( $k =~ /error_(?:(\w+?)_)?(\d+)$/ ) {
            my $lang = $1 || 'all';
            $self->trOver->{$lang}->{"PE$2"} = $self->localConfig->{$k};
        }
        elsif ( $k =~ /msg_(?:(\w+?)_)?(\w+)$/ ) {
            my $lang = $1 || 'all';
            $self->trOver->{$lang}->{$2} = $self->localConfig->{$k};
        }
    }
    $self->trOver( JSON::to_json( $self->trOver ) );

    # Purge loaded module list
    $self->loadedModules( {} );

    # Insert `reloadConf` in handler reload stack
    Lemonldap::NG::Handler::Main->onReload( $self, 'reloadConf' );

    # Handler::PSGI::Try initialization
    return 0 unless ( $self->SUPER::init( $self->localConfig ) );
    return 0 if ( $self->error );

    # Handle requests (other path may be declared in enabled plugins)
    $self

      # "/" or undeclared paths
      ->addUnauthRoute( '*' => 'login',     ['GET'] )
      ->addUnauthRoute( '*' => 'postLogin', ['POST'] )
      ->addAuthRoute( '*' => 'authenticatedRequest',     ['GET'] )
      ->addAuthRoute( '*' => 'postAuthenticatedRequest', ['POST'] )

      # psgi.js
      ->addUnauthRoute( 'psgi.js' => 'sendJs', ['GET'] )
      ->addAuthRoute( 'psgi.js' => 'sendJs', ['GET'] )

      # portal.css
      ->addUnauthRoute( 'portal.css' => 'sendCss', ['GET'] )
      ->addAuthRoute( 'portal.css' => 'sendCss', ['GET'] )

      # lmerror
      ->addUnauthRoute( lmerror => { ':code' => 'lmError' }, ['GET'] )
      ->addAuthRoute( lmerror => { ':code' => 'lmError' }, ['GET'] )

      # Core REST API
      ->addUnauthRoute( ping => 'pleaseAuth', ['GET'] )
      ->addAuthRoute( ping => 'authenticated', ['GET'] )

      # Refresh session
      ->addAuthRoute( refresh => 'refresh', ['GET'] )

      # Logout
      ->addAuthRoute( logout => 'logout', ['GET'] );

    # Default routes must point to routines declared above
    $self->defaultAuthRoute('');
    $self->defaultUnauthRoute('');
    return 1;
}

sub reloadConf {
    my ( $self, $conf ) = @_;

    # Reinitialize $self->conf
    %{ $self->{conf} } = %{ $self->localConfig };

    # Reinitialize arrays
    foreach ( qw(_macros _groups), @entryPoints ) {
        $self->{$_} = [];
    }
    $self->spRules( {} );

    # Load conf in portal object
    foreach my $key ( keys %$conf ) {
        $self->{conf}->{$key} ||= $conf->{$key};
    }

    # Initialize content-security-policy header
    my $csp = '';
    foreach (qw(default img src style font connect)) {
        my $prm = $self->conf->{ 'csp' . ucfirst($_) };
        $csp .= "$_-src $prm;" if ($prm);
    }
    $self->csp($csp);

    # Initialize templateDir
    $self->{templateDir} =
      $self->conf->{templateDir} . '/' . $self->conf->{portalSkin};
    unless ( -d $self->{templateDir} ) {
        $self->error("Template dir $self->{templateDir} doesn't exist");
        return $self->fail;
    }

    $self->{staticPrefix} = $self->conf->{staticPrefix} || '/static';
    $self->{languages}    = $self->conf->{languages}    || '/';

    # Initialize session DBs
    unless ( $self->conf->{globalStorage} ) {
        $self->error(
            'globalStorage not defined (perhaps configuration can not be read)'
        );
        return $self->fail;
    }

    # Initialize persistent session DB
    unless ( $self->conf->{persistentStorage} ) {
        $self->conf->{persistentStorage} = $self->conf->{globalStorage};
        $self->conf->{persistentStorageOptions} =
          $self->conf->{globalStorageOptions};
    }

    # Initialize cookie domain
    unless ( $self->conf->{domain} ) {
        $self->error('Configuration error: no domain');
        return $self->fail;
    }
    $self->conf->{domain} =~ s/^([^\.])/.$1/;

    # Load menu
    # ---------
    $self->menu( $self->loadPlugin('::Main::Menu') );
    $self->displayInit;

    # Load authentication/userDB
    # --------------------------
    my $mod;
    for my $type (qw(authentication userDB)) {
        unless ( $self->conf->{$type} ) {
            $self->error("$type is not set");
            return $self->fail;
        }
        $mod = $self->conf->{$type}
          unless ( $self->conf->{$type} eq 'Same' );
        my $module = '::' . ucfirst($type) . '::' . $mod;
        $module =~ s/Authentication/Auth/;

        # Launch and initialize module
        return $self->fail
          unless ( $self->{"_$type"} = $self->loadPlugin($module) );
    }

    # Load second-factor engine
    return $self->fail
      unless $self->{_sfEngine} =
      $self->loadPlugin( $self->conf->{'sfEngine'} );

    # Initialize trusted domain regexp
    if (    $self->conf->{trustedDomains}
        and $self->conf->{trustedDomains} =~ /^\s*\*\s*$/ )
    {
        $self->trustedDomainsRe(qr#^https?://#);
    }
    else {
        my $re = Regexp::Assemble->new();
        if ( my $td = $self->conf->{trustedDomains} ) {
            $td =~ s/^\s*(.*?)\s*/$1/;
            foreach ( split( /\s+/, $td ) ) {
                next unless ($td);
                s#^\.#([^/]+\.)?#;
                $self->logger->debug("Domain $_ added in trusted domains");
                s/\./\\./g;

                # This regexp is valid for the followings hosts:
                #  - $td
                #  - $domainlabel.$td
                # $domainlabel is build looking RFC2396
                # (see Regexp::Common::URI::RFC2396)
                $_ =~
                  s/\*\\\./(?:(?:[a-zA-Z0-9][-a-zA-Z0-9]*)?[a-zA-Z0-9]\\.)*/g;
                $re->add("$_");
            }
        }
        my $p = $self->conf->{portal};
        $p =~ s#https?://([^/]*).*$#$1#;
        $re->add( quotemeta($p) );
        foreach my $vhost ( keys %{ $self->conf->{locationRules} } ) {
            $self->logger->debug("Vhost $vhost added in trusted domains");
            $re->add( quotemeta($vhost) );
            $self->conf->{vhostOptions} ||= {};
            if ( my $tmp =
                $self->conf->{vhostOptions}->{$vhost}->{vhostAliases} )
            {
                foreach my $alias ( split /\s+/, $tmp ) {
                    $self->logger->debug(
                        "Alias $alias added in trusted domains");
                    $re->add( quotemeta($alias) );
                }
            }
        }
        my $tmp = 'https?://' . $re->as_string . '(?::\d+)?(?:/|$)';
        $self->trustedDomainsRe(qr/$tmp/);
    }

    # Compile macros in _macros, groups in _groups
    foreach my $type (qw(macros groups)) {
        $self->{"_$type"} = {};
        if ( $self->conf->{$type} ) {
            for my $name ( sort keys %{ $self->conf->{$type} } ) {
                my $sub =
                  HANDLER->buildSub(
                    HANDLER->substitute( $self->conf->{$type}->{$name} ) );
                if ($sub) {
                    $self->{"_$type"}->{$name} = $sub;
                }
                else {
                    $self->logger->error( "$type $name returns an error: "
                          . HANDLER->tsv->{jail}->error );
                }
            }
        }
    }
    $self->{_jsRedirect} =
      HANDLER->buildSub( HANDLER->substitute( $self->conf->{jsRedirect} ) )
      or $self->logger->error(
        'jsRedirect returns an error: ' . HANDLER->tsv->{jail}->error );

    # Load plugins
    foreach my $plugin ( $self->enabledPlugins ) {
        $self->loadPlugin($plugin) or return $self->fail;
    }

    # Clean $req->pdata after authentication
    push @{ $self->endAuth }, sub {
        unless ( $_[0]->pdata->{keepPdata} ) {
            $self->logger->debug('Cleaning pdata');
            $_[0]->pdata( {} );
        }
        return PE_OK;
    };
    unshift @{ $self->beforeAuth }, sub {
        if ( $_[0]->param('cancel') ) {
            $self->logger->debug('Cancel called, push authCancel calls');
            unshift @{ $_[0]->steps }, @{ $self->authCancel };
            return PE_OK;
        }
    };

    1;
}

# Method used to load plugins
sub loadPlugin {
    my ( $self, $plugin ) = @_;
    unless ($plugin) {
        require Carp;
        Carp::confess('Calling loadPugin without arg !');
    }
    my $obj;
    return 0
      unless ( $obj = $self->loadModule("$plugin") );
    return $self->findEP( $plugin, $obj );
}

# Insert declared entry points into corresponding arrays
sub findEP {
    my ( $self, $plugin, $obj ) = @_;

    # Standards entry points
    foreach my $sub (@entryPoints) {
        if ( $obj->can($sub) ) {
            $self->logger->debug(" Found $sub entry point:");
            if ( my $callback = $obj->$sub ) {
                push @{ $self->{$sub} }, sub {
                    eval {
                        $obj->logger->debug("Launching ${plugin}::$callback");
                    };
                    $obj->$callback( $_[0] );
                };
                $self->logger->debug("  -> $callback");
            }
        }
    }
    $self->logger->debug("Plugin $plugin initializated");

    # Rules for menu
    if ( $obj->can('spRules') ) {
        foreach my $k ( keys %{ $obj->{spRules} } ) {
            $self->logger->info(
"$k is defined more than one time, it can have some bad effect on Menu display"
            ) if ( $self->spRules->{$k} );
            $self->spRules->{$k} = $obj->{spRules}->{$k};
        }
    }
    return $obj;
}

sub loadModule {
    my ( $self, $module, $conf, %args ) = @_;
    $conf //= $self->conf;
    my $obj;
    $module = "Lemonldap::NG::Portal$module" if ( $module =~ /^::/ );

    eval "require $module";
    if ($@) {
        $self->logger->error("$module load error: $@");
        return 0;
    }
    eval {
        $obj = $module->new( { p => $self, conf => $conf, %args } );
        $self->logger->debug("Module $module loaded");
    };
    if ($@) {
        $self->error("Unable to build $module object: $@");
        return 0;
    }
    ( $obj and $obj->init ) or return 0;
    $self->loadedModules->{$module} = $obj;
    return $obj;
}

sub fail {
    $_[0]->userLogger->error( $_[0]->error );
    $_[0]->addUnauthRoute( '*' => 'displayError' );
    $_[0]->addAuthRoute( '*' => 'displayError' );
    return 0;
}

sub displayError {
    my ( $self, $req ) = @_;
    return $self->sendError( $req,
        'Portal error, contact your administrator', 500 );
}

1;
