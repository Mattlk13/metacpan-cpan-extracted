use utf8;

package SemanticWeb::Schema::BusReservation;

# ABSTRACT: A reservation for bus travel

use Moo;

extends qw/ SemanticWeb::Schema::Reservation /;


use MooX::JSON_LD 'BusReservation';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v7.0.4';




1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::BusReservation - A reservation for bus travel

=head1 VERSION

version v7.0.4

=head1 DESCRIPTION

=for html <p>A reservation for bus travel. <br/><br/> Note: This type is for
information about actual reservations, e.g. in confirmation emails or HTML
pages with individual confirmations of reservations. For offers of tickets,
use <a class="localLink" href="http://schema.org/Offer">Offer</a>.<p>

=head1 SEE ALSO

L<SemanticWeb::Schema::Reservation>

=head1 SOURCE

The development version is on github at L<https://github.com/robrwo/SemanticWeb-Schema>
and may be cloned from L<git://github.com/robrwo/SemanticWeb-Schema.git>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/robrwo/SemanticWeb-Schema/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018-2020 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
