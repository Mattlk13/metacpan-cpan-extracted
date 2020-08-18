package Bio::MUST::Core::Taxonomy::Filter;
# ABSTRACT: Helper class for filtering seqs according to taxonomy
$Bio::MUST::Core::Taxonomy::Filter::VERSION = '0.202310';
use Moose;
use namespace::autoclean;

use autodie;
use feature qw(say);

use Smart::Comments;

use Carp;
use Const::Fast;
use List::AllUtils;

use Bio::MUST::Core::Types;
use aliased 'Bio::MUST::Core::IdList';
with 'Bio::MUST::Core::Roles::Taxable';


has '_specs' => (
    is       => 'ro',
    isa      => 'Bio::MUST::Core::IdList',
    required => 1,
    coerce   => 1,
    handles  => {
        all_specs => 'all_ids',
    },
);


has '_is_' . $_ => (
    traits   => ['Hash'],
    is       => 'ro',
    isa      => 'HashRef',
    init_arg => undef,
    writer   => '_set_is_' . $_,
    handles  => {
        'all_' . $_ => 'keys',
         'is_' . $_ => 'defined',
    },
) for qw(wanted unwanted);


# regexes for deriving filter from specifications
const my $WANTED   => qr{\A \+ \s* (.*) }xms;
const my $UNWANTED => qr{\A \- \s* (.*) }xms;

sub BUILD {
    my $self = shift;

    # parse filter specifications
    my   @wanted = map { $_ =~   $WANTED ? $1 : () } $self->all_specs;
    my @unwanted = map { $_ =~ $UNWANTED ? $1 : () } $self->all_specs;

    # warn in case of ambiguous taxa
    for my $taxon (@wanted, @unwanted) {
        carp "[BMC] Warning: $taxon is taxonomically ambiguous in filter!"
            if $self->tax->is_dupe($taxon);
    }

    # build filtering hashes from wanted and unwanted arrays
    # Note: we want no virus by default but exclude nothing
    push @wanted, 'cellular organisms' unless @wanted;
    my %is_wanted   = map { $_ => 1 }   @wanted;
    my %is_unwanted = map { $_ => 1 } @unwanted;

    # store HashRefs for filter
    $self->_set_is_wanted(  \%is_wanted  );
    $self->_set_is_unwanted(\%is_unwanted);

    return;
}



sub is_allowed {
    my $self   = shift;
    my $seq_id = shift;

    # test whether lineage of seq_id has at least one wanted taxon
    #                         ... or has at least one unwanted taxon
    # non-matching taxa are allowed by default

    my @lineage = $self->tax->fetch_lineage($seq_id);
    return undef unless @lineage;   ## no critic (ProhibitExplicitReturnUndef)

    return 0 unless List::AllUtils::any { $self->is_wanted(  $_) } @lineage;
    return 0     if List::AllUtils::any { $self->is_unwanted($_) } @lineage;
    return 1;
}



sub tax_list {
    my $self     = shift;
    my $listable = shift;

    my @ids;
    for my $seq_id ($listable->all_seq_ids) {
        push @ids, $seq_id->full_id if $self->is_allowed($seq_id);
    }

    return IdList->new( ids => \@ids );
}

__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=head1 NAME

Bio::MUST::Core::Taxonomy::Filter - Helper class for filtering seqs according to taxonomy

=head1 VERSION

version 0.202310

=head1 SYNOPSIS

    # TODO

=head1 DESCRIPTION

    # TODO

=head1 METHODS

=head2 is_allowed

=head2 tax_list

=head1 AUTHOR

Denis BAURAIN <denis.baurain@uliege.be>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by University of Liege / Unit of Eukaryotic Phylogenomics / Denis BAURAIN.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
