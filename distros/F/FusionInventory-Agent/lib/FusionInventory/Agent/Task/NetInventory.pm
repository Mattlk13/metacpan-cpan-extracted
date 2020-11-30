package FusionInventory::Agent::Task::NetInventory;

use strict;
use warnings;
use threads;
use parent 'FusionInventory::Agent::Task';

use Encode qw(encode);
use English qw(-no_match_vars);
use Time::HiRes qw(usleep);
use Thread::Queue v2.01;
use UNIVERSAL::require;

use FusionInventory::Agent::XML::Query;
use FusionInventory::Agent::Version;
use FusionInventory::Agent::Tools;
use FusionInventory::Agent::Tools::Hardware;
use FusionInventory::Agent::Tools::Network;
use FusionInventory::Agent::Tools::Expiration;

use FusionInventory::Agent::Task::NetInventory::Version;
use FusionInventory::Agent::Task::NetInventory::Job;

our $VERSION = FusionInventory::Agent::Task::NetInventory::Version::VERSION;

sub isEnabled {
    my ($self, $response) = @_;

    if (!$self->{target}->isType('server')) {
        $self->{logger}->debug("NetInventory task not compatible with local target");
        return;
    }

    my @options = $response->getOptionsInfoByName('SNMPQUERY');
    if (!@options) {
        $self->{logger}->debug("NetInventory task execution not requested");
        return;
    }

    my @jobs;
    foreach my $option (@options) {
        if (!$option->{DEVICE}) {
            $self->{logger}->error("invalid job: no device defined");
            next;
        }

        my @devices;
        foreach my $device (@{$option->{DEVICE}}) {
            if (!$device->{IP}) {
                $self->{logger}->error("invalid device: no address defined");
                next;
            }
            push @devices, $device;
        }

        if (!@devices) {
            $self->{logger}->error("invalid job: no valid device defined");
            next;
        }

        my $params = $option->{PARAM}->[0];

        push @jobs, FusionInventory::Agent::Task::NetInventory::Job->new(
            logger      => $self->{logger},
            params      => $params,
            credentials => $option->{AUTHENTICATION},
            devices     => \@devices
        );
    }

    if (!@jobs) {
        $self->{logger}->error("no valid job found, aborting");
        return;
    }

    $self->{jobs} = \@jobs;

    return 1;
}

sub _inventory_thread {
    my ($self, $jobs, $done) = @_;

    my $id = threads->tid();
    $self->{logger}->debug("[thread $id] creation");

    # run as long as they are a job to process
    while (my $job = $jobs->dequeue()) {

        last unless ref($job) eq 'HASH';
        last if $job->{leave};

        my $device = $job->{device};

        my $result;
        eval {
            $result = $self->_queryDevice($job);
        };
        if ($EVAL_ERROR) {
            chomp $EVAL_ERROR;
            $result = {
                ERROR => {
                    ID      => $device->{ID},
                    MESSAGE => $EVAL_ERROR
                }
            };

            $result->{ERROR}->{TYPE} = $device->{TYPE} if $device->{TYPE};

            # Inserted back device PID in result if set by server
            $result->{PID} = $device->{PID} if defined($device->{PID});

            $self->{logger}->error("[thread $id] $EVAL_ERROR");
        }

        # Get result PID from result
        my $pid = delete $result->{PID};

        # Directly send the result message from the thread, but use job pid if
        # it was not set in result
        $self->_sendResultMessage($result, $pid || $job->{pid});

        $done->enqueue($job);
    }

    delete $self->{logger}->{prefix};

    $self->{logger}->debug("[thread $id] termination");
}

sub run {
    my ($self, %params) = @_;

    # Prepare client configuration in needed to send message to server
    $self->{_client_params} = {
        logger       => $self->{logger},
        user         => $params{user},
        password     => $params{password},
        proxy        => $params{proxy},
        ca_cert_file => $params{ca_cert_file},
        ca_cert_dir  => $params{ca_cert_dir},
        no_ssl_check => $params{no_ssl_check},
        no_compress  => $params{no_compress},
    } if !$self->{client};

    # Extract greatest max_threads from jobs
    my ($max_threads) = sort { $b <=> $a } map { int($_->max_threads()) }
        @{$self->{jobs}};

    my %running_threads = ();

    # initialize FIFOs
    my $jobs = Thread::Queue->new();
    my $done = Thread::Queue->new();

    # count devices and check skip_start_stop
    my $devices_count   = 0;
    my $skip_start_stop = 0;
    foreach my $job (@{$self->{jobs}}) {
        $devices_count += $job->count();
        # newer server won't need START message if PID is provided on <DEVICE/>
        $skip_start_stop = any { defined($_->{PID}) } $job->devices()
            unless $skip_start_stop;
    }

    # Define a job expiration: 15 minutes by device to scan is large enough
    setExpirationTime( timeout => $devices_count * 900 );
    my $expiration = getExpirationTime();

    # no need more threads than devices to scan
    my $threads_count = $max_threads > $devices_count ? $devices_count : $max_threads;

    $self->{logger}->debug("creating $threads_count worker threads");
    for (my $i = 0; $i < $threads_count; $i++) {
        my $newthread = threads->create(sub { $self->_inventory_thread($jobs, $done); });
        # Keep known created threads in a hash
        $running_threads{$newthread->tid()} = $newthread ;
        usleep(50000) until ($newthread->is_running() || $newthread->is_joinable());
    }

    # Check really started threads number vs really running ones
    my @really_running  = map { $_->tid() } threads->list(threads::running);
    my @started_threads = keys(%running_threads);
    unless (@really_running == $threads_count && keys(%running_threads) == $threads_count) {
        $self->{logger}->debug(scalar(@really_running)." really running: [@really_running]");
        $self->{logger}->debug(scalar(@started_threads)." started: [@started_threads]");
    }

    my %queues = ();
    my $pid_index = 1;

    # Start jobs by preparing queues
    foreach my $job (@{$self->{jobs}}) {

        # SNMP credentials
        my $credentials = $job->credentials();

        # set pid
        my $pid = $job->pid() || $pid_index++;

        # send initial message to server unless it supports newer protocol
        $self->_sendStartMessage($pid) unless $skip_start_stop;

        # prepare queue
        my $queue = $queues{$pid} || {
            max_in_queue    => $job->max_threads(),
            in_queue        => 0,
            todo            => []
        };
        foreach my $device ($job->devices()) {
            push @{$queue->{todo}}, {
                pid         => $pid,
                device      => $device,
                timeout     => $job->timeout(),
                credentials => $credentials->{$device->{AUTHSNMP_ID}}
            };
        }

        # Only keep queue if we have a device to scan
        $queues{$pid} = $queue
            if @{$queue->{todo}};
    }

    my $queued_count = 0;
    my $job_count = 0;
    my $jid_len = length(sprintf("%i",$devices_count));
    my $jid_pattern = "#%0".$jid_len."i";

    # We need to guaranty we don't have more than max_in_queue device in shared
    # queue for each job
    while (my @pids = sort { $a <=> $b } keys(%queues)) {

        # Enqueue as device as possible
        foreach my $pid (@pids) {
            my $queue = $queues{$pid};
            next unless @{$queue->{todo}};
            next if $queue->{in_queue} >= $queue->{max_in_queue};
            my $device = shift @{$queue->{todo}};
            $queue->{in_queue} ++;
            $device->{jid} = sprintf($jid_pattern, ++$job_count);
            $jobs->enqueue($device);
            $queued_count++;
        }

        # as long as some of our threads are still running...
        if (keys(%running_threads)) {

            # send available results on the fly
            while (my $device = $done->dequeue_nb()) {
                my $pid = $device->{pid};
                my $queue = $queues{$pid};
                $queue->{in_queue} --;
                $queued_count--;
                unless ($queue->{in_queue} || @{$queue->{todo}}) {
                    # send final message to the server before cleaning threads unless it supports newer protocol
                    $self->_sendStopMessage($pid) unless $skip_start_stop;

                    delete $queues{$pid};

                    # send final message to the server unless it supports newer protocol
                    $self->_sendStopMessage($pid) unless $skip_start_stop;
                }
                # Check if it's time to abort a thread
                $devices_count--;
                if ($devices_count < $threads_count) {
                    $jobs->enqueue({ leave => 1 });
                    $threads_count--;
                }
            }

            # wait for a little
            usleep(50000);

            if ($expiration && time > $expiration) {
                $self->{logger}->warning("Aborting netinventory job as it reached expiration time");
                # detach all our running worker
                foreach my $tid (keys(%running_threads)) {
                    $running_threads{$tid}->detach()
                        if $running_threads{$tid}->is_running();
                    delete $running_threads{$tid};
                }
                last;
            }

            # List our created and possibly running threads in a list to check
            my %running_threads_checklist = map { $_ => 0 }
                keys(%running_threads);

            foreach my $running (threads->list(threads::running)) {
                my $tid = $running->tid();
                # Skip if this running thread tid is not is our started list
                next unless exists($running_threads{$tid});

                # Check a thread is still running
                $running_threads_checklist{$tid} = 1 ;
            }

            # Clean our started list from thread tid that don't run anymore
            foreach my $tid (keys(%running_threads_checklist)) {
                delete $running_threads{$tid}
                    unless $running_threads_checklist{$tid};
            }
            last unless keys(%running_threads);
        }
    }

    if ($queued_count) {
        $self->{logger}->error("$queued_count devices inventory are missing");
    }

    # Cleanup joinable threads
    $_->join() foreach threads->list(threads::joinable);
    $self->{logger}->debug("All netinventory threads terminated")
        unless threads->list(threads::running);

    # Reset expiration
    setExpirationTime();
}

sub _sendMessage {
    my ($self, $content) = @_;

    my $message = FusionInventory::Agent::XML::Query->new(
        deviceid => $self->{deviceid} || 'foo',
        query    => 'SNMPQUERY',
        content  => $content
    );

    # task-specific client, if needed
    $self->{client} = FusionInventory::Agent::HTTP::Client::OCS->new(%{$self->{_client_params}})
        if !$self->{client};

    $self->{client}->send(
        url     => $self->{target}->getUrl(),
        message => $message
    );
}

sub _sendStartMessage {
    my ($self, $pid) = @_;

    $self->_sendMessage({
        AGENT => {
            START        => 1,
            AGENTVERSION => $FusionInventory::Agent::Version::VERSION,
        },
        MODULEVERSION => $VERSION,
        PROCESSNUMBER => $pid
    });
}

sub _sendStopMessage {
    my ($self, $pid) = @_;

    $self->_sendMessage({
        AGENT => {
            END => 1,
        },
        MODULEVERSION => $VERSION,
        PROCESSNUMBER => $pid
    });
}

sub _sendResultMessage {
    my ($self, $result, $pid) = @_;

    $self->_sendMessage({
        DEVICE        => $result,
        MODULEVERSION => $VERSION,
        PROCESSNUMBER => $pid || 0
    });
}

sub _queryDevice {
    my ($self, $params) = @_;

    my $credentials = $params->{credentials};
    my $device      = $params->{device};
    my $logger      = $self->{logger};
    my $id          = threads->tid();
    $logger->{prefix} = "[thread $id] $params->{jid}, ";
    $logger->debug(
        "scanning $device->{ID}: $device->{IP}" .
        ( $device->{PORT} ? ' on port ' . $device->{PORT} : '' ) .
        ( $device->{PROTOCOL} ? ' via ' . $device->{PROTOCOL} : '' )
    );

    my $snmp;
    if ($device->{FILE}) {
        FusionInventory::Agent::SNMP::Mock->require();
        eval {
            $snmp = FusionInventory::Agent::SNMP::Mock->new(
                ip   => $device->{IP},
                file => $device->{FILE}
            );
        };
        die "SNMP emulation error: $EVAL_ERROR" if $EVAL_ERROR;
    } else {
        eval {
            FusionInventory::Agent::SNMP::Live->require();
            $snmp = FusionInventory::Agent::SNMP::Live->new(
                version      => $credentials->{VERSION},
                hostname     => $device->{IP},
                port         => $device->{PORT},
                domain       => $device->{PROTOCOL},
                timeout      => $params->{timeout} || 15,
                community    => $credentials->{COMMUNITY},
                username     => $credentials->{USERNAME},
                authpassword => $credentials->{AUTHPASSPHRASE},
                authprotocol => $credentials->{AUTHPROTOCOL},
                privpassword => $credentials->{PRIVPASSPHRASE},
                privprotocol => $credentials->{PRIVPROTOCOL},
            );
        };
        die "SNMP communication error: $EVAL_ERROR" if $EVAL_ERROR;
    }

    my $result = getDeviceFullInfo(
         id      => $device->{ID},
         type    => $device->{TYPE},
         snmp    => $snmp,
         model   => $params->{model},
         logger  => $self->{logger},
         datadir => $self->{datadir}
    );

    # Inserted back device PID in result if set by server
    $result->{PID} = $device->{PID} if defined($device->{PID});

    return $result;
}

1;

__END__

=head1 NAME

FusionInventory::Agent::Task::NetInventory - Remote inventory support for FusionInventory Agent

=head1 DESCRIPTION

This task extracts various information from remote hosts through SNMP
protocol:

=over

=item *

printer cartridges and counters status

=item *

router/switch ports status

=item *

relations between devices and router/switch ports

=back

This task requires a GLPI server with FusionInventory plugin.

=head1 AUTHORS

Copyright (C) 2009 David Durieux
Copyright (C) 2010-2012 FusionInventory Team
