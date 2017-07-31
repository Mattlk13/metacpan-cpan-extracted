package MooseX::DIC::ServiceFactoryFactory;

require Exporter;
@ISA       = qw/Exporter/;
@EXPORT_OK = qw/build_factory/;

use aliased 'MooseX::DIC::ContainerException';
use Module::Load;

sub build_factory {
    my ( $factory_type, $container ) = @_;

    my $service_factory = eval {
        load "MooseX::DIC::ServiceFactory::$factory_type";
        "MooseX::DIC::ServiceFactory::$factory_type"
            ->new( container => $container );
    };
    ContainerException->throw(
        message => "Could not build the service factory $factory_type: $@" )
        if $@;

    return $service_factory;
}

1;
