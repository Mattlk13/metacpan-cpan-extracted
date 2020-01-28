use utf8;

package SemanticWeb::Schema::InformAction;

# ABSTRACT: The act of notifying someone of information pertinent to them

use Moo;

extends qw/ SemanticWeb::Schema::CommunicateAction /;


use MooX::JSON_LD 'InformAction';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v6.0.0';


has event => (
    is        => 'rw',
    predicate => '_has_event',
    json_ld   => 'event',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::InformAction - The act of notifying someone of information pertinent to them

=head1 VERSION

version v6.0.0

=head1 DESCRIPTION

The act of notifying someone of information pertinent to them, with no
expectation of a response.

=head1 ATTRIBUTES

=head2 C<event>

Upcoming or past event associated with this place, organization, or action.

A event should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Event']>

=back

=head2 C<_has_event>

A predicate for the L</event> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::CommunicateAction>

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
