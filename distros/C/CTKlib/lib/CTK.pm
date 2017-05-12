package CTK; # $Id: CTK.pm 201 2017-05-02 10:37:04Z minus $
use Moose; #use strict;

=head1 NAME

CTK - Command-line ToolKit

=head1 VERSION

Version 1.18

=head1 SYNOPSIS

    use CTK;
    use CTK qw( :BASE ); # :SUBS and :VARS tags to export
    use CTK qw( :SUBS ); # :SUBS tag only to export
    use CTK qw( :VARS ); # :VARS tag only to export

    my $c = new CTK;
    my $c = new CTK (
        prefix       => 'myprogram',
        suffix       => 'sample',
        cfgfile      => '/path/to/conf/file.conf',
        voidfile     => '/path/to/void/file.txt',
        needconfig   => 1, # need creating empty config file
        loglevel     => 'info', # or '1'
        logfile      => CTK::catfile($LOGDIR,'foo.log'),
        logseparator => ' ', # as default
    );

=head1 ABSTRACT

CTKlib - Command-line ToolKit library (CTKlib). Command line interface (CLI)

=head1 DESCRIPTION

CTKlib - is library that provides "extended-features" (utilities) for your robots written on Perl.
Most of the functions and methods this module written very simple language and easy to understand.
To work with CTKlib, you just need to start using it!

See also C<README> file

=head2 new

    my $c = new CTK;

    my $c = new CTK ( syspaths => 1 ); # need use system paths

    my $c = new CTK (
        prefix       => 'myprogram',
        suffix       => 'sample',
        cfgfile      => '/path/to/conf/file.conf',
        voidfile     => '/path/to/void/file.txt',
        needconfig   => 1, # need creating empty config file
        loglevel     => 'info', # or '1'
        logfile      => CTK::catfile($LOGDIR,'foo.log'),
        logseparator => ' ', # as default
    );

Main constructor. All the params are optional

=over 8

=item B<cfgfile>

Full path to the configuration file of the your project

=item B<logfile>

Full path to the log file

=item B<loglevel>

Logging level. It can be set as: debug, info, notice, warning, error, crit, alert, emerg, fatal and except.

=item B<logseparator>

Separator for log columns. The default is the space character (" ")

=item B<needconfig>

Specifies the need to create an empty configuration file. Not recommended for use

=item B<prefix>, B<suffix>

Prefix and suffix of the name your project

=item B<syspaths>

The directive specifies the use of system paths for configuration, logging and allocation of temporary and working data

=item B<voidfile>

Full path to the VOID file for connections testing

=back

=head2 init, again

For internal use only. Please not call this functions

=head2 debug

Prints debug information on STDOUT or into general log-file

=head2 debugmode

Returns debug flag set. 1 - on, 0 - off

=head2 exception

Shows error and immediately exit from program with die state

=head2 logmode

Returns log flag set. 1 - on, 0 - off

=head2 say

Prints a string or a list of strings implicitly appends a newline

=head2 silentmode

Returns the verbose flag in the opposite value. 0 - verbose, 1 - silent.
See L<"/verbosemode">

=head2 testmode

Returns test flag set. 1 - on, 0 - off

=head2 tms

Returns timestamp. For example: [8588] {TimeStamp: +0.5580 sec}

=head2 verbosemode

Returns verbose flag set. 1 - on, 0 - off

=head1 HISTORY

=over 8

=item B<1.00 / 18.06.2012>

Init version

=back

See C<CHANGES> file for details

=head1 DEPENDENCIES

L<Archive::Extract>,
L<Archive::Tar>,
L<Archive::Zip>,
L<Config::General>,
L<DBI>,
L<ExtUtils::MakeMaker>,
L<File::Copy>,
L<File::Path>,
L<File::Pid>,
L<File::Spec>,
L<HTTP::Headers>,
L<HTTP::Request>,
L<HTTP::Response>,
L<IO::Handle>,
L<IPC::Open3>,
L<LWP>,
L<LWP::MediaTypes>,
L<LWP::UserAgent>,
L<MIME::Base64>,
L<MIME::Lite>,
L<Moose>,
L<namespace::autoclean>,
L<Net::FTP>,
L<Perl::OSType>,
L<Sys::SigAction>,
L<Term::ReadKey>,
L<Term::ReadLine>,
L<Test::More>,
L<Text::ParseWords>,
L<Time::Local>,
L<Time::HiRes>,
L<URI>,
L<YAML>

=head1 TO DO

See C<TODO> file

=head1 BUGS

* none noted

=head1 SEE ALSO

C<perl>, L<Moose>, L<CTK::Util>, L<CTK::DBI>, L<CTK::Status>, L<CTK::FilePid>, L<CTK::CPX>

=head1 DIAGNOSTICS

The usual warnings if it can't read or write the files involved.

=head1 AUTHOR

Sergey Lepenkov (Serz Minus) L<http://www.serzik.com> E<lt>minus@mail333.comE<gt>

=head1 COPYRIGHT

Copyright (C) 1998-2017 D&D Corporation. All Rights Reserved

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it under the same terms and conditions as Perl itself.

This program is distributed under the GNU LGPL v3 (GNU Lesser General Public License version 3).

See C<LICENSE> file

=cut

use vars qw/
        $VERSION
        $TM $EXEDIR $DATADIR $CONFDIR $CONFFILE $LOGDIR $LOGFILE %ARGS %OPT @OPTSYSDEF $TERMCHSET
    /;
$VERSION = '1.18';

use constant {
    DEBUG     => 1, # 0 - off, 1 - on, 2 - all (+ http headers and other)
    LOG       => 1, # 0 - off, 1 - on
    TESTMODE  => 1, # 0 - off, 1 - on (�������� ����� ����������� ������ �� �������� ���� � �������� ������)
    VERBOSE   => 1, # 0 - off, 1 - on
    SILENT    => 1, # 0 - off, 1 - on (silent/quiet)

    WIN       => $^O =~ /mswin/i ? 1 : 0,
    NULL      => $^O =~ /mswin/i ? 'NUL' : '/dev/null',
    TONULL    => $^O =~ /mswin/i ? '>NUL 2>&1' : '>/dev/null 2>&1',
    ERR2OUT   => '2>&1',

    TERMCHSETD=> 'utf8', # ��������� ��������� ��� ���������������

    LOGFILED  => 'ctklib.log',    # ���� ���� �� ���������
    CFGFILED  => 'ctklib.conf',   # ���� ������������ �� ���������
    CFGFILE   => '[PREFIX].conf', # ���� ������������
    VOIDFILE  => 'void.txt',      # ���� VOID (��� ������������ ������ � �������)

    DATADIRD  => 'data', # ��� �������� ������ �� ���������
    CONFDIRD  => 'conf', # ��� �������� ������������ �� ���������
    LOGDIRD   => 'log',  # ��� �������� ����� �� ���������
};

use base qw /Exporter/; # extends qw/CTK::Arc/;
our @EXPORT = qw(
        say debug tms exception testmode debugmode logmode verbosemode silentmode
        $EXEDIR $DATADIR $CONFDIR $CONFFILE $LOGDIR $LOGFILE %OPT @OPTSYSDEF
    );
our @EXPORT_OK = qw(
        say debug tms exception testmode debugmode logmode verbosemode silentmode
        $TM $EXEDIR $DATADIR $CONFDIR $CONFFILE $LOGDIR $LOGFILE %OPT @OPTSYSDEF
    );
our %EXPORT_TAGS = (
        ALL     => [qw($TM $EXEDIR $DATADIR $CONFDIR $CONFFILE $LOGDIR $LOGFILE %OPT @OPTSYSDEF
                       say debug tms exception testmode debugmode logmode verbosemode silentmode)],
        BASE    => [qw($EXEDIR $DATADIR $CONFDIR $LOGDIR say debug tms exception testmode debugmode
                       logmode verbosemode silentmode)],
        FUNC    => [qw(say debug tms exception testmode debugmode logmode verbosemode silentmode)],
        FUNCS   => [qw(say debug tms exception testmode debugmode logmode verbosemode silentmode)],
        SUB     => [qw(say debug tms exception testmode debugmode logmode verbosemode silentmode)],
        SUBS    => [qw(say debug tms exception testmode debugmode logmode verbosemode silentmode)],
        VARS    => [qw($TM $EXEDIR $DATADIR $CONFDIR $CONFFILE $LOGDIR $LOGFILE %OPT @OPTSYSDEF)],
        NONE    => [qw()],
    );

use Time::HiRes qw(gettimeofday);
use FindBin qw($RealBin $Script);

use Config::General;
use CTK::CPX;
use CTK::Util;

########################
## Init functions
########################
sub init {
    # GLOBAL VARS
    $TM       = gettimeofday();
    $EXEDIR   = $RealBin; # ������� ��� ������ (�� ��������������)
    $DATADIR  = catdir($EXEDIR, DATADIRD);  # ����� ��� �������� ������ � ������
    $CONFDIR  = catdir($EXEDIR, CONFDIRD);  # ����� ��� �������� ���������������� ����� (�� �������)
    $LOGDIR   = catdir($EXEDIR, LOGDIRD);   # ����� ��� �������� ������ � ������
    $CONFFILE = catfile($EXEDIR, CFGFILED); # ���� ������������ (���������). ��. BUILD()
    $LOGFILE  = catfile($LOGDIR, LOGFILED); # ���� ���� (���������)
    %OPT = (                                # ����� ��������� ������
        'debug'     => DEBUG    ? 0 : 1,    # ��� ��������� ������� ��� ��� �������� ���� "!"
        'log'       => LOG      ? 0 : 1,    # ��� ��������� ������� ��� ��� �������� ���� "!"
        'testmode'  => TESTMODE ? 0 : 1,    # ��� ��������� ������� ��� ��� �������� ���� "!"
        'verbose'   => 0,
    );
    @OPTSYSDEF = ( # ��������� �� ���������. ������������ �������� �����: humvdlcyt?
        # ��������� �������
        "help|usage|h|?",                   # ������ �� ���������
        "man|m",                            # �������
        "version|ver|v",                    # ������� ������

        # ��������� �������
        "debug|d",                          # ������� -- �� �����, ������� ������� ��. DEBUG
        "log|l",                            # ����������� -- � ���, ������� ���� ��. LOG
        "logclear|logclean|c",              # ������� ���� ����� ������ ��������
        "signature|sign|y=s",               # ������� � ����

        # ����� ������
        "testmode|test|t",                  # �������� ����� ������ -- ������� ������ ��. TESTMODE
    );
}
BEGIN { init() }
*again = \&init;

# ���������� ������������ ������
if (WIN) {
    my $tcs = $TERMCHSET || 'cp866';
    tie *CTKCP, 'CTK::CPX', $tcs;
} else {
    my $tcs = $TERMCHSET // TERMCHSETD;
    if ($tcs) { tie *CTKCP, 'CTK::CPX', $tcs } else { *CTKCP = *STDOUT }
}

########################
## Base functions
########################
sub say { print CTKCP @_ ? @_ : '',"\n"}
sub debug {
    unshift(@_,$OPT{signature}." ") if defined $OPT{signature};
    if (LOG && $OPT{'log'}) {
        my @dt=localtime(time());
        if (open(FD, ">>", $LOGFILE)) {
            flock FD, 2 or carp("Can't lock file: $!");
            print FD sprintf("[%02d.%02d.%04d %02d:%02d:%02d] ",$dt[3],$dt[4]+1,$dt[5]+1900,$dt[2],$dt[1],$dt[0]), @_ ? @_ : '', "\n";
            close(FD);
        } else {
            carp("Can't open file to write: $!");
        }
    }
    return 1 unless DEBUG && $OPT{debug};
    say(@_);
}
sub tms { "[$$] {TimeStamp: ".sprintf("%+.*f",4, gettimeofday()-$TM)." sec}" }
sub exception {
    my $clr = " [ CALLER: ".join("; ", caller())." ]";
    debug(@_,$clr);
    confess(translate(join("",(@_,$clr))));
}

# Modes
sub testmode { return CTK::TESTMODE && $OPT{testmode} }
sub debugmode { return (CTK::DEBUG && $OPT{debug}) ? DEBUG : undef }
sub logmode { return CTK::LOG && $OPT{'log'} }
sub verbosemode { return CTK::VERBOSE && $OPT{verbose} }
sub silentmode { return CTK::SILENT && !$OPT{verbose} }

########################
## General Moose Methods
########################

with 'CTK::CLI' => {
            -excludes => [qw/_cli_select/],
        },
     'CTK::File' => {
            -excludes => [qw/_error _expand_wildcards/],
        },
     'CTK::Crypt' => {},
     'CTK::Arc' => {
            -excludes => [qw/_getarc/],
        },
     'CTK::Net' => {
            -alias    => {
                    _debug_http => 'debug_http',
                },
            -excludes => [qw/_error/],
        },
     'CTK::Log' => {
            -excludes => [qw/_flush/],
        };

has 'revision'  => ( # �������
        is      => 'ro',
        isa     => 'Str',
        default => q/$Revision: 201 $/ =~ /(\d+\.?\d*)/ ? $1 : '0',
        lazy    => 1,
        init_arg=> undef,
    );
has 'script'    => ( # ��� �������
        is      => 'ro',
        isa     => 'Str',
        default => $Script,
    );
has 'prefix'    => ( # ������� (��� ���� �������� �� ���� CTKlib)
        is      => 'rw',
        isa     => 'Str',
        default => ($Script =~ /^(.+?)\./ ? $1 : $Script),
    );
has 'suffix'    => ( # ������ (��� ���� �������� �� ���� CTKlib)
        is      => 'rw',
        isa     => 'Str',
        default => '',
    );
has 'cfgfile'   => ( # ������ ��� ����� ������������
        is      => 'rw',
        isa     => 'Str',
        default => CFGFILE,
        trigger => sub {
                my $self = shift;
                my $val = shift || '';
                my $old_val = shift || '';
                #debug "TRIGGER: $self, $val, $old_val";
                $self->{cfgfile} = dformat($val,{
                        PREFIX   => $self->prefix(),
                        SUFFIX   => $self->suffix(),
                        EXT      => 'conf',
                        DEFAULT  => CFGFILED,
                    }) if $val;
                $CONFFILE = $self->{cfgfile};
            },
    );
has 'voidfile'  => ( # ������ ��� ����� ������� �����, ��� ���� ������
        is      => 'rw',
        isa     => 'Str',
        default => VOIDFILE,
        trigger => sub {
                my $self = shift;
                my $val = shift || '';
                my $old_val = shift || '';
                # debug "TRIGGER: $self, $val, $old_val";
                $self->{voidfile} = dformat($val,{
                        PREFIX   => $self->prefix(),
                        SUFFIX   => $self->suffix(),
                        EXT      => 'txt',
                        DEFAULT  => VOIDFILE,
                    }) if $val; # if $val ne $old_val
            },
    );
has 'config'    => ( # ���������������� ��� (Config::General)
        is      => 'rw',
        isa     => 'HashRef',
    );
has 'options'   => ( # ��� ����� ��������� ������ (Getopt::Long)
        is      => 'rw',
        isa     => 'HashRef',
        default => sub { \%OPT } ,
    );
has 'needconfig'=> ( # ����� �� ��������� ������ ������ � ������ ���������� �������?
        is      => 'rw',
        isa     => 'Bool',
        default => 0,
    );
has 'syspaths'=> ( # ������������ �� ��������� ���� �� ���������, ������ "��������"?
        is      => 'rw',
        isa     => 'Bool',
        default => 0,
    );
has 'exedir'    => ( # ������� �������� ����������� ��������� ���������� ����������
        is      => 'ro',
        isa     => 'Str',
        default => sub { $EXEDIR },
        lazy    => 1,
    );
has 'datadir'   => ( # ������� �������� ����������� ��������� ������� ����������
        is      => 'rw',
        isa     => 'Str',
        default => sub { $DATADIR },
        lazy    => 1,
        trigger => sub {
                my $self = shift;
                my $val = shift || '';
                # debug "TRIGGER: $self, $val";
                $DATADIR = $val;
            },

    );
has 'confdir'   => ( # ������� �������� ����������� ��������� ���������� ���������������� ������
        is      => 'rw',
        isa     => 'Str',
        default => sub { $CONFDIR },
        lazy    => 1,
        trigger => sub {
                my $self = shift;
                my $val = shift || '';
                # debug "TRIGGER: $self, $val";
                $CONFDIR = $val;
            },

    );
has 'logdir'    => ( # ������� �������� ����������� ��������� ���������� �����
        is      => 'rw',
        isa     => 'Str',
        default => sub { $LOGDIR },
        lazy    => 1,
        trigger => sub {
                my $self = shift;
                my $val = shift || '';
                # debug "TRIGGER: $self, $val";
                $LOGDIR = $val;
                $LOGFILE = catfile($val,sprintf("%s.log",$self->prefix()));
            },

    );

sub BUILD { # new
    my $self = shift;
    my $options = shift || {};

    # �������� ����-���������
    my $prefix = $self->prefix();
    my $suffix = $self->suffix();

    # ����������� �� ������ � ������ ���� ������ �� ����� ������������
    my $oldcfgfile = $self->cfgfile();
    if ($self->syspaths()) {
        # ������������ ��������� ����
        $self->datadir(catdir(tmpdir(),$prefix));
        $self->confdir(catdir(sysconfdir(),$prefix,CONFDIRD));
        my $t_logdir = syslogdir();
        $t_logdir = tmpdir() unless -e $t_logdir;
        $self->logdir($t_logdir);
        $oldcfgfile = catfile(sysconfdir(),$prefix,$prefix.'.conf');
    } else {
        # ������������ ������� ���� (������������ $EXEDIR)
        $oldcfgfile = catfile($EXEDIR,CFGFILE) if $oldcfgfile eq CFGFILE;
    }

    # Paths rebuilding
    $self->cfgfile($oldcfgfile); # CFGFILE rebuilding
    $self->voidfile($self->voidfile()); # VOIDFILE rebuilding

    # ���������� ����� ������������
    $self->config({_loadconfig($self->cfgfile(), $self->needconfig())});

    #debug Dumper(\@_);
    return 1;
};
sub AUTOLOAD {
    # ��� ������ ���� ��������� �� ���� �������� ����� ��������� ������
    # ���� ������ ������ �� ��������, �� ������ �������� ������
    my $self = shift;
    our $AUTOLOAD;
    my $AL = $AUTOLOAD;
    my $ss = undef;
    $ss = $1 if $AL=~/\:\:([^\:]+)$/;
    if ($ss) {
        #debug($self->x());
        #debug($ss);
        my $lcode = __PACKAGE__->can($ss);
        if ($lcode && ref($lcode) eq 'CODE') {
            &{$lcode}(@_);
        } else {
            exception("Can't call method or procedure \"$ss\"!");
        }
    } else {
        exception("Can't find procedure \"$AL\"!");
    }
    return;
}
sub DEMOLISH { # DESTROY
    # ������ ����������
}

########################
## ���������� ���������
########################
sub _loadconfig {
    # ������ ����������������� ����� ��� �������� �������
    my $cfile = shift || '';
    my $need  = shift || 0;

    my %config = (loadstatus => 0);
    my $conf;

    # �������� ��������� ���������������� ������
    if ($cfile && -e $cfile) {
        $conf = new Config::General(
                -ConfigFile         => $cfile,
                -ConfigPath         => [$EXEDIR, $CONFDIR],
                -ApacheCompatible   => 1,
                -LowerCaseNames     => 1,
                -AutoTrue           => 1,
            );
        %config = $conf->getall;
        $config{configfiles} = [$conf->files];
        $config{loadstatus} = 1;
    }

    # ������������ ���� ������� ��������� ������������
    return %config unless $need;

    # ���� �� ������� ���������, �� �������������� ������� �������� ������ ������� (�������)
    unless (%config && $config{loadstatus}) {
        debug "Configuration save into \"$cfile\"...";
        $conf = new Config::General( -ConfigHash => \%config, );
        $conf->save_file($cfile)
    }

    return %config;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__
