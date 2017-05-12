use Test::More;

BEGIN { use_ok( 'Zonemaster::Config' ) }
use Zonemaster::Util;

my $ref = Zonemaster::Config->get;

isa_ok( $ref, 'HASH' );
is( $ref->{resolver}{defaults}{retry},              2, 'retry exists and has expected value' );
is( Zonemaster->config->resolver_defaults->{retry}, 2, 'access other way works too' );

isa_ok( Zonemaster::Config->policy, 'HASH', 'policy got loaded and' );
is( Zonemaster::Config->policy->{'EXAMPLE'}{'EXAMPLE_TAG'}, 'DEBUG', 'found policy for example tag' );
Zonemaster::Config->load_module_policy( "DNSSEC" );
is( Zonemaster::Config->policy->{DNSSEC}{ALGORITHM_OK}, 'INFO', 'Found policy loaded from module' );

Zonemaster::Config->load_config_file( 't/config.json' );
is( Zonemaster->config->resolver_defaults->{retry}, 4711, 'loading config works' );

Zonemaster::Config->load_policy_file( 't/policy.json' );
is( Zonemaster::Config->policy->{'EXAMPLE'}{'EXAMPLE_TAG'}, 'WARNING', 'loading policy works' );

my $conf = Zonemaster::Config->new;
isa_ok($conf, 'Zonemaster::Config');
isa_ok($conf->testcases, 'HASH');
ok($conf->testcases->{basic03}, 'Data for basic03 in place');
ok($conf->should_run(basic03), 'basic03 should run');

is($conf->testcases->{basic02}, undef, 'Data for basic02 does not exist');
ok($conf->should_run(basic02), 'basic02 should run');

ok(defined($conf->testcases->{placeholder}), 'Data for placeholder in place');
ok(!$conf->should_run('placeholder'), 'placeholder should not run');

ok(!defined(Zonemaster->config->resolver_source), 'No source set.');
Zonemaster->config->resolver_source('192.0.2.2');
is(Zonemaster->config->resolver_source, '192.0.2.2', 'Source correctly set.');

done_testing;
