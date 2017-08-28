undef $VERSION;

package Bio::Roary::CommandLine::UniqueGenesPerSample;
$Bio::Roary::CommandLine::UniqueGenesPerSample::VERSION = '3.9.1';
# ABSTRACT: Take in the clustered file and produce a sorted file with the frequency of each samples unique genes


use Moose;
use Getopt::Long qw(GetOptionsFromArray);
use Bio::Roary::UniqueGenesPerSample;

extends 'Bio::Roary::CommandLine::Common';

has 'args'        => ( is => 'ro', isa => 'ArrayRef', required => 1 );
has 'script_name' => ( is => 'ro', isa => 'Str',      required => 1 );
has 'help'        => ( is => 'rw', isa => 'Bool',     default  => 0 );

has 'clustered_proteins' => ( is => 'rw', isa => 'Str',  default => 'clustered_proteins' );
has 'output_filename'    => ( is => 'rw', isa => 'Str',  default => 'unique_genes_per_sample.tsv' );
has 'verbose'            => ( is => 'rw', isa => 'Bool', default => 0 );
has '_error_message'     => ( is => 'rw', isa => 'Str' );

sub BUILD {
    my ($self) = @_;

    my ( $clustered_proteins, $output_filename, $verbose, $help );

    GetOptionsFromArray(
        $self->args,
        'o|output=s'             => \$output_filename,
        'c|clustered_proteins=s' => \$clustered_proteins,
        'v|verbose'              => \$verbose,
        'h|help'                 => \$help,
    );

    if ( defined($verbose) ) {
        $self->verbose($verbose);
        $self->logger->level(10000);
    }

    $self->help($help) if ( defined($help) );
    ( !$self->help ) or die $self->usage_text;

    $self->output_filename($output_filename) if ( defined($output_filename) );
    if ( defined($clustered_proteins) && ( -e $clustered_proteins ) ) {
        $self->clustered_proteins($clustered_proteins);
    }
    else {
        $self->_error_message("Error: Cant access the clustered proteins file");
    }
}

sub run {
    my ($self) = @_;

    if ( defined( $self->_error_message ) ) {
        print $self->_error_message . "\n";
        die $self->usage_text;
    }

    my $obj = Bio::Roary::UniqueGenesPerSample->new(
        clustered_proteins  => $self->clustered_proteins,
        output_filename => $self->output_filename,
    );
    $obj->write_unique_frequency;

}

sub usage_text {
    my ($self) = @_;

    return <<USAGE;
Usage: roary-unique_genes_per_sample [options] -c clustered_proteins
Take in the clustered file and produce a sorted file with the frequency of each samples unique genes

Options: -o STR output filename [unique_genes_per_sample.tsv]
         -c STR clusters filename [clustered_proteins]
         -v     verbose output to STDOUT
         -h     this help message

For further info see: http://sanger-pathogens.github.io/Roary/
USAGE
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bio::Roary::CommandLine::UniqueGenesPerSample - Take in the clustered file and produce a sorted file with the frequency of each samples unique genes

=head1 VERSION

version 3.9.1

=head1 SYNOPSIS

Take in the clustered file and produce a sorted file with the frequency of each samples unique genes

=head1 AUTHOR

Andrew J. Page <ap13@sanger.ac.uk>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Wellcome Trust Sanger Institute.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
