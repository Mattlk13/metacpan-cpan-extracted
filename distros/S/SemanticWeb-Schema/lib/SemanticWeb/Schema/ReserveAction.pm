use utf8;

package SemanticWeb::Schema::ReserveAction;

# ABSTRACT: Reserving a concrete object

use Moo;

extends qw/ SemanticWeb::Schema::PlanAction /;


use MooX::JSON_LD 'ReserveAction';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v7.0.3';




1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::ReserveAction - Reserving a concrete object

=head1 VERSION

version v7.0.3

=head1 DESCRIPTION

=for html <p>Reserving a concrete object.<br/><br/> Related actions:<br/><br/> <ul>
<li><a class="localLink"
href="http://schema.org/ScheduleAction">ScheduleAction</a></a>: Unlike
ScheduleAction, ReserveAction reserves concrete objects (e.g. a table, a
hotel) towards a time slot / spatial allocation.</li> </ul> <p>

=head1 SEE ALSO

L<SemanticWeb::Schema::PlanAction>

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
