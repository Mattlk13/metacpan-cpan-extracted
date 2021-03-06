###############################################################################
#
# $Header: Radius.pm,v 1.14 98/03/03 14:33:01 paulg Exp $
# Copyright (c) 1997-98 Paul Gampe. All Rights Reserved.
# 
###############################################################################

###############################################################################
##                 L I B R A R I E S / M O D U L E S
###############################################################################
package Logfile::Radius;

require Logfile::Base;

use Carp;
use English;
use strict qw(vars subs);

###############################################################################
##                         V A R I A B L E S 
###############################################################################

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %SESSIONS);

$VERSION = do { my @r=(q$Revision: 1.14 $=~/\d+/g); sprintf "%d."."%02d"x$#r,@r};

@ISA = qw(Logfile::Base);

###############################################################################
##                             M A I N
###############################################################################

sub norm {
    my ($self, $key, $val) = @_;

    if ($key eq 'Acct-Session-Id') {
		if ($SESSIONS{$val}) {
			$val = -1;			# Session Id's are supposedly unique ??
		} else {
			$SESSIONS{$val} = $val;
		}
	}
	$val;
}

sub next {
	my $self = shift;
	my $fh = $self->{Fh};
	my ($rec,$line,%args,$date);

	# Example
    # 
    # Thu Nov 27 19:02:58 1997
    #         User-Name = "user01"
    #         NAS-Identifier = 127.0.0.1
    #         NAS-Port = 10110
    #         Acct-Status-Type = Stop
    #         Acct-Delay-Time = 0
    #         Acct-Session-Id = "241738358"
    #         Acct-Authentic = RADIUS
	#

	*S = $fh;

	while (defined ($line = <S>)) {
		# the date field starts a record
		chomp($line);
		next unless ($args{"Date"})= 
			$line =~ /^(\w+\s+\w+\s+\d+\s+\d+:\d+:\d+\s+\d+)$/;
		if ( $rec = $self->_next( %args )) {
			return $rec;
		}
	}
		
}

sub _next {
	my ($self, %args) = @_;
	my $fh = $self->{Fh};
	*S = $fh;
	my ($line,$param,$value,$stop_record,);

	while (defined ($line = <S>)) {
		# now parsing the parameter value section of record
		chomp($line);
		($param, $value) = $line =~ /\s+(\S+) = (\"?[^\"]*\"?)/;

		last unless $param;

		# add new field to param list
		$args{"$param"} = "$value";

		## bug in Logfile::Base clobbers ip addresses
		$args{"$param"} = "\"$value\"" if ( $param eq "NAS-Identifier"
		                                 or $param eq "NAS-IP-Address"
										 or $param eq "Framed-IP-Address"
										 );

		## set flag if this is a stop record
		$stop_record++ if ($param eq 'Acct-Status-Type' and $value eq 'Stop');
	}

	return ($stop_record ? Logfile::Base::Record->new( %args ) : undef);
}

1;


__END__

=head1 NAME

Logfile::Radius - Perl module for generating reports from Radius 
                  Accounting logfiles

=head1 SYNOPSIS

   use Logfile::Radius;

=head1 DESCRIPTION

This module is a subclass of the L<Logfile::Base> package by I<Ulrich Pfeifer>.
A description on how to pass logfiles to this module and generate reports
is available in the Logfile package.

This module has been written to parse I<Radius Accounting> detail files.  I 
only have copies of those generated by the I<Ascend> Radius server, so I don't 
know if it is compatible with other Radius versions.

In particular I only record Stop type records as they contain the
information that is relavent to my analysis.  This may change if enough
people want the Start records included.

=head1 DEPENDANCIES

I overwrite the norm function, to avoid accepting duplicate session
ids.  This may or may not suit you.

=head1 COPYRIGHT

Copyright (c) 1997-98 Paul Gampe. All rights reserved.
This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

=head1 SEE ALSO

L<Logfile::Base> by I<Ulrich Pfeifer>.

=head1 AUTHORS

Paul Gampe <paulg@twics.com>

=cut

