#!/usr/bin/perl

use Helios::Panoptes::JobLog;
my $helios = Helios::Panoptes::JobLog->new(
	TMPL_PATH => 'tmpl'
);
$helios->run();


=head1 NAME

joblog.pl  - CGI::Application script to bootstrap Helios::Panoptes::JobLog

=head1 DESCRIPTION

The joblog.pl is the CGI script that actually runs the Helios::Panoptes::JobLog webapp.

=head1 SEE ALSO

L<Helios::Panoptes>, L<Helios::Service>, L<helios.pl>, <CGI::Application>, L<HTML::Template>

=head1 AUTHOR 

Andrew Johnson, <lajandy at cpan dotorg>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008-9 by CEB Toolbox, Inc.

This library is free software; you can redistribute it and/or modify it under the same terms as 
Perl itself, either Perl version 5.8.0 or, at your option, any later version of Perl 5 you may 
have available.

=head1 WARRANTY 

This software comes with no warranty of any kind.

=cut
