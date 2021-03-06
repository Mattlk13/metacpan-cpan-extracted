package Goo::SimpleEmailer;

###############################################################################
# Nigel Hamilton
#
# Copyright Nigel Hamilton 1999
# All Rights Reserved
#
# Author:       Nigel Hamilton
# Filename:     Goo::SimpleEmailer.pm
# Description:  Replace tokens in a file or a string and send an email
#
# Date          Change
# -----------------------------------------------------------------------------
# 04/03/1999    Version 1
# 10/05/2000    Version 2 - a more efficient slurping mode
# 01/06/2002    Changed in big refactoring session
#               Replace changed to Template!
# 14/08/2002    Email template
# 25/05/2003    Added string email
# 25/06/2003    Used WebDBLite
# 24/10/2005    Converted into a very simple Goo-specific self-contained
#               emailer without templates
# 28/10/2005    Added method: sendSMSEmail
#
###############################################################################

use strict;


###############################################################################
#
# send_email     -    send an email
#
###############################################################################

sub send_email {

    my ($from, $to, $subject, $body) = @_;

    # this talks to postfix on Mandrake
    open(EMAIL, "|/usr/sbin/sendmail -t");

    my $message = <<MESSAGE;
From: $from
To: $to
Subject: $subject
$body
MESSAGE

    print EMAIL $message;
    close(EMAIL);

}


###############################################################################
#
# show_email - display the contents of the email to STDOUT, used for debugging
#
###############################################################################

sub show_email {

    my ($from, $to, $subject, $body) = @_;

    print <<EMAIL;
From: $from
To: $to
Subject: $subject
$body
EMAIL

}

1;



__END__

=head1 NAME

Goo::SimpleEmailer - Replace tokens in a file or a string and send an email

=head1 SYNOPSIS

use Goo::SimpleEmailer;

=head1 DESCRIPTION

=head1 METHODS

=over

=item show_email

display the contents of the email to STDOUT, used for debugging

=item send_email

send an email

=back

=head1 AUTHOR

Nigel Hamilton <nigel@trexy.com>

=head1 SEE ALSO

