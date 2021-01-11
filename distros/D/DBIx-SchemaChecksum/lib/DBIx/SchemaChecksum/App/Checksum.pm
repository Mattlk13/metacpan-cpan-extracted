package DBIx::SchemaChecksum::App::Checksum;

# ABSTRACT: get the current DB checksum
our $VERSION = '1.103'; # VERSION

use 5.010;

use MooseX::App::Command;
extends qw(DBIx::SchemaChecksum::App);

option 'show_dump' => (
    is            => 'ro',
    isa           => 'Bool',
    documentation => q[Show the raw database dump structure],
    default       => 0,
);

sub run {
    my $self = shift;

    say $self->checksum;
    say $self->_schemadump if $self->show_dump;
}

__PACKAGE__->meta->make_immutable();
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

DBIx::SchemaChecksum::App::Checksum - get the current DB checksum

=head1 VERSION

version 1.103

=head1 DESCRIPTION

Calculate the current checksum and report it. Use C<--show_dump> to
show the string dump on which the checksum is based.

=head1 AUTHORS

=over 4

=item *

Thomas Klausner <domm@plix.at>

=item *

Maroš Kollár <maros@cpan.org>

=item *

Klaus Ita <koki@worstofall.com>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 - 2021 by Thomas Klausner, Maroš Kollár, Klaus Ita.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
