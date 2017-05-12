
use Test::Lib;
use My::Test;
use Statocles::Site;
my $SHARE_DIR = path( __DIR__ )->parent->child( 'share' );

use Statocles::Page::Plain;
my $site = Statocles::Site->new( deploy => tempdir );

subtest 'constructor' => sub {
    test_constructor(
        'Statocles::Page::Plain',
        required => {
            path => '/index.html',
            content => 'some test content',
        },
        default => {
            search_change_frequency => 'weekly',
            search_priority => 0.5,
            author => Statocles::Person->new( name => '' ),
            date => sub {
                isa_ok $_, 'DateTime::Moonpig';
            },
        },
    );
};

subtest author => sub {

    subtest 'default to site author' => sub {
        my $site = Statocles::Site->new(
            author => {
                name => 'Doug Bell',
                email => 'doug@example.com',
            },
            deploy => tempdir,
        );
        my $page = Statocles::Page::Plain->new(
            path => '/',
            site => $site,
            content => 'Hello',
        );

        cmp_deeply $page->author, $site->author, 'page author default to site author';
    };

};

subtest 'render' => sub {
    $site->log->level( 'debug' );

    my $page = Statocles::Page::Plain->new(
        site => $site,
        path => '/path/to/page.html',
        content => 'some test content',
        layout => "LAYOUT\n<%= \$content %>",
        template => "TEMPLATE\n<%= \$content %>",
    );

    eq_or_diff $page->render, "LAYOUT\nTEMPLATE\nsome test content\n\n";
    cmp_deeply $site->log->history->[-1],
        [ ignore(), 'debug', 'Render page: /path/to/page.html' ],
        'debug log shows render page message';

    subtest 'cached page shows up in log' => sub {
        $page->render;
        cmp_deeply $site->log->history->[-1],
            [ ignore(), 'debug', 'Render page (cached): /path/to/page.html' ],
            'debug log shows cached render page message';
    };
};

done_testing;
