use utf8;

package SemanticWeb::Schema::AudioObject;

# ABSTRACT: An audio file.

use Moo;

extends qw/ SemanticWeb::Schema::MediaObject /;


use MooX::JSON_LD 'AudioObject';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v7.0.0';


has caption => (
    is        => 'rw',
    predicate => '_has_caption',
    json_ld   => 'caption',
);



has transcript => (
    is        => 'rw',
    predicate => '_has_transcript',
    json_ld   => 'transcript',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::AudioObject - An audio file.

=head1 VERSION

version v7.0.0

=head1 DESCRIPTION

An audio file.

=head1 ATTRIBUTES

=head2 C<caption>

=for html <p>The caption for this object. For downloadable machine formats (closed
caption, subtitles etc.) use MediaObject and indicate the <a
class="localLink"
href="http://schema.org/encodingFormat">encodingFormat</a>.<p>

A caption should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::MediaObject']>

=item C<Str>

=back

=head2 C<_has_caption>

A predicate for the L</caption> attribute.

=head2 C<transcript>

If this MediaObject is an AudioObject or VideoObject, the transcript of
that object.

A transcript should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_transcript>

A predicate for the L</transcript> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::MediaObject>

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
