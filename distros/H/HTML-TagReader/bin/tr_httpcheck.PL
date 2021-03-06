#!/usr/bin/perl
# vim: set sw=4 ts=4 si et:
no locale;
use Config;
use File::Basename qw(basename dirname);
chdir(dirname($0));
($file = basename($0)) =~ s/\.PL$//;
$file =~ s/\.pl$//
        if ($Config{'osname'} eq 'VMS' or
            $Config{'osname'} eq 'OS2');  # "case-forgiving"
open OUT,">$file" or die "Can't create $file: $!";
chmod(0755, $file);
print "Extracting $file (with variable substitutions)\n";

my $VERSION="unknown";
if (-r "../TagReader.pm"){ # get version
    open(F,"../TagReader.pm")||die;
    while(<F>){
        if (/\$VERSION *= *(.+)/){
            $VERSION=$1;
            $VERSION=~s/[^\.\d]//g;
        }
    }
    close F;
}

print OUT "$Config{'startperl'} -w
my \$VERSION = \"$VERSION\";
";

while(<DATA>){
        print OUT;
}

__END__ 
# vim: set sw=4 ts=4 si et: 
# Copyright: GPL
# Author: Guido Socher
#
no locale;
use strict;
use vars qw($opt_E $opt_e $opt_h);
use Getopt::Std;
require 5.003;
use Socket;
# 
sub geturlres($);
sub help();
#------------------
my $url;
my $res;
my $exitstat=0;
my $err=1;
my $dotcnt=0;
#------------------
$opt_e=0;
$opt_E=0;
&getopts("ehE")||die "ERROR: No such option. -h for help.\n";
help() if ($opt_h);
#
if (scalar @ARGV < 1){
    # read output of tr_blck -a on stdin 
    $|=1; #flush for dot printing
    while(<>){
        chomp;
        next unless (/\w/); #ignore empty lines
        # lines look like this: index.html:133:55: href="https://en.wikipedia.org/wiki/1889–1890_flu_pandemic"
        next if (/=\"\//); # ignore abs file system links
        if (/: *\w+=\"(.+)\"/){
            $url=$1;
            # encode space URL encoding:
            $url=~s/ /%20/g;
            if ($url=~m%^https?://%i){
		($err,$res)=geturlres($url);
                if ($opt_E){
                    print ".";
                    $dotcnt=($dotcnt+1)%40;
                    print "\n" if ($dotcnt==0);
                }
                if ($opt_e || $opt_E){
                    if ($opt_E && $err){
                        print "\n";
                        $dotcnt=0;
                    }
                    # print nothing if no error
                    print "$url :: $res\n" if ($err);
                }else{
                    print "$url :: $res\n";
                }
                $exitstat=1 if($err);
            }else{
                print "$url -- SORRY: can not check this url\n" unless($opt_e || $opt_E);
                $exitstat=2;
            }
        }
    }
    print "\n" if ($opt_E);
    exit($exitstat);
}else{
    for $url (@ARGV){
        if ($url=~m%^https?://%i){
	    ($err,$res)=geturlres($url);
            open(PP,"curl -i -G -k -m 4 -s '$url' |")||die;
            if ($opt_e || $opt_E){
                if ($opt_E && $err){
                    print "\n";
                    $dotcnt=0;
                }
                # print nothing if no error
                print "$url :: $res\n" if ($err);
            }else{
                print "$url :: $res\n";
            }
            $exitstat=1 if($err);
        }else{
            print "$url -- SORRY: can not check this url\n" unless($opt_e || $opt_E);
            $exitstat=2;
        }
    }
    print "\n" if ($opt_E);
    exit($exitstat);
}
#------------------
sub geturlres($){
    my $url =shift;
    open(PP,"curl -i -G -k -m 4 -s '$url' |")||die;
    my $res="no data received";
    my $err=1;
    # read only the status code on the first line, we can not use "last" here otherwise curl will complain
    # about a broken pipe and not all body written
    my $ignorerest=0;
    while(<PP>){
	# first line is something like: HTTP/1.1 404 Not Found
	#print "\nurl $url, dbg $_\n";
	if ($ignorerest==0){
	    chomp;
	    $res=$_;
	    unless(defined $res && $res){
		$res="no status code";
	    }
	    if (m/^HTTP\S+\s[23]/){
		$err=0;
	    }
	    $ignorerest=1;
	}
    }
    close PP;
    return($err,$res);
}
#------------------
sub help(){
    print "tr_httpcheck -- check if a particular web-pages exists 
USAGE: tr_httpcheck [-heE] [url1 url2...]

OPTIONS: 

    -h this help

    -e print only results if an error was found

    -E Like -e but print a . for every checked url.

If no URL is given then tr_httpcheck reads output from 
\"tr_blck -a\" on stdin and processes it. 
Note: This program does only http and https type of protocol checks. 

EXAMPLES: 
 check a single url:
 tr_httpcheck http://www.tuxgraphics.org/

 check many URLs extracted with tr_blck
 from web pages:
 tr_blck -a *.html |  tr_httpcheck -E

tr_httpcheck uses under the hood curl (make sure you have curl installed).

tr_httpcheck is part of the HTML::TagReader package.
\n";
print "Version: $VERSION\n";
    exit;
}
#------------------
__END__

=head1 NAME

tr_httpcheck -- check if a particular web-pages exists

=head1 SYNOPSIS

USAGE: tr_httpcheck [-heEs] [url1 url2...]

=head1 DESCRIPTION

tr_httpcheck is a post-processor for tr_blck to allow for checking
of absolute linke of the type http://....

=head1 OPTIONS

B<-h> this help

B<-e> print only results if an error was found

B<-E> Like -e but print a . for every checked url.

If no URL is given then tr_httpcheck reads output from 
\"tr_blck -a\" on stdin and processes it. 
Note: This program does only http type of protocol checks. It can e.g not
check https or ftp.

=head1 EXAMPLES

check a single url:
 tr_httpcheck http://www.tuxgraphics.org/

check many URLs extracted with tr_blck from web pages:
 tr_blck -a *.html |  tr_httpcheck -E

=head1 ENVIRONMENT

tr_httpcheck uses under the hood curl (make sure you have curl installed).

This software uses curl to fetch the URLs and you may use the http_proxy
environment variable to pass a proxy to curl 
The format of the http_proxy variable looks like "http://www-proxy:8080/"
and the no_proxy is a comma or space seperated list of servers or domains
for which a direct connection should be made.

=head1 AUTHOR

tr_httpcheck is part of the HTML::TagReader package and was written by
Guido Socher 

=head1 NOTES

If you are interessted in a link checker to check links only via the
web-server then this is not the right program for you.  This program is
just a simple addon to tr_blck.  Other programs like e.g

http://linkchecker.sourceforge.net/ or

http://www.linklint.org/ 

can be used if you want to check your web-pages only
remotely via a web server.

=cut

Status-Codes according to RFC 1945
200 is OK
204 is No Content
301 is Moved Permanently
302 is Moved Temporarily
400 is Bad Request
401 is Unauthorized
403 is Forbidden
404 is Not Found
500 is Internal Server Error
501 is Not Implemented
502 is Bad Gateway
503 is Service Unavailable

 
HTTP/1.1 200
Date: Tue, 04 May 1999 18:30:15 GMT
Server: Apache/1.2.6
Pragma: no-cache
Connection: close
Content-Type: text/html
  
HTTP/1.1 200 OK
Server: Apache/1.3.0 (Unix) Debian/GNU PHP/3.0
Keep-alive: timeout=20, max=100
Content-type: text/html
Date: Wed, 05 May 1999 07:10:30 GMT

HTTP/1.1 301 Moved Permanently
Date: Thu, 13 May 1999 16:27:55 GMT
Server: Apache/1.3.3 (Unix)  (Red Hat/Linux)
Location: http://www.linuxfocus.org/~guido.socher/
Connection: close
Content-Type: text/html
 
ENDOFFILE
