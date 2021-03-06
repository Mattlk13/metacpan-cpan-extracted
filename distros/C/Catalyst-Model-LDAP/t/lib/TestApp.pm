package TestApp;

use strict;
use warnings;
use Catalyst;

our $VERSION = '0.01';

__PACKAGE__->config(
    name => 'TestApp',
    'Model::LDAP' => {
        host             => 'ldap.ufl.edu',
        base             => 'ou=People,dc=ufl,dc=edu',
        connection_class => 'TestApp::LDAP::Connection',
        entry_class      => 'TestApp::LDAP::Entry',
    },
);

__PACKAGE__->setup;

1;
