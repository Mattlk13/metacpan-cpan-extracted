use utf8;

package SemanticWeb::Schema::SpeakableSpecification;

# ABSTRACT: A SpeakableSpecification indicates (typically via xpath or cssSelector ) sections of a document that are highlighted as particularly speakable 

use Moo;

extends qw/ SemanticWeb::Schema::Intangible /;


use MooX::JSON_LD 'SpeakableSpecification';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v9.0.0';


has css_selector => (
    is        => 'rw',
    predicate => '_has_css_selector',
    json_ld   => 'cssSelector',
);



has xpath => (
    is        => 'rw',
    predicate => '_has_xpath',
    json_ld   => 'xpath',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::SpeakableSpecification - A SpeakableSpecification indicates (typically via xpath or cssSelector ) sections of a document that are highlighted as particularly speakable 

=head1 VERSION

version v9.0.0

=head1 DESCRIPTION

=for html <p>A SpeakableSpecification indicates (typically via <a class="localLink"
href="http://schema.org/xpath">xpath</a> or <a class="localLink"
href="http://schema.org/cssSelector">cssSelector</a>) sections of a
document that are highlighted as particularly <a class="localLink"
href="http://schema.org/speakable">speakable</a>. Instances of this type
are expected to be used primarily as values of the <a class="localLink"
href="http://schema.org/speakable">speakable</a> property.<p>

=head1 ATTRIBUTES

=head2 C<css_selector>

C<cssSelector>

=for html <p>A CSS selector, e.g. of a <a class="localLink"
href="http://schema.org/SpeakableSpecification">SpeakableSpecification</a>
or <a class="localLink"
href="http://schema.org/WebPageElement">WebPageElement</a>. In the latter
case, multiple matches within a page can constitute a single conceptual
"Web page element".<p>

A css_selector should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::CssSelectorType']>

=back

=head2 C<_has_css_selector>

A predicate for the L</css_selector> attribute.

=head2 C<xpath>

=for html <p>An XPath, e.g. of a <a class="localLink"
href="http://schema.org/SpeakableSpecification">SpeakableSpecification</a>
or <a class="localLink"
href="http://schema.org/WebPageElement">WebPageElement</a>. In the latter
case, multiple matches within a page can constitute a single conceptual
"Web page element".<p>

A xpath should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::XPathType']>

=back

=head2 C<_has_xpath>

A predicate for the L</xpath> attribute.

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
