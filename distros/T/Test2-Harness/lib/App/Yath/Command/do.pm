package App::Yath::Command::do;
use strict;
use warnings;

our $VERSION = '2.000005';

use parent 'App::Yath::Command::test';
use Test2::Harness::Util::HashBase;

sub group { ' main' }

sub summary { "Run tests using 'run' or 'test', same as the default command, but explicit." }
sub cli_args { "[run or test args]" }

sub description {
    return <<"    EOT";
This is the same as running yath without a command, except that it will not
fail on CLI parsing issues that often get mistaken for commands.

If there is a persistent runner then the 'run' command is used, otherwise the
'test' command is used.
    EOT
}

sub run {
    # This file is actually just a stub for the magic of 'do'. Code is not executed.
    die "This should not be reachable";
}


1;

__END__

=pod

=encoding UTF-8

=head1 NAME

App::Yath::Command::do - Run tests using 'run' or 'test', same as the default command, but explicit.

=head1 DESCRIPTION

This is the same as running yath without a command, except that it will not
fail on CLI parsing issues that often get mistaken for commands.

If there is a persistent runner then the 'run' command is used, otherwise the
'test' command is used.


=head1 USAGE

    $ yath [YATH OPTIONS] do [COMMAND OPTIONS] [COMMAND ARGUMENTS]

=head2 OPTIONS

=head3 Database Options

=over 4

=item --db-config ARG

=item --db-config=ARG

=item --no-db-config

Module that implements 'MODULE->yath_db_config(%params)' which should return a App::Yath::Schema::Config instance.

Can also be set with the following environment variables: C<YATH_DB_CONFIG>


=item --db-driver Pg

=item --db-driver MySQL

=item --db-driver SQLite

=item --db-driver MariaDB

=item --db-driver Percona

=item --db-driver PostgreSQL

=item --no-db-driver

DBI Driver to use

Can also be set with the following environment variables: C<YATH_DB_DRIVER>


=item --db-dsn ARG

=item --db-dsn=ARG

=item --no-db-dsn

DSN to use when connecting to the db

Can also be set with the following environment variables: C<YATH_DB_DSN>


=item --db-host ARG

=item --db-host=ARG

=item --no-db-host

hostname to use when connecting to the db

Can also be set with the following environment variables: C<YATH_DB_HOST>


=item --db-name ARG

=item --db-name=ARG

=item --no-db-name

Name of the database to use

Can also be set with the following environment variables: C<YATH_DB_NAME>


=item --db-pass ARG

=item --db-pass=ARG

=item --no-db-pass

Password to use when connecting to the db

Can also be set with the following environment variables: C<YATH_DB_PASS>


=item --db-port ARG

=item --db-port=ARG

=item --no-db-port

port to use when connecting to the db

Can also be set with the following environment variables: C<YATH_DB_PORT>


=item --db-socket ARG

=item --db-socket=ARG

=item --no-db-socket

socket to use when connecting to the db

Can also be set with the following environment variables: C<YATH_DB_SOCKET>


=item --db-user ARG

=item --db-user=ARG

=item --no-db-user

Username to use when connecting to the db

Can also be set with the following environment variables: C<YATH_DB_USER>, C<USER>


=back

=head3 Finder Options

=over 4

=item --changed path/to/file

=item --no-changed

Specify one or more files as having been changed.

Note: Can be specified multiple times


=item --changed-only

=item --no-changed-only

Only search for tests for changed files (Requires a coverage data source, also requires a list of changes either from the --changed option, or a plugin that implements changed_files() or changed_diff())


=item --changes-diff path/to/diff.diff

=item --no-changes-diff

Path to a diff file that should be used to find changed files for use with --changed-only. This must be in the same format as `git diff -W --minimal -U1000000`


=item --changes-exclude-file path/to/file

=item --changes-exclude-files path/to/file

=item --no-changes-exclude-files

Specify one or more files to ignore when looking at changes

Note: Can be specified multiple times


=item --changes-exclude-loads

=item --no-changes-exclude-loads

Exclude coverage tests which only load changed files, but never call code from them. (default: off)


=item --changes-exclude-nonsub

=item --no-changes-exclude-nonsub

Exclude changes outside of subroutines (perl files only) (default: off)


=item --changes-exclude-opens

=item --no-changes-exclude-opens

Exclude coverage tests which only open() changed files, but never call code from them. (default: off)


=item --changes-exclude-pattern '(apple|pear|orange)'

=item --changes-exclude-patterns '(apple|pear|orange)'

=item --no-changes-exclude-patterns

Ignore files matching this pattern when looking for changes. Your pattern will be inserted unmodified into a `$file =~ m/$pattern/` check.

Note: Can be specified multiple times


=item --changes-filter-file path/to/file

=item --changes-filter-files path/to/file

=item --no-changes-filter-files

Specify one or more files to check for changes. Changes to other files will be ignored

Note: Can be specified multiple times


=item --changes-filter-pattern '(apple|pear|orange)'

=item --changes-filter-patterns '(apple|pear|orange)'

=item --no-changes-filter-patterns

Specify a pattern for change checking. When only running tests for changed files this will limit which files are checked for changes. Only files that match this pattern will be checked. Your pattern will be inserted unmodified into a `$file =~ m/$pattern/` check.

Note: Can be specified multiple times


=item --changes-include-whitespace

=item --no-changes-include-whitespace

Include changed lines that are whitespace only (default: off)


=item --changes-plugin Git

=item --changes-plugin +App::Yath::Plugin::Git

=item --no-changes-plugin

What plugin should be used to detect changed files.


=item --default-at-search ARG

=item --default-at-search=ARG

=item --default-at-search '*.*'

=item --default-at-search='*.*'

=item --default-at-search '["json","list"]'

=item --default-at-search='["json","list"]'

=item --default-at-search :{ ARG1 ARG2 ... }:

=item --default-at-search=:{ ARG1 ARG2 ... }:

=item --no-default-at-search

Specify the default file/dir search when 'AUTHOR_TESTING' is set. Defaults to './xt'. The default AT search is only used if no files were specified at the command line

Note: Can be specified multiple times


=item --default-search ARG

=item --default-search=ARG

=item --default-search '*.*'

=item --default-search='*.*'

=item --default-search '["json","list"]'

=item --default-search='["json","list"]'

=item --default-search :{ ARG1 ARG2 ... }:

=item --default-search=:{ ARG1 ARG2 ... }:

=item --no-default-search

Specify the default file/dir search. defaults to './t', './t2', and 'test.pl'. The default search is only used if no files were specified at the command line

Note: Can be specified multiple times


=item --durations file.json

=item --durations http://example.com/durations.json

=item --no-durations

Point at a json file or url which has a hash of relative test filenames as keys, and 'SHORT', 'MEDIUM', or 'LONG' as values. This will override durations listed in the file headers. An exception will be thrown if the durations file or url does not work.


=item --Dt ARG

=item --Dt=ARG

=item --durations-threshold ARG

=item --durations-threshold=ARG

=item --no-durations-threshold

Only fetch duration data if running at least this number of tests. Default: 0


=item --exclude-file t/nope.t

=item --exclude-files t/nope.t

=item --no-exclude-files

Exclude a file from testing

Note: Can be specified multiple times


=item --exclude-list file.txt

=item --exclude-lists file.txt

=item --exclude-list http://example.com/exclusions.txt

=item --exclude-lists http://example.com/exclusions.txt

=item --no-exclude-lists

Point at a file or url which has a new line separated list of test file names to exclude from testing. Starting a line with a '#' will comment it out (for compatibility with Test2::Aggregate list files).

Note: Can be specified multiple times


=item --exclude-pattern nope

=item --exclude-patterns nope

=item --no-exclude-patterns

Exclude a pattern from testing, matched using m/$PATTERN/

Note: Can be specified multiple times


=item --ext ARG

=item --ext=ARG

=item --extension ARG

=item --extension=ARG

=item --extensions ARG

=item --extensions=ARG

=item --ext '["json","list"]'

=item --ext='["json","list"]'

=item --ext :{ ARG1 ARG2 ... }:

=item --ext=:{ ARG1 ARG2 ... }:

=item --extension '["json","list"]'

=item --extension='["json","list"]'

=item --extensions '["json","list"]'

=item --extensions='["json","list"]'

=item --extension :{ ARG1 ARG2 ... }:

=item --extension=:{ ARG1 ARG2 ... }:

=item --extensions :{ ARG1 ARG2 ... }:

=item --extensions=:{ ARG1 ARG2 ... }:

=item --no-extensions

Specify valid test filename extensions, default: t and t2

Note: Can be specified multiple times


=item --finder MyFinder

=item --finder +App::Yath::Finder::MyFinder

=item --no-finder

Specify what Finder subclass to use when searching for files/processing the file list. Use the "+" prefix to specify a fully qualified namespace, otherwise App::Yath::Finder::XXX namespace is assumed.


=item --maybe-durations file.json

=item --maybe-durations http://example.com/durations.json

=item --no-maybe-durations

Point at a json file or url which has a hash of relative test filenames as keys, and 'SHORT', 'MEDIUM', or 'LONG' as values. This will override durations listed in the file headers. An exception will be thrown if the durations file or url does not work.


=item --no-long

=item --no-no-long

Do not run tests that have their duration flag set to 'LONG'


=item --only-long

=item --no-only-long

Only run tests that have their duration flag set to 'LONG'


=item --rerun

=item --rerun=path/to/log.jsonl

=item --rerun=plugin_specific_string

=item --no-rerun

Re-Run tests from a previous run from a log file (or last log file). Plugins can intercept this, such as the database plugin which will grab a run UUID and derive tests to re-run from that.


=item --rerun-modes all,failed,missed,passed,retried

=item --no-rerun-modes

=item /^--(no-)?rerun-(all|failed|missed|passed|retried)(=.+)?$/

Pick which test categories to run. all:     Re-Run all tests from a previous run from a log file (or last log file). Plugins can intercept this, such as the database plugin which will grab a run UUID and derive tests to re-run from that. failed:  Re-Run failed tests from a previous run from a log file (or last log file). Plugins can intercept this, such as the database plugin which will grab a run UUID and derive tests to re-run from that. missed:  Run missed tests from a previously aborted/stopped run from a log file (or last log file). Plugins can intercept this, such as the database plugin which will grab a run UUID and derive tests to re-run from that. passed:  Re-Run passed tests from a previous run from a log file (or last log file). Plugins can intercept this, such as the database plugin which will grab a run UUID and derive tests to re-run from that. retried: Re-Run retried tests from a previous run from a log file (or last log file). Plugins can intercept this, such as the database plugin which will grab a run UUID and derive tests to re-run from that.

Note: This will turn on the 'rerun' option. If the --rerun-MODE form is used, you can specify the log file with --rerun-MODE=logfile.

Note: Can be specified multiple times


=item --rerun-plugin Foo

=item --rerun-plugins Foo

=item --rerun-plugin +App::Yath::Plugin::Foo

=item --rerun-plugins +App::Yath::Plugin::Foo

=item --no-rerun-plugins

What plugin(s) should be used for rerun (will fallback to other plugins if the listed ones decline the value, this is just used to set an order of priority)

Note: Can be specified multiple times


=item --show-changed-files

=item --no-show-changed-files

Print a list of changed files if any are found


=back

=head3 Harness Options

=over 4

=item -d

=item --dummy

=item --no-dummy

Dummy run, do not actually execute anything

Can also be set with the following environment variables: C<T2_HARNESS_DUMMY>

The following environment variables will be cleared after arguments are processed: C<T2_HARNESS_DUMMY>


=item --procname-prefix ARG

=item --procname-prefix=ARG

=item --no-procname-prefix

Add a prefix to all proc names (as seen by ps).

The following environment variables will be set after arguments are processed: C<T2_HARNESS_PROC_PREFIX>


=back

=head3 IPC Options

=over 4

=item --ipc-address ARG

=item --ipc-address=ARG

=item --no-ipc-address

IPC address to use (usually auto-generated or discovered)


=item --ipc-allow-multiple

=item --no-ipc-allow-multiple

Normally yath will prevent you from starting multiple persistent runners in the same project, this option will allow you to start more than one.


=item --ipc-dir ARG

=item --ipc-dir=ARG

=item --no-ipc-dir

Directory for ipc files

Can also be set with the following environment variables: C<T2_HARNESS_IPC_DIR>, C<YATH_IPC_DIR>


=item --ipc-dir-order ARG

=item --ipc-dir-order=ARG

=item --ipc-dir-order '["json","list"]'

=item --ipc-dir-order='["json","list"]'

=item --ipc-dir-order :{ ARG1 ARG2 ... }:

=item --ipc-dir-order=:{ ARG1 ARG2 ... }:

=item --no-ipc-dir-order

When finding ipc-dir automatically, search in this order, default: ['base', 'temp']

Note: Can be specified multiple times


=item --ipc-file ARG

=item --ipc-file=ARG

=item --no-ipc-file

IPC file used to locate instances (usually auto-generated or discovered)


=item --ipc-peer-pid ARG

=item --ipc-peer-pid=ARG

=item --no-ipc-peer-pid

Optionally a peer PID may be provided


=item --ipc-port ARG

=item --ipc-port=ARG

=item --no-ipc-port

Some IPC protocols require a port, otherwise this should be left empty


=item --ipc-prefix ARG

=item --ipc-prefix=ARG

=item --no-ipc-prefix

Prefix for ipc files


=item --ipc-protocol IPSocket

=item --ipc-protocol AtomicPipe

=item --ipc-protocol UnixSocket

=item --ipc-protocol +Test2::Harness::IPC::Protocol::AtomicPipe

=item --no-ipc-protocol

Specify what IPC Protocol to use. Use the "+" prefix to specify a fully qualified namespace, otherwise Test2::Harness::IPC::Protocol::XXX namespace is assumed.


=back

=head3 Renderer Options

=over 4

=item --hide-runner-output

=item --no-hide-runner-output

Hide output from the runner, showing only test output. (See Also truncate_runner_output)


=item -q

=item --quiet

=item --no-quiet

Be very quiet.


=item --qvf

=item --no-qvf

Replaces App::Yath::Theme::Default with App::Yath::Theme::QVF which is quiet for passing tests and verbose for failing ones.


=item --renderer +My::Renderer

=item --renderers +My::Renderer

=item --renderer MyRenderer=opt1,opt2

=item --renderers MyRenderer=opt1,opt2

=item --renderer MyRenderer,MyOtherRenderer

=item --renderers MyRenderer,MyOtherRenderer

=item --renderer=:{ MyRenderer opt1,opt2,... }:

=item --renderers=:{ MyRenderer opt1,opt2,... }:

=item --renderer :{ MyRenderer :{ opt1 opt2 }: }:

=item --renderers :{ MyRenderer :{ opt1 opt2 }: }:

=item --no-renderers

Specify renderers. Use "+" to give a fully qualified module name. Without "+" "App::Yath::Renderer::" will be prepended to your argument.

Note: Can be specified multiple times


=item --server

=item --server=ARG

=item --no-server

Start an ephemeral yath database and web server to view results


=item --show-job-end

=item --no-show-job-end

Show output when a job ends. (Default: on)


=item --show-job-info

=item --no-show-job-info

Show the job configuration when a job starts. (Default: off, unless -vv)


=item --show-job-launch

=item --no-show-job-launch

Show output for the start of a job. (Default: off unless -v)


=item --show-run-fields

=item --no-show-run-fields

Show run fields. (Default: off, unless -vv)


=item --show-run-info

=item --no-show-run-info

Show the run configuration when a run starts. (Default: off, unless -vv)


=item -T

=item --show-times

=item --no-show-times

Show the timing data for each job.


=item -tARG

=item -t ARG

=item -t=ARG

=item --theme ARG

=item --theme=ARG

=item --no-theme

Select a theme for the renderer (not all renderers use this)


=item --truncate-runner-output

=item --no-truncate-runner-output

Only show runner output that was generated after the current command. This is only useful with a persistent runner.


=item -v

=item -vv

=item -vvv..

=item -v=COUNT

=item --verbose

=item --verbose=COUNT

=item --no-verbose

Be more verbose

The following environment variables will be set after arguments are processed: C<T2_HARNESS_IS_VERBOSE>, C<HARNESS_IS_VERBOSE>

Note: Can be specified multiple times, counter bumps each time it is used.


=item --wrap

=item --no-wrap

When active (default) renderers should try to wrap text in a human-friendly way. When this is turned off they should just throw text at the terminal.


=back

=head3 Resource Options

=over 4

=item -x2

=item --job-slots 2

=item --slots-per-job 2

=item --no-job-slots

This sets the number of slots each job will use (default 1). This is normally set by the ':#' in '-j#:#'.

Can also be set with the following environment variables: C<T2_HARNESS_JOB_CONCURRENCY>

The following environment variables will be cleared after arguments are processed: C<T2_HARNESS_JOB_CONCURRENCY>


=item -RMyResource

=item -R +My::Resource

=item -R MyResource=opt1,opt2

=item -R MyResource,MyOtherResource

=item -R=:{ MyResource opt1,opt2,... }:

=item -R :{ MyResource :{ opt1 opt2 }: }:

=item --resource +My::Resource

=item --resources +My::Resource

=item --resource MyResource=opt1,opt2

=item --resources MyResource=opt1,opt2

=item --resource MyResource,MyOtherResource

=item --resources MyResource,MyOtherResource

=item --resource=:{ MyResource opt1,opt2,... }:

=item --resources=:{ MyResource opt1,opt2,... }:

=item --resource :{ MyResource :{ opt1 opt2 }: }:

=item --resources :{ MyResource :{ opt1 opt2 }: }:

=item --no-resources

Specify resources. Use "+" to give a fully qualified module name. Without "+" "App::Yath::Resource::" and "Test2::Harness::Resource::" will be searched for a matching resource module.

Note: Can be specified multiple times


=item -j4

=item -j8:2

=item --jobs 4

=item --slots 4

=item --jobs 8:2

=item --slots 8:2

=item --job-count 4

=item --job-count 8:2

=item --no-slots

Set the number of concurrent jobs to run. Add a :# if you also wish to designate multiple slots per test. 8:2 means 8 slots, but each test gets 2 slots, so 4 tests run concurrently. Tests can find their concurrency assignemnt in the "T2_HARNESS_MY_JOB_CONCURRENCY" environment variable.

Can also be set with the following environment variables: C<YATH_JOB_COUNT>, C<T2_HARNESS_JOB_COUNT>, C<HARNESS_JOB_COUNT>

The following environment variables will be cleared after arguments are processed: C<YATH_JOB_COUNT>, C<T2_HARNESS_JOB_COUNT>, C<HARNESS_JOB_COUNT>

Note: If System::Info is installed, this will default to half the cpu core count, otherwise the default is 2.


=back

=head3 Run Options

=over 4

=item --abort-on-bail

=item --no-abort-on-bail

Abort all testing if a bail-out is encountered (default: on)


=item -A

=item --author-testing

=item --no-author-testing

This will set the AUTHOR_TESTING environment to true

Can also be set with the following environment variables: C<AUTHOR_TESTING>

The following environment variables will be set after arguments are processed: C<AUTHOR_TESTING>


=item --dbi-profiling

=item --no-dbi-profiling

Use Test2::Plugin::DBIProfile to collect database profiling data


=item -f name=details

=item -f '{"name":"NAME","details":"DETAILS"}'

=item --field name=details

=item --fields name=details

=item --field '{"name":"NAME","details":"DETAILS"}'

=item --fields '{"name":"NAME","details":"DETAILS"}'

=item --no-fields

Add custom data to the harness run

Note: Can be specified multiple times


=item -i

=item --interactive

=item --no-interactive

Use interactive mode, 1 test at a time, stdin forwarded to it

Can also be set with the following environment variables: C<YATH_INTERACTIVE>

The following environment variables will be set after arguments are processed: C<YATH_INTERACTIVE>


=item --link 'https://jenkins.work/job/42'

=item --links 'https://jenkins.work/job/42'

=item --link 'https://travis.work/builds/42'

=item --links 'https://travis.work/builds/42'

=item --link 'https://buildbot.work/builders/foo/builds/42'

=item --links 'https://buildbot.work/builders/foo/builds/42'

=item --no-links

Provide one or more links people can follow to see more about this run.

Note: Can be specified multiple times


=item --nytprof

=item --no-nytprof

Use Devel::NYTProf on tests. This will set addpid=1 for you. This works with or without fork.


=item --run-auditor ARG

=item --run-auditor=ARG

=item --no-run-auditor

Auditor class to use when auditing the overall test run


=item --id ARG

=item --id=ARG

=item --run-id ARG

=item --run-id=ARG

=item --no-run-id

Set a specific run-id. (Default: a UUID)


=back

=head3 Runner Options

=over 4

=item --dump-depmap

=item --no-dump-depmap

When using staged preload, dump the depmap for each stage as json files


=item --preload-early key=val

=item --preload-early=key=val

=item --preload-early '{"json":"hash"}'

=item --preload-early='{"json":"hash"}'

=item --preload-early :{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item --preload-early=:{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item --no-preload-early

Preload a module when spawning perl to launch the preload stages, before any other preload.

Note: Can be specified multiple times


=item --preload-retry-delay ARG

=item --preload-retry-delay=ARG

=item --no-preload-retry-delay

Time in seconds to wait before trying to load a preload/stage after a failed attempt


=item -WARG

=item -W ARG

=item -W=ARG

=item --Pt ARG

=item --Pt=ARG

=item --preload-threshold ARG

=item --preload-threshold=ARG

=item --no-preload-threshold

Only do preload if at least N tests are going to be run. In some cases a full preload takes longer than simply running the tests, this lets you specify a minimum number of test jobs that will be run for preload to happen. The default is 0, and it means always preload.


=item -P ARG

=item -P=ARG

=item -P '["json","list"]'

=item -P='["json","list"]'

=item -P :{ ARG1 ARG2 ... }:

=item -P=:{ ARG1 ARG2 ... }:

=item --preload ARG

=item --preload=ARG

=item --preloads ARG

=item --preloads=ARG

=item --preload '["json","list"]'

=item --preload='["json","list"]'

=item --preloads '["json","list"]'

=item --preloads='["json","list"]'

=item --preload :{ ARG1 ARG2 ... }:

=item --preload=:{ ARG1 ARG2 ... }:

=item --preloads :{ ARG1 ARG2 ... }:

=item --preloads=:{ ARG1 ARG2 ... }:

=item --no-preloads

Preload a module before running tests

Note: Can be specified multiple times


=item --reload

=item --reload-in-place

=item --no-reload-in-place

Reload modules in-place when possible (Not recommended)


=item --reloader

=item --reloader=ARG

=item --no-reloader

Use a reloader (default Test2::Harness::Reloader) to detect module changes, and reload stages as necessary.


=item --restrict-reload

=item --restrict-reload=ARG

=item --restrict-reload='["json","list"]'

=item --restrict-reload=:{ ARG1 ARG2 ... }:

=item --no-restrict-reload

NO DESCRIPTION - FIX ME

Note: Can be specified multiple times


=item --runner MyRunner

=item --runner +Test2::Harness::Runner::MyRunner

=item --no-runner

Specify what Runner subclass to use. Use the "+" prefix to specify a fully qualified namespace, otherwise Test2::Harness::Runner::XXX namespace is assumed.


=back

=head3 Scheduler Options

=over 4

=item --scheduler MyScheduler

=item --scheduler +Test2::Harness::MyScheduler

=item --no-scheduler

Specify what Scheduler subclass to use. Use the "+" prefix to specify a fully qualified namespace, otherwise Test2::Harness::Scheduler::XXX namespace is assumed.


=back

=head3 Terminal Options

=over 4

=item -c

=item --color

=item --no-color

Turn color on, default is true if STDOUT is a TTY.

Can also be set with the following environment variables: C<YATH_COLOR>, C<CLICOLOR_FORCE>

The following environment variables will be set after arguments are processed: C<YATH_COLOR>


=item --progress

=item --no-progress

Toggle progress indicators. On by default if STDOUT is a TTY. You can use --no-progress to disable the 'events seen' counter and buffered event pre-display


=item --term-size 80

=item --term-width 80

=item --term-size 200

=item --term-width 200

=item --no-term-width

Alternative to setting $TABLE_TERM_SIZE. Setting this will override the terminal width detection to the number of characters specified.

Can also be set with the following environment variables: C<TABLE_TERM_SIZE>

The following environment variables will be set after arguments are processed: C<TABLE_TERM_SIZE>


=back

=head3 Test Options

=over 4

=item --allow-retry

=item --no-allow-retry

Toggle retry capabilities on and off (default: on)


=item -b

=item --blib

=item --no-blib

(Default: include if it exists) Include 'blib/lib' and 'blib/arch' in your module path (These will come after paths you specify with -D or -I)


=item --cover

=item --cover=-silent,1,+ignore,^t/,+ignore,^t2/,+ignore,^xt,+ignore,^test.pl

=item --no-cover

Use Devel::Cover to calculate test coverage. This disables forking. If no args are specified the following are used: -silent,1,+ignore,^t/,+ignore,^t2/,+ignore,^xt,+ignore,^test.pl

Can also be set with the following environment variables: C<T2_DEVEL_COVER>

The following environment variables will be set after arguments are processed: C<T2_DEVEL_COVER>


=item -E key=val

=item -E=key=val

=item -Ekey=value

=item -E '{"json":"hash"}'

=item -E='{"json":"hash"}'

=item -E:{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item -E :{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item -E=:{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item --env-var key=val

=item --env-var=key=val

=item --env-vars key=val

=item --env-vars=key=val

=item --env-var '{"json":"hash"}'

=item --env-var='{"json":"hash"}'

=item --env-vars '{"json":"hash"}'

=item --env-vars='{"json":"hash"}'

=item --env-var :{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item --env-var=:{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item --env-vars :{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item --env-vars=:{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item --no-env-vars

Set environment variables

Note: Can be specified multiple times


=item --et SECONDS

=item --event-timeout SECONDS

=item --no-event-timeout

Kill test if no output is received within timeout period. (Default: 60 seconds). Add the "# HARNESS-NO-TIMEOUT" comment to the top of a test file to disable timeouts on a per-test basis. This prevents a hung test from running forever.


=item --event-uuids

=item --no-event-uuids

Use Test2::Plugin::UUID inside tests (default: on)


=item -I ARG

=item -I=ARG

=item -I '*.*'

=item -I='*.*'

=item -I '["json","list"]'

=item -I='["json","list"]'

=item -I :{ ARG1 ARG2 ... }:

=item -I=:{ ARG1 ARG2 ... }:

=item --include ARG

=item --include=ARG

=item --include '*.*'

=item --include='*.*'

=item --include '["json","list"]'

=item --include='["json","list"]'

=item --include :{ ARG1 ARG2 ... }:

=item --include=:{ ARG1 ARG2 ... }:

=item --no-include

Add a directory to your include paths

Note: Can be specified multiple times


=item --input ARG

=item --input=ARG

=item --no-input

Input string to be used as standard input for ALL tests. See also: --input-file


=item --input-file ARG

=item --input-file=ARG

=item --no-input-file

Use the specified file as standard input to ALL tests


=item -l

=item --lib

=item --no-lib

(Default: include if it exists) Include 'lib' in your module path (These will come after paths you specify with -D or -I)


=item -m ARG

=item -m=ARG

=item -m '["json","list"]'

=item -m='["json","list"]'

=item -m :{ ARG1 ARG2 ... }:

=item -m=:{ ARG1 ARG2 ... }:

=item --load ARG

=item --load=ARG

=item --load-module ARG

=item --load-module=ARG

=item --load '["json","list"]'

=item --load='["json","list"]'

=item --load :{ ARG1 ARG2 ... }:

=item --load=:{ ARG1 ARG2 ... }:

=item --load-module '["json","list"]'

=item --load-module='["json","list"]'

=item --load-module :{ ARG1 ARG2 ... }:

=item --load-module=:{ ARG1 ARG2 ... }:

=item --no-load

Load a module in each test (after fork). The "import" method is not called.

Note: Can be specified multiple times


=item -M Module

=item -M Module=import_arg1,arg2,...

=item -M '{"Data::Dumper":["Dumper"]}'

=item --loadim Module

=item --load-import Module

=item --loadim Module=import_arg1,arg2,...

=item --loadim '{"Data::Dumper":["Dumper"]}'

=item --load-import Module=import_arg1,arg2,...

=item --load-import '{"Data::Dumper":["Dumper"]}'

=item --no-load-import

Load a module in each test (after fork). Import is called.

Note: Can be specified multiple times


=item --mem-usage

=item --no-mem-usage

Use Test2::Plugin::MemUsage inside tests (default: on)


=item --pet SECONDS

=item --post-exit-timeout SECONDS

=item --no-post-exit-timeout

Stop waiting post-exit after the timeout period. (Default: 15 seconds) Some tests fork and allow the parent to exit before writing all their output. If Test2::Harness detects an incomplete plan after the test exits it will monitor for more events until the timeout period. Add the "# HARNESS-NO-TIMEOUT" comment to the top of a test file to disable timeouts on a per-test basis.


=item -rARG

=item -r ARG

=item -r=ARG

=item --retry ARG

=item --retry=ARG

=item --no-retry

Run any jobs that failed a second time. NOTE: --retry=1 means failing tests will be attempted twice!


=item --retry-iso

=item --retry-isolated

=item --no-retry-isolated

If true then any job retries will be done in isolation (as though -j1 was set)


=item --stream

=item --use-stream

=item --no-stream

=item --TAP

The TAP format is lossy and clunky. Test2::Harness normally uses a newer streaming format to receive test results. There are old/legacy tests where this causes problems, in which case setting --TAP or --no-stream can help.


=item -S ARG

=item -S=ARG

=item -S '["json","list"]'

=item -S='["json","list"]'

=item -S :{ ARG1 ARG2 ... }:

=item -S=:{ ARG1 ARG2 ... }:

=item --switch ARG

=item --switch=ARG

=item --switches ARG

=item --switches=ARG

=item --switch '["json","list"]'

=item --switch='["json","list"]'

=item --switches '["json","list"]'

=item --switches='["json","list"]'

=item --switch :{ ARG1 ARG2 ... }:

=item --switch=:{ ARG1 ARG2 ... }:

=item --switches :{ ARG1 ARG2 ... }:

=item --switches=:{ ARG1 ARG2 ... }:

=item --no-switches

Pass the specified switch to perl for each test. This is not compatible with preload.

Note: Can be specified multiple times


=item --test-arg ARG

=item --test-arg=ARG

=item --test-args ARG

=item --test-args=ARG

=item --test-arg '["json","list"]'

=item --test-arg='["json","list"]'

=item --test-args '["json","list"]'

=item --test-args='["json","list"]'

=item --test-arg :{ ARG1 ARG2 ... }:

=item --test-arg=:{ ARG1 ARG2 ... }:

=item --test-args :{ ARG1 ARG2 ... }:

=item --test-args=:{ ARG1 ARG2 ... }:

=item --no-test-args

Arguments to pass in as @ARGV for all tests that are run. These can be provided easier using the '::' argument separator.

Note: Can be specified multiple times


=item --tlib

=item --no-tlib

(Default: off) Include 't/lib' in your module path (These will come after paths you specify with -D or -I)


=item --unsafe-inc

=item --no-unsafe-inc

perl is removing '.' from @INC as a security concern. This option keeps things from breaking for now.

Can also be set with the following environment variables: C<PERL_USE_UNSAFE_INC>

The following environment variables will be set after arguments are processed: C<PERL_USE_UNSAFE_INC>


=item --fork

=item --use-fork

=item --no-use-fork

(default: on, except on windows) Normally tests are run by forking, which allows for features like preloading. This will turn off the behavior globally (which is not compatible with preloading). This is slower, it is better to tag misbehaving tests with the '# HARNESS-NO-PRELOAD' comment in their header to disable forking only for those tests.

Can also be set with the following environment variables: C<!T2_NO_FORK>, C<T2_HARNESS_FORK>, C<!T2_HARNESS_NO_FORK>, C<YATH_FORK>, C<!YATH_NO_FORK>


=item --timeout

=item --use-timeout

=item --no-use-timeout

(default: on) Enable/disable timeouts


=back

=head3 Web Client Options

=over 4

=item --api-key ARG

=item --api-key=ARG

=item --no-api-key

Yath server API key. This is not necessary if your Yath server instance is set to single-user

Can also be set with the following environment variables: C<YATH_API_KEY>


=item --grace

=item --no-grace

If yath cannot connect to a server it normally throws an error, use this to make it fail gracefully. You get a warning, but things keep going.


=item --request-retry

=item --request-retry=COUNT

=item --no-request-retry

How many times to try an operation before giving up

Note: Can be specified multiple times, counter bumps each time it is used.


=item --url http://my-yath-server.com/...

=item --uri http://my-yath-server.com/...

=item --no-url

Yath server url

Can also be set with the following environment variables: C<YATH_URL>


=back

=head3 Workspace Options

=over 4

=item -C

=item --clear

=item --no-clear

Clear the work directory if it is not already empty


=item -k

=item --keep-dir

=item --keep-dirs

=item --no-keep-dirs

Do not delete directories when done. This is useful if you want to inspect the directories used for various commands.


=item --tmpdir ARG

=item --tmpdir=ARG

=item --tmp-dir ARG

=item --tmp-dir=ARG

=item --no-tmpdir

Use a specific temp directory (Default: create a temp dir under the system one)

Can also be set with the following environment variables: C<T2_HARNESS_TEMP_DIR>, C<YATH_TEMP_DIR>

The following environment variables will be cleared after arguments are processed: C<T2_HARNESS_TEMP_DIR>, C<YATH_TEMP_DIR>

The following environment variables will be set after arguments are processed: C<TMPDIR>, C<TEMPDIR>, C<TMP_DIR>, C<TEMP_DIR>


=item --workdir ARG

=item --workdir=ARG

=item --no-workdir

Set the work directory (Default: new temp directory)

Can also be set with the following environment variables: C<T2_WORKDIR>, C<YATH_WORKDIR>

The following environment variables will be cleared after arguments are processed: C<T2_WORKDIR>, C<YATH_WORKDIR>


=back

=head3 Yath Options

=over 4

=item --base-dir ARG

=item --base-dir=ARG

=item --no-base-dir

Root directory for the project being tested (usually where .yath.rc lives)


=item -D

=item -Dlib

=item -Dlib

=item -D=lib

=item -D"lib/*"

=item --dev-lib

=item --dev-lib=lib

=item --dev-lib="lib/*"

=item --no-dev-lib

This is what you use if you are developing yath or yath plugins to make sure the yath script finds the local code instead of the installed versions of the same code. You can provide an argument (-Dfoo) to provide a custom path, or you can just use -D without and arg to add lib, blib/lib and blib/arch.

Note: This option can cause yath to use exec() to reload itself with the correct libraries in place. Each occurence of this argument can cause an additional exec() call. Use --dev-libs-verbose BEFORE any -D calls to see the exec() calls.

Note: Can be specified multiple times


=item --dev-libs-verbose

=item --no-dev-libs-verbose

Be verbose and announce that yath will re-exec in order to have the correct includes (normally yath will just call exec() quietly)


=item -h

=item -h=Group

=item --help

=item --help=Group

=item --no-help

exit after showing help information


=item -p key=val

=item -p=key=val

=item -pkey=value

=item -p '{"json":"hash"}'

=item -p='{"json":"hash"}'

=item -p:{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item -p :{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item -p=:{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item --plugin key=val

=item --plugin=key=val

=item --plugins key=val

=item --plugins=key=val

=item --plugin '{"json":"hash"}'

=item --plugin='{"json":"hash"}'

=item --plugins '{"json":"hash"}'

=item --plugins='{"json":"hash"}'

=item --plugin :{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item --plugin=:{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item --plugins :{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item --plugins=:{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item --no-plugins

Load a yath plugin.

Note: Can be specified multiple times


=item --project ARG

=item --project=ARG

=item --project-name ARG

=item --project-name=ARG

=item --no-project

This lets you provide a label for your current project/codebase. This is best used in a .yath.rc file.


=item --scan-options key=val

=item --scan-options=key=val

=item --scan-options '{"json":"hash"}'

=item --scan-options='{"json":"hash"}'

=item --scan-options(?^:^--(no-)?(?^:scan-(.+))$)

=item --scan-options :{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item --scan-options=:{ KEY1 VAL KEY2 :{ VAL1 VAL2 ... }: ... }:

=item --no-scan-options

=item /^--(no-)?scan-(.+)$/

Yath will normally scan plugins for options. Some commands scan other libraries (finders, resources, renderers, etc) for options. You can use this to disable all scanning, or selectively disable/enable some scanning.

Note: This is parsed early in the argument processing sequence, before options that may be earlier in your argument list.

Note: Can be specified multiple times


=item --show-opts

=item --show-opts=group

=item --no-show-opts

Exit after showing what yath thinks your options mean


=item --user ARG

=item --user=ARG

=item --no-user

Username to associate with logs, database entries, and yath servers.

Can also be set with the following environment variables: C<YATH_USER>, C<USER>


=item -V

=item --version

=item --no-version

Exit after showing a helpful usage message


=back


=head1 SOURCE

The source code repository for Test2-Harness can be found at
L<http://github.com/Test-More/Test2-Harness/>.

=head1 MAINTAINERS

=over 4

=item Chad Granum E<lt>exodist@cpan.orgE<gt>

=back

=head1 AUTHORS

=over 4

=item Chad Granum E<lt>exodist@cpan.orgE<gt>

=back

=head1 COPYRIGHT

Copyright Chad Granum E<lt>exodist7@gmail.comE<gt>.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

See L<http://dev.perl.org/licenses/>

=cut


