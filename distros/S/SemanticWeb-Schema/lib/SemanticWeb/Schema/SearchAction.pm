use utf8;

package SemanticWeb::Schema::SearchAction;

# ABSTRACT: The act of searching for an object

use Moo;

extends qw/ SemanticWeb::Schema::Action /;


use MooX::JSON_LD 'SearchAction';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v9.0.0';


has query => (
    is        => 'rw',
    predicate => '_has_query',
    json_ld   => 'query',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::SearchAction - The act of searching for an object

=head1 VERSION

version v9.0.0

=head1 DESCRIPTION

=for html <p>The act of searching for an object.<br/><br/> Related actions:<br/><br/>
<ul> <li><a class="localLink"
href="http://schema.org/FindAction">FindAction</a>: SearchAction generally
leads to a FindAction, but not necessarily.</li> </ul> <p>

=head1 ATTRIBUTES

=head2 C<query>

A sub property of instrument. The query used on this action.

A query should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_query>

A predicate for the L</query> attribute.

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
