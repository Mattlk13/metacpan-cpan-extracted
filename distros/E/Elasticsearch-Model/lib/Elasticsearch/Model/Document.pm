package Elasticsearch::Model::Document;

use Moose ();

use Moose::Exporter;
use Elasticsearch::Model::Document::Role::Metaclass;

my (undef, undef, $init_meta) = Moose::Exporter->build_import_methods(
    install   => [qw(
        import
        unimport
    )],
    with_meta => [qw(
        has
        has_non_attribute_mapping
    )],
    class_metaroles => {
        class => [
            'Elasticsearch::Model::Document::Role::Metaclass',
        ]
    },
);

sub has { shift->add_property(@_) }

sub init_meta {
    my $class = shift;
    my %p     = @_;

    Moose::Util::ensure_all_roles(
        $p{for_class},
        qw(Elasticsearch::Model::Document::Role)
    );

    $class->$init_meta(%p);
}

sub has_non_attribute_mapping {
    my ($self,$mapping) = @_;
    $self->non_attribute_mapping($mapping);
}

1;

