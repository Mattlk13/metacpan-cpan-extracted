use lib 't/lib';

$ENV{ES_VERSION} = '5_0';
$ENV{ES_CXN} = 'HTTPTiny';
do "es_sync_fork.pl" or die( $@ || $! );

