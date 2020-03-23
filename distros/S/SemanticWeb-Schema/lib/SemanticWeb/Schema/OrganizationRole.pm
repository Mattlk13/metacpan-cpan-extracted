use utf8;

package SemanticWeb::Schema::OrganizationRole;

# ABSTRACT: A subclass of Role used to describe roles within organizations.

use Moo;

extends qw/ SemanticWeb::Schema::Role /;


use MooX::JSON_LD 'OrganizationRole';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v7.0.0';


has numbered_position => (
    is        => 'rw',
    predicate => '_has_numbered_position',
    json_ld   => 'numberedPosition',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::OrganizationRole - A subclass of Role used to describe roles within organizations.

=head1 VERSION

version v7.0.0

=head1 DESCRIPTION

A subclass of Role used to describe roles within organizations.

=head1 ATTRIBUTES

=head2 C<numbered_position>

C<numberedPosition>

A number associated with a role in an organization, for example, the number
on an athlete's jersey.

A numbered_position should be one of the following types:

=over

=item C<Num>

=back

=head2 C<_has_numbered_position>

A predicate for the L</numbered_position> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::Role>

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
