package Blog;

use strict;
use warnings;
use Punk;

# Compile time, so the `feed` keyword exists by the time the statements below
# are parsed. `plugin 'Feed'` runs at RUNTIME of this package body, long after
# `feed sub {...}` has been compiled - a keyword installed only there is one
# perl has already refused to parse.
use Punk::Plugin::Feed;

our $VERSION = '0.01';

# config/punk.yml declares `host`, which is where the feed gets the origin it
# builds absolute URLs on. Never the request's Host header: that would let
# `Host: evil.example` produce a feed naming that host for every item, and
# every reader that fetched it would keep it for as long as they stayed
# subscribed.
config 'config/punk.yml';

plugin 'Feed' => {
    title       => 'A Punk Blog',
    author      => 'The Management',
    description => 'Notes on shipping a feed',
    ttl         => 3600,      # the documents are rebuilt at most this often
    limit       => 20,
};

get '/'             => 'Web::Root#index', { name => 'home' };
get '/posts/:slug'  => 'Web::Root#show',  { name => 'post' };

# The default feed, served at /feed.xml and /feed.rss.
#
# A 'Controller#method' target, exactly like a route's - the section reads rows
# and shapes them, which is controller work. A bare string holding a '#' is a
# target for the default feed; a bare string without one would be a NAME whose
# body was left off.
#
# A section returns rows; loc, title and updated are required and anything
# missing one of them is dropped with a warning. Atom makes all three
# mandatory and a reader rejects a document that breaks that WHOLE, so one bad
# row must not be able to empty the feed.
feed 'Web::Feed#posts';

# A second feed, at /feed/releases.xml and /feed/releases.rss, with its own
# title and its own length. It may not restate `base`, `ttl` or `format` -
# those belong to the plugin, and a feed disagreeing about the origin would be
# a feed pointing somewhere else.
#
# A closure works here too - `entries => sub { ... }` - and is the right shape
# for something small enough not to earn a controller method.
feed releases => {
    title       => 'A Punk Blog: releases',
    description => 'Just the releases',
    limit       => 5,
    entries     => 'Web::Feed#releases',
};

1;

__END__

