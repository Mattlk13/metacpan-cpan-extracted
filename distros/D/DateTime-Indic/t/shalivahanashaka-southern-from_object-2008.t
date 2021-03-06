#!perl
#
# $Id$
#
use strict;
use warnings;

use Test::More tests => 121;
use DateTime;
use DateTime::Calendar::ShalivahanaShaka::Southern;

# Source Date Panchanga http://www.datepanchang.com/panchang.asp
my $dates = {
    '01' => [
        '1929 mArgashIrasa kR^iShNa 9',
        '1929 mArgashIrasa kR^iShNa 10',
        '1929 mArgashIrasa kR^iShNa adhika 10',
        '1929 mArgashIrasa kR^iShNa 11',
        '1929 mArgashIrasa kR^iShNa 12',
        '1929 mArgashIrasa kR^iShNa 13',
        '1929 mArgashIrasa kR^iShNa 14',
        '1929 mArgashIrasa kR^iShNa 30',
        '1929 pauSha shukla 1',
        '1929 pauSha shukla 2',
        '1929 pauSha shukla 3',
        '1929 pauSha shukla 4',
        '1929 pauSha shukla 5',
        '1929 pauSha shukla 6',
        '1929 pauSha shukla 7',
        '1929 pauSha shukla 8',
        '1929 pauSha shukla 9',
        '1929 pauSha shukla 10',
        '1929 pauSha shukla 12',
        '1929 pauSha shukla 13',
        '1929 pauSha shukla 14',
        '1929 pauSha shukla 15',
        '1929 pauSha kR^iShNa 1',
        '1929 pauSha kR^iShNa 2',
        '1929 pauSha kR^iShNa 3',
        '1929 pauSha kR^iShNa 4',
        '1929 pauSha kR^iShNa 5',
        '1929 pauSha kR^iShNa 6',
        '1929 pauSha kR^iShNa 7',
        '1929 pauSha kR^iShNa 8',
        '1929 pauSha kR^iShNa 9',
    ],
    '02' => [
        '1929 pauSha kR^iShNa 10',
        '1929 pauSha kR^iShNa 11',
        '1929 pauSha kR^iShNa 12',
        '1929 pauSha kR^iShNa adhika 12',
        '1929 pauSha kR^iShNa 13',
        '1929 pauSha kR^iShNa 14',
        '1929 pauSha kR^iShNa 30',
        '1929 mAgha shukla 1',
        '1929 mAgha shukla 2',
        '1929 mAgha shukla 4',
        '1929 mAgha shukla 5',
        '1929 mAgha shukla 6',
        '1929 mAgha shukla 7',
        '1929 mAgha shukla 8',
        '1929 mAgha shukla 9',
        '1929 mAgha shukla 10',
        '1929 mAgha shukla 11',
        '1929 mAgha shukla 12',
        '1929 mAgha shukla 13',
        '1929 mAgha shukla 14',
        '1929 mAgha shukla 15',
        '1929 mAgha kR^iShNa 1',
        '1929 mAgha kR^iShNa 2',
        '1929 mAgha kR^iShNa 3',
        '1929 mAgha kR^iShNa 4',
        '1929 mAgha kR^iShNa 5',
        '1929 mAgha kR^iShNa 6',
        '1929 mAgha kR^iShNa 7',
        '1929 mAgha kR^iShNa 8',
    ],
    '03' => [
        '1929 mAgha kR^iShNa 9',
        '1929 mAgha kR^iShNa 10',
        '1929 mAgha kR^iShNa 11',
        '1929 mAgha kR^iShNa 12',
        '1929 mAgha kR^iShNa 13',
        '1929 mAgha kR^iShNa 14',
        '1929 mAgha kR^iShNa 30',
        '1929 phAlguna shukla 1',
        '1929 phAlguna shukla 2',
        '1929 phAlguna shukla 3',
        '1929 phAlguna shukla 4',
        '1929 phAlguna shukla 5',
        '1929 phAlguna shukla 6',
        '1929 phAlguna shukla 8',
        '1929 phAlguna shukla 9',
        '1929 phAlguna shukla 10',
        '1929 phAlguna shukla 11',
        '1929 phAlguna shukla 12',
        '1929 phAlguna shukla 13',
        '1929 phAlguna shukla 14',
        '1929 phAlguna shukla 15',
        '1929 phAlguna kR^iShNa 1',
        '1929 phAlguna kR^iShNa 2',
        '1929 phAlguna kR^iShNa 3',
        '1929 phAlguna kR^iShNa 4',
        '1929 phAlguna kR^iShNa adhika 4',
        '1929 phAlguna kR^iShNa 5',
        '1929 phAlguna kR^iShNa 6',
        '1929 phAlguna kR^iShNa 7',
        '1929 phAlguna kR^iShNa 8',
        '1929 phAlguna kR^iShNa 9',
    ],
    '04' => [
        '1929 phAlguna kR^iShNa 10',
        '1929 phAlguna kR^iShNa 11',
        '1929 phAlguna kR^iShNa 12',
        '1929 phAlguna kR^iShNa 13',
        '1929 phAlguna kR^iShNa 14',
        '1929 phAlguna kR^iShNa 30',
        '1930 chaitra shukla 2',
        '1930 chaitra shukla 3',
        '1930 chaitra shukla 4',
        '1930 chaitra shukla 5',
        '1930 chaitra shukla 6',
        '1930 chaitra shukla 7',
        '1930 chaitra shukla 8',
        '1930 chaitra shukla 9',
        '1930 chaitra shukla 10',
        '1930 chaitra shukla 11',
        '1930 chaitra shukla 12',
        '1930 chaitra shukla 13',
        '1930 chaitra shukla 14',
        '1930 chaitra shukla 15',
        '1930 chaitra kR^iShNa 1',
        '1930 chaitra kR^iShNa 2',
        '1930 chaitra kR^iShNa 3',
        '1930 chaitra kR^iShNa 4',
        '1930 chaitra kR^iShNa 5',
        '1930 chaitra kR^iShNa 6',
        '1930 chaitra kR^iShNa 7',
        '1930 chaitra kR^iShNa adhika 7',
        '1930 chaitra kR^iShNa 8',
        '1930 chaitra kR^iShNa 9',
    ],
};

foreach my $month (sort keys %{$dates}) {
    my $day = 0;
    foreach my $expected (@{$dates->{$month}}) {
        ++$day;
        my $dt = DateTime->new(day => $day, month => $month, year => '2008',
            time_zone => 'Asia/Kolkata');
        # sunrise at Mumbai
        my $date =
        DateTime::Calendar::ShalivahanaShaka::Southern->from_object(
            object    => $dt,
            latitude  => '18.53',
            longitude => '73.85',
#            latitude  => '18.96',
#            longitude => '72.82',
        );
        is($date->strftime("%x"), $expected, "$month $day, 2008");
    }
}
