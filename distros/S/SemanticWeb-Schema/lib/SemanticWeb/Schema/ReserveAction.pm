use utf8;

package SemanticWeb::Schema::ReserveAction;

# ABSTRACT: Reserving a concrete object

use Moo;

extends qw/ SemanticWeb::Schema::PlanAction /;


use MooX::JSON_LD 'ReserveAction';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v3.5.0';




1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::ReserveAction - Reserving a concrete object

=head1 VERSION

version v3.5.0

=head1 DESCRIPTION

=for html Reserving a concrete object.<br/><br/> Related actions:<br/><br/> <ul>
<li><a class="localLink"
href="http://schema.org/ScheduleAction">ScheduleAction</a></a>: Unlike
ScheduleAction, ReserveAction reserves concrete objects (e.g. a table, a
hotel) towards a time slot / spatial allocation.</li> </ul> 

=head1 SEE ALSO

L<SemanticWeb::Schema::PlanAction>

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
