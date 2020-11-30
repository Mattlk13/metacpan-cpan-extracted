package FusionInventory::Agent::HTTP::Server::Proxy;

use strict;
use warnings;

use English qw(-no_match_vars);
use XML::TreePP;
use XML::XPath;
use Compress::Zlib;
use File::Temp;

use base "FusionInventory::Agent::HTTP::Server::Plugin";

use FusionInventory::Agent::Tools;
use FusionInventory::Agent::HTTP::Client::OCS;

our $VERSION = "1.1";

sub urlMatch {
    my ($self, $path) = @_;
    # By default, re_path_match => qr{^/proxy/(version|fusioninventory)/?$}
    return 0 unless $path =~ $self->{re_path_match};
    $self->{request} = $1;
    return 1;
}

sub log_prefix {
    return "[proxy server plugin] ";
}

sub config_file {
    return "proxy-server-plugin.cfg";
}

sub defaults {
    return {
        disabled            => "yes",
        url_path            => "/proxy",
        port                => 0,
        only_local_store    => "no",
        local_store         => '',
        prolog_freq         => 24,
        max_proxy_threads   => 10,
        # Supported by class FusionInventory::Agent::HTTP::Server::Plugin
        maxrate             => 30,
        maxrate_period      => 3600,
    };
}

sub supported_method {
    my ($self, $method) = @_;

    return 1 if $method eq 'GET' || $method eq 'POST';

    $self->error("invalid request type: $method");

    return 0;
}

sub init {
    my ($self) = @_;

    $self->SUPER::init(@_);

    $self->{request}  = 'none';

    my $defaults = $self->defaults();
    my $url_path = $self->config('url_path');
    $self->debug("Using $url_path as base url matching")
        if ($url_path ne $defaults->{url_path});
    $self->{re_path_match} = qr{^$url_path/(apiversion|fusioninventory)/?$};

    # Normalize only_local_store
    $self->{only_local_store} = $self->config('only_local_store') !~ /^0|no$/i ? 1 : 0;
}

sub handle {
    my ($self, $client, $request, $clientIp) = @_;

    my $agent  = $self->{server}->{agent};

    # rate limit by ip to avoid abuse
    if ($self->rate_limited($clientIp)) {
        $client->send_error(429); # Too Many Requests
        return 429;
    }

    if ($self->{request} eq 'apiversion') {
        my $response = HTTP::Response->new(
            200,
            'OK',
            HTTP::Headers->new( 'Content-Type' => 'text/plain' ),
            $VERSION
        );

        $client->send_response($response);

        return 200;
    }

    my $retcode = $self->_handle_proxy_request($client, $request, $clientIp);

    # In the case we run in a fork, just close the socket and quit
    if ($agent->forked()) {
        $self->debug("response status $retcode");
        $client->close();
        $agent->fork_exit(logger => $self, name => $self->name());
    }

    return $retcode;
}

sub _handle_proxy_request {
    my ($self, $client, $request, $clientIp) = @_;

    return unless $client && $request && $clientIp;

    my $remoteid = $clientIp;

    # /proxy/fusioninventory request

    # From here we should fork and return
    my $agent = $self->{server}->{agent};
    unless ($agent->forked()) {
        # check against max_proxy_threads
        my $current_requests = $agent->forked(name => $self->name());

        if ($current_requests >= $self->config('max_proxy_threads')) {
            $client->send_error(429); # Too Many Requests
            return 429;
        }

        return 1 if $agent->fork(name => $self->name(), description => $self->name()." request");
    }

    my $content_type = $request->header('Content-type');

    my ($url, $params) = split(/[?]/, $request->uri());

    if ($params && $params =~ /action=getConfig/) {
        $self->debug("$params request from $clientIp, sending nothing to do");
        my $response = HTTP::Response->new(
            200,
            'OK',
            HTTP::Headers->new( 'Content-Type' => 'application/json' ),
            '{}'
        );

        $client->send_response($response);

        return 200;
    } elsif ($params) {
        $self->info("Unsupported $params request from $clientIp");
        $client->send_error(403, 'Unsupported request');
        return 403;
    }

    unless ($content_type) {
        $self->info("No mandatory Content-type header provided in $self->{request} request from $clientIp");
        $client->send_error(403, 'Content-type not set');
        return 403;
    }

    my $content = $request->content();

    # Uncompress if needed
    if ($content_type =~ m|^application/x-compress(-zlib)?$|i && $content =~ /(\x78\x9C.*)/s) {
        $content = Compress::Zlib::uncompress($content);
    } elsif ($content_type =~ m|^application/x-compress-gzip$|i) {
        my $in = File::Temp->new(SUFFIX => '.proxy');
        print $in $content;
        close($in);

        my $out;
        eval {
            $out = getFileHandle(
                command => 'gzip -dc ' . $in->filename(),
                logger  => $self->{logger}
            );
        };

        unless ($out) {
            $client->send_error(403, 'Unsupported $content_type Content-type');
            $self->info("Can't uncompress $content_type Content-type in $self->{request} request from $clientIp");
            return 403;
        }

        local $INPUT_RECORD_SEPARATOR; # Set input to "slurp" mode.
        $content = <$out>;
        close($out);
    } elsif ($content_type !~ m|^application/xml$|i) {
        $client->send_error(403, 'Unsupported Content-type');
        $self->info("Unsupported '$content_type' Content-type header provided in $self->{request} request from $clientIp");
        return 403;
    }

    unless ($content) {
        $self->info("No Content found in $self->{request} request from $clientIp");
        $client->send_error(403, 'No content');
        return 403;
    }

    my $deviceid;
    if ($content =~ m|^<\?xml|ms) {
        # Check if it's a PROLOG request
        my $parser = XML::XPath->new(xml => $content);

        # Don't validate XML against DTD, parsing may fail if a proxy is active
        $XML::XPath::ParseParamEnt = 0;

        my $query = $parser->getNodeText("/REQUEST/QUERY");

        unless ($query && $query =~ /^PROLOG|INVENTORY$/) {
            $self->info("Not supported ".($query||"unknown")." query from $remoteid");
            my ($sample) = $content =~ /^(.{1,80})/ms;
            if ($sample) {
                $sample =~ s/\n\s*//gs;
                $sample = getSanitizedString($sample);
                $self->debug("Not supported XML looking like: $sample")
                    if $sample;
            }
            $client->send_error(403, 'Unsupported query');
            return 403;
        }

        $deviceid = $parser->getNodeText("/REQUEST/DEVICEID");

        unless ($deviceid) {
            $self->info("Not supported $query query from $remoteid");
            $client->send_error(403, "$query query without deviceid");
            return 403;
        }

        $remoteid = $deviceid . '@' . $clientIp;
        $self->info("$query query from $remoteid");

        if ($query eq 'PROLOG') {

            $self->debug2("PROLOG request from $remoteid");

            my $tpp = XML::TreePP->new(indent => 2);
            my $data = {
                REPLY => {
                    RESPONSE    => 'SEND',
                    PROLOG_FREQ => $self->config("prolog_freq")
                }
            };

            my $response = HTTP::Response->new(
                200,
                'OK',
                HTTP::Headers->new( 'Content-Type' => 'application/xml' ),
                $tpp->write($data)
            );

            $client->send_response($response);

            return 200;
        }
    } else {
        $client->send_error(403, 'Unsupported content');
        $self->info("Unsupported content in $self->{request} request from $clientIp");
        $self->debug("Content from $clientIp was starting with '".(substr($content,0,40))."'");
        return 403;
    }

    $self->debug("proxy request for $remoteid");

    my @servers = ();
    my $serverconfig = $agent->{config};

    unless ($serverconfig) {
        $client->send_error(500, 'Server configuration missing');
        $self->info("Server configuration is missing");
        return 500;
    }

    my $response = HTTP::Response->new(
        200,
        'OK',
        HTTP::Headers->new( 'Content-Type' => 'application/xml' ),
        "<?xml version='1.0' encoding='UTF-8'?>\n<REPLY></REPLY>\n"
    );

    if ($self->config('only_local_store')) {
        $response = HTTP::Response->new(500, 'No local storage for inventory')
            unless ($self->config('local_store') && -d $self->config('local_store'));
    } else {
        @servers = grep { $_->isType('server') } $agent->getTargets();
    }

    if ($self->config('local_store') && -d $self->config('local_store')) {
        my $xmlfile = $self->config('local_store');
        $xmlfile =~ s|/*$||;
        $xmlfile .= "/$deviceid.xml";
        $self->debug("Saving inventory in $xmlfile");
        my $XML;
        if (!open($XML, '>', $xmlfile)) {
            $client->send_error(500, 'Cannot store content');
            $self->error("Can't store content from $clientIp $self->{request} request");
            return 500;
        }
        print $XML $content;
        close($XML);
        if (-s $xmlfile != length($content)) {
            $client->send_error(500, 'Content store failure');
            $self->error("Can't store content from $clientIp $self->{request} request");
            return 500;
        }
        if ($self->config('only_local_store')) {
            $client->send_response($response);
            return 200;
        }
    }

    if (@servers) {
        my $proxyclient = FusionInventory::Agent::HTTP::Client::OCS->new(
            logger       => $self->{logger},
            user         => $serverconfig->{user},
            password     => $serverconfig->{password},
            proxy        => $serverconfig->{proxy},
            ca_cert_file => $serverconfig->{'ca-cert-file'},
            ca_cert_dir  => $serverconfig->{'ca-cert-dir'},
            no_ssl_check => $serverconfig->{'no-ssl-check'},
            no_compress  => $serverconfig->{'no-compress'},
        );

        my $message = FusionInventory::Agent::HTTP::Server::Proxy::Message->new(
            content  => $content,
        );

        foreach my $target (@servers) {
            $self->debug("Submitting inventory from $remoteid to ".$target->getName());
            my $sent = $proxyclient->send(
                url     => $target->getUrl(),
                message => $message
            );
            unless ($sent) {
                $response = HTTP::Response->new(500, 'Inventory not sent to server');
                $self->error("Can't submit $remoteid inventory to ".$target->getName()." server");
                last;
            }
            $self->info("Inventory from $remoteid submitted to ".$target->getName());
        }
    }

    $client->send_response($response);

    return $response->code();
}

## no critic (ProhibitMultiplePackages)
package
    FusionInventory::Agent::HTTP::Server::Proxy::Message;

sub new {
    my ($class, %params) = @_;

    my $self = {
        content => $params{content},
    };
    bless $self, $class;
}

sub getContent {
    my ($self) = @_;

    return $self->{content};
}

1;
__END__

=head1 NAME

FusionInventory::Agent::HTTP::Server::Proxy - An embedded HTTP server plugin
providing a proxy for agents not able to contact the server

=head1 DESCRIPTION

This is a server plugin to transmit inventory toward a server.

It listens on port 62354 by default.

The following default requests are accepted:

=over

=item /proxy/fusioninventory

=item /proxy/apiversion

=back

=head1 CONFIGURATION

=over

=item disabled         C<yes> by default

=item url_path         C</proxy> by default

=item port             C<0> by default to use default one

=item prolog_freq      C<24> by default, this is the delay agents will finally
                       recontact the proxy

=item local_store      empty by default, this is the folder where to store inventories

=item only_local_store C<no> by default, set it to C<yes> to not submit inventories
                       to server.

=item maxrate          C<30> by default

=item maxrate_period   C<3600> (in seconds) by default.

=back

Defaults can be overrided in C<proxy-server-plugin.cfg> file or better in the
C<proxy-server-plugin.local> if included from C<proxy-server-plugin.cfg>.
