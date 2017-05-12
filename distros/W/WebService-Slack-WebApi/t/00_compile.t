use strict;
use warnings;
use utf8;
use 5.10.0;

use Test::More;

use_ok $_ for qw/
    WebService::Slack::WebApi
    WebService::Slack::WebApi::Im
    WebService::Slack::WebApi::Rtm
    WebService::Slack::WebApi::Api
    WebService::Slack::WebApi::Auth
    WebService::Slack::WebApi::Chat
    WebService::Slack::WebApi::Users
    WebService::Slack::WebApi::Files
    WebService::Slack::WebApi::Emoji
    WebService::Slack::WebApi::Stars
    WebService::Slack::WebApi::Oauth
    WebService::Slack::WebApi::Client
    WebService::Slack::WebApi::Groups
    WebService::Slack::WebApi::Search
    WebService::Slack::WebApi::Channels
/;

done_testing;

