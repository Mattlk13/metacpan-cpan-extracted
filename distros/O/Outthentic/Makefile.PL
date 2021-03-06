use lib ".";
use inc::Module::Install;

# Define metadata
name           'Outthentic';
abstract       'Multipurpose scenarios framework';

all_from       'lib/Outthentic.pm';

# Specific dependencies
requires    'File::Temp';
requires    'Config::General';
requires    'YAML';
requires    'JSON';
requires    'File::ShareDir';
requires    'Outthentic::DSL' => "0.2.8";
requires    'Term::ANSIColor' => '4.02';
requires    'Hash::Merge';
requires    'Capture::Tiny' => '0.30';
requires    'File::Path::Tiny';

license     'perl';
repository  'https://github.com/melezhik/outthentic';

install_script 'bin/strun';

install_share 'ruby_lib';
install_share 'python_lib';
install_share 'bash_lib';
install_share 'ps_lib';

no_index    directory => 'examples';

WriteAll;


