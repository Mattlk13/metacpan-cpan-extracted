use utf8;

package SemanticWeb::Schema::MedicalTestPanel;

# ABSTRACT: Any collection of tests commonly ordered together.

use Moo;

extends qw/ SemanticWeb::Schema::MedicalTest /;


use MooX::JSON_LD 'MedicalTestPanel';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v5.0.1';


has sub_test => (
    is        => 'rw',
    predicate => '_has_sub_test',
    json_ld   => 'subTest',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::MedicalTestPanel - Any collection of tests commonly ordered together.

=head1 VERSION

version v5.0.1

=head1 DESCRIPTION

Any collection of tests commonly ordered together.

=head1 ATTRIBUTES

=head2 C<sub_test>

C<subTest>

A component test of the panel.

A sub_test should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::MedicalTest']>

=back

=head2 C<_has_sub_test>

A predicate for the L</sub_test> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::MedicalTest>

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
