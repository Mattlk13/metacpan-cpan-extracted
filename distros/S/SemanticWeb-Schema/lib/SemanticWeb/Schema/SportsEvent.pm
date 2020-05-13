use utf8;

package SemanticWeb::Schema::SportsEvent;

# ABSTRACT: Event type: Sports event.

use Moo;

extends qw/ SemanticWeb::Schema::Event /;


use MooX::JSON_LD 'SportsEvent';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v8.0.0';


has away_team => (
    is        => 'rw',
    predicate => '_has_away_team',
    json_ld   => 'awayTeam',
);



has competitor => (
    is        => 'rw',
    predicate => '_has_competitor',
    json_ld   => 'competitor',
);



has home_team => (
    is        => 'rw',
    predicate => '_has_home_team',
    json_ld   => 'homeTeam',
);



has sport => (
    is        => 'rw',
    predicate => '_has_sport',
    json_ld   => 'sport',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::SportsEvent - Event type: Sports event.

=head1 VERSION

version v8.0.0

=head1 DESCRIPTION

Event type: Sports event.

=head1 ATTRIBUTES

=head2 C<away_team>

C<awayTeam>

The away team in a sports event.

A away_team should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Person']>

=item C<InstanceOf['SemanticWeb::Schema::SportsTeam']>

=back

=head2 C<_has_away_team>

A predicate for the L</away_team> attribute.

=head2 C<competitor>

A competitor in a sports event.

A competitor should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Person']>

=item C<InstanceOf['SemanticWeb::Schema::SportsTeam']>

=back

=head2 C<_has_competitor>

A predicate for the L</competitor> attribute.

=head2 C<home_team>

C<homeTeam>

The home team in a sports event.

A home_team should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Person']>

=item C<InstanceOf['SemanticWeb::Schema::SportsTeam']>

=back

=head2 C<_has_home_team>

A predicate for the L</home_team> attribute.

=head2 C<sport>

A type of sport (e.g. Baseball).

A sport should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_sport>

A predicate for the L</sport> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::Event>

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
