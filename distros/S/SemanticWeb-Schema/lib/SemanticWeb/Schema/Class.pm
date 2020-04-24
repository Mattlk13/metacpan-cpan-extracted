use utf8;

package SemanticWeb::Schema::Class;

# ABSTRACT: A class

use Moo;

extends qw/ SemanticWeb::Schema::Intangible /;


use MooX::JSON_LD 'Class';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v7.0.4';


has superseded_by => (
    is        => 'rw',
    predicate => '_has_superseded_by',
    json_ld   => 'supersededBy',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::Class - A class

=head1 VERSION

version v7.0.4

=head1 DESCRIPTION

A class, also often called a 'Type'; equivalent to rdfs:Class.

=head1 ATTRIBUTES

=head2 C<superseded_by>

C<supersededBy>

Relates a term (i.e. a property, class or enumeration) to one that
supersedes it.

A superseded_by should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Class']>

=item C<InstanceOf['SemanticWeb::Schema::Enumeration']>

=item C<InstanceOf['SemanticWeb::Schema::Property']>

=back

=head2 C<_has_superseded_by>

A predicate for the L</superseded_by> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::Intangible>

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
