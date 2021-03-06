package Feed::Data::Parser;

use Moo;
use Carp qw/croak/;

use Class::Load qw/load_class/;
use Types::Standard qw/Object ScalarRef Str/;

has 'stream' => (
	is  => 'ro',
	isa => ScalarRef,
	lazy => 1,
);

has 'parse_tag' => (
	is  => 'ro',
	isa => Str,
	lazy => 1,
	default => sub {
		my $self = shift;
		my $content = $self->stream;
		my $tag;
		if ($$content =~ m/^([A-Za-z]+)\s*\:/) {
			$tag = 'text';
		} elsif ($$content =~ m/^\s*\[/) {
			$tag = 'json';
		} elsif ($$content =~ m/^([A-Za-z]+,)/) {
			$tag = 'csv';
		} elsif ($$content =~ m/---/) {
			$tag = 'yaml';
		} else {
			while ( $$content =~ /<(\S+)/sg) {
				(my $t = $1) =~ tr/a-zA-Z0-9:\-\?!//cd;
				my $first = substr $t, 0, 1;
				$tag = $t, last unless $first eq '?' || $first eq '!';
			}
		}
		croak 'Could not find the first XML element' unless $tag;
		$tag =~ s/^,*://;
		return $tag;
	}
);

has 'parser_type' => (
	is => 'ro',
	isa => Str,
	lazy => 1,
	default => sub {
		my $self = shift;
		my $tag = $self->parse_tag;
		return 'RSS' if $tag =~ /^(?:rss|rdf)/i;
		return 'Atom' if $tag =~ /^feed/i;
		return 'Meta' if $tag =~ /^html/i;
		return 'Text' if $tag =~ /^text/;
		return 'JSON' if $tag =~ /^json/;
		return 'CSV' if $tag =~ /^csv/;
		return 'Table' if $tag =~ /^table/;
		return 'YAML' if $tag =~ /^yaml/;
		return croak "Could not find a parser";
	}
);

has 'parse' => (
	is => 'ro',
	isa => Object,
	lazy => 1,
	default => sub {
		my $self = shift;
		my $type = $self->parser_type;
		my $class = "Feed::Data::Parser::" . $type;
		load_class($class);
		return $class->new(content_ref => $self->stream);
	}
);

1; # End of Feed::Data
