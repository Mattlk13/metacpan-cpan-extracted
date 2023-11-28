package School::Code::Compare::Charset::Signes;
# ABSTRACT: remove word characters completely
$School::Code::Compare::Charset::Signes::VERSION = '0.201';
use strict;
use warnings;

sub new {
    my $class = shift;

    my $self = {
               };
    bless $self, $class;

    return $self;
}

sub filter {
    my $self   = shift;
    my $lines_ref = shift;

    my @signes;

    foreach my $row (@{$lines_ref}) {

      $row =~ s/\w//g;
      next if ($row eq '');

      push @signes, $row;
    }

    return \@signes;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

School::Code::Compare::Charset::Signes - remove word characters completely

=head1 VERSION

version 0.201

=head1 AUTHOR

Boris Däppen <bdaeppen.perl@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2023 by Boris Däppen.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
