use Module::Build;
# See perldoc Module::Build for details of how this works

Module::Build->new(
	module_name        => 'Acme::Pills',
	license            => 'perl',
	requires           =>
	{
		'Test::Simple' => '0.47',
		'IO::File'     =>     '',
	},
	dist_version_from  => 'lib/Acme/Pills.pm',
	create_makefile_pl => 'traditional',
	sign               => 1,
)->create_build_script();
