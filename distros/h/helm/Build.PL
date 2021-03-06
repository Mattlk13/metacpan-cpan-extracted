use Module::Build;
use Data::Dumper;
my $build = Module::Build->new(
    dist_abstract      => 'helm - Easy server and cluster automation',
    dist_author        => 'Michael Peters <wonko@cpan.org>',
    dist_name          => 'helm',
    dist_version_from  => 'bin/helm',
    license            => 'perl',
    create_makefile_pl => 'small',
    create_readme      => 1,
    requires           => {
        'perl'                  => '5.8.0',
        'AnyEvent'              => '0',
        'Carp'                  => '0',
        'Cwd'                   => '0',
        'Data::UUID'            => '0',
        'DateTime'              => '0',
        'Fcntl'                 => '0',
        'File::Basename'        => '0',
        'File::HomeDir'         => '0',
        'File::Spec::Functions' => '0',
        'Getopt::Long'          => '0',
        'IO::File'              => '0',
        'IO::Pipe'              => '0',
        'Moose'                 => '1.14',
        'namespace::autoclean'  => '0',
        'Net::OpenSSH'          => '0',
        'Parallel::ForkManager' => '0',
        'Pod::Usage'            => '0',
        'Term::ANSIColor'       => '0',
        'Try::Tiny'             => '0',
        'URI'                   => '0',
    },
    recommends => {
        'AnyEvent::IRC::Client'  => '0',
        'Config::ApacheFormat'   => '0',
        'Email::Sender'          => '0',
        'Email::Simple'          => '0',
        'Email::Simple::Creator' => '0',
        'Email::Valid'           => '0',
    },
);
$build->create_build_script;
