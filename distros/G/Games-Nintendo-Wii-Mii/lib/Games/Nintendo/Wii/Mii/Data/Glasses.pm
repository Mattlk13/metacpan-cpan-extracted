package Games::Nintendo::Wii::Mii::Data::Glasses;

use strict;
use warnings;

use base qw(Class::Accessor::Fast);

use Readonly;

Readonly our @ACCESSORS => qw/
                                 glasses_type
                                 glasses_color
                                 glasses_size
                                 glasses_vertical_position
                             /;

__PACKAGE__->mk_accessors(@ACCESSORS);

=head1 NAME

Games::Nintendo::Wii::Mii::Data::Glasses - The fantastic new Games::Nintendo::Wii::Mii::Data::Glasses!

=head1 VERSION

version 0.01

=cut

our $VERSION = '0.01';

=head1 METHODS

=head2 new

=cut

sub new {
    my ($class, $args) = @_;

    $args ||= {};

    $args->{glasses_type} ||= 4;
    $args->{glasses_color} ||= 3;
    $args->{glasses_size} ||= 3;
    $args->{glasses_vertical_position} ||= 5;

    my $self = $class->SUPER::new($args);

    return $self;
}

=head2 glasses_type

=head2 glasses_color

=head2 glasses_size

=head2 glasses_vertical_postion

=head1 AUTHOR

Toru Yamaguchi, C<< <zigorou@cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-games-nintendo-wii-mii-data-glasses@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically be
notified of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2007 Toru Yamaguchi, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Games::Nintendo::Wii::Mii::Data::Glasses
