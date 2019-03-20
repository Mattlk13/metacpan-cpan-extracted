use strict;
use warnings;
use lib 't/lib';
use Test::Most;
use DBIx::Class::Migration;
use File::Spec::Functions 'catfile';
use File::Path 'rmtree';
use File::Temp 'tempdir';

my $dir = tempdir(DIR => 't', CLEANUP => 1);

ok(
  my $migration = DBIx::Class::Migration->new(
    schema_class=>'Local::Schema',
    target_dir => $dir,
  ),
  'created migration with schema_class');

isa_ok(
  my $schema = $migration->schema, 'Local::Schema',
  'got a reasonable looking schema');

like(
  ($migration->_build_schema_args)->[0], qr/local-schema\.db$/,
  'generated schema_args seem ok');

is(
  DBIx::Class::Migration::_infer_database_from_schema($schema),
  'SQLite',
  'can correctly infer a database DBD');

$migration->prepare;

ok(
  (my $target_dir = $migration->target_dir),
  'got a good target directory');

ok -d catfile($target_dir, 'fixtures'), 'got fixtures';
ok -e catfile($target_dir, 'fixtures','1','conf','all_tables.json'), 'got the all_tables.json';
ok -d catfile($target_dir, 'migrations'), 'got migrations';
ok -e catfile($target_dir, 'migrations','SQLite','deploy','1','001-auto.sql'), 'found DDL';

open(
  my $perl_run,
  ">",
  catfile($target_dir, 'migrations', 'SQLite', 'deploy', '1', '002-artists.pl')
) || die "Cannot open: $!";

print $perl_run <<'END';

use DBIx::Class::Migration::RunScript;
use Test::Most;

ok $ENV{DBIC_MIGRATION_TARGET_DIR};

builder {
  'SchemaLoader',
  sub {
    my $self = shift;
    $self->schema->resultset('Country')
      ->populate([
      ['code'],
      ['bel'],
      ['deu'],
      ['fra'],
    ]);
  };
};

END

ok close($perl_run), "wrote file";

ok $migration->install, 'install ok';

ok $schema->resultset('Country')->find({code=>'fra'}),
  'got some previously inserted data';

$migration->dump_all_sets;

ok -e catfile($target_dir, 'fixtures','1','all_tables','country','1.fix'),
  'found a fixture';

rmtree catfile($target_dir, 'fixtures','1','all_tables');

$migration->dump_named_sets('all_tables');

ok -e catfile($target_dir, 'fixtures','1','all_tables','country','1.fix'),
  'found a fixture';

$migration->delete_table_rows;
$migration->populate('all_tables');

ok $schema->resultset('Country')->find({code=>'fra'}),
  'got some previously inserted data';

$migration->drop_tables;

NEW_SCOPE_FOR_SCHEMA: {
  my $migration = DBIx::Class::Migration->new(
    schema_class=>'Local::Schema',
    target_dir => $dir,
  );

  $migration->install;

  ok $schema->resultset('Country')->find({code=>'fra'}),
    'got some previously inserted data';

  $migration->delete_table_rows;
  $migration->populate('all_tables');

  ok $schema->resultset('Country')->find({code=>'bel'}),
    'got some previously inserted data';
}

CATALYST_HELPER: {
  require Catalyst::TraitFor::Model::DBIC::Schema::FromMigration::_MigrationHelper;
  my @warnings;
  local $SIG{__WARN__} = sub { push @warnings, @_ };
  my $helper = Catalyst::TraitFor::Model::DBIC::Schema::FromMigration::_MigrationHelper->new(
     'install_if_needed' => {
       'default_fixture_sets' => undef
     },
     'migration_init_args' => {
       'schema_class' => 'Local::Schema',
        target_dir => $dir,
     }
  );
  ok $helper->migration, 'built DBICM object';
  ok !@warnings, 'no warnings' or diag explain \@warnings;
}

done_testing;
