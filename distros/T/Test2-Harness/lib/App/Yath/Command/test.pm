package App::Yath::Command::test;
use strict;
use warnings;

our $VERSION = '0.001019';

use Test2::Harness::Util::TestFile;
use Test2::Harness::Feeder::Run;
use Test2::Harness::Run::Runner;
use Test2::Harness::Run::Queue;
use Test2::Harness::Run;

use Test2::Harness::Util::Term qw/USE_ANSI_COLOR/;

use App::Yath::Util qw/is_generated_test_pl find_yath/;

use Time::HiRes qw/time/;

use parent 'App::Yath::Command';
use Test2::Harness::Util::HashBase;

sub group { ' test' }

sub has_jobs      { 1 }
sub has_runner    { 1 }
sub has_logger    { 1 }
sub has_display   { 1 }
sub manage_runner { 1 }

sub summary { "Run tests" }
sub cli_args { "[--] [test files/dirs] [::] [arguments to test scripts]" }

sub description {
    return <<"    EOT";
This yath command (which is also the default command) will run all the test
files for the current project. If no test files are specified this command will
look for the 't', and 't2' dirctories, as well as the 'test.pl' file.

This command is always recursive when given directories.

This command will add 'lib', 'blib/arch' and 'blib/lib' to the perl path for
you by default.

Any command line argument that is not an option will be treated as a test file
or directory of test files to be run.

If you wish to specify the ARGV for tests you may append them after '::'. This
is mainly useful for Test::Class::Moose and similar tools. EVERY test run will
get the same ARGV.
    EOT
}

sub handle_list_args {
    my $self = shift;
    my ($list) = @_;

    my $settings = $self->{+SETTINGS} ||= {};

    $settings->{search} = $list;

    my $has_search = $settings->{search} && @{$settings->{search}};

    unless ($has_search) {
        return if grep { $_->block_default_search($settings) } keys %{$settings->{plugins}};

        my @dirs = grep { -d $_ } './t', './t2';

        push @dirs => './xt'
            if -d './xt'
            && ($settings->{env_vars}->{AUTHOR_TESTING}
            || $ENV{AUTHOR_TESTING});

        my @files;
        push @files => 'test.pl' if -f 'test.pl' && !is_generated_test_pl('test.pl');

        $settings->{search} = [@dirs, @files];
    }
}


sub feeder {
    my $self = shift;

    my $settings = $self->{+SETTINGS};

    my $run = $self->make_run_from_settings(finite => 1);

    my $runner = Test2::Harness::Run::Runner->new(
        dir => $settings->{dir},
        run => $run,
        script => find_yath(),
    );

    my $queue = $runner->queue;
    $queue->start;

    my $job_id = 1;
    for my $tf ($run->find_files) {
        $queue->enqueue($tf->queue_item($job_id++));
    }

    my $pid = $runner->spawn(jobs_todo => $job_id - 1);

    $queue->end;

    my $feeder = Test2::Harness::Feeder::Run->new(
        run      => $run,
        runner   => $runner,
        dir      => $settings->{dir},
        keep_dir => $settings->{keep_dir},
    );

    return ($feeder, $runner, $pid, $job_id - 1);
}

sub run_command {
    my $self = shift;

    my $settings = $self->{+SETTINGS};

    my $renderers = $self->renderers;
    my $loggers   = $self->loggers;

    my ($feeder, $runner, $pid, $stat, $jobs_todo);
    my $ok = eval {
        ($feeder, $runner, $pid, $jobs_todo) = $self->feeder or die "No feeder!";

        my $harness = Test2::Harness->new(
            run_id            => $settings->{run_id},
            live              => $pid ? 1 : 0,
            feeder            => $feeder,
            loggers           => $loggers,
            renderers         => $renderers,
            event_timeout     => $settings->{event_timeout},
            post_exit_timeout => $settings->{post_exit_timeout},
            jobs              => $settings->{jobs},
            jobs_todo         => $jobs_todo,
        );

        $stat = $harness->run();

        1;
    };
    my $err = $@;
    warn $err unless $ok;

    my $exit = 0;

    if ($self->manage_runner) {
        unless ($ok) {
            if ($pid) {
                print STDERR "Killing runner\n";
                kill($self->{+SIGNAL} || 'TERM', $pid);
            }
        }

        if ($runner && $runner->pid) {
            $runner->wait;
            $exit = $runner->exit;
        }
    }

    if (-t STDOUT) {
        print STDOUT Term::ANSIColor::color('reset') if USE_ANSI_COLOR;
        print STDOUT "\r\e[K";
    }

    if (-t STDERR) {
        print STDERR Term::ANSIColor::color('reset') if USE_ANSI_COLOR;
        print STDERR "\r\e[K";
    }

    $self->paint("\n", '=' x 80, "\n");
    $self->paint("\nRun ID: $settings->{run_id}\n");

    my $bad = $stat ? $stat->{fail} : [];
    my $lost = $stat ? $stat->{lost} : 0;

    # Possible failure causes
    my $fail = $lost || $exit || !defined($exit) || !$ok || !$stat;

    if (@$bad) {
        $self->paint("\nThe following test jobs failed:\n");
        $self->paint("  [", $_->{job_id}, '] ', File::Spec->abs2rel($_->file), "\n") for sort {
            my $an = $a->{job_id};
            $an =~ s/\D+//g;
            my $bn = $b->{job_id};
            $bn =~ s/\D+//g;

            # Sort numeric if possible, otherwise string
            int($an) <=> int($bn) || $a->{job_id} cmp $b->{job_id}
        } @$bad;
        $self->paint("\n");
        $exit += @$bad;
    }

    if ($fail) {
        my $sig = $self->{+SIGNAL};

        $self->paint("\n");

        $self->paint("Test runner exited badly: $exit\n") if $exit;
        $self->paint("Test runner exited badly: ?\n") unless defined $exit;
        $self->paint("An exception was cought\n") if !$ok && !$sig;
        $self->paint("Received SIG$sig\n") if $sig;
        $self->paint("$lost test files were never run!\n") if $lost;

        $self->paint("\n");

        $exit ||= 255;
    }

    if (!@$bad && !$fail) {
        $self->paint("\nAll tests were successful!\n\n");

        if ($settings->{cover}) {
            require IPC::Cmd;
            if(my $cover = IPC::Cmd::can_run('cover')) {
                system($^X, (map { "-I$_" } @INC), $cover);
            }
            else {
                $self->paint("You will need to run the `cover` command manually to build the coverage report.\n\n");
            }
        }
    }

    print "Keeping work dir: $settings->{dir}\n" if $settings->{keep_dir} && $settings->{dir};

    print "Wrote " . ($ok ? '' : '(Potentially Corrupt) ') . "log file: $settings->{log_file}\n"
        if $settings->{log};

    $exit = 255 unless defined $exit;
    $exit = 255 if $exit > 255;

    return $exit;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

App::Yath::Command::test - Command to run tests

=head1 DESCRIPTION

=head1 SYNOPSIS

=head1 COMMAND LINE USAGE


    $ yath test [options] [--] [test files/dirs] [::] [arguments to test scripts]

=head2 Help

=over 4

=item --show-opts

Exit after showing what yath thinks your options mean

=item -h

=item --help

Exit after showing this help message

=back

=head2 Harness Options

=over 4

=item --id ID

=item --run_id ID

Set a specific run-id

(Default: current timestamp)

=item --no-long

Do not run tests with the HARNESS-CAT-LONG header

=item --shm

=item --no-shm

Use shm for tempdir if possible (Default: on)

Do not use shm.

=item -C

=item --clear

Clear the work directory if it is not already empty

=item -D

=item --dummy

Dummy run, do not actually execute tests

=item -d path

=item --dir path

=item --workdir path

Set the work directory

(Default: new temp directory)

=item -j #

=item --jobs #

=item --job-count #

Set the number of concurrent jobs to run

(Default: 1)

=item -m Module

=item --load Module

=item --load-module Mod

Load a module in each test (after fork)

this option may be given multiple times

=item -M Module

=item --loadim Module

=item --load-import Mod

Load and import module in each test (after fork)

this option may be given multiple times

=item -P Module

=item --preload Module

Preload a module before running tests

this option may be given multiple times

=item -t path/

=item --tmpdir path/

Use a specific temp directory

(Default: use system temp dir)

=item -X foo

=item --exclude-pattern bar

Exclude files that match

May be specified multiple times

matched using `m/$PATTERN/`

=item -x t/bad.t

=item --exclude-file t/bad.t

Exclude a file from testing

May be specified multiple times

=item --et SECONDS

=item --event_timeout #

Kill test if no events received in timeout period

(Default: 60 seconds)

This is used to prevent the harness for waiting forever for a hung test. Add the "# HARNESS-NO-TIMEOUT" comment to the top of a test file to disable timeouts on a per-test basis.

=item --no-preload

cancel any preloads listed until now

This can be used to negate preloads specified in .yath.rc or similar

=item --pet SECONDS

=item --post-exit-timeout #

Stop waiting post-exit after the timeout period

(Default: 15 seconds)

Some tests fork and allow the parent to exit before writing all their output. If Test2::Harness detects an incomplete plan after the test exists it will monitor for more events until the timeout period. Add the "# HARNESS-NO-TIMEOUT" comment to the top of a test file to disable timeouts on a per-test basis.

=back

=head2 Job Options

=over 4

=item --blib

=item --no-blib

(Default: on) Include 'blib/lib' and 'blib/arch'

Do not include 'blib/lib' and 'blib/arch'

=item --input-file file

Use the specified file as standard input to ALL tests

=item --lib

=item --no-lib

(Default: on) Include 'lib' in your module path

Do not include 'lib'

=item --tlib

(Default: off) Include 't/lib' in your module path

=item -E VAR=value

=item --env-var VAR=val

Set an environment variable for each test

(but not the harness)

=item -i "string"

This input string will be used as standard input for ALL tests

See also --input-file

=item -I path/lib

=item --include lib/

Add a directory to your include paths

This can be used multiple times

=item --cover

use Devel::Cover to calculate test coverage

This is essentially the same as combining: '--no-fork', and '-MDevel::Cover=-silent,1,+ignore,^t/,+ignore,^t2/,+ignore,^xt,+ignore,^test.pl' Devel::Cover and preload/fork do not work well together.

=item --fork

=item --no-fork

(Default: on) fork to start tests

Do not fork to start tests

Test2::Harness normally forks to start a test. Forking can break some select tests, this option will allow such tests to pass. This is not compatible with the "preload" option. This is also significantly slower. You can also add the "# HARNESS-NO-PRELOAD" comment to the top of the test file to enable this on a per-test basis.

=item --stream

=item --no-stream

=item --TAP

=item --tap

Use 'stream' instead of TAP (Default: use stream)

Do not use stream

Use TAP

The TAP format is lossy and clunky. Test2::Harness normally uses a newer streaming format to receive test results. There are old/legacy tests where this causes problems, in which case setting --TAP or --no-stream can help.

=item --unsafe-inc

=item --no-unsafe-inc

(Default: On) put '.' in @INC

Do not put '.' in @INC

perl is removing '.' from @INC as a security concern. This option keeps things from breaking for now.

=item -A

=item --author-testing

=item --no-author-testing

This will set the AUTHOR_TESTING environment to true

Many cpan modules have tests that are only run if the AUTHOR_TESTING environment variable is set. This will cause those tests to run.

=item -k

=item --keep-dir

Do not delete the work directory when done

This is useful if you want to inspect the work directory after the harness is done. The work directory path will be printed at the end.

=item -S SW

=item -S SW=val

=item --switch SW=val

Pass the specified switch to perl for each test

This is not compatible with preload.

=item -T

=item --times

Monitor timing data for each test file

This tells perl to load Test2::Plugin::Times before starting each test.

=back

=head2 Logging Options

=over 4

=item -B

=item --bz2

=item --bzip2-log

Use bzip2 compression when writing the log

This option implies -L

.bz2 prefix is added to log file name for you

=item -F file.jsonl

=item --log-file FILE

Specify the name of the log file

This option implies -L

(Default: event_log-RUN_ID.jsonl)

=item -G

=item --gz

=item --gzip-log

Use gzip compression when writing the log

This option implies -L

.gz prefix is added to log file name for you

=item -L

=item --log

Turn on logging

=back

=head2 Display Options

=over 4

=item --color

=item --no-color

Turn color on (Default: on)

Turn color off

=item --show-job-info

=item --no-show-job-info

Show the job configuration when a job starts

(Default: off, unless -vv)

=item --show-job-launch

=item --no-show-job-launch

Show output for the start of a job

(Default: off unless -v)

=item --show-run-info

=item --no-show-run-info

Show the run configuration when a run starts

(Default: off, unless -vv)

=item -q

=item --quiet

Be very quiet

=item -v

=item -vv

=item --verbose

Turn on verbose mode.

Specify multiple times to be more verbose.

=item --formatter Mod

=item --formatter +Mod

Specify the formatter to use

(Default: "Test2")

Only useful when the renderer is set to "Formatter". This specified the Test2::Formatter::XXX that will be used to render the test output.

=item --show-job-end

=item --no-show-job-end

Show output when a job ends

(Default: on)

This is only used when the renderer is set to "Formatter"

=item -r +Module

=item -r Postfix

=item --renderer ...

Specify an alternate renderer

(Default: "Formatter")

Use "+" to give a fully qualified module name. Without "+" "Test2::Harness::Renderer::" will be prepended to your argument.

=back

=head2 Plugins

=over 4

=item -pPlugin

=item -p+My::Plugin

=item --plugin Plugin

Load a plugin

can be specified multiple times

=item --no-plugins

cancel any plugins listed until now

This can be used to negate plugins specified in .yath.rc or similar

=back

=head1 SOURCE

The source code repository for Test2-Harness can be found at
F<http://github.com/Test-More/Test2-Harness/>.

=head1 MAINTAINERS

=over 4

=item Chad Granum E<lt>exodist@cpan.orgE<gt>

=back

=head1 AUTHORS

=over 4

=item Chad Granum E<lt>exodist@cpan.orgE<gt>

=back

=head1 COPYRIGHT

Copyright 2017 Chad Granum E<lt>exodist7@gmail.comE<gt>.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

See F<http://dev.perl.org/licenses/>

=cut
