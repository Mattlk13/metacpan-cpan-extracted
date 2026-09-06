#!perl
use 5.010;
use strict;
use warnings;
use Test::More;
use Punk ();
use Punk::Plugin::Feed ();

my $N = 0;

# A whole Punk class from source, so the compile-time half of the keyword is
# exercised the way an application exercises it.
sub compile {
    my ($body) = @_;
    my $pkg = 'FeedKw' . ++$N;
    local $@;
    my $ok = eval "package $pkg;\nuse Punk;\n$body\n1";
    return $ok ? ($pkg->punk_app, undef) : (undef, $@);
}

my $PLUGIN = q{plugin 'Feed' => { title => 'x' };};

# ---- the bareword form needs the use --------------------------------------

{
    my ($app, $err) = compile(<<"PERL");
use Punk::Plugin::Feed;
$PLUGIN
feed news => sub { () };
PERL
    is($err, undef, 'with the use, the bareword form parses') or diag $err;
    is_deeply(Punk::Plugin::Feed::_feeds($app), ['news'], '  and records the feed');
}

{
    my ($app, $err) = compile(<<"PERL");
$PLUGIN
feed news => sub { () };
PERL
    like($err, qr/\bfeed\b/,
        'without the use, the bareword form is a compile error');
}

{
    my ($app, $err) = compile(<<"PERL");
$PLUGIN
feed('news' => sub { () });
PERL
    is($err, undef, 'the parenthesised form works without the use')
        or diag $err;
    is_deeply(Punk::Plugin::Feed::_feeds($app), ['news'],
        '  because perl resolves it at runtime, when register has installed it');
}

# ---- the default feed ------------------------------------------------------

{
    my ($app, $err) = compile(<<"PERL");
use Punk::Plugin::Feed;
$PLUGIN
feed sub { () };
PERL
    is($err, undef, 'a feed with no name is the default one') or diag $err;
    is_deeply(Punk::Plugin::Feed::_feeds($app), [''],
        '  and it is stored under the empty name');
}

# ---- replace by name, keeping position ------------------------------------

{
    my ($app, $err) = compile(<<"PERL");
use Punk::Plugin::Feed;
$PLUGIN
feed a => sub { 'first' };
feed b => sub { () };
feed c => sub { () };
feed a => sub { 'second' };
PERL
    is($err, undef, 'a name may be declared twice') or diag $err;
    is_deeply(Punk::Plugin::Feed::_feeds($app), [qw(a b c)],
        'the second declaration replaces rather than appends, keeping position');
}

# ---- the hashref form ------------------------------------------------------

{
    my ($app, $err) = compile(<<"PERL");
use Punk::Plugin::Feed;
$PLUGIN
feed news => { title => 'News', limit => 5, entries => sub { () } };
PERL
    is($err, undef, 'the hashref form is accepted') or diag $err;
    is_deeply(Punk::Plugin::Feed::_feeds($app), ['news'], '  and names the feed');
}

{
    my (undef, $err) = compile(<<"PERL");
use Punk::Plugin::Feed;
$PLUGIN
feed news => { title => 'News' };
PERL
    like($err, qr/needs a code reference or a 'Controller#method' target/,
        'a hashref with no entries croaks');
}

{
    my (undef, $err) = compile(<<"PERL");
use Punk::Plugin::Feed;
$PLUGIN
feed news => { titel => 'News', entries => sub { () } };
PERL
    like($err, qr/unknown feed option 'titel'/,
        'a misspelled per-feed option croaks like a plugin option');
}

{
    my (undef, $err) = compile(<<"PERL");
use Punk::Plugin::Feed;
$PLUGIN
feed news => { base => 'https://elsewhere.example', entries => sub { () } };
PERL
    like($err, qr/unknown feed option 'base'/,
        'a feed may not restate the origin - that belongs to the plugin');
}

# ---- what is not a feed ----------------------------------------------------

{
    my (undef, $err) = compile(<<"PERL");
use Punk::Plugin::Feed;
$PLUGIN
feed 'news';
PERL
    like($err, qr/feed 'news' needs a code reference/,
        'a name with no body croaks and names the feed');
}

{
    my (undef, $err) = compile(<<"PERL");
use Punk::Plugin::Feed;
$PLUGIN
feed news => [];
PERL
    like($err, qr/needs a code reference or a 'Controller#method' target/,
        'a body that is a reference but not code croaks at the feed line');
}

# ---- a controller target, like any route takes ----------------------------

{
    package KwCtl::Controller::Web::Root;
    sub posts { ({ loc => '/p/1', title => 'T', updated => 1 }) }
    sub named { ({ loc => '/n/1', title => 'N', updated => 1 }) }
}

sub built {
    my ($body) = @_;
    my $pkg = 'KwCtl';                 # the controller namespace declared above
    local $@;
    my $ok = eval "package $pkg;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
       . "host 'https://example.com';\n$PLUGIN\n$body\n1";
    return (undef, $@) unless $ok;
    $ok = eval { $pkg->to_app; 1 };
    return $ok ? ($pkg->punk_app, undef) : (undef, $@);
}

{
    my ($app, $err) = built("feed 'Web::Root#posts';");
    is($err, undef, "a bare target is the DEFAULT feed, not a name") or diag $err;
    like(Punk::Plugin::Feed::_doc($app, '', 'atom'), qr{<entry>},
        '  and the controller method supplied its entries');
}

# The ambiguity that rule resolves: a bare string with no '#' is still a name
# that forgot its body, which is much the more common mistake.
{
    my (undef, $err) = compile(<<"PERL");
use Punk::Plugin::Feed;
$PLUGIN
feed 'news';
PERL
    like($err, qr/feed 'news' needs a code reference/,
        'a bare string with no # is a name missing its body');
}

{
    package KwCtlB::Controller::Web::Root;
    sub named { ({ loc => '/n/1', title => 'N', updated => 1 }) }
}
{
    local $@;
    my $ok = eval "package KwCtlB;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
       . "host 'https://example.com';\n$PLUGIN\n"
       . "feed news => 'Web::Root#named';\n"
       . "feed extra => { title => 'E', entries => 'Web::Root#named' };\n1";
    my $err = $ok ? undef : $@;
    is($err, undef, 'a named feed takes a target too') or diag $err;
    KwCtlB->to_app;
    my $app = KwCtlB->punk_app;
    like(Punk::Plugin::Feed::_doc($app, 'news', 'atom'), qr{<entry>},
        '  and serves it');
    like(Punk::Plugin::Feed::_doc($app, 'extra', 'atom'), qr{<entry>},
        '  as does the hashref form via entries');
}

# A target that cannot be resolved is Punk's own diagnostic, naming the feed -
# resolution goes through $app->_resolve_target rather than a second set of
# rules kept in step by hand.
{
    local $@;
    eval "package KwCtlC;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
       . "host 'https://example.com';\n$PLUGIN\n"
       . "feed news => 'Web::Root#nosuch';\n1" or die $@;
    ok(!eval { KwCtlC->to_app; 1 }, 'an unresolvable target croaks at to_app');
    like($@, qr/feed 'news' names 'Web::Root#nosuch'/,
        '  naming the feed and the target');
}

done_testing;
