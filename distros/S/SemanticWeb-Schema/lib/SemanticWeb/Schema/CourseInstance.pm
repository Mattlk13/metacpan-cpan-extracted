use utf8;

package SemanticWeb::Schema::CourseInstance;

# ABSTRACT: An instance of a Course which is distinct from other instances because it is offered at a different time or location or through different media or modes of study or to a specific section of students.

use Moo;

extends qw/ SemanticWeb::Schema::Event /;


use MooX::JSON_LD 'CourseInstance';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v6.0.0';


has course_mode => (
    is        => 'rw',
    predicate => '_has_course_mode',
    json_ld   => 'courseMode',
);



has course_workload => (
    is        => 'rw',
    predicate => '_has_course_workload',
    json_ld   => 'courseWorkload',
);



has instructor => (
    is        => 'rw',
    predicate => '_has_instructor',
    json_ld   => 'instructor',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::CourseInstance - An instance of a Course which is distinct from other instances because it is offered at a different time or location or through different media or modes of study or to a specific section of students.

=head1 VERSION

version v6.0.0

=head1 DESCRIPTION

=for html <p>An instance of a <a class="localLink"
href="http://schema.org/Course">Course</a> which is distinct from other
instances because it is offered at a different time or location or through
different media or modes of study or to a specific section of students.<p>

=head1 ATTRIBUTES

=head2 C<course_mode>

C<courseMode>

The medium or means of delivery of the course instance or the mode of
study, either as a text label (e.g. "online", "onsite" or "blended";
"synchronous" or "asynchronous"; "full-time" or "part-time") or as a URL
reference to a term from a controlled vocabulary (e.g.
https://ceds.ed.gov/element/001311#Asynchronous ).

A course_mode should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_course_mode>

A predicate for the L</course_mode> attribute.

=head2 C<course_workload>

C<courseWorkload>

The amount of work expected of students taking the course, often provided
as a figure per week or per month, and may be broken down by type. For
example, "2 hours of lectures, 1 hour of lab work and 3 hours of
independent study per week".

A course_workload should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_course_workload>

A predicate for the L</course_workload> attribute.

=head2 C<instructor>

=for html <p>A person assigned to instruct or provide instructional assistance for
the <a class="localLink"
href="http://schema.org/CourseInstance">CourseInstance</a>.<p>

A instructor should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Person']>

=back

=head2 C<_has_instructor>

A predicate for the L</instructor> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::Event>

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
