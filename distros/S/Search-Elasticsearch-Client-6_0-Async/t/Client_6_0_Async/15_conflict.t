use Test::More;
use strict;
use warnings;
use AE;
use lib 't/lib';

$ENV{ES_VERSION} = '6_0';
my $es = do "es_async.pl" or die( $@ || $! );

wait_for( $es->indices->delete( index => '_all' ) );

my $error;

wait_for(
    $es->index( index => 'test', type => 'test', id => 1, body => {} )->then(
        sub {
            $es->index(
                index   => 'test',
                type    => 'test',
                id      => 1,
                body    => {},
                version => 2
            );
        }
    )->catch( sub { $error = shift() } )
);

ok $error->is('Conflict'), 'Conflict Exception';
is $error->{vars}{current_version}, 1, "Error has current version v1";

done_testing;
