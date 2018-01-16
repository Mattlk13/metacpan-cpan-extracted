package Bio::Roary::External::GeneAlignmentFromNucleotides;
$Bio::Roary::External::GeneAlignmentFromNucleotides::VERSION = '3.11.3';
# ABSTRACT: Take in multi-FASTA files of nucleotides and align each file with PRANK or MAFFT


use Moose;
with 'Bio::Roary::JobRunner::Role';

has 'fasta_files'                 => ( is => 'ro', isa => 'ArrayRef', required => 1 );
has 'exec'                        => ( is => 'ro', isa => 'Str',      default  => 'protein_alignment_from_nucleotides' );
has 'translation_table'           => ( is => 'rw', isa => 'Int',      default => 11 );
has 'core_definition'             => ( is => 'ro', isa => 'Num',      default => 1 );
has 'mafft'                       => ( is => 'ro', isa => 'Bool',     default => 0 );
has 'dont_delete_files'           => ( is => 'rw', isa => 'Bool',     default  => 0 );
has 'allow_paralogs'              => ( is => 'rw', isa => 'Bool',     default  => 0 );
has 'num_input_files'             => ( is => 'ro', isa => 'Int',      required => 1);

# Overload Role`
has 'memory_in_mb' => ( is => 'rw', isa => 'Int', lazy     => 1, builder => '_build_memory_in_mb' );
has '_min_memory_in_mb'      => ( is => 'ro', isa => 'Int', default => 1500 );
has '_max_memory_in_mb'      => ( is => 'ro', isa => 'Int', default => 60000 );
has '_queue'                 => ( is => 'rw', isa => 'Str', default  => 'normal' );
has '_files_per_chunk'       => ( is => 'ro', isa => 'Int', lazy     => 1, builder => '_build__files_per_chunk' );
has '_core_alignment_cmd'    => ( is => 'rw', isa => 'Str', lazy_build => 1 );
has '_dependancy_memory_in_mb'  => ( is => 'ro', isa => 'Int', default => 15000 );

sub _build__files_per_chunk
{
    my ($self) = @_;
    return 1;
}

sub _build_memory_in_mb {
    my ($self)          = @_;

    my $largest_file_size = 1;
    for my $file (@{$self->fasta_files})
    {
        my $file_size = -s $file;
        if($file_size > $largest_file_size)
        {
            $largest_file_size = $file_size;
        }
    }
    
    my $approx_sequence_length_of_largest_file = $largest_file_size/ $self->num_input_files;
    my $memory_required = int((($approx_sequence_length_of_largest_file*$approx_sequence_length_of_largest_file)/1000000)*2 + $self->_min_memory_in_mb);
    
    $memory_required = $self->_max_memory_in_mb if($memory_required  > $self->_max_memory_in_mb);

    return $memory_required;
}

sub _command_to_run {
    my ( $self, $fasta_files) = @_;
	my $verbose = "";
	if($self->verbose)
	{
		$verbose = ' -v ';
	}
    my $mafft_str = "";	
	$mafft_str = ' --mafft ' if($self->mafft);
    return $self->exec." ".$verbose.$mafft_str.join( " ", @{$fasta_files}  );
}

sub _build__core_alignment_cmd {
    my ( $self ) = @_;
    
    my $core_cmd = "pan_genome_core_alignment";
    $core_cmd .= " -cd " . ($self->core_definition*100) if ( defined $self->core_definition );
    $core_cmd .= " --dont_delete_files " if ( defined $self->dont_delete_files  && $self->dont_delete_files == 1 );
	$core_cmd .= " --allow_paralogs " if ( defined $self->allow_paralogs  && $self->allow_paralogs == 1 );

    return $core_cmd;
}

sub run {
    my ($self) = @_;
    my @commands_to_run;

    my @files_chunk;
    for my $fasta_file ( @{ $self->fasta_files } ) {
        push(@files_chunk,$fasta_file);
        if(@files_chunk == $self->_files_per_chunk )
        {
          push(@commands_to_run, $self->_command_to_run(\@files_chunk));
		  $self->logger->info( "Running command: " . $self->_command_to_run(\@files_chunk) );
          @files_chunk = ();
        }
    }
    
    if(@files_chunk > 0)
    {
      push(@commands_to_run, $self->_command_to_run(\@files_chunk));
	  $self->logger->info( "Running command: " . $self->_command_to_run(\@files_chunk) );
    }

    my $job_runner_obj = $self->_job_runner_class->new(
        commands_to_run => \@commands_to_run,
        memory_in_mb    => $self->memory_in_mb,
        queue           => $self->_queue,
        dont_wait       => 1,
        cpus            => $self->cpus 
    );
    $job_runner_obj->run();
    
	$job_runner_obj->memory_in_mb($self->_dependancy_memory_in_mb);
	$self->logger->info( "Running command: " . $self->_core_alignment_cmd() );
    $job_runner_obj->submit_dependancy_job($self->_core_alignment_cmd);
    1;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bio::Roary::External::GeneAlignmentFromNucleotides - Take in multi-FASTA files of nucleotides and align each file with PRANK or MAFFT

=head1 VERSION

version 3.11.3

=head1 SYNOPSIS

Take in multi-FASTA files of nucleotides and align each file with PRANK or MAFFT

   use Bio::Roary::External::GeneAlignmentFromNucleotides;
   
   my $seg = Bio::Roary::External::GeneAlignmentFromNucleotides->new(
     fasta_files => [],
   );
   
   $seg->run();

=head1 METHODS

=head2 output_file

Returns the path to the results file

=head1 AUTHOR

Andrew J. Page <ap13@sanger.ac.uk>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Wellcome Trust Sanger Institute.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
