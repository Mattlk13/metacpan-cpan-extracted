use utf8;

package SemanticWeb::Schema::WriteAction;

# ABSTRACT: The act of authoring written creative content.

use Moo;

extends qw/ SemanticWeb::Schema::CreateAction /;


use MooX::JSON_LD 'WriteAction';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v0.0.4';


has in_language => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'inLanguage',
);



has language => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'language',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::WriteAction - The act of authoring written creative content.

=head1 VERSION

version v0.0.4

=head1 DESCRIPTION

The act of authoring written creative content.

=head1 ATTRIBUTES

=head2 C<in_language>

C<inLanguage>

=for html The language of the content or performance or used in an action. Please use
one of the language codes from the <a
href="http://tools.ietf.org/html/bcp47">IETF BCP 47 standard</a>. See also
<a class="localLink"
href="http://schema.org/availableLanguage">availableLanguage</a>.

A in_language should be one of the following types:

=over

=item C<Str>

=item C<InstanceOf['SemanticWeb::Schema::Language']>

=back

=head2 C<language>

A sub property of instrument. The language used on this action.

A language should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Language']>

=back

=head1 SEE ALSO

L<SemanticWeb::Schema::CreateAction>

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
