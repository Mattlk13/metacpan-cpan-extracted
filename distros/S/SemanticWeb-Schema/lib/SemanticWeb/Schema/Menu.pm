use utf8;

package SemanticWeb::Schema::Menu;

# ABSTRACT: A structured representation of food or drink items available from a FoodEstablishment.

use Moo;

extends qw/ SemanticWeb::Schema::CreativeWork /;


use MooX::JSON_LD 'Menu';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v7.0.4';


has has_menu_item => (
    is        => 'rw',
    predicate => '_has_has_menu_item',
    json_ld   => 'hasMenuItem',
);



has has_menu_section => (
    is        => 'rw',
    predicate => '_has_has_menu_section',
    json_ld   => 'hasMenuSection',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::Menu - A structured representation of food or drink items available from a FoodEstablishment.

=head1 VERSION

version v7.0.4

=head1 DESCRIPTION

A structured representation of food or drink items available from a
FoodEstablishment.

=head1 ATTRIBUTES

=head2 C<has_menu_item>

C<hasMenuItem>

A food or drink item contained in a menu or menu section.

A has_menu_item should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::MenuItem']>

=back

=head2 C<_has_has_menu_item>

A predicate for the L</has_menu_item> attribute.

=head2 C<has_menu_section>

C<hasMenuSection>

A subgrouping of the menu (by dishes, course, serving time period, etc.).

A has_menu_section should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::MenuSection']>

=back

=head2 C<_has_has_menu_section>

A predicate for the L</has_menu_section> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::CreativeWork>

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
