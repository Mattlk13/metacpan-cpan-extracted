# ABSTRACT: Dancer::Plugin::Auth::RBAC authentication via MySQL!

package Dancer::Plugin::Auth::RBAC::Credentials::MySQL;
BEGIN {
  $Dancer::Plugin::Auth::RBAC::Credentials::MySQL::VERSION = '1.110720';
}

use strict;
use warnings;
use base qw/Dancer::Plugin::Auth::RBAC::Credentials/;
use Dancer::Plugin::Database;


sub authorize {
    
    my ($self, $options, @arguments) = @_;
    my ($login, $password) = @arguments;
    
    my $settings = $Dancer::Plugin::Auth::RBAC::settings;
    
    if ($login) {
    
    # authorize a new account using supplied credentials
        
        unless ($password) {
            $self->errors('login and password are required');
            return 0;
        }
        
        my $sth = database($options->{handle})->prepare(
            'SELECT * FROM `users` WHERE login = ? AND password = ?',
        );  $sth->execute($login, $password) if $sth;
        
        my $accounts = $sth->fetchrow_hashref;
    
        if (defined $accounts) {
            
            my $session_data = {
                id    => $accounts->{id},
                name  => $accounts->{name},
                login => $accounts->{login},
                roles => [
                    map { $_ =~ s/^\s+|\s+$//; $_  }
                    split /\,/, $accounts->{roles}
                ],
                error => []
            };
            return $self->credentials($session_data);
            
        }
        else {
            $self->errors('login and/or password is invalid');
            return 0;
        }
    
    }
    else {
        
    # check if current user session is authorized
        
        my $user = $self->credentials;
        if (($user->{id} || $user->{login}) && !@{$user->{error}}) {
            
            return $user;
            
        }
        else {
            $self->errors('you are not authorized', 'your session may have ended');
            return 0;
        }
        
    }
    
}

1;

__END__
=pod

=head1 NAME

Dancer::Plugin::Auth::RBAC::Credentials::MySQL - Dancer::Plugin::Auth::RBAC authentication via MySQL!

=head1 VERSION

version 1.110720

=head1 SYNOPSIS

    # in your app code
    my $auth = auth($login, $password);
    if ($auth) {
        # login successful
    }
    
    # use your own encryption (if the user account password is encrypted)
    my $auth = auth($login, encrypt($password));
    if ($auth) {
        # login successful
    }

=head1 DESCRIPTION

Dancer::Plugin::Auth::RBAC::Credentials::MySQL uses your MySQL database connection 
as the application's user management system.

=head1 METHODS

=head2 authorize

The authorize method (found in every authentication class) validates a user against
the defined datastore using the supplied arguments and configuration file options.

=head1 CONFIGURATION

    plugins:
      Database:
        driver: 'mysql'
        database: 'test'
        username: 'root'
        password: '****'
      Auth::RBAC:
        credentials:
          class: MySQL

Sometime you might define multiple connections for the Database plugin, make
sure you tell the Auth::RBAC plugin about it... e.g.

    plugins:
      Database:
        foo:
          driver: 'sqlite'
          database: 'example1.db'
        bar:
          driver: 'mysql'
          database: 'test'
          username: 'root'
          password: '****'
      Auth::RBAC:
        credentials:
          class: MySQL
          options:
            handle: bar

Please see L<Dancer::Plugin::Database> for a list of all available connection
options and arguments.

=head1 DATABASE SETUP

    # users table (feel free to add more columns as you see fit)
    
    CREATE TABLE `users` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) DEFAULT NULL,
    `login` varchar(255) NOT NULL,
    `password` mediumtext NOT NULL,
    `roles` mediumtext,
    PRIMARY KEY (`id`)
    ) ENGINE=MyISAM DEFAULT CHARSET=latin1
    
    # create an initial adminstrative user (should probably encrypt the password)
    # Note! this module is not responsible for creating user accounts, it simply
    # provides a consistant authentication framework
    
    INSERT INTO `users` (name, login, password, roles)
    VALUES ('Administrator', 'admin', '*****', 'guest, user, admin');

=head1 AUTHOR

  Al Newkirk <awncorp@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by awncorp.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

