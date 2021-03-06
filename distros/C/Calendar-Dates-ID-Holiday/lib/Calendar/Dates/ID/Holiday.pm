package Calendar::Dates::ID::Holiday;

our $DATE = '2019-02-15'; # DATE
our $VERSION = '0.007'; # VERSION

use 5.010001;
use strict;
use warnings;

use Calendar::Indonesia::Holiday;
use Role::Tiny::With;

with 'Calendar::DatesRoles::DataUser::CalendarVar';

our $CALENDAR;

sub prepare_data {
    $CALENDAR = {
        entries => [],
    };

    my $res = Calendar::Indonesia::Holiday::list_id_holidays(detail=>1);
    die "Cannot get list of holidays from Calendar::Indonesia::Holiday: $res->[0] - $res->[1]"
        unless $res->[0] == 200;
    for my $e (@{ $res->[2] }) {
        $e->{summary} = delete $e->{eng_name};
        $e->{"summary.alt.lang.id"} = delete $e->{ind_name};
        if ($e->{eng_aliases} && @{ $e->{eng_aliases} }) {
            $e->{description} = "Also known as ".
                join(", ", @{ delete $e->{eng_aliases} });
        }
        if ($e->{ind_aliases} && @{ $e->{ind_aliases} }) {
            $e->{"description.alt.lang.id"} = "Juga dikenal dengan ".
                join(", ", @{ delete $e->{ind_aliases} });
        }
        push @{ $CALENDAR->{entries} }, $e;
    }
}

1;
# ABSTRACT: Indonesian holiday calendar

__END__

=pod

=encoding UTF-8

=head1 NAME

Calendar::Dates::ID::Holiday - Indonesian holiday calendar

=head1 VERSION

This document describes version 0.007 of Calendar::Dates::ID::Holiday (from Perl distribution Calendar-Dates-ID-Holiday), released on 2019-02-15.

=head1 SYNOPSIS

=head2 Using from Perl

 use Calendar::Dates::ID::Holiday;
 my $min_year = Calendar::Dates::ID::Holiday->get_min_year; # => 2002
 my $max_year = Calendar::Dates::ID::Holiday->get_max_year; # => 2019
 my $entries  = Calendar::Dates::ID::Holiday->get_entries(2019);

C<$entries> result:

 [
   {
     "date" => "2019-01-01",
     "day" => 1,
     "dow" => 2,
     "is_holiday" => 1,
     "is_joint_leave" => 0,
     "month" => 1,
     "summary" => "New Year",
     "summary.alt.lang.id" => "Tahun Baru",
     "tags" => ["international", "fixed-date"],
     "year" => 2019,
   },
   {
     "date"                => "2019-02-05",
     "day"                 => 5,
     "dow"                 => 2,
     "eng_aliases"         => [],
     "ind_aliases"         => [],
     "is_holiday"          => 1,
     "is_joint_leave"      => 0,
     "month"               => 2,
     "summary"             => "Chinese New Year 2570",
     "summary.alt.lang.id" => "Tahun Baru Imlek 2570",
     "tags"                => ["international", "calendar=lunar"],
     "year"                => 2019,
   },
   {
     "date" => "2019-03-07",
     "day" => 7,
     "description" => "Also known as Bali New Year, Bali Day Of Silence",
     "description.alt.lang.id" => "Juga dikenal dengan Tahun Baru Saka",
     "dow" => 4,
     "is_holiday" => 1,
     "is_joint_leave" => 0,
     "month" => 3,
     "summary" => "Nyepi 1941",
     "summary.alt.lang.id" => "Nyepi 1941",
     "tags" => ["religious", "religion=hinduism", "calendar=saka"],
     "year" => 2019,
   },
   {
     "date"                => "2019-04-03",
     "day"                 => 3,
     "dow"                 => 3,
     "eng_aliases"         => [],
     "ind_aliases"         => [],
     "is_holiday"          => 1,
     "is_joint_leave"      => 0,
     "month"               => 4,
     "summary"             => "Isra And Miraj",
     "summary.alt.lang.id" => "Isra Miraj",
     "tags"                => ["religious", "religion=islam", "calendar=lunar"],
     "year"                => 2019,
   },
   {
     "date" => "2019-04-19",
     "day" => 19,
     "description.alt.lang.id" => "Juga dikenal dengan Wafat Isa Al-Masih",
     "dow" => 5,
     "eng_aliases" => [],
     "is_holiday" => 1,
     "is_joint_leave" => 0,
     "month" => 4,
     "summary" => "Good Friday",
     "summary.alt.lang.id" => "Jum'at Agung",
     "tags" => ["religious", "religion=christianity"],
     "year" => 2019,
   },
   {
     "date"                => "2019-05-01",
     "day"                 => 1,
     "decree_date"         => "2013-04-29",
     "decree_note"         => "Labor day becomes national holiday since 2014, decreed by president",
     "dow"                 => 3,
     "is_holiday"          => 1,
     "is_joint_leave"      => 0,
     "month"               => 5,
     "summary"             => "Labor Day",
     "summary.alt.lang.id" => "Hari Buruh",
     "tags"                => ["international", "fixed-date"],
     "year"                => 2019,
     "year_start"          => 2014,
   },
   {
     "date"                => "2019-05-19",
     "day"                 => 19,
     "description"         => "Also known as Vesak",
     "dow"                 => 7,
     "ind_aliases"         => [],
     "is_holiday"          => 1,
     "is_joint_leave"      => 0,
     "month"               => 5,
     "summary"             => "Vesakha 2563",
     "summary.alt.lang.id" => "Waisyak 2563",
     "tags"                => ["religious", "religion=buddhism"],
     "year"                => 2019,
   },
   {
     "date"                => "2019-05-30",
     "day"                 => 30,
     "dow"                 => 4,
     "eng_aliases"         => [],
     "ind_aliases"         => [],
     "is_holiday"          => 1,
     "is_joint_leave"      => 0,
     "month"               => 5,
     "summary"             => "Ascension Day",
     "summary.alt.lang.id" => "Kenaikan Isa Al-Masih",
     "tags"                => ["religious", "religion=christianity"],
     "year"                => 2019,
   },
   {
     "date"                => "2019-06-01",
     "day"                 => 1,
     "decree_date"         => "2016-06-01",
     "decree_note"         => "Pancasila day becomes national holiday since 2017, decreed by president (Keppres 24/2016)",
     "dow"                 => 6,
     "is_holiday"          => 1,
     "is_joint_leave"      => 0,
     "month"               => 6,
     "summary"             => "Pancasila Day",
     "summary.alt.lang.id" => "Hari Lahir Pancasila",
     "tags"                => ["national", "fixed-date"],
     "year"                => 2019,
     "year_start"          => 2017,
   },
   {
     "date"                => "2019-06-03",
     "day"                 => 3,
     "dow"                 => 1,
     "eng_aliases"         => [],
     "ind_aliases"         => [],
     "is_holiday"          => 0,
     "is_joint_leave"      => 1,
     "month"               => 6,
     "summary"             => "Joint Leave (Eid Ul-Fitr 1440H, Day 1)",
     "summary.alt.lang.id" => "Cuti Bersama (Idul Fitri 1440H, Hari 1)",
     "tags"                => [],
     "year"                => 2019,
   },
   {
     "date"                => "2019-06-04",
     "day"                 => 4,
     "dow"                 => 2,
     "eng_aliases"         => [],
     "ind_aliases"         => [],
     "is_holiday"          => 0,
     "is_joint_leave"      => 1,
     "month"               => 6,
     "summary"             => "Joint Leave (Eid Ul-Fitr 1440H, Day 1)",
     "summary.alt.lang.id" => "Cuti Bersama (Idul Fitri 1440H, Hari 1)",
     "tags"                => [],
     "year"                => 2019,
   },
   {
     "date" => "2019-06-05",
     "day" => 5,
     "description.alt.lang.id" => "Juga dikenal dengan Lebaran",
     "dow" => 3,
     "eng_aliases" => [],
     "is_holiday" => 1,
     "is_joint_leave" => 0,
     "month" => 6,
     "summary" => "Eid Ul-Fitr 1440H, Day 1",
     "summary.alt.lang.id" => "Idul Fitri 1440H, Hari 1",
     "tags" => ["religious", "religion=islam", "calendar=lunar"],
     "year" => 2019,
   },
   {
     "date" => "2019-06-06",
     "day" => 6,
     "description.alt.lang.id" => "Juga dikenal dengan Lebaran",
     "dow" => 4,
     "eng_aliases" => [],
     "is_holiday" => 1,
     "is_joint_leave" => 0,
     "month" => 6,
     "summary" => "Eid Ul-Fitr 1439H, Day 2",
     "summary.alt.lang.id" => "Idul Fitri 1439H, Hari 2",
     "tags" => ["religious", "religion=islam", "calendar=lunar"],
     "year" => 2019,
   },
   {
     "date"                => "2019-06-07",
     "day"                 => 7,
     "dow"                 => 5,
     "eng_aliases"         => [],
     "ind_aliases"         => [],
     "is_holiday"          => 0,
     "is_joint_leave"      => 1,
     "month"               => 6,
     "summary"             => "Joint Leave (Eid Ul-Fitr 1440H, Day 1)",
     "summary.alt.lang.id" => "Cuti Bersama (Idul Fitri 1440H, Hari 1)",
     "tags"                => [],
     "year"                => 2019,
   },
   {
     "date" => "2019-08-11",
     "day" => 11,
     "description.alt.lang.id" => "Juga dikenal dengan Idul Kurban",
     "dow" => 7,
     "eng_aliases" => [],
     "is_holiday" => 1,
     "is_joint_leave" => 0,
     "month" => 8,
     "summary" => "Eid Al-Adha",
     "summary.alt.lang.id" => "Idul Adha",
     "tags" => ["religious", "religion=islam", "calendar=lunar"],
     "year" => 2019,
   },
   {
     "date" => "2019-08-17",
     "day" => 17,
     "dow" => 6,
     "is_holiday" => 1,
     "is_joint_leave" => 0,
     "month" => 8,
     "summary" => "Declaration Of Independence",
     "summary.alt.lang.id" => "Proklamasi",
     "tags" => ["national", "fixed-date"],
     "year" => 2019,
   },
   {
     "date" => "2019-09-01",
     "day" => 1,
     "description.alt.lang.id" => "Juga dikenal dengan 1 Muharam",
     "dow" => 7,
     "eng_aliases" => [],
     "is_holiday" => 1,
     "is_joint_leave" => 0,
     "month" => 9,
     "summary" => "Hijra 1441H",
     "summary.alt.lang.id" => "Tahun Baru Hijriyah 1441H",
     "tags" => ["calendar=lunar"],
     "year" => 2019,
   },
   {
     "date" => "2019-11-09",
     "day" => 9,
     "description" => "Also known as Mawlid An-Nabi",
     "description.alt.lang.id" => "Juga dikenal dengan Maulud",
     "dow" => 6,
     "is_holiday" => 1,
     "is_joint_leave" => 0,
     "month" => 11,
     "summary" => "Mawlid",
     "summary.alt.lang.id" => "Maulid Nabi Muhammad",
     "tags" => ["religious", "religion=islam", "calendar=lunar"],
     "year" => 2019,
   },
   {
     "date"                => "2019-12-24",
     "day"                 => 24,
     "dow"                 => 2,
     "eng_aliases"         => [],
     "ind_aliases"         => [],
     "is_holiday"          => 0,
     "is_joint_leave"      => 1,
     "month"               => 12,
     "summary"             => "Joint Leave (Christmas)",
     "summary.alt.lang.id" => "Cuti Bersama (Natal)",
     "tags"                => [],
     "year"                => 2019,
   },
   {
     "date" => "2019-12-25",
     "day" => 25,
     "dow" => 3,
     "is_holiday" => 1,
     "is_joint_leave" => 0,
     "month" => 12,
     "summary" => "Christmas",
     "summary.alt.lang.id" => "Natal",
     "tags" => [
       "international",
       "religious",
       "religion=christianity",
       "fixed-date",
     ],
     "year" => 2019,
   },
 ]

=head2 Using from CLI (requires L<list-calendar-dates> and L<calx>)

 % list-calendar-dates -l -m ID::Holiday
 % calx -c ID::Holiday

=head1 DESCRIPTION

This module provides Indonesian holiday calendar using the L<Calendar::Dates>
interface.

=head1 DATES STATISTICS

 +---------------+-------+
 | key           | value |
 +---------------+-------+
 | Earliest year | 2002  |
 | Latest year   | 2019  |
 +---------------+-------+

=head1 DATES SAMPLES

Entries for year 2018:

 [
    200,
    "OK",
    [
       {
          "date" : "2018-01-01",
          "day" : 1,
          "dow" : 1,
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 1,
          "summary" : "New Year",
          "summary.alt.lang.id" : "Tahun Baru",
          "tags" : "international, fixed-date",
          "year" : 2018
       },
       {
          "date" : "2018-02-16",
          "day" : 16,
          "dow" : 5,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 2,
          "summary" : "Chinese New Year 2569",
          "summary.alt.lang.id" : "Tahun Baru Imlek 2569",
          "tags" : "international, calendar=lunar",
          "year" : 2018
       },
       {
          "date" : "2018-03-17",
          "day" : 17,
          "description" : "Also known as Bali New Year, Bali Day Of Silence",
          "description.alt.lang.id" : "Juga dikenal dengan Tahun Baru Saka",
          "dow" : 6,
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 3,
          "summary" : "Nyepi 1940",
          "summary.alt.lang.id" : "Nyepi 1940",
          "tags" : "religious, religion=hinduism, calendar=saka",
          "year" : 2018
       },
       {
          "date" : "2018-03-30",
          "day" : 30,
          "description.alt.lang.id" : "Juga dikenal dengan Wafat Isa Al-Masih",
          "dow" : 5,
          "eng_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 3,
          "summary" : "Good Friday",
          "summary.alt.lang.id" : "Jum'at Agung",
          "tags" : "religious, religion=christianity",
          "year" : 2018
       },
       {
          "date" : "2018-04-14",
          "day" : 14,
          "dow" : 6,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 4,
          "summary" : "Isra And Miraj",
          "summary.alt.lang.id" : "Isra Miraj",
          "tags" : "religious, religion=islam, calendar=lunar",
          "year" : 2018
       },
       {
          "date" : "2018-05-01",
          "day" : 1,
          "decree_date" : "2013-04-29",
          "decree_note" : "Labor day becomes national holiday since 2014, decreed by president",
          "dow" : 2,
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 5,
          "summary" : "Labor Day",
          "summary.alt.lang.id" : "Hari Buruh",
          "tags" : "international, fixed-date",
          "year" : 2018,
          "year_start" : 2014
       },
       {
          "date" : "2018-05-10",
          "day" : 10,
          "dow" : 4,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 5,
          "summary" : "Ascension Day",
          "summary.alt.lang.id" : "Kenaikan Isa Al-Masih",
          "tags" : "religious, religion=christianity",
          "year" : 2018
       },
       {
          "date" : "2018-05-29",
          "day" : 29,
          "description" : "Also known as Vesak",
          "dow" : 2,
          "ind_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 5,
          "summary" : "Vesakha 2562",
          "summary.alt.lang.id" : "Waisyak 2562",
          "tags" : "religious, religion=buddhism",
          "year" : 2018
       },
       {
          "date" : "2018-06-01",
          "day" : 1,
          "decree_date" : "2016-06-01",
          "decree_note" : "Pancasila day becomes national holiday since 2017, decreed by president (Keppres 24/2016)",
          "dow" : 5,
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 6,
          "summary" : "Pancasila Day",
          "summary.alt.lang.id" : "Hari Lahir Pancasila",
          "tags" : "national, fixed-date",
          "year" : 2018,
          "year_start" : 2017
       },
       {
          "date" : "2018-06-11",
          "day" : 11,
          "dow" : 1,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 0,
          "is_joint_leave" : 1,
          "month" : 6,
          "summary" : "Joint Leave (Eid Ul-Fitr 1439H, Day 1)",
          "summary.alt.lang.id" : "Cuti Bersama (Idul Fitri 1439H, Hari 1)",
          "tags" : "",
          "year" : 2018
       },
       {
          "date" : "2018-06-12",
          "day" : 12,
          "dow" : 2,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 0,
          "is_joint_leave" : 1,
          "month" : 6,
          "summary" : "Joint Leave (Eid Ul-Fitr 1439H, Day 1)",
          "summary.alt.lang.id" : "Cuti Bersama (Idul Fitri 1439H, Hari 1)",
          "tags" : "",
          "year" : 2018
       },
       {
          "date" : "2018-06-13",
          "day" : 13,
          "dow" : 3,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 0,
          "is_joint_leave" : 1,
          "month" : 6,
          "summary" : "Joint Leave (Eid Ul-Fitr 1439H, Day 1)",
          "summary.alt.lang.id" : "Cuti Bersama (Idul Fitri 1439H, Hari 1)",
          "tags" : "",
          "year" : 2018
       },
       {
          "date" : "2018-06-14",
          "day" : 14,
          "dow" : 4,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 0,
          "is_joint_leave" : 1,
          "month" : 6,
          "summary" : "Joint Leave (Eid Ul-Fitr 1439H, Day 1)",
          "summary.alt.lang.id" : "Cuti Bersama (Idul Fitri 1439H, Hari 1)",
          "tags" : "",
          "year" : 2018
       },
       {
          "date" : "2018-06-15",
          "day" : 15,
          "description.alt.lang.id" : "Juga dikenal dengan Lebaran",
          "dow" : 5,
          "eng_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 6,
          "summary" : "Eid Ul-Fitr 1439H, Day 1",
          "summary.alt.lang.id" : "Idul Fitri 1439H, Hari 1",
          "tags" : "religious, religion=islam, calendar=lunar",
          "year" : 2018
       },
       {
          "date" : "2018-06-16",
          "day" : 16,
          "description.alt.lang.id" : "Juga dikenal dengan Lebaran",
          "dow" : 6,
          "eng_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 6,
          "summary" : "Eid Ul-Fitr 1439H, Day 2",
          "summary.alt.lang.id" : "Idul Fitri 1439H, Hari 2",
          "tags" : "religious, religion=islam, calendar=lunar",
          "year" : 2018
       },
       {
          "date" : "2018-06-18",
          "day" : 18,
          "dow" : 1,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 0,
          "is_joint_leave" : 1,
          "month" : 6,
          "summary" : "Joint Leave (Eid Ul-Fitr 1439H, Day 1)",
          "summary.alt.lang.id" : "Cuti Bersama (Idul Fitri 1439H, Hari 1)",
          "tags" : "",
          "year" : 2018
       },
       {
          "date" : "2018-06-19",
          "day" : 19,
          "dow" : 2,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 0,
          "is_joint_leave" : 1,
          "month" : 6,
          "summary" : "Joint Leave (Eid Ul-Fitr 1439H, Day 1)",
          "summary.alt.lang.id" : "Cuti Bersama (Idul Fitri 1439H, Hari 1)",
          "tags" : "",
          "year" : 2018
       },
       {
          "date" : "2018-06-20",
          "day" : 20,
          "dow" : 3,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 0,
          "is_joint_leave" : 1,
          "month" : 6,
          "summary" : "Joint Leave (Eid Ul-Fitr 1439H, Day 1)",
          "summary.alt.lang.id" : "Cuti Bersama (Idul Fitri 1439H, Hari 1)",
          "tags" : "",
          "year" : 2018
       },
       {
          "date" : "2018-06-27",
          "day" : 27,
          "decree_date" : "2018-06-25",
          "dow" : 3,
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 6,
          "summary" : "Joint Regional Election",
          "summary.alt.lang.id" : "Pilkada Serentak",
          "tags" : "political",
          "year" : 2018
       },
       {
          "date" : "2018-08-17",
          "day" : 17,
          "dow" : 5,
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 8,
          "summary" : "Declaration Of Independence",
          "summary.alt.lang.id" : "Proklamasi",
          "tags" : "national, fixed-date",
          "year" : 2018
       },
       {
          "date" : "2018-08-22",
          "day" : 22,
          "description.alt.lang.id" : "Juga dikenal dengan Idul Kurban",
          "dow" : 3,
          "eng_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 8,
          "summary" : "Eid Al-Adha",
          "summary.alt.lang.id" : "Idul Adha",
          "tags" : "religious, religion=islam, calendar=lunar",
          "year" : 2018
       },
       {
          "date" : "2018-09-11",
          "day" : 11,
          "description.alt.lang.id" : "Juga dikenal dengan 1 Muharam",
          "dow" : 2,
          "eng_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 9,
          "summary" : "Hijra 1440H",
          "summary.alt.lang.id" : "Tahun Baru Hijriyah 1440H",
          "tags" : "calendar=lunar",
          "year" : 2018
       },
       {
          "date" : "2018-11-20",
          "day" : 20,
          "description" : "Also known as Mawlid An-Nabi",
          "description.alt.lang.id" : "Juga dikenal dengan Maulud",
          "dow" : 2,
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 11,
          "summary" : "Mawlid",
          "summary.alt.lang.id" : "Maulid Nabi Muhammad",
          "tags" : "religious, religion=islam, calendar=lunar",
          "year" : 2018
       },
       {
          "date" : "2018-12-24",
          "day" : 24,
          "dow" : 1,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 0,
          "is_joint_leave" : 1,
          "month" : 12,
          "summary" : "Joint Leave (Christmas)",
          "summary.alt.lang.id" : "Cuti Bersama (Natal)",
          "tags" : "",
          "year" : 2018
       },
       {
          "date" : "2018-12-25",
          "day" : 25,
          "dow" : 2,
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 12,
          "summary" : "Christmas",
          "summary.alt.lang.id" : "Natal",
          "tags" : "international, religious, religion=christianity, fixed-date",
          "year" : 2018
       }
    ],
    {}
 ]

Entries for year 2019:

 [
    200,
    "OK",
    [
       {
          "date" : "2019-01-01",
          "day" : 1,
          "dow" : 2,
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 1,
          "summary" : "New Year",
          "summary.alt.lang.id" : "Tahun Baru",
          "tags" : "international, fixed-date",
          "year" : 2019
       },
       {
          "date" : "2019-02-05",
          "day" : 5,
          "dow" : 2,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 2,
          "summary" : "Chinese New Year 2570",
          "summary.alt.lang.id" : "Tahun Baru Imlek 2570",
          "tags" : "international, calendar=lunar",
          "year" : 2019
       },
       {
          "date" : "2019-03-07",
          "day" : 7,
          "description" : "Also known as Bali New Year, Bali Day Of Silence",
          "description.alt.lang.id" : "Juga dikenal dengan Tahun Baru Saka",
          "dow" : 4,
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 3,
          "summary" : "Nyepi 1941",
          "summary.alt.lang.id" : "Nyepi 1941",
          "tags" : "religious, religion=hinduism, calendar=saka",
          "year" : 2019
       },
       {
          "date" : "2019-04-03",
          "day" : 3,
          "dow" : 3,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 4,
          "summary" : "Isra And Miraj",
          "summary.alt.lang.id" : "Isra Miraj",
          "tags" : "religious, religion=islam, calendar=lunar",
          "year" : 2019
       },
       {
          "date" : "2019-04-19",
          "day" : 19,
          "description.alt.lang.id" : "Juga dikenal dengan Wafat Isa Al-Masih",
          "dow" : 5,
          "eng_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 4,
          "summary" : "Good Friday",
          "summary.alt.lang.id" : "Jum'at Agung",
          "tags" : "religious, religion=christianity",
          "year" : 2019
       },
       {
          "date" : "2019-05-01",
          "day" : 1,
          "decree_date" : "2013-04-29",
          "decree_note" : "Labor day becomes national holiday since 2014, decreed by president",
          "dow" : 3,
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 5,
          "summary" : "Labor Day",
          "summary.alt.lang.id" : "Hari Buruh",
          "tags" : "international, fixed-date",
          "year" : 2019,
          "year_start" : 2014
       },
       {
          "date" : "2019-05-19",
          "day" : 19,
          "description" : "Also known as Vesak",
          "dow" : 7,
          "ind_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 5,
          "summary" : "Vesakha 2563",
          "summary.alt.lang.id" : "Waisyak 2563",
          "tags" : "religious, religion=buddhism",
          "year" : 2019
       },
       {
          "date" : "2019-05-30",
          "day" : 30,
          "dow" : 4,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 5,
          "summary" : "Ascension Day",
          "summary.alt.lang.id" : "Kenaikan Isa Al-Masih",
          "tags" : "religious, religion=christianity",
          "year" : 2019
       },
       {
          "date" : "2019-06-01",
          "day" : 1,
          "decree_date" : "2016-06-01",
          "decree_note" : "Pancasila day becomes national holiday since 2017, decreed by president (Keppres 24/2016)",
          "dow" : 6,
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 6,
          "summary" : "Pancasila Day",
          "summary.alt.lang.id" : "Hari Lahir Pancasila",
          "tags" : "national, fixed-date",
          "year" : 2019,
          "year_start" : 2017
       },
       {
          "date" : "2019-06-03",
          "day" : 3,
          "dow" : 1,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 0,
          "is_joint_leave" : 1,
          "month" : 6,
          "summary" : "Joint Leave (Eid Ul-Fitr 1440H, Day 1)",
          "summary.alt.lang.id" : "Cuti Bersama (Idul Fitri 1440H, Hari 1)",
          "tags" : "",
          "year" : 2019
       },
       {
          "date" : "2019-06-04",
          "day" : 4,
          "dow" : 2,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 0,
          "is_joint_leave" : 1,
          "month" : 6,
          "summary" : "Joint Leave (Eid Ul-Fitr 1440H, Day 1)",
          "summary.alt.lang.id" : "Cuti Bersama (Idul Fitri 1440H, Hari 1)",
          "tags" : "",
          "year" : 2019
       },
       {
          "date" : "2019-06-05",
          "day" : 5,
          "description.alt.lang.id" : "Juga dikenal dengan Lebaran",
          "dow" : 3,
          "eng_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 6,
          "summary" : "Eid Ul-Fitr 1440H, Day 1",
          "summary.alt.lang.id" : "Idul Fitri 1440H, Hari 1",
          "tags" : "religious, religion=islam, calendar=lunar",
          "year" : 2019
       },
       {
          "date" : "2019-06-06",
          "day" : 6,
          "description.alt.lang.id" : "Juga dikenal dengan Lebaran",
          "dow" : 4,
          "eng_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 6,
          "summary" : "Eid Ul-Fitr 1439H, Day 2",
          "summary.alt.lang.id" : "Idul Fitri 1439H, Hari 2",
          "tags" : "religious, religion=islam, calendar=lunar",
          "year" : 2019
       },
       {
          "date" : "2019-06-07",
          "day" : 7,
          "dow" : 5,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 0,
          "is_joint_leave" : 1,
          "month" : 6,
          "summary" : "Joint Leave (Eid Ul-Fitr 1440H, Day 1)",
          "summary.alt.lang.id" : "Cuti Bersama (Idul Fitri 1440H, Hari 1)",
          "tags" : "",
          "year" : 2019
       },
       {
          "date" : "2019-08-11",
          "day" : 11,
          "description.alt.lang.id" : "Juga dikenal dengan Idul Kurban",
          "dow" : 7,
          "eng_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 8,
          "summary" : "Eid Al-Adha",
          "summary.alt.lang.id" : "Idul Adha",
          "tags" : "religious, religion=islam, calendar=lunar",
          "year" : 2019
       },
       {
          "date" : "2019-08-17",
          "day" : 17,
          "dow" : 6,
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 8,
          "summary" : "Declaration Of Independence",
          "summary.alt.lang.id" : "Proklamasi",
          "tags" : "national, fixed-date",
          "year" : 2019
       },
       {
          "date" : "2019-09-01",
          "day" : 1,
          "description.alt.lang.id" : "Juga dikenal dengan 1 Muharam",
          "dow" : 7,
          "eng_aliases" : [],
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 9,
          "summary" : "Hijra 1441H",
          "summary.alt.lang.id" : "Tahun Baru Hijriyah 1441H",
          "tags" : "calendar=lunar",
          "year" : 2019
       },
       {
          "date" : "2019-11-09",
          "day" : 9,
          "description" : "Also known as Mawlid An-Nabi",
          "description.alt.lang.id" : "Juga dikenal dengan Maulud",
          "dow" : 6,
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 11,
          "summary" : "Mawlid",
          "summary.alt.lang.id" : "Maulid Nabi Muhammad",
          "tags" : "religious, religion=islam, calendar=lunar",
          "year" : 2019
       },
       {
          "date" : "2019-12-24",
          "day" : 24,
          "dow" : 2,
          "eng_aliases" : [],
          "ind_aliases" : [],
          "is_holiday" : 0,
          "is_joint_leave" : 1,
          "month" : 12,
          "summary" : "Joint Leave (Christmas)",
          "summary.alt.lang.id" : "Cuti Bersama (Natal)",
          "tags" : "",
          "year" : 2019
       },
       {
          "date" : "2019-12-25",
          "day" : 25,
          "dow" : 3,
          "is_holiday" : 1,
          "is_joint_leave" : 0,
          "month" : 12,
          "summary" : "Christmas",
          "summary.alt.lang.id" : "Natal",
          "tags" : "international, religious, religion=christianity, fixed-date",
          "year" : 2019
       }
    ],
    {}
 ]

=for Pod::Coverage ^(prepare_data)$

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Calendar-Dates-ID-Holiday>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Calendar-Dates-ID-Holiday>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Calendar-Dates-ID-Holiday>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<Calendar::Dates>

L<App::CalendarDatesUtils> contains CLIs to list dates from this module, etc.

L<calx> from L<App::calx> can display calendar and highlight dates from Calendar::Dates::* modules

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2019 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
