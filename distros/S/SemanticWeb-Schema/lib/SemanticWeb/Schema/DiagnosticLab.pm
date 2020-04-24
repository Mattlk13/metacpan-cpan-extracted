use utf8;

package SemanticWeb::Schema::DiagnosticLab;

# ABSTRACT: A medical laboratory that offers on-site or off-site diagnostic services.

use Moo;

extends qw/ SemanticWeb::Schema::MedicalOrganization /;


use MooX::JSON_LD 'DiagnosticLab';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v7.0.4';


has available_test => (
    is        => 'rw',
    predicate => '_has_available_test',
    json_ld   => 'availableTest',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::DiagnosticLab - A medical laboratory that offers on-site or off-site diagnostic services.

=head1 VERSION

version v7.0.4

=head1 DESCRIPTION

A medical laboratory that offers on-site or off-site diagnostic services.

=head1 ATTRIBUTES

=head2 C<available_test>

C<availableTest>

A diagnostic test or procedure offered by this lab.

A available_test should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::MedicalTest']>

=back

=head2 C<_has_available_test>

A predicate for the L</available_test> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::MedicalOrganization>

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
