package DateTime::Format::JSON::MicrosoftDateFormat;
use strict;
use warnings;
use DateTime;

our $VERSION = '0.05';
our $PACKAGE = __PACKAGE__;

=head1 NAME

DateTime::Format::JSON::MicrosoftDateFormat - Parse and format JSON MicrosoftDateFormat strings

=head1 SYNOPSIS

  use DateTime::Format::JSON::MicrosoftDateFormat;

  my $formatter = DateTime::Format::JSON::MicrosoftDateFormat->new;
  my $dt        = $formatter->parse_datetime("/Date(1392089278000-0600)/"); #2014-02-10T21:27:58Z
  my $dt        = $formatter->parse_datetime("/Date(1392067678000)/");      #2014-02-10T21:27:58Z

  say $formatter->format_datetime($dt);                                     #/Date(1392067678000)/

=head2 The Perl One Liner

  perl -MDateTime::Format::JSON::MicrosoftDateFormat -e 'print DateTime::Format::JSON::MicrosoftDateFormat->new->parse_datetime(shift), "\n";' '/Date(1392606509000-0500)/'

=head1 DESCRIPTION

This module understands the JSON MicrosoftDateFormat date/time format. e.g. /Date(1392067678000)/

=head1 USAGE

Note: The usage of MicrosoftDateFormat is deprecated for new JSON services.  Please use ISO 8601 for all new development.

From RFC 7493 (The I-JSON Message Format):

  Protocols often contain data items that are designed to contain timestamps or time durations. It
  is RECOMMENDED that all such data items be expressed as string values in ISO 8601 format,
  as specified in RFC 3339, with the additional restrictions that uppercase rather than lowercase
  letters be used, that the timezone be included not defaulted, and that optional trailing seconds
  be included even when their value is "00". It is also RECOMMENDED that all data items
  containing time durations conform to the "duration" production in Appendix A of RFC 3339, with
  the same additional restrictions.

=head2 import

Installs the TO_JSON method into the DateTime namespace when requested

  use DateTime::Format::JSON::MicrosoftDateFormat (to_json => 1); #TO_JSON method installed in DateTime package
  use DateTime::Format::JSON::MicrosoftDateFormat;                #TO_JSON method not installed by default

Use the imported DateTime::TO_JSON method and the JSON->convert_blessed options to seamlessly convert DateTime objects to the JSON MicrosoftDateFormat for use in creating encoded JSON structures.

  use JSON;
  use DateTime;
  use DateTime::Format::JSON::MicrosoftDateFormat (to_json=>1);
  my $formatter = DateTime::Format::JSON::MicrosoftDateFormat->new;
  my $json      = JSON->new->convert_blessed->pretty;

  my $dt        = DateTime->now(formatter=>$formatter);
  print $json->encode({now=>$dt}); #prints {"now" : "/Date(1392747671000)/"}

=cut

sub import {
  my $self=shift;
  die("$PACKAGE import: Expecting parameters to be hash") if @_ % 2;
  my %opt=@_;
  if ($opt{"to_json"}) {
    *DateTime::TO_JSON=sub {my $self=shift; return "$self"};
  }
}

=head1 CONSTRUCTOR

=head2 new

=cut

sub new {
  my $class = shift;
  return bless {}, $class;
}

=head1 METHODS

=head2 parse_datetime

Returns a DateTime object from the given string

  use DateTime::Format::JSON::MicrosoftDateFormat;
  my $parser = DateTime::Format::JSON::MicrosoftDateFormat->new;
  my $dt     = $parser->parse_datetime("/Date(1392606509000)/");
  print "$dt\n";

=cut

sub parse_datetime {
  my $self   = shift;
  my $string = shift;
  #/Date(1392089278000)/
  #/Date(1392089278000-0600)/
  #/Date(1392089278000+0600)/
  $string =~ m{^/Date\(([+-]?\d+)(?:([+-])(\d\d)(\d\d))?\)/$} or die "Invalid JSON MicrosoftDateFormat string ($string)";
  my $milliseconds = $1; #[+-]\d+
  my $direction    = $2; #[+-]
  my $hh           = $3; #\d\d
  my $mi           = $4; #\d\d
  my $dt=DateTime->from_epoch(epoch => $milliseconds / 1000);
  if (defined $direction) {
    my $minutes = ($direction."1") * ($mi + $hh * 60);
    $dt->add(minutes => $minutes);
  }
  return $dt;
}

=head2 format_datetime

Returns a JSON formatted date string for the passed DateTime object

  my $dt        = DateTime->now;
  my $formatter = DateTime::Format::JSON::MicrosoftDateFormat->new;
  print $formatter->format_datetime($dt), "\n";

However, format_datetime is typically used like this...

  use DateTime;
  use DateTime::Format::JSON::MicrosoftDateFormat;
  my $formatter = DateTime::Format::JSON::MicrosoftDateFormat->new;

  my $dt        = DateTime->now;
  $dt->set_formatter($formatter);
  print "$dt\n"; #prints /Date(1392747078000)/

Note: The format_datetime method returns all dates as UTC and does does not support time zone offset in output as it is not well supported in the Microsoft stack e.g. /Date(1392747078000-0500)/

=cut

sub format_datetime {
  my $self = shift;
  my $dt   = shift;
  return sprintf("/Date(%s)/", $dt->epoch * 1000 + $dt->millisecond);
}

=head1 BUGS

Please log on RT and send an email to the author.

=head1 SUPPORT

DavisNetworks.com supports all Perl applications including this package.

=head1 AUTHOR

  Michael R. Davis
  CPAN ID: MRDVT
  Satellite Tracking of People, LLC
  mdavis@stopllc.com
  http://www.stopllc.com/

=head1 COPYRIGHT

This program is free software licensed under the...

  The General Public License (GPL)
  Version 2, June 1991

The full text of the license can be found in the LICENSE file included with this module.

=head1 SEE ALSO

L<DateTime>

=cut

1;
