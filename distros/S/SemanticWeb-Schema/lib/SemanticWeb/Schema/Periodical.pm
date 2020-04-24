use utf8;

package SemanticWeb::Schema::Periodical;

# ABSTRACT: A publication in any medium issued in successive parts bearing numerical or chronological designations and intended

use Moo;

extends qw/ SemanticWeb::Schema::CreativeWorkSeries /;


use MooX::JSON_LD 'Periodical';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v7.0.4';




1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::Periodical - A publication in any medium issued in successive parts bearing numerical or chronological designations and intended

=head1 VERSION

version v7.0.4

=head1 DESCRIPTION

=for html <p>A publication in any medium issued in successive parts bearing numerical
or chronological designations and intended, such as a magazine, scholarly
journal, or newspaper to continue indefinitely.<br/><br/> See also <a
href="http://blog.schema.org/2014/09/schemaorg-support-for-bibliographic_2.
html">blog post</a>.<p>

=head1 SEE ALSO

L<SemanticWeb::Schema::CreativeWorkSeries>

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
