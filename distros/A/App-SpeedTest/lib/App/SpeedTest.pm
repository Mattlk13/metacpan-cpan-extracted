#!/usr/bin/perl

package App::SpeedTest;

use strict;
use warnings;

our $VERSION = "0.24";

1;
__END__

=encoding UTF-8

=head1 NAME

App::SpeedTest - Command-line interface to speedtest.net

=head1 SYNOPSIS

 $ speedtest [ --no-geo | --country=NL ] [ --list | --ping ] [ options ]

 $ speedtest --list
 $ speedtest --ping --country=BE
 $ speedtest
 $ speedtest -s 4358
 $ speedtest --url=http://ookla.extraip.net
 $ speedtest -q --no-download
 $ speedtest -Q --no-upload

=head1 DESCRIPTION

The provided perl script is a command-line interface to the
L<speedtest.net|http://www.speedtest.net/> infrastructure so that
flash is not required

It was written to feature the functionality that speedtest.net offers
without the overhead of flash or java and the need of a browser.

=head1 Raison-d'être

The tool is there to give you a quick indication of the achievable
throughput of your current network. That can drop dramatically if
you are behind (several) firewalls or badly configured networks (or
network parts like switches, hubs and routers).

It was inspired by L<speedtest-cli|https://github.com/sivel/speedtest-cli>,
a project written in python. But I neither like python, nor did I like the
default behavior of that script. I also think it does not take the right
decisions in choosing the server based on distance instead of speed. That
B<does> matter if one has fiber lines. I prefer speed over distance.

=head1 Command-line Arguments
X<CLIA>

=over 2

=item -? | --help
X<-?>
X<--help>

Show all available options and then exit.

=item -V | --version
X<-V>
X<--version>

Show program version and exit.

=item --man
X<--man>

Show the builtin manual using C<pod2man> and C<nroff>.

=item --info
X<--info>

Show the builtin manual using C<pod2text>.

=item -v[#] | --verbose[=#]
X<-v>
X<--version>

Set verbose level. Default value is 1. A plain -v without value will set
the level to 2.

=item --simple
X<--simple>

An alias for C<-v0>

=item --all
X<--all>

No (default) filtering on available servers. Useful when finding servers
outside of the country of your own location.

=item -g | --geo
X<-g>
X<--geo>

Use GEO-IP service to find the country your ISP is located. The default
is true. If disable (C<--no-geo>), the server to use will be based on
distance instead of on latency.

=item -cXX | --cc=XX | --country=XX
X<-c>
X<--cc>
X<--country>

Pass the ISO country code to select the servers

 $ speedtest -c NL ...
 $ speedtest --cc=B ...
 $ speedtest --country=D ...

=item --list-cc
X<--list-cc>

Fetch the server list and then show the list of countries the servers are
located with their country code and server count

 $ speedtest --list-cc
 AD Andorra                             1
 AE United Arab Emirates                4
 :
 ZW Zimbabwe                            6

You can then use that code to list the servers in the chosen country, as
described below.

=item -l | --list
X<-l>
X<--list>

This option will show all servers in the selection with the distance in
kilometers to the server.

 $ speedtest --list --country=IS
   1: 10661 - Tengir hf              Akureyri    1980.02 km
   2: 21605 - Premis ehf             Reykjav�k   2039.16 km
   3:  3684 - Nova                   Reykjavik   2039.16 km
   4:  6471 - Gagnaveita Reykjavikur Reykjavik   2039.16 km
   5: 10650 - Nova VIP               Reykjavik   2039.16 km
   6: 16148 - Hringidan              Reykjavik   2039.16 km
   7:  4818 - Siminn                 Reykjavik   2039.16 km
   8: 17455 - Hringdu                Reykjav�k   2039.16 km
   9:  4141 - Vodafone               Reykjav�k   2039.16 km
  10:  3644 - Snerpa                 Isafjordur  2192.27 km

=item -p | --ping | --ping=40
X<-p>
X<--ping>

Show a list of servers in the selection with their latency in ms.
Be very patient if running this with L</--all>.

 $ speedtest --ping --cc=BE
   1:  4320 - EDPnet               Sint-Niklaas     148.06 km      52 ms
   2: 12627 - Proximus             Brussels         173.04 km      55 ms
   3: 10986 - Proximus             Schaarbeek       170.54 km      55 ms
   4: 15212 - Telenet BVBA/SPRL    Mechelen         133.89 km      57 ms
   5: 29238 - Arcadiz              DIEGEM           166.33 km      58 ms
   6:  5151 - Combell              Brussels         173.04 km      59 ms
   7: 26887 - Arxus NV             Brussels         173.04 km      64 ms
   8:  4812 - Universite Catholiq… Louvain-La-Neuv  186.87 km      70 ms
   9:  2848 - Cu.be Solutions      Diegem           166.33 km      75 ms
  10: 12306 - VOO                  Li�ge            186.26 km      80 ms
  11: 24261 - Une Nouvelle Ville…  Charleroi        217.48 km     147 ms
  12: 30594 - Orange Belgium       Evere            169.29 km     150 ms

If a server does not respond, a very high latency is used as default.

This option only shows the 40 nearest servers. The number can be changed
as optional argument.

 $ speedtest --cc=BE --ping=4
   1:  4320 - EDPnet               Sint-Niklaas     148.06 km      53 ms
   2: 29238 - Arcadiz              DIEGEM           166.33 km      57 ms
   3: 15212 - Telenet BVBA/SPRL    Mechelen         133.89 km      62 ms
   4:  2848 - Cu.be Solutions      Diegem           166.33 km      76 ms

=item -1 | --one-line
X<-1>
X<--ono-line>

Generate a very short report easy to paste in e.g. IRC channels.

 $ speedtest -1Qv0
 DL:   40.721 Mbit/s, UL:   30.307 Mbit/s

=item -B | --bytes
X<-B>
X<--bytes>

Report throughput in Mbyte/s instead of Mbit/s

=item -C | --csv
X<-C>
X<--csv>

Generate the measurements in CSV format. The data can be collected in
a file (by a cron job) to be able to follow internet speed over time.

The reported fields are

 - A timestam (the time the tests are finished)
 - The server ID
 - The latency in ms
 - The number of tests executed in this measurement
 - The direction of the test (D = Down, U = Up)
 - The measure avarage speed in Mbit/s
 - The minimum speed measured in one of the test in Mbit/s
 - The maximum speed measured in one of the test in Mbit/s

 $ speedtest -Cs4358
 "2015-01-24 17:15:09",4358,63.97,40,D,93.45,30.39,136.93
 "2015-01-24 17:15:14",4358,63.97,40,U,92.67,31.10,143.06

=item -U | --skip-undef
X<-U>
X<--skip-undef>

Skip reporting measurements that have no speed recordings at all.
The default is to report these as C<0.00> .. C<999999999.999>.

=item -P | --prtg
X<-P>
X<--prtg>

Generate the measurements in XML suited for PRTG

 $ speedtest -P
 <?xml version="1.0" encoding="UTF-8" ?>
 <prtg>
   <text>Testing from My ISP (10.20.30.40)</text>
   <result>
     <channel>Ping</channel>
     <customUnit>ms</customUnit>
     <float>1</float>
     <value>56.40</value>
     </result>
   <result>
     <channel>Download</channel>
     <customUnit>Mbit/s</customUnit>
     <float>1</float>
     <value>38.34</value>
     </result>
   <result>
     <channel>Upload</channel>
     <customUnit>Mbit/s</customUnit>
     <float>1</float>
     <value>35.89</value>
     </result>
   </prtg>

=item --url=XXX
X<--url>

=item --ip
X<--ip>

=item -T[#] | --try[=#]
X<-T>
X<--try>

Use the top # (based on lowest latency or shortest distance) from the list
to do all required tests.

 $ speedtest -T3 -c NL -Q2
 Testing for 80.x.y.z : XS4ALL Internet BV (NL)

 Using 13218:  26.52 km      25 ms XS4ALL Internet BV
 Test download ..                                      Download     31.807 Mbit/s
 Test upload   ..                                      Upload       86.587 Mbit/s

 Using 15850:  26.09 km      25 ms QTS Data Centers
 Test download ..                                      Download     80.763 Mbit/s
 Test upload   ..                                      Upload       77.122 Mbit/s

 Using 11365:  26.09 km      27 ms Vancis
 Test download ..                                      Download    106.022 Mbit/s
 Test upload   ..                                      Upload       82.891 Mbit/s

 Rank 01: Server:  11365   26.09 km      27 ms,  DL:  106.022 UL:   82.891
 Rank 02: Server:  15850   26.09 km      25 ms,  DL:   80.763 UL:   77.122
 Rank 03: Server:  13218   26.52 km      25 ms,  DL:   31.807 UL:   86.587

 $ speedtest -1v0 -T5
 DL:  200.014 Mbit/s, UL:  159.347 Mbit/s, SRV: 13218
 DL:  203.599 Mbit/s, UL:  166.247 Mbit/s, SRV: 15850
 DL:  207.249 Mbit/s, UL:  134.957 Mbit/s, SRV: 11365
 DL:  195.490 Mbit/s, UL:  172.109 Mbit/s, SRV: 5972
 DL:  179.413 Mbit/s, UL:  160.309 Mbit/s, SRV: 2042

 Rank 01: Server:  15850   26.09 km      30 ms,  DL:  203.599 UL:  166.247
 Rank 02: Server:   5972   26.09 km      32 ms,  DL:  195.490 UL:  172.109
 Rank 03: Server:  13218   26.52 km      23 ms,  DL:  200.014 UL:  159.347
 Rank 04: Server:  11365   26.09 km      31 ms,  DL:  207.249 UL:  134.957
 Rank 05: Server:   2042   51.41 km      33 ms,  DL:  179.413 UL:  160.309

=item -s# | --server=# | --server=filename
X<-s>
X<--server>

Specify the ID of the server to test against. This ID can be taken from the
output of L</--list> or L</--ping>. Using this option prevents fetching the
complete server list and calculation of distances. It also enables you to
always test against the same server.

 $ speedtest -1s4358
 Testing for 80.x.y.z : XS4ALL Internet BV ()
 Using 4358:  52.33 km      64 ms KPN
 Test download ........................................Download:   92.633 Mbit/s
 Test upload   ........................................Upload:     92.552 Mbit/s
 DL:   92.633 Mbit/s, UL:   92.552 Mbit/s

If you pass a filename, it is expected to reflect a server-like structure as
received from the speedtest server-list, possibly completed with upload- and
download URL's:

  {   cc      => "NL",
      country => "Netherlands",
      host    => "unlisted.host.amsterdam:8080",
      id      => 9999,
      lat     => "52.37316",
      lon     => "4.89122",
      name    => "Amsterdam",
      ping    => 20.0,
      sponsor => "Dam tot Damloop",
      url     => "http://unlisted.host.amsterdam/speedtest/speedtest/upload.php",
      url2    => "http://unlisted.host.amsterdam/speedtest/speedtest/upload.php",

      dl_list => [
          "http://unlisted.host.amsterdam/files/128.bin",
          "http://unlisted.host.amsterdam/files/256.bin",
          # 40 URL's pointing to files in increasing size
          "http://unlisted.host.amsterdam/files/2G.bin",
          ],
      ul_list => [
          # 40 URL's
          ],
      }

=item -t# | --timeout=#
X<-t>
X<--timeout>

Specify the maximum timeout in seconds.

=item -d | --download
X<-d>
X<--download>

Run the download tests. This is default unless L</--upload> is passed.

=item -u | --upload
X<-u>
X<--upload>

Run the upload tests. This is default unless L</--download> is passed.

=item -q[#] | --quick[=#] | --fast[=#]
X<-q>
X<--quick>
X<--fast>

Don't run the full test. The default test runs 40 tests, sorting on
increasing test size (and thus test duration). Long(er) tests may take
too long on slow connections without adding value. The default value
for C<-q> is 20 but any value between 1 and 40 is allowed.

=item -Q[#] | --realquick[=#]
X<-Q>
X<--realquick>

Don't run the full test. The default test runs 40 tests, sorting on
increasing test size (and thus test duration). Long(er) tests may take
too long on slow connections without adding value. The default value
for C<-Q> is 10 but any value between 1 and 40 is allowed.

=item -mXX | --mini=XX
X<-m>
X<--mini>

Run the speedtest on a speedtest mini server.

=item --source=XX

NYI - mentioned for speedtest-cli compatibility

=back

=head1 EXAMPLES

See L</SYNOPSIS> and L<Command-line arguments|/CLIA>

=head1 DIAGNOSTICS

...

=head1 BUGS and CAVEATS

Due to language implementation, it may report speeds that are not
consistent with the speeds reported by the web interface or other
speed-test tools.  Likewise for reported latencies, which are not
to be compared to those reported by tools like ping.

=head1 TODO

=over 2

=item Improve documentation

What did I miss?

=item Enable alternative XML parsers

XML::Simple is not the recommended XML parser, but it sufficed on
startup. All other API's are more complex.

=back

=head1 PORTABILITY

As Perl has been ported to a plethora of operating systems, this CLI
will work fine on all systems that fulfill the requirement as listed
in Makefile.PL (or the various META files).

The script has been tested on Linux, HP-UX, AIX, and Windows 7.

Debian wheezy will run with just two additional packages:

 # apt-get install libxml-simple-perl libdata-peek-perl

=head1 SEE ALSO

As an alternative to L<speedtest.net|http://www.speedtest.net/>, you
could consider L<http://compari.tech/speed|http://compari.tech/speed>.

The L<speedtest-cli|https://github.com/sivel/speedtest-cli> project
that inspired me to improve a broken CLI written in python into our
beloved language Perl.

=head1 CONTRIBUTING

=head2 General

I am always open to improvements and suggestions. Use issues at
L<github issues|https://github.com/Tux/speedtest/issues>.

=head2 Style

I will never accept pull request that do not strictly conform to my
style, however you might hate it. You can read the reasoning behind
my preferences L<here|https://tux.nl/style.html>.

I really don't care about mixed spaces and tabs in (leading) whitespace

=head1 WARRANTY

This tool is by no means a guarantee to show the correc6t speeds. It
is only to be used as an indication of the throughput of your internet
connection. The values shown cannot be used in a legal debate.

=head1 AUTHOR

H.Merijn Brand F<E<lt>h.m.brand@xs4all.nlE<gt>> wrote this for his own
personal use, but was asked to make it publicly available as application.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014-2020 H.Merijn Brand

This software is free; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
