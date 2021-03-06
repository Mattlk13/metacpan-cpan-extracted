#!perl
use 5.006;
use strict;
use warnings FATAL => 'all';
use POSIX ":sys_wait_h";
use Test::More;
use IPC::Transit;
use App::MultiModule::API;
use Data::Dumper;

BEGIN {
    use_ok( 'App::MultiModule' ) || print "Bail out!\n";
    use_ok( 'App::MultiModule::Test' ) || print "Bail out!\n";
}


App::MultiModule::Test::begin();

my $test_qname_in = 'tqueue';
my $test_qname_out = 'tqueue_out';
my $test_qname_out_alt = 'tqueue_out_alt';
my $module_qname = 'OtherExternalModule';
my $module_qname_alt = 'OtherModule';

ok my $pid = App::MultiModule::Test::run_program('-q tqueue -p MultiModuleTest::');


my $increment = int rand 10000;
my $increment_alt = int rand 10000;
my $config = {
    '.multimodule' => {
        config => {
            MultiModule => {

            },
            OtherExternalModule => {
                is_external => 1,
                increment_by => $increment,
            },
            OtherModule => {
                increment_by => $increment_alt, #random number here
#                is_external => 1,
            },
            Router => {  #router config
                routes => [
                    {   match => {
                            some => 'message',
                        },
                        forwards => [
                            {   qname => $test_qname_out }
                        ]
                    },{ match => {
                            another => 'different message',
                        },
                        forwards => [
                            {   qname => $test_qname_out_alt }
                        ]
                    }
                ],
            }
        },
    }
};

ok IPC::Transit::send(qname => $test_qname_in, message => $config);

sleep 26;

my $initial_ct = int rand 10000;
ok IPC::Transit::send(qname => $module_qname, message => {
    some => 'message',
    ct => $initial_ct
});

my $initial_ct_alt = int rand 10000;
ok IPC::Transit::send(qname => $module_qname_alt, message => {
    another => 'different message',
    ct => $initial_ct_alt
});

sleep 26;

#first the external
eval {
    ok my $msg = IPC::Transit::receive(qname => $test_qname_out, nonblock => 1);
    ok $msg->{ct} == $initial_ct;
    ok $msg->{my_ct} == $initial_ct + $increment;
    ok $msg->{module_pid} != $pid;

    ok my $api = App::MultiModule::API->new();
    ok my $status = $api->get_task_status($module_qname);
    ok my $module_pid = $status->{pid};
    ok $module_pid == $msg->{module_pid};
    ok my $save_ts = $status->{save_ts};
    ok $save_ts - time < 5;
};
print STDERR "exception: $@\n" if $@;

#then the internal
eval {
    ok my $msg = IPC::Transit::receive(qname => $test_qname_out_alt, nonblock => 1);
    ok $msg->{ct} == $initial_ct_alt;
    ok $msg->{my_ct} == $initial_ct_alt + $increment_alt;
    ok $msg->{module_pid} == $pid;
    ok my $api = App::MultiModule::API->new();
    ok my $status = $api->get_task_status('main');
    ok my $module_pid = $status->{pid};
    ok $module_pid == $msg->{module_pid};
    ok my $save_ts = $status->{save_ts};
    ok $save_ts - time < 5;
};
print STDERR "exception in internal: $@\n" if $@;



#ask it to go away nicely
ok IPC::Transit::send(qname => $test_qname_in, message => {
    '.multimodule' => {
        control => [
            {   type => 'cleanly_exit',
#                exit_externals => 1, # but not its external
            }
        ],
    }
});

sleep 26;

ok waitpid($pid, WNOHANG) == $pid;
ok not kill 15, $pid;

#at this point, the module should be running in splended isolation
{   ok IPC::Transit::send(qname => $module_qname, message => {
        some => 'message',
        ct => $initial_ct+1
    });
    sleep 26;
    eval {
        ok my $msg = IPC::Transit::receive(qname => $test_qname_out, nonblock => 1);
        ok $msg->{ct} == $initial_ct+1;
        #print STDERR 'isolated_external.t: ' . Data::Dumper::Dumper $msg;
        #print STDERR "\$initial_ct=$initial_ct \$increment=$increment\n sum_increment_by=$msg->{sum_increment_by}\n";
        ok $msg->{my_ct} == $initial_ct + $increment + 1;
        ok $msg->{sum_increment_by} == $increment + $increment;
        ok $msg->{module_pid} != $pid;
        ok my $api = App::MultiModule::API->new();
        ok my $status = $api->get_task_status($module_qname);
        ok my $module_pid = $status->{pid};
        ok $module_pid == $msg->{module_pid};
        ok my $save_ts = $status->{save_ts};
        ok $save_ts - time < 5;
    };
    {   ok my $api = App::MultiModule::API->new();
        ok my $status = $api->get_task_status($module_qname);
        ok my $module_pid = $status->{pid};
        ok kill 15, $module_pid;
        sleep 4;
        ok not kill 9, $module_pid;
    }
}
 

App::MultiModule::Test::finish();

done_testing();
