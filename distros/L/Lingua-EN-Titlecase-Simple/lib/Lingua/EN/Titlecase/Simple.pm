#!/usr/bin/perl
use 5.008001; use strict; use warnings; use utf8;

package Lingua::EN::Titlecase::Simple;
$Lingua::EN::Titlecase::Simple::VERSION = '1.003';
# ABSTRACT: John Gruber's headline capitalization script

our @SMALL_WORD
	= qw/ (?<!q&)a an and as at(?!&t) but by en for if in of on or the to v[.]? via vs[.]? /;

my $apos = q/ (?: ['’] [[:lower:]]* )? /;

sub titlecase {
	my @str = @_ or return;

	for ( @str ) {
		s{\A\s+}{}, s{\s+\z}{};

		$_ = lc $_ unless /[[:lower:]]/;

		s{
			\b (_*) (?:
				( (?<=[ ][/\\]) [[:alpha:]]+ [-_[:alpha:]/\\]+ |   # file path or
				[-_[:alpha:]]+ [@.:] [-_[:alpha:]@.:/]+ $apos )    # URL, domain, or email
				|
				( (?i) ${\join '|', @SMALL_WORD} $apos )           # or small word (case-insensitive)
				|
				( [[:alpha:]] [[:lower:]'’()\[\]{}]* $apos )       # or word w/o internal caps
				|
				( [[:alpha:]] [[:alpha:]'’()\[\]{}]* $apos )       # or some other word
			) (?= _* \b )
		}{
			$1 .
			( defined $2 ? $2         # preserve URL, domain, or email
			: defined $3 ? lc $3      # lowercase small word
			: defined $4 ? ucfirst $4 # capitalize lower-case word
			: $5 )                    # preserve other kinds of word
		}exgo;

		# exceptions for small words: capitalize at start and end of title
		s{
			( \A [[:punct:]]*          # start of title...
			|  [:.;?!][ ]+             # or of subsentence...
			|  [ ]['"“‘(\[][ ]*     )  # or of inserted subphrase...
			( ${\join '|', @SMALL_WORD} ) \b  # ... followed by small word
		}{$1\u\L$2}xigo;

		s{
			\b ( ${\join '|', @SMALL_WORD} )  # small word...
			(?= [[:punct:]]* \Z   # ... at the end of the title...
			|   ['"’”)\]] [ ] )   # ... or of an inserted subphrase?
		}{\u\L$1}xigo;
	}

	wantarray ? @str : ( @str > 1 ) ? \@str : $str[0];
}

sub import {
	my ( $class, $pkg, $file, $line ) = ( shift, caller );
	die "Unknown symbol: $_ at $file line $line.\n" for grep 'titlecase' ne $_, @_;
	no strict 'refs';
	*{ $pkg . '::titlecase' } = \&titlecase if @_;
}

return 1 if defined caller;

eval 'use open qw( :encoding(UTF-8) :std ); 1' or die;
my $opt_force = @ARGV && '-f' eq $ARGV[0];
shift @ARGV if $opt_force;
shift @ARGV if @ARGV && '--' eq $ARGV[0];
print titlecase( $opt_force ? lc : $_ ), "\n" while readline;
