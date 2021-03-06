#!/usr/bin/env perl -T

use strict;
use warnings;

use Test::More;

use File::Spec;
use Sentry::Raven;
use Devel::StackTrace;
use File::Slurp;

local $ENV{SENTRY_DSN} = 'http://key:secret@somewhere.com:9000/foo/123';
my $raven = Sentry::Raven->new();

my $trace;
sub a { $trace = Devel::StackTrace->new() }
a(1,"x");

subtest 'message' => sub {
    my $event = $raven->_construct_message_event('mymessage', level => 'info');

    is($event->{message}, 'mymessage');
    is($event->{level}, 'info');
};

subtest 'exception' => sub {
    my $event = $raven->_construct_exception_event('Operation completed successfully', type => 'OperationFailedException', level => 'info');

    is($event->{level}, 'info');
    is_deeply(
        $event->{'sentry.interfaces.Exception'},
        {
            type    => 'OperationFailedException',
            value   => 'Operation completed successfully',
        },
    );
};

subtest 'request' => sub {
    my $event = $raven->_construct_request_event(
        'http://google.com',
        method       => 'GET',
        data         => 'foo=bar',
        query_string => 'foo=bar',
        cookies      => 'foo=bar',
        headers      => { 'Content-Type' => 'text/html' },
        env          => { REMOTE_ADDR => '192.168.0.1' },
        level        => 'info',
    );

    is($event->{level}, 'info');
    is_deeply(
        $event->{'sentry.interfaces.Http'},
        {
            url          => 'http://google.com',
            method       => 'GET',
            data         => 'foo=bar',
            query_string => 'foo=bar',
            cookies      => 'foo=bar',
            headers      => { 'Content-Type' => 'text/html' },
            env          => { REMOTE_ADDR => '192.168.0.1' },
        },
    );
};

subtest 'stacktrace' => sub {
    my $frames = [
        {
            filename     => 'filename1',
            function     => 'function1',
            module       => 'module1',
            lineno       => 10,
            colno        => 20,
            abs_path     => '/tmp/filename1',
            context_line => 'my $foo = "bar";',
            pre_context  => [ 'sub function1 {' ],
            post_context => [ 'print $foo' ],
            in_app       => 1,
            vars         => { foo => 'bar' },
        },
        {
            filename => 'my/file2.pl',
        },
    ];

    my $event = $raven->_construct_stacktrace_event($frames, level => 'info');

    is($event->{level}, 'info');
    is_deeply(
        $event->{'sentry.interfaces.Stacktrace'},
        { frames => $frames },
    );

    my @file_lines = read_file(File::Spec->catfile('t', '12-specialized-event.t'));
    chomp(@file_lines);

    $frames = [
        {
            abs_path     => File::Spec->catfile('t', '12-specialized-event.t'),
            filename     => '12-specialized-event.t',
            function     => undef,
            lineno       => 18,
            module       => 'main',
            vars         => undef,
            context_line => $file_lines[ 17 ],
            pre_context  => [ @file_lines[ 12 .. 16 ] ],
            post_context => [ @file_lines [ 18 .. 22 ] ],
        },
        {
            abs_path => File::Spec->catfile('t', '12-specialized-event.t'),
            filename => '12-specialized-event.t',
            function => 'main::a',
            lineno   => 17,
            module   => 'main',
            vars     => {
                '@_' => ['1','"x"'],
            },
            context_line => $file_lines[ 16 ],
            pre_context  => [ @file_lines[ 11 .. 15 ] ],
            post_context => [ @file_lines [ 17 .. 21 ] ],
        },
    ];

    is_deeply(
        $raven->_construct_stacktrace_event($trace)->{'sentry.interfaces.Stacktrace'},
        { frames => $frames },
    );
};

subtest 'user' => sub {
    my $event = $raven->_construct_user_event(id => 'myid', username => 'myusername', email => 'my@email.com', ip_address => '192.168.0.1', level => 'info');

    is($event->{level}, 'info');
    is_deeply(
        $event->{'sentry.interfaces.User'},
        {
            id            => 'myid',
            username      => 'myusername',
            email         => 'my@email.com',
            ip_address    => '192.168.0.1',
        },
    );
};

subtest 'user_context arbitray data' => sub {
    my $event = {$raven->user_context(arbitrary_key => 'arbitrary value')};
    is($event->{'sentry.interfaces.User'}{arbitrary_key}, 'arbitrary value');
};

subtest 'query' => sub {
    my $event = $raven->_construct_query_event( 'select 1', engine => 'DBD::Pg', level => 'info');

    is($event->{level}, 'info');
    is_deeply(
        $event->{'sentry.interfaces.Query'},
        {
            query  => 'select 1',
            engine => 'DBD::Pg',
        },
    );
};

done_testing();
