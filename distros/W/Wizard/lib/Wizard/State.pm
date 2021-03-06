#! -*- perl -*-
#
#   Wizard - A Perl package for implementing system administration
#            applications in the style of Windows wizards.
#
#
#   This module is
#
#           Copyright (C) 1999     Jochen Wiedmann
#                                  Am Eisteich 9
#                                  72555 Metzingen
#                                  Germany
#
#                                  Email: joe@ispsoft.de
#                                  Phone: +49 7123 14887
#
#                          and     Amarendran R. Subramanian
#                                  Grundstr. 32
#                                  72810 Gomaringen
#                                  Germany
#
#                                  Email: amar@ispsoft.de
#                                  Phone: +49 7072 920696
#
#   All Rights Reserved.
#
#   You may distribute under the terms of either the GNU General Public
#   License or the Artistic License, as specified in the Perl README file.
#
#   $Id$
#

use strict;


=pod

=head1 NAME

Wizard::State - A class for storing the Wizard state.


=head1 SYNOPSIS

  # Create a new state
  my $state = Wizard::State->new();


=head1 DESCRIPTION

A Wizard can be interpreted as a very simple finite state machine. The
state is stored in ab object of class Wizard::State.

A wizard state is typically a collection of Wizard::SaveAble objects.
For example, while configuring an Apache webserver, the state might
have attributes I<prefs> (global preferences), I<host> (the machine
where the webserver is running on) and I<server> (the web server), each
of them being a SaveAble object. If the state's I<Store> method is
called, then the I<Store> method is called for any of these objects,
as if they were a single object.

=head1 CLASS INTERFACE

=head2 Constructor

  my $state = Wizard::State->new(\%attr)

(Class Method) A new object is generated by calling its I<new> method.
The object attributes are passed as a hash ref.

=cut

package Wizard::State;

sub new {
    my $proto = shift; my $attr = shift;
    my $self = { %$attr };
    bless($self, (ref($proto) || $proto));
    $self->{'running'} = 1;
    $self;
}

=pod

=head2 Terminating the application

  # Stopping the application
  $state->Running(0);

  # Querying whether the application is running
  $is_running = $state->Running();

(Instance method) The state's I<Running> method can be used to set or
get its I<running> attribute. This attribute will be set to 0 for
stopping the application.

=cut

sub Running {
    my $self = shift;
    $self->{'running'} = shift if @_;
    $self->{'running'};
}


=pod

=head2 Storing a state

  # Storing a state temporarily; real SaveAble objects won't be
  # changed
  $state->Store($wiz);

  # Storing a state, including the SaveAble objects.
  $state->Store($wiz, 1);

=cut

sub Store {
    my $self = shift;  my $wiz = shift;
    $wiz->Store($self);
    return unless shift;
    while (my($var, $val) = each %$self) {
	if (UNIVERSAL::can($val, 'Store')) {
	    $val->Store();
	}
    }
}

1;

__END__

=pod

=head1 AUTHORS AND COPYRIGHT

This module is

  Copyright (C) 1999     Jochen Wiedmann
                         Am Eisteich 9
                         72555 Metzingen
                         Germany

                         Email: joe@ispsoft.de
                         Phone: +49 7123 14887

                 and     Amarendran R. Subramanian
                         Grundstr. 32
                         72810 Gomaringen
                         Germany

                         Email: amar@ispsoft.de
                         Phone: +49 7072 920696

All Rights Reserved.

You may distribute under the terms of either the GNU General Public
License or the Artistic License, as specified in the Perl README file.


=cut
