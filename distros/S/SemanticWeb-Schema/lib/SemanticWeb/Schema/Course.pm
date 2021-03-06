use utf8;

package SemanticWeb::Schema::Course;

# ABSTRACT: A description of an educational course which may be offered as distinct instances at which take place at different times or take place at different locations

use Moo;

extends qw/ SemanticWeb::Schema::CreativeWork SemanticWeb::Schema::LearningResource /;


use MooX::JSON_LD 'Course';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v9.0.0';


has course_code => (
    is        => 'rw',
    predicate => '_has_course_code',
    json_ld   => 'courseCode',
);



has course_prerequisites => (
    is        => 'rw',
    predicate => '_has_course_prerequisites',
    json_ld   => 'coursePrerequisites',
);



has educational_credential_awarded => (
    is        => 'rw',
    predicate => '_has_educational_credential_awarded',
    json_ld   => 'educationalCredentialAwarded',
);



has has_course_instance => (
    is        => 'rw',
    predicate => '_has_has_course_instance',
    json_ld   => 'hasCourseInstance',
);



has number_of_credits => (
    is        => 'rw',
    predicate => '_has_number_of_credits',
    json_ld   => 'numberOfCredits',
);



has occupational_credential_awarded => (
    is        => 'rw',
    predicate => '_has_occupational_credential_awarded',
    json_ld   => 'occupationalCredentialAwarded',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::Course - A description of an educational course which may be offered as distinct instances at which take place at different times or take place at different locations

=head1 VERSION

version v9.0.0

=head1 DESCRIPTION

A description of an educational course which may be offered as distinct
instances at which take place at different times or take place at different
locations, or be offered through different media or modes of study. An
educational course is a sequence of one or more educational events and/or
creative works which aims to build knowledge, competence or ability of
learners.

=head1 ATTRIBUTES

=head2 C<course_code>

C<courseCode>

=for html <p>The identifier for the <a class="localLink"
href="http://schema.org/Course">Course</a> used by the course <a
class="localLink" href="http://schema.org/provider">provider</a> (e.g.
CS101 or 6.001).<p>

A course_code should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_course_code>

A predicate for the L</course_code> attribute.

=head2 C<course_prerequisites>

C<coursePrerequisites>

=for html <p>Requirements for taking the Course. May be completion of another <a
class="localLink" href="http://schema.org/Course">Course</a> or a textual
description like "permission of instructor". Requirements may be a
pre-requisite competency, referenced using <a class="localLink"
href="http://schema.org/AlignmentObject">AlignmentObject</a>.<p>

A course_prerequisites should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::AlignmentObject']>

=item C<InstanceOf['SemanticWeb::Schema::Course']>

=item C<Str>

=back

=head2 C<_has_course_prerequisites>

A predicate for the L</course_prerequisites> attribute.

=head2 C<educational_credential_awarded>

C<educationalCredentialAwarded>

A description of the qualification, award, certificate, diploma or other
educational credential awarded as a consequence of successful completion of
this course or program.

A educational_credential_awarded should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::EducationalOccupationalCredential']>

=item C<Str>

=back

=head2 C<_has_educational_credential_awarded>

A predicate for the L</educational_credential_awarded> attribute.

=head2 C<has_course_instance>

C<hasCourseInstance>

An offering of the course at a specific time and place or through specific
media or mode of study or to a specific section of students.

A has_course_instance should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::CourseInstance']>

=back

=head2 C<_has_has_course_instance>

A predicate for the L</has_course_instance> attribute.

=head2 C<number_of_credits>

C<numberOfCredits>

The number of credits or units awarded by a Course or required to complete
an EducationalOccupationalProgram.

A number_of_credits should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Integer']>

=item C<InstanceOf['SemanticWeb::Schema::StructuredValue']>

=back

=head2 C<_has_number_of_credits>

A predicate for the L</number_of_credits> attribute.

=head2 C<occupational_credential_awarded>

C<occupationalCredentialAwarded>

A description of the qualification, award, certificate, diploma or other
occupational credential awarded as a consequence of successful completion
of this course or program.

A occupational_credential_awarded should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::EducationalOccupationalCredential']>

=item C<Str>

=back

=head2 C<_has_occupational_credential_awarded>

A predicate for the L</occupational_credential_awarded> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::LearningResource>

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
