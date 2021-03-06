use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Data::Domain',
    license             => 'perl',
    dist_author         => 'Laurent Dami <laurent.dami@justice.ge.ch>',
    dist_version_from   => 'lib/Data/Domain.pm',
    requires => {
      'perl'            => "5.010001",
      'autouse'         => 0,
      'experimental'    => 0,
      'Date::Calc'      => 0,
      'List::MoreUtils' => 0,
      'Scalar::Does'    => 0.007,
      'Scalar::Util'    => 0,
      'Sub::Exporter'   => 0,
      'Try::Tiny'       => 0,
     },
    build_requires => {
      'Test::More'   => 0,
    },
    add_to_cleanup      => [ 'Data-Domain-*' ],
    meta_merge => {
      resources => {
        repository => 'https://github.com/damil/Data-Domain',
       }
     },
);

$builder->create_build_script();
