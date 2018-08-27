use strict;
use warnings;

use Test::More;

use IO::String;
use SockJS::Connection;
use SockJS::Transport::JSONPSend;

subtest 'return error when not connected' => sub {
    my $transport = _build_transport();

    my $conn = _build_conn();

    my $res = $transport->dispatch( { REQUEST_METHOD => 'POST' }, $conn );

    is_deeply $res, [ 404, [], ['Not found'] ];
};

subtest 'return error when content length not equals actual read data' => sub {
    my $transport = _build_transport();

    my $conn = _build_conn();

    $conn->connected;

    my $input = 'foobar';
    my $fh    = IO::String->new($input);

    my $res = $transport->dispatch(
        {
            REQUEST_METHOD => 'POST',
            CONTENT_LENGTH => 100,
            'psgi.input'   => $fh
        },
        $conn
    );

    is_deeply $res,
      [
        500,
        [ 'Content-Type', 'text/plain; charset=UTF-8', 'Content-Length' => 12 ],
        ['System error']
      ];
};

subtest 'return error when no payload' => sub {
    my $transport = _build_transport();

    my $conn = _build_conn();

    $conn->connected;

    my $input = '';
    my $fh    = IO::String->new($input);

    my $res = $transport->dispatch(
        { REQUEST_METHOD => 'POST', CONTENT_LENGTH => 0, 'psgi.input' => $fh },
        $conn
    );

    is_deeply $res,
      [
        500,
        [ 'Content-Type', 'text/plain; charset=UTF-8', 'Content-Length' => 17 ],
        ['Payload expected.']
      ];
};

subtest 'return error when broken JSON' => sub {
    my $transport = _build_transport();

    my $conn = _build_conn();

    $conn->connected;

    my $input = '123';
    my $fh    = IO::String->new($input);

    my $res = $transport->dispatch(
        { REQUEST_METHOD => 'POST', CONTENT_LENGTH => 3, 'psgi.input' => $fh },
        $conn
    );

    is_deeply $res,
      [
        500,
        [ 'Content-Type', 'text/plain; charset=UTF-8', 'Content-Length' => 21 ],
        ['Broken JSON encoding.']
      ];
};

subtest 'call on data with simple POST' => sub {
    my $transport = _build_transport();

    my $conn = _build_conn();

    my @data;
    $conn->connected;
    $conn->on( data => sub { shift; @data = @_ } );

    my $input = '[{"foo":"bar"}]';
    my $fh    = IO::String->new($input);

    my $res = $transport->dispatch(
        {
            REQUEST_METHOD => 'POST',
            CONTENT_LENGTH => length($input),
            'psgi.input'   => $fh
        },
        $conn
    );

    is_deeply \@data, [ { foo => 'bar' } ];
};

subtest 'call on data with form POST' => sub {
    my $transport = _build_transport();

    my $conn = _build_conn();

    my @data;
    $conn->connected;
    $conn->on( data => sub { shift; @data = @_ } );

    my $input = 'd=[{"foo":"bar"}]';
    my $fh    = IO::String->new($input);

    my $res = $transport->dispatch(
        {
            REQUEST_METHOD => 'POST',
            CONTENT_LENGTH => length($input),
            CONTENT_TYPE   => 'application/x-www-form-urlencoded',
            'psgi.input'   => $fh
        },
        $conn
    );

    is_deeply \@data, [ { foo => 'bar' } ];
};

subtest 'return correct response' => sub {
    my $transport = _build_transport();

    my $conn = _build_conn();

    $conn->connected;

    my $input = '[{"foo":"bar"}]';
    my $fh    = IO::String->new($input);

    my $res = $transport->dispatch(
        {
            REQUEST_METHOD => 'POST',
            CONTENT_LENGTH => length($input),
            'psgi.input'   => $fh
        },
        $conn
    );

    is_deeply $res,
      [
        200,
        [
            'Content-Type'   => 'text/plain; charset=UTF-8',
            'Content-Length' => 2,
        ],
        ['ok']
      ];
};

done_testing;

sub _build_conn {
    SockJS::Connection->new(@_);
}

sub _build_transport {
    SockJS::Transport::JSONPSend->new(@_);
}
