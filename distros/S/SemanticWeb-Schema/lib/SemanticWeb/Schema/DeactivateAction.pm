use utf8;

package SemanticWeb::Schema::DeactivateAction;

# ABSTRACT: The act of stopping or deactivating a device or application (e

use Moo;

extends qw/ SemanticWeb::Schema::ControlAction /;


use MooX::JSON_LD 'DeactivateAction';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v3.9.0';




1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::DeactivateAction - The act of stopping or deactivating a device or application (e

=head1 VERSION

version v3.9.0

=head1 DESCRIPTION

The act of stopping or deactivating a device or application (e.g. stopping
a timer or turning off a flashlight).

=head1 SEE ALSO

L<SemanticWeb::Schema::ControlAction>

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
