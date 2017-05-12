#
#  Copyright 2009-2013 MongoDB, Inc.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#


use strict;
use warnings;
use Test::More;
use Test::Fatal;

use MongoDB::Timestamp; # needed if db is being run as master
use MongoDB;
use DateTime;

use constant HAS_DATETIME_TINY => eval { require DateTime::Tiny; 1 };

use lib "t/lib";
use MongoDBTest qw/skip_unless_mongod build_client get_test_db/;

skip_unless_mongod();

my $conn = build_client();
my $testdb = get_test_db($conn);
my $base_coll = $testdb->get_collection( 'test_collection' );

my $now = DateTime->now;

{
    $base_coll->insert_one( { date => $now } );
    my $date1 = $base_coll->find_one->{date};
    isa_ok $date1, 'DateTime';
    is $date1->epoch, $now->epoch;
    $base_coll->drop;
}

{
    my $coll = $base_coll->with_codec( dt_type => undef );

    $coll->insert_one( { date => $now } );
    my $date3 = $coll->find_one->{date};
    ok( ! ref $date3, "dt_type undef returns unblessed value" );
    is( $date3, $now->epoch, "returned value is epoch secs without fractions" );
    $coll->drop;
}

if ( HAS_DATETIME_TINY ) {
    my $coll = $base_coll->with_codec( dt_type => "DateTime::Tiny" );

    $coll->insert_one( { date => $now } );
    my $date2 = $coll->find_one->{date};
    isa_ok( $date2, 'DateTime::Tiny' );
    is $date2->DateTime->epoch, $now->epoch;
    $coll->drop;
}

{
    my $coll = $base_coll->with_codec( dt_type => "DateTime::Bad" );

    $coll->insert_one( { date => $now } );
    like( exception { 
            my $date4 = $coll->find_one->{date};
        },
        qr/Invalid dt_type "DateTime::Bad"/i,
        "invalid dt_type throws"
    );
    $coll->drop;
}

# roundtrips

{
    $base_coll->insert_one( { date => $now } );
    my $doc = $base_coll->find_one;

    $doc->{date}->add( seconds => 60 );

    $base_coll->replace_one( { _id => $doc->{_id} }, { date => $doc->{date} } );

    my $doc2 = $base_coll->find_one;
    is( $doc2->{date}->epoch, ( $now->epoch + 60 ) );
    $base_coll->drop;
}


if ( HAS_DATETIME_TINY ) {
    my $coll = $base_coll->with_codec( dt_type => "DateTime::Tiny" );

    my $dtt_now = DateTime::Tiny->now;
    $coll->insert_one( { date => $dtt_now } );
    my $doc = $coll->find_one;

    is $doc->{date}->year,   $dtt_now->year;
    is $doc->{date}->month,  $dtt_now->month;
    is $doc->{date}->day,    $dtt_now->day;
    is $doc->{date}->hour,   $dtt_now->hour;
    is $doc->{date}->minute, $dtt_now->minute;
    is $doc->{date}->second, $dtt_now->second;

    $doc->{date} = DateTime::Tiny->from_string( $doc->{date}->DateTime->add( seconds => 30 )->iso8601 );
    $coll->replace_one( { _id => $doc->{_id} }, $doc );

    my $doc2 = $coll->find_one( { _id => $doc->{_id} } );

    is( $doc2->{date}->DateTime->epoch, $dtt_now->DateTime->epoch + 30 );
    $coll->drop;
}

{
    # test fractional second roundtrip
    my $now = DateTime->now;
    $now->add( nanoseconds => 500_000_000 );

    $base_coll->insert_one( { date => $now } );
    my $doc = $base_coll->find_one;

    is $doc->{date}->year,       $now->year;
    is $doc->{date}->month,      $now->month;
    is $doc->{date}->day,        $now->day;
    is $doc->{date}->hour,       $now->hour;
    is $doc->{date}->minute,     $now->minute;
    is $doc->{date}->second,     $now->second;
    is $doc->{date}->nanosecond, $now->nanosecond;
    $base_coll->drop;
}

done_testing;
