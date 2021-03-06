package Biblio::ILL::ISO::ForwardNotification;

=head1 NAME

Biblio::ILL::ISO::ForwardNotification - Perl extension for handling ISO 10161 
interlibrary loan Forward-Notification messages

=cut

use Biblio::ILL::ISO::ISO;
use Carp;

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';
#---------------------------------------------------------------------------
# Mods
# 0.01 - 2003.08.11 - original version
#---------------------------------------------------------------------------

=head1 DESCRIPTION

Biblio::ILL::ISO::ForwardNotification is a derivation of the abstract 
Biblio::ILL::ISO::ISO object, and handles the ForwardNotification message type.

=head1 EXPORT

None.

=head1 ERROR HANDLING

Each of the set_() methods will croak on missing or invalid parameters.

=cut
BEGIN{@ISA = qw ( Biblio::ILL::ISO::ISO );  }

=head1 FROM THE ASN DEFINITION
    
    Forward-Notification ::= [APPLICATION 2] SEQUENCE {
    	protocol-version-num	[0]	IMPLICIT INTEGER, -- {
    				-- version-1 (1),
    				-- version-2 (2)
    				-- },
    	transaction-id	[1]	IMPLICIT Transaction-Id,   
    	service-date-time	[2]	IMPLICIT Service-Date-Time,
    	requester-id	[3]	IMPLICIT System-Id OPTIONAL,
    		-- mandatory when using store-and-forward communications
    		-- optional when using connection-oriented communications
    	responder-id	[4]	IMPLICIT System-Id,
    		-- mandatory in this APDU
    	responder-address	[24]	IMPLICIT System-Address OPTIONAL,
    	intermediary-id	[25]	IMPLICIT System-Id,
    	notification-note	[48]	ILL-String OPTIONAL,
    	forward-notification-extensions	[49]	IMPLICIT SEQUENCE OF Extension OPTIONAL
    	}
    
=cut

=head1 CONSTRUCTORS

new()

Base constructor for the class. It just returns a completely
empty message object, which you'll need to populate with the
various set_() methods, or use the read() method to read a
Forward-Notification message from a file (followed by a call to
from_asn() to turn the read's returned hash into a proper
ForwardNotification message.

The constructor also initializes the Convert::ASN1 if it
hasn't been initialized.

=cut
#---------------------------------------------------------------
#
#---------------------------------------------------------------
sub new {
    my $class = shift;
    my $self = {};

    Biblio::ILL::ISO::ISO::_init() if (not $Biblio::ILL::ISO::ISO::_asn_initialized);
    $self->{"ASN_TYPE"} = "Forward-Notification";

    bless($self, ref($class) || $class);
    return ($self);
}


#---------------------------------------------------------------
#
#---------------------------------------------------------------
sub as_pretty_string {
    my $self = shift;

    foreach my $key (sort keys %$self) {
	if ($key ne "ASN_TYPE") {
	    print "\n[$key]\n";
	    print $self->{$key}->as_pretty_string();
	}
    }
    return;
}

#---------------------------------------------------------------
# This will return a structure usable by Convert::ASN1
#---------------------------------------------------------------
sub as_asn {
    my $self = shift;

    my %h = ();
    foreach my $key (sort keys %$self) {
	if ($key ne "ASN_TYPE") {
	    #print "\n[$key]\n";
	    $h{$key} = $self->{$key}->as_asn();
	}
    }
    return \%h;
}

=head1 METHODS

For any example code, assume the following:
    my $msg = new Biblio::ILL::ISO::ForwardNotification;

=cut

#---------------------------------------------------------------
#
#---------------------------------------------------------------
=head1

=head2 from_asn($href)

To read a message from a file, use the following:

    my $href = $msg->read("msg_02.forward-notification.ber");
    $msg = $msg->from_asn($href);

The from_asn() method turns the hash returned from read() into
a proper message-type object.

=cut
sub from_asn {
    my $self = shift;
    my $href = shift;

    foreach my $k (keys %$href) {

	if ($k =~ /^protocol-version-num$/) {
	    $self->{$k} = new Biblio::ILL::ISO::ProtocolVersionNum();
	    $self->{$k}->from_asn($href->{$k});

	} elsif ($k =~ /^transaction-id$/) {
	    $self->{$k} = new Biblio::ILL::ISO::TransactionId();
	    $self->{$k}->from_asn($href->{$k});

	} elsif ($k =~ /^service-date-time$/) {
	    $self->{$k} = new Biblio::ILL::ISO::ServiceDateTime();
	    $self->{$k}->from_asn($href->{$k});

	} elsif (($k =~ /^requester-id$/)
		 || ($k =~ /^responder-id$/)
		 || ($k =~ /^intermediary-id$/)
		 ) {
	    $self->{$k} = new Biblio::ILL::ISO::SystemId();
	    $self->{$k}->from_asn($href->{$k});

	} elsif ($k =~ /^responder-address$/) {
	    $self->{$k} = new Biblio::ILL::ISO::SystemAddress();
	    $self->{$k}->from_asn($href->{$k});

	} elsif ($k =~ /^notification-note$/) {
	    $self->{$k} = new Biblio::ILL::ISO::ILLString();
	    $self->{$k}->from_asn($href->{$k});

	} elsif ($k =~ /^forward-notification-extensions$/) {
	    #$self->{$k} = new Biblio::ILL::ISO::Extension();
	    #$self->{$k}->from_asn($href->{$k});

	} else {
	    croak "invalid " . ref($self) . " element: [$k]";
	}

    }
    return $self;
}

#---------------------------------------------------------------
#
#---------------------------------------------------------------
=head1

=head2 set_protocol_version_num($pvn)

 Sets the protocol version number.
 Acceptable parameter values are the strings:
    version-1
    version-2

=cut
sub set_protocol_version_num {
    my $self = shift;
    my ($parm) = shift;

    croak "missing protocol-version-num" unless $parm;

    $self->{"protocol-version-num"} = new Biblio::ILL::ISO::ProtocolVersionNum($parm);

    return;
}

#---------------------------------------------------------------
#
#---------------------------------------------------------------
=head1

=head2 set_transaction_id($tid)

 Sets the message's transaction-id.  
 Expects a valid Biblio::ILL::ISO::TransactionId.

    my $tid = new Biblio::ILL::ISO::TransactionId("PLS","001","", 
					          new Biblio::ILL::ISO::SystemId("MWPL"));
    $msg->set_transaction_id($tid);

 This is a mandatory field.

=cut
sub set_transaction_id {
    my $self = shift;
    my ($parm) = shift;

    croak "missing transaction-id" unless $parm;
    croak "invalid transaction-id" unless (ref($parm) eq "Biblio::ILL::ISO::TransactionId");

    $self->{"transaction-id"} = $parm;

    return;
}

#---------------------------------------------------------------
#
#---------------------------------------------------------------
=head1

=head2 set_service_date_time($sdt)

 Sets the message's service-date-time.  
 Expects a valid Biblio::ILL::ISO::ServiceDateTime.

    my $dt_this = new Biblio::ILL::ISO::DateTime("20030623","114400");
    my $dt_orig = new Biblio::ILL::ISO::DateTime("20030623","114015")
    my $sdt = new Biblio::ILL::ISO::ServiceDateTime( $dt_this, $dt_orig);
    $msg->set_service_date_time($sdt);

 This is a mandatory field.

=cut
sub set_service_date_time {
    my $self = shift;
    my ($sdt) = shift;

    croak "missing service-date-time" unless $sdt;
    croak "invalid service-date-time" unless (ref($sdt) eq "Biblio::ILL::ISO::ServiceDateTime");

    $self->{"service-date-time"} = $sdt;

    return;
}

#---------------------------------------------------------------
#
#---------------------------------------------------------------
=head1

=head2 set_requester_id($reqid)

 Sets the message's requester-id.  
 Expects a valid Biblio::ILL::ISO::SystemId.

    my $reqid = new Biblio::ILL::ISO::SystemId();
    $reqid->set_person_name("David A. Christensen");
    $msg->set_requester_id($reqid);

 This is an optional field.

=cut
sub set_requester_id {
    my $self = shift;
    my ($parm) = shift;

    croak "missing requester-id" unless $parm;
    croak "invalid requester-id" unless (ref($parm) eq "Biblio::ILL::ISO::SystemId");

    $self->{"requester-id"} = $parm;

    return;
}

#---------------------------------------------------------------
#
#---------------------------------------------------------------
=head1

=head2 set_responder_id($resid)

 Sets the message's responder-id.  
 Expects a valid Biblio::ILL::ISO::SystemId.

    my $resid = new Biblio::ILL::ISO::SystemId("MWPL");
    $msg->set_responder_id($resid);

 This is a mandatory field.

=cut
sub set_responder_id {
    my $self = shift;
    my ($parm) = shift;

    croak "missing responder-id" unless $parm;
    croak "invalid responder-id" unless (ref($parm) eq "Biblio::ILL::ISO::SystemId");

    $self->{"responder-id"} = $parm;

    return;
}

#---------------------------------------------------------------
#
#---------------------------------------------------------------
=head1

=head2 set_responder_address($rad)

 Sets the message's responder-address.
 Expects a valid Biblio::ILL::ISO::SystemAddress.

    my $rad = new Biblio::ILL::ISO::SystemAddress("SMTP","pls\@gov.mb.ca");
    $msg->set_responder_address($rad);

 This is an optional field.

=cut
sub set_responder_address {
    my $self = shift;
    my ($parm) = shift;

    croak "missing responder-address" unless $parm;
    croak "invalid responder-address" unless (ref($parm) eq "Biblio::ILL::ISO::SystemAddress");

    $self->{"responder-address"} = $parm;

    return;
}

#---------------------------------------------------------------
#
#---------------------------------------------------------------
=head1

=head2 set_intermediary_id($iid)

 Sets the message's intermediary-id.
 Expects a valid Biblio::ILL::ISO::SystemAddress.

    my $iid = new Biblio::ILL::ISO::SystemId();
    $iid->set_institution_name("The Great Library of Alexandria");
    $msg->set_intermediary_id($iid);

 This is a mandatory field.

=cut
sub set_intermediary_id {
    my $self = shift;
    my ($parm) = shift;

    croak "missing intermediary-id" unless $parm;
    croak "invalid intermediary-id" unless (ref($parm) eq "Biblio::ILL::ISO::SystemId");

    $self->{"intermediary-id"} = $parm;

    return;
}

#---------------------------------------------------------------
#
#---------------------------------------------------------------
=head1

=head2 set_notification_note($note)

 Sets the message's notification-note.
 Expects a simple text string.

    $msg->set_notification_note("This is a notification note");

 This is an optional field.

=cut
sub set_notification_note {
    my $self = shift;
    my ($parm) = shift;

    croak "missing notification-note" unless $parm;
    if (ref($parm) eq "Biblio::ILL::ISO::ILLString") {
	$self->{"notification-note"} = $parm;
    } else {
	$self->{"notification-note"} = new Biblio::ILL::ISO::ILLString( $parm );
    }

    return;
}

=head1 RELATED MODULES

 Biblio::ILL::ISO::ISO
 Biblio::ILL::ISO::Request
 Biblio::ILL::ISO::ForwardNotification
 Biblio::ILL::ISO::Shipped
 Biblio::ILL::ISO::Answer
 Biblio::ILL::ISO::ConditionalReply
 Biblio::ILL::ISO::Cancel
 Biblio::ILL::ISO::CancelReply
 Biblio::ILL::ISO::Received
 Biblio::ILL::ISO::Recall
 Biblio::ILL::ISO::Returned
 Biblio::ILL::ISO::CheckedIn
 Biblio::ILL::ISO::Overdue
 Biblio::ILL::ISO::Renew
 Biblio::ILL::ISO::RenewAnswer
 Biblio::ILL::ISO::Lost
 Biblio::ILL::ISO::Damaged
 Biblio::ILL::ISO::Message
 Biblio::ILL::ISO::StatusQuery
 Biblio::ILL::ISO::StatusOrErrorReport
 Biblio::ILL::ISO::Expired

=cut

=head1 SEE ALSO

See the README for system design notes.

For more information on Interlibrary Loan standards (ISO 10160/10161),
a good place to start is:

http://www.nlc-bnc.ca/iso/ill/main.htm

=cut

=head1 AUTHOR

David Christensen, <DChristensenSPAMLESS@westman.wave.ca>

=cut


=head1 COPYRIGHT AND LICENSE

Copyright 2003 by David Christensen

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
