#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;
use Pod::Usage;

use Readonly;
use IO::All -utf8;
use FilmAffinity::Movie;

=head1 NAME

filmaffinity-get-movie-info.pl

=head1 DESCRIPTION

Get information from filmaffinity about a film and print them in JSON format

=head1 VERSION

Version 1.01

=head1 USAGE

  filmaffinity-get-movie-info.pl --id=123456

  filmaffinity-get-movie-info.pl --id=123456 --delay=2

  filmaffinity-get-movie-info.pl --id=932476 --output=/home/william/matrix.json

=head1 REQUIRED ARGUMENTS

=over 2

=item --id=932476

movie id from filmaffinity

=back

=head1 OPTIONS

=over 2

=item --delay=3

delay between requests

=item --output=/home/william/matrix.json

output json file

=back

=cut

our $VERSION = '1.01';

Readonly my $DELAY => 5;

my ( $movieID, $delay, $output, $help );

GetOptions(
  'id=i'     => \$movieID,
  'delay=i'  => \$delay,
  'output=s' => \$output,
  'help'     => \$help,
) || pod2usage(2);

if ( $help || !$movieID ) {
  pod2usage(1);
  exit 0;
}

my $movie = FilmAffinity::Movie->new(
  id    => $movieID,
  delay => $delay || $DELAY,
);

$movie->parse();

my $json = $movie->toJSON();
$output ? $json > io($output) : print $json;

=head1 AUTHOR

William Belle, C<< <william.belle at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-filmaffinity-userrating at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=FilmAffinity-UserRating>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc filmaffinity-get-movie-info.pl

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=FilmAffinity-UserRating>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/FilmAffinity-UserRating>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/FilmAffinity-UserRating>

=item * Search CPAN

L<http://search.cpan.org/dist/FilmAffinity-UserRating/>

=back

=head1 SEE ALSO

L<http://www.filmaffinity.com>

=head1 LICENSE AND COPYRIGHT

Copyright 2013 William Belle.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
