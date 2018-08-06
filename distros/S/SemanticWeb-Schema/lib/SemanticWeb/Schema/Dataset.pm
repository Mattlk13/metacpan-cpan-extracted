package SemanticWeb::Schema::Dataset;

# ABSTRACT: A body of structured information describing some topic(s) of interest.

use Moo;

extends qw/ SemanticWeb::Schema::CreativeWork /;


use MooX::JSON_LD 'Dataset';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v0.0.1';


has catalog => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'catalog',
);



has dataset_time_interval => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'datasetTimeInterval',
);



has distribution => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'distribution',
);



has included_data_catalog => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'includedDataCatalog',
);



has included_in_data_catalog => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'includedInDataCatalog',
);



has issn => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'issn',
);



has spatial => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'spatial',
);



has temporal => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'temporal',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::Dataset - A body of structured information describing some topic(s) of interest.

=head1 VERSION

version v0.0.1

=head1 DESCRIPTION

A body of structured information describing some topic(s) of interest.

=head1 ATTRIBUTES

=head2 C<catalog>

A data catalog which contains this dataset.

A catalog should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::DataCatalog']>

=back

=head2 C<dataset_time_interval>

C<datasetTimeInterval>

The range of temporal applicability of a dataset, e.g. for a 2011 census
dataset, the year 2011 (in ISO 8601 time interval format).

A dataset_time_interval should be one of the following types:

=over

=item C<Str>

=back

=head2 C<distribution>

A downloadable form of this dataset, at a specific location, in a specific
format.

A distribution should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::DataDownload']>

=back

=head2 C<included_data_catalog>

C<includedDataCatalog>

A data catalog which contains this dataset (this property was previously
'catalog', preferred name is now 'includedInDataCatalog').

A included_data_catalog should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::DataCatalog']>

=back

=head2 C<included_in_data_catalog>

C<includedInDataCatalog>

A data catalog which contains this dataset.

A included_in_data_catalog should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::DataCatalog']>

=back

=head2 C<issn>

The International Standard Serial Number (ISSN) that identifies this serial
publication. You can repeat this property to identify different formats of,
or the linking ISSN (ISSN-L) for, this serial publication.

A issn should be one of the following types:

=over

=item C<Str>

=back

=head2 C<spatial>

The range of spatial applicability of a dataset, e.g. for a dataset of New
York weather, the state of New York.

A spatial should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Place']>

=back

=head2 C<temporal>

The range of temporal applicability of a dataset, e.g. for a 2011 census
dataset, the year 2011 (in ISO 8601 time interval format).

A temporal should be one of the following types:

=over

=item C<Str>

=back

=head1 SEE ALSO

L<SemanticWeb::Schema::CreativeWork>

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
