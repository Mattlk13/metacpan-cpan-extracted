package RackMan::Device::PDU::APC_RackPDU;

use Carp;
use Config::IniFiles;
use Cwd         qw< getcwd >;
use File::Path;
use File::Temp  qw< tempdir >;
use Moose::Role;
use Net::FTP;
use Net::SNMP;
use RackMan;
use RackMan::File;
use RackMan::Utils;
use namespace::autoclean;


use constant {
    CONFIG_SECTION  => "device:pdu:apc_rackpdu",
    INTERFACE_NAME  => "AC-out",
    CONFIG_FILENAME => "config.ini",
    EMPTY_VALUE     => '""',
    PDU_RESTART_OID => ".1.3.6.1.4.1.318.2.2.1",
};


#
# write_config()
# ------------
sub write_config {
    my ($self, $args) = @_;

    my $rackman = $args->{rackman};
    my $path    = $rackman->config->val(general => "path");

    # generate the configuration file
    my $file = $self->fetch_from_database($args);

    # write the configuration file on disk, to its final path
    $file->path($path);
    print "  + writing ", $file->fullpath, $/ if $args->{verbose};
    my $scm = $rackman->get_scm({ path => $path });
    $scm->update;
    $file->write;
    $scm->add($file->name);
    $scm->commit($file->name, "generated by ".__PACKAGE__
        . " / $::PROGRAM v$::VERSION");
}


#
# diff_config()
# -----------
sub diff_config {
    my ($self, $args) = @_;

    # fetch config from the device
    my $actual   = $self->fetch_from_device($args);

    # generate the config from the database
    my $expected = $self->fetch_from_database($args);

    # prepare the files
    my @cfg_actual    = split $/, $actual->content;
    my @cfg_expected  = split $/, $expected->content;

    # .. remove bits here and there that will generate useless diffs
    s|generated on \S+ at \S+|generated|,
    s|; Rack PDU Feature Not Supported *||
        for @cfg_actual, @cfg_expected;

    # computes the differences between the two files
    print "  - computing differences..." if $args->{verbose};
    my @diff = diff_lines(\@cfg_actual, \@cfg_expected);
    print " done\n\n" if $args->{verbose};
    print @diff;

    RackMan->set_status(1) if @diff;
}


#
# push_config()
# -----------
sub push_config {
    my ($self, $args) = @_;

    my $rackman = $args->{rackman};
    my $path    = $rackman->config->val(general => "path");
    my $file    = RackMan::File->new({ path => $path, name => CONFIG_FILENAME });

    # read the file from disk
    $file->read;

    # store it on the device
    $self->store_to_device($args, $file);
}


#
# fetch_from_database()
# -------------------
sub fetch_from_database {
    my ($self, $args) = @_;

    my $rackman = $args->{rackman};
    my $host    = $self->attributes->{FQDN} || $self->object_name;
    my ($node, $domain) = split /\./, $host;

    # get the current device config
    my $file    = $self->fetch_from_device($args);

    my $rt_url      = $rackman->config->val(general => "racktables_url");
    my $short_url   = $rackman->config->val(general => "short_url");
    my $nagios_url  = $rackman->config->val(general => "nagios_url");
    s:/$:: for $nagios_url, $rt_url;

    # parse the config file
    my $config = Config::IniFiles->new(-file => $file->fullpath)
        or RackMan->error("can't parse config file: ", @Config::IniFiles::errors);

    # network settings
    $config->setval("NetworkTCP/IP", "HostName", $node);
    $config->setval("NetworkTCP/IP", "DomainName", $domain);

    # DNS settings
    my @dns_servers = split / +/,
        $rackman->config->val(general => "dns_servers");
    push @dns_servers, "0.0.0.0", "0.0.0.0";
    $config->setval("NetworkDNS", "DNSManualOverride", "enabled");
    $config->setval("NetworkDNS", "PrimaryDNSServerIP", $dns_servers[0]);
    $config->setval("NetworkDNS", "SecondaryDNSServerIP", $dns_servers[1]);

    # email settings
    my $mail_address = $rackman->config->val(CONFIG_SECTION, "mail_address");
    $config->setval("NetworkEMAIL", "EmailServerName",
        $rackman->config->val(general => "mail_server"));
    $config->setval("NetworkEMAIL", "EmailFromName", $mail_address);
    $config->setval("NetworkEMAIL", "EmailReceiver1Address", $mail_address);
    $config->setval("NetworkEMAIL", "EmailReceiver1Enable", "enabled");

    # system information
    $config->setval("SystemID", "Name", $host);
    $config->setval("SystemID", "Contact", $mail_address);
    $config->setval("SystemID", "Location",
        $self->rack->{name}.' @ '.$self->rack->{row_name});

    # NTP settings
    my @ntp_servers = split / +/,
        $rackman->config->val(general => "ntp_servers");
    push @ntp_servers, "0.0.0.0", "0.0.0.0";
    $config->setval("SystemDate/Time", "NTPEnable", "enabled");
    $config->setval("SystemDate/Time", "NTPPrimaryServer", $ntp_servers[0]);
    $config->setval("SystemDate/Time", "NTPSecondaryServer", $ntp_servers[1]);
    $config->setval("SystemDate/Time", "NTPTimeZone", "+01:00");

    # set the first bottom link to the corresponding page in RackTables
    if ($rt_url) {
        my $url = sprintf "$rt_url/index.php?page=object&object_id=%d",
                $self->object_id;
        $config->setval("SystemLinks", "LinkURL1", $url);
        $config->setval("SystemLinks", "LinkDisplay1", "RackTables");
        $config->setval("SystemLinks", "LinkName1",
            "link to $node\'s page on RackTables");
    }

    # set the second bottom link to the corresponding page in Nagios
    if ($nagios_url) {
        my $url = "$nagios_url/cgi-bin/extinfo.cgi?type=1&host=$host";
        $config->setval("SystemLinks", "LinkURL2", $url);
        $config->setval("SystemLinks", "LinkDisplay2", "Nagios");
        $config->setval("SystemLinks", "LinkName2",
            "link to $node\'s page on Nagios");
    }

    # set the third bottom link to the corresponding page on APC site
    $config->setval("SystemLinks", "LinkURL3",
        $self->attributes->{"HW type link"});
    $config->setval("SystemLinks", "LinkDisplay3",
        $self->attributes->{"HW type"}." specifications");
    $config->setval("SystemLinks", "LinkName3",
        "link to this model's specifications page on APC site");

    # the config format differs mostly for outlets settings, so we
    # detect the format version by looking the section present in
    # the file
    my ($outlet_sect, $outlet_name, $outlet_link)
        = $config->SectionExists("RackPDUOutlet")
        ? qw< RackPDUOutlet Name OutletLink >                 # Rack PDU v3
        : qw< Outlet OUTLET_NAME_A OUTLET_EXTERNAL_LINK_A >;  # Rack PDU v5

    # outlets settings
    for my $port (grep { $_->{oif_name} eq INTERFACE_NAME } @{ $self->ports }) {
        my ($name, $url) = ("(unused)", "#");

        if ($port->{peer_object_name}) {
            # note: an outlet name can be 23 chars max
            ($name) = split /\./, $port->{peer_object_name};
            my $max = 23 - 1 - length $port->{peer_port_name};
            substr($name, $max-1) = "~" if length $name > $max;
            $name .= ":$port->{peer_port_name}";
        }

        # construct the RackTables url for the peer device, if any
        if ($short_url and $port->{peer_object_id}) {
            # note: an outlet URL can be 60 chars max
            $url = "$short_url?oi=$port->{peer_object_id}"
                 . "&pi=$port->{peer_port_id}";

            substr($url , 59) = "~" if length $url  > 60;
        }

        my $n = int $port->{name};
        $config->setval($outlet_sect, "$outlet_name$n", $name);
        $config->setval($outlet_sect, "$outlet_link$n", $url);
    }

    # write the modified config back on disk
    $config->RewriteConfig;
    $file->read;

    return $file
}


#
# fetch_from_device()
# -----------------
sub fetch_from_device {
    my ($self, $args) = @_;

    my $rackman = $args->{rackman};
    my $host    = $self->attributes->{FQDN} || $self->object_name;
    my $login   = $rackman->options->{device_login}
               || $rackman->config->val(CONFIG_SECTION, "ftp_login", "apc");
    my $passwd  = $rackman->options->{device_password}
               || $rackman->config->val(CONFIG_SECTION, "ftp_password", "apc");

    # create a temporary directory to work in there
    my $olddir = getcwd();
    my $tmpdir = tempdir(CLEANUP => 1);

    # fetch the config file from the device using FTP
    print "  < fetching from device via FTP." if $args->{verbose};
    # .. connect
    my $ftp = Net::FTP->new($host)
        or RackMan->error_n("could not connect to '$host': $@");
    $ftp->login($login, $passwd)
        or RackMan->error_n("could not login: ", $ftp->message);

    # .. configure, chdir
    print "." if $args->{verbose};
    $ftp->ascii;
    $ftp->cwd("/")
        or RackMan->error_n("could not change working directory: ", $ftp->message);

    # .. fetch the file
    print "." if $args->{verbose};
    chdir $tmpdir;
    $ftp->get(CONFIG_FILENAME)
        or RackMan->error_n("could not fetch file: ", $ftp->message);
    chdir $olddir;
    $ftp->quit;
    print " done\n" if $args->{verbose};

    # put the config file in a RackMan:File instance
    my $file = RackMan::File->new({ path => $tmpdir, name => CONFIG_FILENAME });
    $file->read;


    return $file
}


#
# store_to_device()
# ---------------
sub store_to_device {
    my ($self, $args, $file) = @_;

    my $rackman = $args->{rackman};
    my $me      = $::COMMAND.": ".(caller(0))[3];
    my $host    = $self->attributes->{FQDN} || $self->object_name;
    my $login   = $rackman->options->{device_login}
               || $rackman->config->val(CONFIG_SECTION, "ftp_login", "apc");
    my $passwd  = $rackman->options->{device_password}
               || $rackman->config->val(CONFIG_SECTION, "ftp_password", "apc");
    my $community = $rackman->options->{write_community}
        || $rackman->config->val(CONFIG_SECTION, "write_community", "private");

    # check argument
    eval { $file->isa("RackMan::File") }
        or croak "argument must be a RackMan::File instance";

    # ensure the file is written on disk
    $file->write;

    # store the config file to the device using FTP
    print "  > storing to device via FTP." if $args->{verbose};
    # .. connect
    my $ftp = Net::FTP->new($host)
        or RackMan->error_n("could not connect to '$host': $@");
    $ftp->login($login, $passwd)
        or RackMan->error_n("could not login: ", $ftp->message);

    # .. configure, chdir
    print "." if $args->{verbose};
    $ftp->ascii;
    $ftp->cwd("/")
        or RackMan->error_n("could not change working directory: ", $ftp->message);

    # .. send the file
    print "." if $args->{verbose};
    $ftp->put($file->fullpath, CONFIG_FILENAME)
        or RackMan->error_n("could not store file: ", $ftp->message);
    $ftp->quit;
    print " done\n" if $args->{verbose};

    # send the SNMP request to make the PDU reboot
    #   mcontrolRestartAgent = restartCurrentAgent(1)
    my ($session, $error);
    ($session, $error) = Net::SNMP->session(
        -hostname   => $host, 
        -community  => $community,
        -version    => 2,
    ) or RackMan->error("can't create SNMP session: $error");

    my $result = $session->set_request(
        -varbindlist    => [ PDU_RESTART_OID, INTEGER, 1 ],
    ) or RackMan->error("could not execute SNMP set request: ", $session->error);
}


__PACKAGE__

__END__

=head1 NAME

RackMan::Device::PDU::APC_RackPDU - Role for APC Rack PDUs

=head1 DESCRIPTION

This module is the role for APC Rack PDUs.

It works by fetching the configuration from the corresponding PDU
(obviously, you need a network access to it) and updating it with
the values from the RackTables database. The resulting configuration
file can then be compared with the original or pushed back to the
device.


=head1 PUBLIC METHODS

=head2 write_config

Write the PDU configuration file, F<config.ini>, in the directory
specified in RackMan's config (section C<[general]>, parameter C<path>).

B<Arguments:>

=over

=item 1. options (hashref)

=back


=head2 diff_config

Fetch the PDU configuration from the device twice, modify one according
to the database, compute and print the differences between the two.

The exit status of the program is set to 1 if there are differences,
0 otherwise.

B<Arguments:>

=over

=item 1. options (hashref)

=back


=head2 push_config

Push the configuration from disk (where C<write_config> wrote it)
to the PDU device.

B<Arguments:>

=over

=item 1. options (hashref)

=back


=head1 INTERNAL METHODS

=head2 fetch_from_database

Fetch the PDU configuration from the device via FTP and modify it
according to the information from the RackTables database.

B<Arguments:>

=over

=item 1. options (hashref)

=back

B<Return:>

=over

=item *

PDU configuration (RackMan::File instance)

=back


=head2 fetch_from_device

Fetch the PDU configuration from the device via FTP.

B<Arguments:>

=over

=item 1. options (hashref)

=back

B<Return:>

=over

=item *

PDU configuration (RackMan::File instance)

=back


=head2 store_to_device

Store the PDU configuration to the device via FTP.

B<Arguments:>

=over

=item 1. options (hashref)

=item 2. PDU configuration (RackMan::File instance)

=back


=head1 CONFIGURATION

See L<rack/"Section [device:pdu:apc_rackpdu]">


=head1 AUTHOR

Sebastien Aperghis-Tramoni

=cut

