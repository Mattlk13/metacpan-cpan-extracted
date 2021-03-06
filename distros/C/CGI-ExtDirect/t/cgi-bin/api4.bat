@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!perl
#line 15

use CGI 'cookie';
use CGI::ExtDirect;

use RPC::ExtDirect::API     Namespace       => 'Namespace',
                            Router_path     => '/cgi-bin/router.cgi',
                            Poll_path       => '/cgi-bin/events.cgi',
                            Remoting_var    => 'Ext.app.CALL',
                            Polling_var     => 'Ext.app.POLL',
                        ;

use RPC::ExtDirect::Test::Pkg::Foo;
use RPC::ExtDirect::Test::Pkg::Bar;
use RPC::ExtDirect::Test::Pkg::Qux;
use RPC::ExtDirect::Test::Pkg::PollProvider;
use RPC::ExtDirect::Test::Pkg::Meta;

my $cookie = cookie(-name=>'sessionID',
                    -value=>'xyzzy',
                    -expires=>'Thursday, 25-Apr-1999 00:40:33 GMT',
                    -path=>'/cgi-bin/database',
                    -domain=>'.capricorn.org',
                    -secure=>1);

my %headers = (
    '-Status'           => '204 No Response',
    '-Content-type'     => 'text/plain',
    '-ChArSeT'          => 'iso-8859-1',
    '-Content_Length'   => '123123',
    '-cookie'           => $cookie,
);

my $cgi = CGI::ExtDirect->new({ debug => 1 });

print $cgi->api( %headers );

exit 0;

__END__
:endofperl

