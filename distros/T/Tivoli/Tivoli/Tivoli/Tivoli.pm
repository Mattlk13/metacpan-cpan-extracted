package Tivoli;

$VERSION = '0.02';

################################################################################################

=head1 NAME

	Tivoli - Perl extension for Tivoli TME10

=head1 SYNOPSIS

	Not (yet) Autoloader implemented.

 	use Tivoli::DateTime;
 	use Tivoli::Logging;
 	use Tivoli::Fwk;
 	use Tivoli::Endpoints;

=head1 VERSION

	v0.01

=head1 License

	Copyright (c) 2001 Robert Hase.
	All rights reserved.
	This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself. 

=head1 DESCRIPTION

=over

	This Module will handle about everything you may need for Tivoli TME10.
	If anything has been left out, please contact me at
	tivoli.rhase@muc-net.de
	so it can be added.

=back

=head2 DETAILS

	This Module is still in work.

	The following Packages are included in v0.01
	(read Package-Documentations for Details)

=over

=item * Tivoli::DateTime

	This Package will handle about everything you may need for handling the date / time.

=item * Tivoli::Logging

	This Package will handle about everything you may need for Logging.

=item * Tivoli::Fwk

	This Package will handle about everything you may need for Framework.

=item * Tivoli::Endpoints

        This Package will handle about everything you may need for Endpoints.

=back

=head2 DEPENDENCIES

	The Tivoli Environment should be sourced at first

=head2 Plattforms and Requirements

=over

	read Package-Documentations for Details

=item * Plattforms

	tested on:

	- w32-ix86 (Win9x, NT4, Windows 2000)
	- aix4-r1 (AIX 4.3)
	- Linux (Kernel 2.2.x)

=back

=item * Requirements

	requires Perl v5 or higher

=back

=head2 HISTORY

=over

=item * MODULE

	MODULE		AUTHOR		VERSION		DATE
	----------------------------------------------------
	Tivoli		RHase		0.01		2001-08-05

=item * PACKAGES

	PACKAGE		AUTHOR		VERSION		DATE
	----------------------------------------------------
	DateTime	RHase		0.03		1999
	Logging		RHase		0.02		2001-07-18
	Fwk		RHase		0.04		2001-07-06
	Endpoints	RHase		0.02		2001-07-06

=back

=head1 INSTALLATION

=head2 UNIX

	To install this module type the following:

=over

=item * perl Makefile.PL

=item * make

=item * make test

=item * make install

=back

=head2 Win32

	Still in work

=head1 AUTHOR

	Robert Hase
	ID	: RHASE
	eMail	: Tivoli.RHase@Muc-Net.de
	Web	: http://www.Muc-Net.de

=head1 SEE ALSO

	CPAN
	http://www.perl.com

	Tivoli
	http://www.tivoli.com

=cut

###############################################################################################
1;
