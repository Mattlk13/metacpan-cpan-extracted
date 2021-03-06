use strict;
use warnings;

use Test::Routine::Util;
use Test::Most;
use lib qw< t/lib >;

run_tests(
    'create with no rules then add one before update',
    [
        'App::Rssfilter::Feed::Tester',
        'App::Rssfilter::Feed::Test::AddedRule',
        'App::Rssfilter::Feed::Test::AttemptsToFetchNewFeed',
        'App::Rssfilter::Feed::Test::ChecksOldFeed',
        'App::Rssfilter::Feed::Test::SavesNewFeed',
        'App::Rssfilter::Feed::Test::RulesRanOverNewFeed',
        'App::Rssfilter::Feed::Test::RulesRanOverOldFeed',
    ],
    {
        new_feed => <<'EOM',
<?xml version="1.0" encoding="UTF-8"?>
<rss><channel><item><description>hi</description></item></channel></rss>
EOM
        rules => [],
        old_feed => <<'EOM',
<?xml version="1.0" encoding="UTF-8"?>
<rss><channel><item><description>hello</description></item></channel></rss>
EOM
        last_modified => 'Thu, 01 Jan 1970 00:00:00 GMT',
    }
);

done_testing;
