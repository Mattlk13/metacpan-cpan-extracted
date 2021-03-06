[% IF not file %][% file     =  out     %][% END -%]
[% IF not file %][% file     = '<Name>' %][% END -%]
[% IF not module %][% module = file     %][% END -%]
[% IF not version %][% version.perl = '0.001' %][% END -%]
#!/usr/bin/perl

# Created on: [% date %] [% time %]
# Create by:  [% contact.fullname or user %]
# $Id$
# $Revision$, $HeadURL$, $Date$
# $Revision$, $Source$, $Date$

use strict;
use warnings;
use version;
use Scalar::Util;
use List::Util;
#use List::MoreUtils;
use Getopt::[% IF alt %]Alt qw/get_options/[% ELSE %]Long[% END %];
use Pod::Usage;
use Data::Dumper qw/Dumper/;
use English qw/ -no_match_vars /;
use FindBin qw/$Bin/;
use Path::Tiny;

our $VERSION = [% version.perl %];
my ($name)   = $PROGRAM_NAME =~ m{^.*/(.*?)$}mxs;

my %option = (
	out     => undef,
	verbose => 0,
	man     => 0,
	help    => 0,
	VERSION => 0,
);

if ( !@ARGV ) {
	pod2usage( -verbose => 1 );
}

main();
exit 0;

sub main {
	[%- IF alt %]
	my $opt = get_options(
		{
			default => \%option,
			helper  => 1,
		},
		[
			'out|o=s',
			'verbose|v+',
		],
	);
	[%- ELSE %]
	Getopt::Long::Configure('bundling');
	GetOptions(
		\%option,
		'out|o=s',
		'verbose|v+',
		'man',
		'help',
		'VERSION!',
	) or pod2usage(2);

	if ( $option{'VERSION'} ) {
		print "$name Version = $VERSION\n";
		exit 1;
	}
	elsif ( $option{'man'} ) {
		pod2usage( -verbose => 2 );
	}
	elsif ( $option{'help'} ) {
		pod2usage( -verbose => 1 );
	}
	[% END -%]

	# do stuff here

	return;
}

__DATA__

=head1 NAME

[% file %] - <One-line description of commands purpose>

[% INCLUDE perl/pod/VERSION.pl %]
[% INCLUDE perl/pod/USAGE.pl -%]
[% INCLUDE perl/pod/DESCRIPTION.pl -%]
[% INCLUDE perl/pod/METHODS.pl %]
[% INCLUDE perl/pod/detailed.pl %]
=head1 AUTHOR

[% contact.fullname %] - ([% contact.email %])

=head1 LICENSE AND COPYRIGHT
[% INCLUDE licence.txt %]
=cut
