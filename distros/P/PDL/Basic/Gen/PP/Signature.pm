package PDL::PP::Signature;

use strict; use warnings;
use PDL::PP::PdlParObj;
use PDL::PP::Dims;
use Carp;

=head1 NAME

PDL::PP::Signature - Internal module to handle signatures

=head1 DESCRIPTION

Internal module to handle signatures

=head1 SYNOPSIS

 use PDL::PP::Signature;

=cut

# Eliminate whitespace entries
sub nospacesplit {grep /\S/, split $_[0],$_[1]}

sub new {
  my ($type,$str,$bvalflag) = @_;
  $bvalflag ||= 0;
  my $this = bless {}, $type;
  my @objects = map PDL::PP::PdlParObj->new($_,$bvalflag, $this), nospacesplit ';',$str;
  $this->{Names} = [ map $_->name, @objects ];
  $this->{Objects} = { map +($_->name => $_), @objects };
  my @objects_sorted = ((grep !$_->{FlagW}, @objects), (grep $_->{FlagW}, @objects));
  $objects_sorted[$_]{Number} = $_ for 0..$#objects_sorted;
  $this->{NamesSorted} = [ map $_->name, @objects_sorted ];
  $this->{DimsObj} = my $dimsobj = PDL::PP::PdlDimsObj->new;
  $_->add_inds($dimsobj) for @objects;
  my %ind2use;
  for my $o (@objects) {
    push @{$ind2use{$_}}, $o for map $_->name, @{$o->{IndObjs}};
  }
  $this->{Ind2Use} = \%ind2use;
  $this;
}

*with = \&new;

=head1 AUTHOR

Copyright (C) Tuomas J. Lukka 1997 (lukka@husc.harvard.edu) and by Christian
Soeller (c.soeller@auckland.ac.nz).
All rights reserved. There is no warranty. You are allowed
to redistribute this software / documentation under certain
conditions. For details, see the file COPYING in the PDL
distribution. If this file is separated from the PDL distribution,
the copyright notice should be included in the file.

=cut

sub names { $_[0]->{Names} }
sub names_sorted { $_[0]->{NamesSorted} }

sub objs { $_[0]->{Objects} }

sub dims_obj { $_[0]->{DimsObj} }
sub dims_count { scalar keys %{$_[0]->{DimsObj}} }
sub dims_values { values %{$_[0]->{DimsObj}} }

sub ind_used { $_[0]->{Ind2Use}{$_[1]} }

sub realdims {
  my $this = shift;
  [ map scalar @{$this->{Objects}->{$_}->{RawInds}}, @{$this->{Names}} ];
}

sub creating {
  my $this = shift;
  croak "you must perform a checkdims before calling creating"
    unless defined $this->{Create};
  return $this->{Create};
}

sub checkdims {
  my $this = shift;
  # we have to recreate to keep defaults currently
  $this->{Dims} = PDL::PP::PdlDimsObj->new;
  $this->{Objects}->{$_}->add_inds($this->{Dims}) for @{$this->{Names}};
  my $n = @{$this->{Names}};
  croak "not enough pdls to match signature" unless $#_ >= $n-1;
  my @pdls = @_[0..$n-1];
  if ($PDL::debug) { print "args: ".
		     join(' ,',map { "[".join(',',$_->dims)."]," } @pdls)
		       . "\n"}
  my $i = 0;
  my @creating = map $this->{Objects}->{$_}->perldimcheck($pdls[$i++]),
         @{$this->{Names}};
  $i = 0;
  for (@{$this->{Names}}) {
    push @creating, $this->{Objects}->{$_}->getcreatedims
      if $creating[$i++];
  }
  $this->{Create} = \@creating;
  $i = 0;
  my $corr = 0;
  for (@{$this->{Names}}) {
    $corr = $this->{Objects}->{$_}->finalcheck($pdls[$i++]);
    next unless $#$corr>-1;
    my ($j,$str) = (0,"");
    for (@$corr) {$str.= ":,"x($_->[0]-$j)."(0),*$_->[1],";
			$j=$_->[0]+1 }
    chop $str;
    $_[$i-1] = $pdls[$i-1]->slice($str);
  }
}

1;
