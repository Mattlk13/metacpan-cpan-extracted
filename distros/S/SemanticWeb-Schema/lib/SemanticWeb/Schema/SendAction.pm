package SemanticWeb::Schema::SendAction;

# ABSTRACT: <p>The act of physically/electronically dispatching an object for transfer from an origin to a destination

use Moo;

extends qw/ SemanticWeb::Schema::TransferAction /;


use MooX::JSON_LD 'SendAction';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v0.0.1';


has delivery_method => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'deliveryMethod',
);



has recipient => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'recipient',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::SendAction - <p>The act of physically/electronically dispatching an object for transfer from an origin to a destination

=head1 VERSION

version v0.0.1

=head1 DESCRIPTION

=for html <p>The act of physically/electronically dispatching an object for transfer
from an origin to a destination.Related actions:</p> <ul> <li><a
class="localLink" href="http://schema.org/ReceiveAction">ReceiveAction</a>:
The reciprocal of SendAction.</li> <li><a class="localLink"
href="http://schema.org/GiveAction">GiveAction</a>: Unlike GiveAction,
SendAction does not imply the transfer of ownership (e.g. I can send you my
laptop, but I'm not necessarily giving it to you).</li> </ul> 

=head1 ATTRIBUTES

=head2 C<delivery_method>

C<deliveryMethod>

A sub property of instrument. The method of delivery.

A delivery_method should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::DeliveryMethod']>

=back

=head2 C<recipient>

A sub property of participant. The participant who is at the receiving end
of the action.

A recipient should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::ContactPoint']>

=item C<InstanceOf['SemanticWeb::Schema::Organization']>

=item C<InstanceOf['SemanticWeb::Schema::Audience']>

=item C<InstanceOf['SemanticWeb::Schema::Person']>

=back

=head1 SEE ALSO

L<SemanticWeb::Schema::TransferAction>

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
