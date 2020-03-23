use utf8;

package SemanticWeb::Schema::TransferAction;

# ABSTRACT: The act of transferring/moving (abstract or concrete) animate or inanimate objects from one place to another.

use Moo;

extends qw/ SemanticWeb::Schema::Action /;


use MooX::JSON_LD 'TransferAction';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v7.0.0';


has from_location => (
    is        => 'rw',
    predicate => '_has_from_location',
    json_ld   => 'fromLocation',
);



has to_location => (
    is        => 'rw',
    predicate => '_has_to_location',
    json_ld   => 'toLocation',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::TransferAction - The act of transferring/moving (abstract or concrete) animate or inanimate objects from one place to another.

=head1 VERSION

version v7.0.0

=head1 DESCRIPTION

The act of transferring/moving (abstract or concrete) animate or inanimate
objects from one place to another.

=head1 ATTRIBUTES

=head2 C<from_location>

C<fromLocation>

A sub property of location. The original location of the object or the
agent before the action.

A from_location should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Place']>

=back

=head2 C<_has_from_location>

A predicate for the L</from_location> attribute.

=head2 C<to_location>

C<toLocation>

A sub property of location. The final location of the object or the agent
after the action.

A to_location should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Place']>

=back

=head2 C<_has_to_location>

A predicate for the L</to_location> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::Action>

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
