use utf8;

package SemanticWeb::Schema::PlanAction;

# ABSTRACT: The act of planning the execution of an event/task/action/reservation/plan to a future date.

use Moo;

extends qw/ SemanticWeb::Schema::OrganizeAction /;


use MooX::JSON_LD 'PlanAction';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v8.0.0';


has scheduled_time => (
    is        => 'rw',
    predicate => '_has_scheduled_time',
    json_ld   => 'scheduledTime',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::PlanAction - The act of planning the execution of an event/task/action/reservation/plan to a future date.

=head1 VERSION

version v8.0.0

=head1 DESCRIPTION

The act of planning the execution of an event/task/action/reservation/plan
to a future date.

=head1 ATTRIBUTES

=head2 C<scheduled_time>

C<scheduledTime>

The time the object is scheduled to.

A scheduled_time should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_scheduled_time>

A predicate for the L</scheduled_time> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::OrganizeAction>

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
