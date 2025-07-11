# -*- cperl -*-
# ABSTRACT: LaTeX Mathelementlist object


use strict;
use warnings;
package SpeL::Object::MathElementList;

use parent 'Exporter';
use Carp;

use SpeL::Object::MathElement;

#use Data::Dumper;




sub read {
  my $self = shift;
  my ( $level, $separator ) = @_;

  return join( ' ',
	       map { $_->read( $level + 1 ) } @{$self->{MathElement}} );
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SpeL::Object::MathElementList - LaTeX Mathelementlist object

=head1 VERSION

version 20250511.1428

=head1 METHODS

=head2 new()

We keep the default method, as the object is generated by the parser.

=head2 read()

returns a string with the spoken version of the node

=head1 SYNOPSYS

Represents a LaTeX Mathelementlist

=head1 AUTHOR

Walter Daems <wdaems@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2025 by Walter Daems.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=head1 CONTRIBUTOR

=for stopwords Paul Levrie

Paul Levrie

=cut
