# ABSTRACT: Helper for 'hid publish -A'


package HiD::Server::Handler;
our $AUTHORITY = 'cpan:GENEHACK';
$HiD::Server::Handler::VERSION = '1.991';
use 5.014;  # strict, unicode_strings
use warnings;

use parent 'Plack::Handler::Standalone';


sub new {
  my( $class , %args ) = @_;

  my $hid = delete $args{hid};

  die "I must be passed something that can('publish') not a '$hid'!\n"
    unless defined $hid and $hid->can('publish');

  my $self = $class->SUPER::new(%args);

  $self->{__hid__} = $hid;

  return $self;

}


sub republish {
  my $self = shift;

  my $hid = $self->{__hid__};

  $hid->reset_hid();

  # FIXME eeeeevvvviillll
  $hid->config();  # force builder to fire
  $hid->{hid}{config}{clean_destination} = 1; # get up in them guts

  $hid->publish();
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

HiD::Server::Handler - Helper for 'hid publish -A'

=head1 METHODS

=head2 new

Constructor.

=head2 republish

Handles resetting the embedded L<HiD> object and calling the C<publish> method
on it.

=head1

Helper for C<hid publish -A>

=head1 VERSION

version 1.991

=head1 AUTHOR

John SJ Anderson <genehack@genehack.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by John SJ Anderson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
