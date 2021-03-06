=head1 NAME

Bio::BioStudio::SeqFeature::Custom

=head1 VERSION

Version 3.00

=head1 DESCRIPTION

BioStudio functions

=head1 AUTHOR

Sarah Richardson <smrichardson@lbl.gov>.

=cut

package Bio::BioStudio::SeqFeature::Custom;

use strict;
use warnings;

use base qw(Bio::DB::SeqFeature);

=head2 new

=cut

sub new
{
  my ($caller, @args) = @_;
  my $self = $caller->SUPER::new(@args);
  
  my ($prototype, $primary_tag, $default_sequence) =
    $self->_rearrange([qw(PROTOTYPE PRIMARY_TAG DEFAULT_SEQUENCE)], @args);
  
  if (! $primary_tag)
  {
    $self->throw('primary_tag not specified');
  }
  if (! $prototype)
  {
    $self->throw('prototype not specified');
  }
  $self->primary_tag($primary_tag);
  $self->source('BS');
  $self->{prototype} = $prototype;
  $self->{default_sequence} = $default_sequence if ($default_sequence);
  return $self;
}

=head2 default_sequence

=cut

sub default_sequence
{
  my ($self) = @_;
  return $self->{default_sequence};
}

=head2 prototype

=cut

sub prototype
{
  my ($self) = @_;
  return $self->{prototype};
}

=head2 seq

=cut

sub seq
{
  my ($self) = @_;
  my $seqobj = Bio::Seq->new(
    -id => $self->{prototype},
    -seq => $self->{default_sequence}
  );
  return $seqobj;
}

1;

__END__

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2015, BioStudio developers
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this
list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

* The names of Johns Hopkins, the Joint Genome Institute, the Joint BioEnergy 
Institute, the Lawrence Berkeley National Laboratory, the Department of Energy, 
and the BioStudio developers may not be used to endorse or promote products 
derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE DEVELOPERS BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut
