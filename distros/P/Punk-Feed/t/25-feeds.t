#!perl
use 5.010;
use strict;
use warnings;
use Test::More;
use Punk ();
use Punk::Test;
use Punk::Plugin::Feed ();

# Several feeds from one application: each has its own entries, its own
# overrides, its own document and its own validators.

our @POSTS    = map +{ loc => "/p/$_", title => "Post $_", updated => 100 + $_ }, 1 .. 3;
our @RELEASES = map +{ loc => "/r/$_", title => "Rel $_",  updated => 200 + $_ }, 1 .. 2;

my $PKG = 'FeedMulti';
eval "package $PKG;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
   . "host 'https://example.com';\n"
   . "plugin 'Feed' => { title => 'Example', description => 'the site',\n"
   . "                   author => 'Site Author' };\n"
   . "feed sub { \@main::POSTS };\n"
   . "feed releases => { title => 'Releases', description => 'just releases',\n"
   . "                   author => 'Rel Author', limit => 1,\n"
   . "                   entries => sub { \@main::RELEASES } };\n"
   . "1" or die $@;

my $t   = Punk::Test->new($PKG);
my $app = $PKG->punk_app;

sub doc { Punk::Plugin::Feed::_doc($app, $_[0], $_[1] || 'atom') }

# ---- each feed carries its own entries ------------------------------------

{
    my $default = doc('');
    my $rel     = doc('releases');

    like($default, qr{<title>Post 3</title>}, 'the default feed has the posts');
    unlike($default, qr{Rel \d},             '  and none of the releases');

    like($rel, qr{<title>Rel 2</title>},     'the named feed has the releases');
    unlike($rel, qr{Post \d},                '  and none of the posts');
}

# ---- per-feed overrides ----------------------------------------------------

{
    my $rel = doc('releases');
    like($rel, qr{<title>Releases</title>},         'a per-feed title');
    like($rel, qr{<subtitle>just releases</subtitle>}, 'a per-feed description');
    like($rel, qr{<author><name>Rel Author</name></author>},
        'a per-feed author');

    my $default = doc('');
    like($default, qr{<title>Example</title>},      'the default keeps the '
      . 'plugin title');
    like($default, qr{<subtitle>the site</subtitle>}, '  and description');
    like($default, qr{<author><name>Site Author</name></author>},
        '  and author');
}

# limit is a per-feed option and has to actually truncate, not just validate.
{
    my $rel = doc('releases');
    my @items = $rel =~ m{<entry>}g;
    is(scalar(@items), 1, 'a per-feed limit of 1 keeps one entry');
    like($rel, qr{<title>Rel 2</title>}, '  the newest');
    unlike($rel, qr{<title>Rel 1</title>}, '  and drops the older');

    my @posts = doc('') =~ m{<entry>}g;
    is(scalar(@posts), 3,
        'and the default feed is unaffected by the other feed\'s limit');
}

# ---- separate documents, validators and timestamps ------------------------

{
    isnt(Punk::Plugin::Feed::_etag($app, '', 'atom'),
         Punk::Plugin::Feed::_etag($app, 'releases', 'atom'),
        'two feeds have different ETags');

    is(Punk::Plugin::Feed::_stamp($app, ''), 103,
        'the default feed is stamped with its own newest entry');
    is(Punk::Plugin::Feed::_stamp($app, 'releases'), 202,
        'and the named feed with its own');
}

{
    $t->get_ok('/feed.xml')->status_is(200);
    my $d_lm = $t->header('Last-Modified');
    $t->get_ok('/feed/releases.xml')->status_is(200);
    my $r_lm = $t->header('Last-Modified');
    isnt($d_lm, $r_lm,
        'each feed reports its own Last-Modified, not the application\'s');
}

# One feed's validator must not satisfy the other's request.
{
    $t->get_ok('/feed.xml');
    my $default_tag = $t->header('ETag');
    $t->get_ok('/feed/releases.xml',
               headers => { 'If-None-Match' => $default_tag })
      ->status_is(200);
    ok(length $t->body,
        "the default feed's ETag does not mark the named feed unchanged");
}

# ---- the self links point at the right URLs -------------------------------

{
    like(doc('', 'atom'), qr{href="https://example\.com/feed\.xml"},
        'the default Atom self link');
    like(doc('releases', 'atom'), qr{href="https://example\.com/feed/releases\.xml"},
        'the named Atom self link');
    like(doc('releases', 'rss'), qr{href="https://example\.com/feed/releases\.rss"},
        'the named RSS self link');
}

# ---- a section that returns nothing is a valid empty feed -----------------

{
    my $pkg = 'FeedMultiEmpty';
    eval "package $pkg;\nuse Punk;\nuse Punk::Plugin::Feed;\n"
       . "host 'https://example.com';\n"
       . "plugin 'Feed' => { title => 'Example' };\n"
       . "feed sub { () };\n"
       . "feed full => sub { \@main::POSTS };\n1" or die $@;
    my $tt = Punk::Test->new($pkg);
    $tt->get_ok('/feed.xml')->status_is(200);
    unlike($tt->body, qr{<entry>}, 'an empty feed serves 200 with no entries');
    $tt->get_ok('/feed/full.xml')->status_is(200);
    like($tt->body, qr{<entry>},
        'and the feed beside it is unaffected');
}

done_testing;
