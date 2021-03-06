use strict;
use warnings;
use Module::Build;


my $builder = Module::Build->new(
    add_to_cleanup      => [ 'Data-ObjectStore-*' ],
    build_requires => {
        'Test::More' => 0,
        'Module::Build' => 0.40,
    },
    dist_abstract      => 'Object store',
    create_makefile_pl => 'traditional',
    license            => 'perl',
    module_name        => 'Data::ObjectStore',
    release_status     => 'stable',
    test_files         => [ 't/object_store.t',
                            't/cache.t',
                        ],
    requires => {
        'perl'              => '5.16.0',
        'Data::RecordStore' => 6.04,
    },
    );

$builder->create_build_script();
