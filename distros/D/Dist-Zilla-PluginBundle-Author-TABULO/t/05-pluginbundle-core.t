use strict;
use warnings;

use Test::More 0.88;
use if $ENV{AUTHOR_TESTING}, 'Test::Warnings';
use Test::DZil;
use Test::Fatal;
use Path::Tiny;

use Test::File::ShareDir -share => { -dist => { 'Dist-Zilla-PluginBundle-Author-TABULO' => 'share' } };

use lib 't/lib';
use Helper;
use NoNetworkHits;
use NoPrereqChecks;

# tests the core plugin - with all options disabled

{
    my $tempdir = no_git_tempdir();
    my $tzil = Builder->from_config(
        { dist_root => 'does-not-exist' },
        {
            tempdir_root => $tempdir->stringify,
            add_files => {
                path(qw(source dist.ini)) => simple_ini(
                    'GatherDir',
                    [ '@Author::TABULO' => {
                        '-remove' => \@REMOVED_PLUGINS,
                        server => 'none',
                        installer => 'MakeMaker',
                        'RewriteVersion::Transitional.skip_version_provider' => 1,
                      },
                    ],
                ),
                path(qw(source lib MyModule.pm)) => "package MyModule;\n\n1",
                path(qw(source Changes)) => '',
            },
        },
    );

    assert_no_git($tzil);

    $tzil->chrome->logger->set_debug(1);
    is(
        exception { $tzil->build },
        undef,
        'build proceeds normally',
    );

    # check that everything we loaded is properly declared as prereqs
    all_plugins_in_prereqs($tzil,
        exempt => [ 'Dist::Zilla::Plugin::GatherDir' ],     # used by us here
        additional => [ 'Dist::Zilla::Plugin::MakeMaker' ], # via installer option
    );

    # TABULO's max_target_perl setting may differ from the others who rely on  ETHER's global setting ('5.006')
    my $max_tgt_perl = ( $tzil->plugin_named('@Author::TABULO/Authority')->authority =~ /^cpan[:]TABULO/ ) ? '5.014' : '5.006';

    #my $max_tgt_perl = '5.014'; # TABULO's setting
    is(
        $tzil->plugin_named('@Author::TABULO/Test::MinimumVersion')->max_target_perl,
        $max_tgt_perl,
        "max_target_perl option defaults to $max_tgt_perl (when not overridden with a slice)",
    );

    ok(!-e "build/$_", "no $_ was created in the dist") foreach qw(Makefile.PL Build.PL);

    diag 'got log messages: ', explain $tzil->log_messages
        if not Test::Builder->new->is_passing;
}

done_testing;
