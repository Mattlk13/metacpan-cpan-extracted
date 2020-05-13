use utf8;

package SemanticWeb::Schema::PathologyTest;

# ABSTRACT: A medical test performed by a laboratory that typically involves examination of a tissue sample by a pathologist.

use Moo;

extends qw/ SemanticWeb::Schema::MedicalTest /;


use MooX::JSON_LD 'PathologyTest';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v8.0.0';


has tissue_sample => (
    is        => 'rw',
    predicate => '_has_tissue_sample',
    json_ld   => 'tissueSample',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::PathologyTest - A medical test performed by a laboratory that typically involves examination of a tissue sample by a pathologist.

=head1 VERSION

version v8.0.0

=head1 DESCRIPTION

A medical test performed by a laboratory that typically involves
examination of a tissue sample by a pathologist.

=head1 ATTRIBUTES

=head2 C<tissue_sample>

C<tissueSample>

The type of tissue sample required for the test.

A tissue_sample should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_tissue_sample>

A predicate for the L</tissue_sample> attribute.

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

This software is Copyright (c) 2018-2020 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
