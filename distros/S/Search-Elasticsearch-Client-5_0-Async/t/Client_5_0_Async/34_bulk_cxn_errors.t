use Test::More;
use Test::Deep;
use Test::Exception;
use AE;

use strict;
use warnings;
use lib 't/lib';
use Log::Any::Adapter;

$ENV{ES_VERSION}   = '5_0';
$ENV{ES}           = '10.255.255.1:9200';
$ENV{ES_SKIP_PING} = 1;
$ENV{ES_CXN_POOL}  = 'Async::Static';

my $es = do "es_async.pl" or die( $@ || $! );
my $error;
my $b = $es->bulk_helper( index => 'foo', type => 'bar' );
$b->create_docs( { foo => 'bar' } );

# Check that the buffer is not cleared on a NoNodes exception

is $b->_buffer_count, 1, "Buffer count pre-flush";

wait_for(
    $b->flush->catch(
        sub {
            my $error = shift;
            isa_ok $error, 'Search::Elasticsearch::Error::NoNodes';
        }
    )
);

is $b->_buffer_count, 1, "Buffer count post-flush";

done_testing;
