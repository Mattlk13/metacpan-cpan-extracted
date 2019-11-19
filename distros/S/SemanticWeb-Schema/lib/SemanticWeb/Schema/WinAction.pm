use utf8;

package SemanticWeb::Schema::WinAction;

# ABSTRACT: The act of achieving victory in a competitive activity.

use Moo;

extends qw/ SemanticWeb::Schema::AchieveAction /;


use MooX::JSON_LD 'WinAction';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v5.0.1';


has loser => (
    is        => 'rw',
    predicate => '_has_loser',
    json_ld   => 'loser',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::WinAction - The act of achieving victory in a competitive activity.

=head1 VERSION

version v5.0.1

=head1 DESCRIPTION

The act of achieving victory in a competitive activity.

=head1 ATTRIBUTES

=head2 C<loser>

A sub property of participant. The loser of the action.

A loser should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Person']>

=back

=head2 C<_has_loser>

A predicate for the L</loser> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::AchieveAction>

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
