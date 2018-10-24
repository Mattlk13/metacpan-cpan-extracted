use utf8;

package SemanticWeb::Schema::LeaveAction;

# ABSTRACT: An agent leaves an event / group with participants/friends at a location

use Moo;

extends qw/ SemanticWeb::Schema::InteractAction /;


use MooX::JSON_LD 'LeaveAction';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v0.0.2';


has event => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'event',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::LeaveAction - An agent leaves an event / group with participants/friends at a location

=head1 VERSION

version v0.0.2

=head1 DESCRIPTION

=for html An agent leaves an event / group with participants/friends at a
location.<br/><br/> Related actions:<br/><br/> <ul> <li><a
class="localLink" href="http://schema.org/JoinAction">JoinAction</a>: The
antonym of LeaveAction.</li> <li><a class="localLink"
href="http://schema.org/UnRegisterAction">UnRegisterAction</a>: Unlike
UnRegisterAction, LeaveAction implies leaving a group/team of people rather
than a service.</li> </ul> 

=head1 ATTRIBUTES

=head2 C<event>

Upcoming or past event associated with this place, organization, or action.

A event should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Event']>

=back

=head1 SEE ALSO

L<SemanticWeb::Schema::InteractAction>

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
