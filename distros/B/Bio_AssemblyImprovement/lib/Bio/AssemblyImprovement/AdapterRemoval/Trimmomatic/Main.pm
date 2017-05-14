package Bio::AssemblyImprovement::AdapterRemoval::Trimmomatic::Main;

# ABSTRACT: Remove adapter sequences from paired reads using Trimmomatic

# =head1 SYNOPSIS

# =cut

use File::Spec;
use Moose;


has 'minlen'           => ( is => 'ro', isa => 'Int', required => 0, default => 50 );
has 'reads_in_1'       => ( is => 'ro', isa => 'Str', required => 1 ); 
has 'reads_in_2'       => ( is => 'ro', isa => 'Str', required => 1 ); 
has 'paired_out_1'     => ( is => 'ro', isa => 'Str', required => 1 );
has 'paired_out_2'     => ( is => 'ro', isa => 'Str', required => 1 );
has 'unpaired_out_1'   => ( is => 'ro', isa => 'Str', required => 0, default => '/dev/null' );
has 'unpaired_out_2'   => ( is => 'ro', isa => 'Str', required => 0, default => '/dev/null' );
has 'trimmomatic_exec' => ( is => 'ro', isa => 'Str', required => 1 );
has 'adapters_file'    => ( is => 'ro', isa => 'Str', required => 1 );
has 'threads'          => ( is => 'ro', isa => 'Int', required => 0, default => 1 );


sub run {
    my ($self) = @_;
    my $cmd = join(
        ' ',
        (
            'java -Xmx1000m -jar', $self->trimmomatic_exec,
            'PE',
            '-threads', $self->threads,
            $self->reads_in_1,
            $self->reads_in_2,
            $self->paired_out_1,
            $self->unpaired_out_1,
            $self->paired_out_2,
            $self->unpaired_out_2,
            "ILLUMINACLIP:" . File::Spec->rel2abs($self->adapters_file) . ":2:10:7:1",
            "MINLEN:50",
        )
    );

    if (system($cmd)) {
        die "Error running Trimmomatic with:\n$cmd";
    }
}


no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bio::AssemblyImprovement::AdapterRemoval::Trimmomatic::Main - Remove adapter sequences from paired reads using Trimmomatic

=head1 VERSION

version 1.160490

=head1 AUTHOR

Andrew J. Page <ap13@sanger.ac.uk>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2012 by Wellcome Trust Sanger Institute.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
