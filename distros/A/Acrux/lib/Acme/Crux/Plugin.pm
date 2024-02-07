package Acme::Crux::Plugin;
use warnings;
use strict;
use utf8;

=encoding utf-8

=head1 NAME

Acme::Crux::Plugin - The Acme::Crux plugin base class

=head1 SYNOPSIS

    package Acme::Crux::Plugin::MyPlugin;
    use parent 'Acme::Crux::Plugin';
    sub register {
       my ($self, $app, $args) = @_;
       # ... your code here ...
    }

    # In your appliction:
    $app->plugin( myplugin => 'Acme::Crux::Plugin::MyPlugin' );

=head1 DESCRIPTION

The Acme::Crux plugin abstract base class

=head2 new

    my $plugin = Acme::Crux::Plugin->new( 'myplugin' );

=head1 METHODS

This class implements the following methods

=head2 name

    my $name = $plugin->name;

Tgis method returns name of this plugin

=head2 register

    $plugin->register( $app, $plugin_args );
    $plugin->register( $app, @$plugin_args );

This method will be called at startup time. You should overload it in your subclass

=head1 TO DO

See C<TODO> file

=head1 SEE ALSO

L<CTK::Plugin>, L<Mojolicious::Plugin>

=head1 AUTHOR

Serż Minus (Sergey Lepenkov) L<https://www.serzik.com> E<lt>abalama@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright (C) 1998-2024 D&D Corporation. All Rights Reserved

=head1 LICENSE

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

See C<LICENSE> file and L<https://dev.perl.org/licenses/>

=cut

our $VERSION = '0.01';

use Carp qw/croak/;

sub new { bless { name => $_[1] }, $_[0] }
sub name { shift->{name} }
sub register { croak 'Method "register" not implemented by subclass' }

1;

__END__
