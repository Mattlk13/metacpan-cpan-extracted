use lib 't/lib';

$ENV{ES_VERSION} = '5_0';
$ENV{ES_CXN} = 'Mojo';
do "es_async_fork.pl" or die( $@ || $! );

