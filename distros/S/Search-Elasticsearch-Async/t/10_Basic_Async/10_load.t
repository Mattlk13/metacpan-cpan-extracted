use Test::More;

BEGIN { use_ok('Search::Elasticsearch::Async') }

my ( $e, $p, $t );

ok $e = Search::Elasticsearch::Async->new(), "new client";
ok $e->does('Search::Elasticsearch::Role::Client::Direct'),
    "client does Search::Elasticsearch::Role::Client::Direct";

isa_ok $t = $e->transport, 'Search::Elasticsearch::Transport::Async',
    "transport";
isa_ok $p = $t->cxn_pool, 'Search::Elasticsearch::CxnPool::Async::Static',
    "cxn_pool";
isa_ok $p->cxn_factory, 'Search::Elasticsearch::Cxn::Factory', "cxn_factory";
isa_ok $e->logger, 'Search::Elasticsearch::Logger::LogAny', "logger";

done_testing;

