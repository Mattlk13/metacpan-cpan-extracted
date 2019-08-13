use utf8;

package SemanticWeb::Schema::TrainReservation;

# ABSTRACT: A reservation for train travel

use Moo;

extends qw/ SemanticWeb::Schema::Reservation /;


use MooX::JSON_LD 'TrainReservation';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v3.9.0';




1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::TrainReservation - A reservation for train travel

=head1 VERSION

version v3.9.0

=head1 DESCRIPTION

=for html A reservation for train travel.<br/><br/> Note: This type is for
information about actual reservations, e.g. in confirmation emails or HTML
pages with individual confirmations of reservations. For offers of tickets,
use <a class="localLink" href="http://schema.org/Offer">Offer</a>.

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

This software is Copyright (c) 2018-2019 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
