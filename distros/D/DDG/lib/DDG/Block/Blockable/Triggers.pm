package DDG::Block::Blockable::Triggers;
our $AUTHORITY = 'cpan:DDG';
# ABSTRACT: A package which reflects the triggers of a blockable plugin.
$DDG::Block::Blockable::Triggers::VERSION = '1016';
use Moo;
use Carp;

our @words_types = qw(

	start
	end
	startend
	any

);

our @regexp_types = qw(

	query_raw
	query
	query_lc
	query_nowhitespace
	query_nowhitespace_nodash
	query_clean

);

our $default_regexp_type = 'query_raw';

has triggers => (
	is => 'ro',
	default => sub {{}},
);

has block_type => (
	is => 'rw',
	predicate => 'has_block_type',
);

sub get { shift->triggers }

sub add {
	my ( $self, @args ) = @_;
	my %params;
	if (ref $args[0] eq 'CODE') {
		%params = $args[0]->();
	} elsif (ref $args[0] eq 'HASH') {
		%params = %{$args[0]};
	} elsif (ref $args[0] eq 'Regexp') {
		%params = ( $default_regexp_type => [@args] );
	} else {
		if (scalar @args > 2) {
			%params = ( $args[0] => [@args[1..(scalar @args-1)]] );
		} else {
			%params = ( $args[0] => $args[1] );
		}
	}
	for (keys %params) {
		my $trigger_type = $_;
		my @triggers = ref $params{$trigger_type} eq 'ARRAY' ? @{$params{$trigger_type}} : ($params{$trigger_type});
		croak 'no trigger values given' unless @triggers;
		$self->add_triggers($trigger_type, @triggers);
	}
}

sub add_triggers {
	my ( $self, $trigger_type, @add_triggers ) = @_;
	my @triggers;
	for (@add_triggers) {
		push @triggers, ref $_ eq 'CODE' ? $_->() : $_;
	}
	if (grep { $_ eq $trigger_type } @words_types) {
		croak "You can't add trigger types of the other block-type" if $self->has_block_type && $self->block_type ne 'Words';
		$self->block_type('Words');
	} elsif (grep { $_ eq $trigger_type } @regexp_types) {
		croak "You can't add trigger types of the other block-type" if $self->has_block_type && $self->block_type ne 'Regexp';
		$self->block_type('Regexp');
		for (@triggers) {
			croak 'You may only give compiled regexps to regexp trigger types (like qr/reverse (.*)/i)' unless ref $_ eq 'Regexp';
		}
	}
	croak "your trigger_type '".$trigger_type."' is unknown" unless $self->has_block_type;
	$self->triggers->{$_} = [] unless defined $self->triggers->{$_};
	push @{$self->triggers->{$_}}, @triggers;
}

1;

__END__

=pod

=head1 NAME

DDG::Block::Blockable::Triggers - A package which reflects the triggers of a blockable plugin.

=head1 VERSION

version 1016

=head1 AUTHOR

DuckDuckGo <open@duckduckgo.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by DuckDuckGo, Inc. L<https://duckduckgo.com/>.

This is free software, licensed under:

  The Apache License, Version 2.0, January 2004

=cut
