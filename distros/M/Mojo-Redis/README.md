# NAME

Mojo::Redis - Redis driver based on Mojo::IOLoop

# SYNOPSIS

## Blocking

    use Mojo::Redis;
    my $redis = Mojo::Redis->new;
    warn $redis->db->get("mykey");

## Promises

    $redis->db->get_p("mykey")->then(sub {
      print "mykey=$_[0]\n";
    })->catch(sub {
      warn "Could not fetch mykey: $_[0]";
    })->wait;

## Pipelining

Pipelining is built into the API by sending a lot of commands and then use
["all" in Mojo::Promise](https://metacpan.org/pod/Mojo::Promise#all) to wait for all the responses.

    Mojo::Promise->all(
      $db->set_p($key, 10),
      $db->incrby_p($key, 9),
      $db->incr_p($key),
      $db->get_p($key),
      $db->incr_p($key),
      $db->get_p($key),
    )->then(sub {
      @res = map {@$_} @_;
    })->wait;

# DESCRIPTION

[Mojo::Redis](https://metacpan.org/pod/Mojo::Redis) is a Redis driver that use the [Mojo::IOLoop](https://metacpan.org/pod/Mojo::IOLoop), which makes it
integrate easily with the [Mojolicious](https://metacpan.org/pod/Mojolicious) framework.

It tries to mimic the same interface as [Mojo::Pg](https://metacpan.org/pod/Mojo::Pg), [Mojo::mysql](https://metacpan.org/pod/Mojo::mysql) and
[Mojo::SQLite](https://metacpan.org/pod/Mojo::SQLite), but the methods for talking to the database vary.

This module is in no way compatible with the 1.xx version of [Mojo::Redis](https://metacpan.org/pod/Mojo::Redis)
and this version also tries to fix a lot of the confusing methods in
[Mojo::Redis2](https://metacpan.org/pod/Mojo::Redis2) related to pubsub.

This module is currently EXPERIMENTAL, and bad design decisions will be fixed
without warning. Please report at
[https://github.com/jhthorsen/mojo-redis/issues](https://github.com/jhthorsen/mojo-redis/issues) if you find this module
useful, annoying or if you simply find bugs. Feedback can also be sent to
`jhthorsen@cpan.org`.

# EVENTS

## connection

    $cb = $self->on(connection => sub { my ($self, $connection) = @_; });

Emitted when [Mojo::Redis::Connection](https://metacpan.org/pod/Mojo::Redis::Connection) connects to the Redis.

# ATTRIBUTES

## encoding

    $str  = $self->encoding;
    $self = $self->encoding("UTF-8");

The value of this attribute will be passed on to
["encoding" in Mojo::Redis::Connection](https://metacpan.org/pod/Mojo::Redis::Connection#encoding) when a new connection is created. This
means that updating this attribute will not change any connection that is
in use.

Default value is "UTF-8".

## max\_connections

    $int = $self->max_connections;
    $self = $self->max_connections(5);

Maximum number of idle database handles to cache for future use, defaults to
5\. (Default is subject to change)

## protocol\_class

    $str = $self->protocol_class;
    $self = $self->protocol_class("Protocol::Redis::XS");

Default to [Protocol::Redis::XS](https://metacpan.org/pod/Protocol::Redis::XS) if the optional module is available, or
falls back to [Protocol::Redis](https://metacpan.org/pod/Protocol::Redis).

## pubsub

    $pubsub = $self->pubsub;

Lazy builds an instance of [Mojo::Redis::PubSub](https://metacpan.org/pod/Mojo::Redis::PubSub) for this object, instead of
returning a new instance like ["db"](#db) does.

## url

    $url = $self->url;
    $self = $self->url(Mojo::URL->new("redis://localhost/3"));

Holds an instance of [Mojo::URL](https://metacpan.org/pod/Mojo::URL) that describes how to connect to the Redis server.

# METHODS

## db

    $db = $self->db;

Returns an instance of [Mojo::Redis::Database](https://metacpan.org/pod/Mojo::Redis::Database).

## cache

    $cache = $self->cache(%attrs);

Returns an instance of [Mojo::Redis::Cache](https://metacpan.org/pod/Mojo::Redis::Cache).

## cursor

    $cursor = $self->cursor(@command);

Returns an instance of [Mojo::Redis::Cursor](https://metacpan.org/pod/Mojo::Redis::Cursor) with
["command" in Mojo::Redis::Cursor](https://metacpan.org/pod/Mojo::Redis::Cursor#command) set to the arguments passed. See
["new" in Mojo::Redis::Cursor](https://metacpan.org/pod/Mojo::Redis::Cursor#new). for possible commands.

## new

    $self = Mojo::Redis->new("redis://localhost:6379/1");
    $self = Mojo::Redis->new(Mojo::URL->new->host("/tmp/redis.sock"));
    $self = Mojo::Redis->new(\%attrs);
    $self = Mojo::Redis->new(%attrs);

Object constructor. Can coerce a string into a [Mojo::URL](https://metacpan.org/pod/Mojo::URL) and set ["url"](#url)
if present.

# AUTHOR

Jan Henning Thorsen

# COPYRIGHT AND LICENSE

Copyright (C) 2018, Jan Henning Thorsen.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

# SEE ALSO

[Mojo::Redis2](https://metacpan.org/pod/Mojo::Redis2).
