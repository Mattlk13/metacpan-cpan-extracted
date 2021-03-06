
use strict;
use warnings;

use Test::More;
use Path::Tiny;
use App::EvalServerAdvanced::Protocol;

my $saved = path(__FILE__)->parent->child("test.packet");
my $data = $saved->slurp_raw;
my $alldata = $saved->slurp_raw;

my $partialdata = substr($data, 0, 10); # make an incomplete packet

my ($res, $message);
my @msgs;

my $count = 0;
do {
  ($res, $message, $data) = decode_message($data);
  push @msgs, $message if $res;
} while($res);

do {
  my ($suc, $message, $copy) = decode_message($partialdata);
  is($suc, 0, "Dont parse partial messages");
  is($message, undef, "Dont get a message from partial data");
  is($copy, $partialdata, "Partial messages dont drop data");
};

is_deeply(\@msgs, [
bless( {
         'files' => [
                      bless( {
                               'filename' => '__code',
                               'contents' => 'print \'hello world\''
                             }, 'App::EvalServerAdvanced::Protocol::Eval::File' )
                    ],
         'sequence' => 187,
         'prio' => bless( {
                            'pr_realtime' => bless( {}, 'App::EvalServerAdvanced::Protocol::Priority::Priority_Realtime' )
                          }, 'App::EvalServerAdvanced::Protocol::Priority' ),
         'language' => 'perl'
       }, 'App::EvalServerAdvanced::Protocol::Eval' ),
bless( {
         'prio' => bless( {
                            'pr_realtime' => bless( {}, 'App::EvalServerAdvanced::Protocol::Priority::Priority_Realtime' )
                          }, 'App::EvalServerAdvanced::Protocol::Priority' ),
         'language' => 'perl',
         'sequence' => 92,
         'files' => [
                      bless( {
                               'contents' => 'print \'hello world\'',
                               'filename' => '__code'
                             }, 'App::EvalServerAdvanced::Protocol::Eval::File' )
                    ]
       }, 'App::EvalServerAdvanced::Protocol::Eval' ),
bless( {
         'sequence' => 16,
         'files' => [
                      bless( {
                               'filename' => '__code',
                               'contents' => 'print \'hello world\''
                             }, 'App::EvalServerAdvanced::Protocol::Eval::File' )
                    ],
         'language' => 'perl',
         'prio' => bless( {
                            'pr_realtime' => bless( {}, 'App::EvalServerAdvanced::Protocol::Priority::Priority_Realtime' )
                          }, 'App::EvalServerAdvanced::Protocol::Priority' )
       }, 'App::EvalServerAdvanced::Protocol::Eval' ),
bless( {
         'language' => 'perl',
         'prio' => bless( {
                            'pr_realtime' => bless( {}, 'App::EvalServerAdvanced::Protocol::Priority::Priority_Realtime' )
                          }, 'App::EvalServerAdvanced::Protocol::Priority' ),
         'sequence' => 14,
         'files' => [
                      bless( {
                               'filename' => '__code',
                               'contents' => 'print \'hello world\''
                             }, 'App::EvalServerAdvanced::Protocol::Eval::File' )
                    ]
       }, 'App::EvalServerAdvanced::Protocol::Eval' ),
bless( {
         'files' => [
                      bless( {
                               'contents' => 'print \'hello world\'',
                               'filename' => '__code'
                             }, 'App::EvalServerAdvanced::Protocol::Eval::File' )
                    ],
         'sequence' => 184,
         'prio' => bless( {
                            'pr_realtime' => bless( {}, 'App::EvalServerAdvanced::Protocol::Priority::Priority_Realtime' )
                          }, 'App::EvalServerAdvanced::Protocol::Priority' ),
         'language' => 'perl'
       }, 'App::EvalServerAdvanced::Protocol::Eval' ),
bless( {
         'language' => 'perl',
         'prio' => bless( {
                            'pr_realtime' => bless( {}, 'App::EvalServerAdvanced::Protocol::Priority::Priority_Realtime' )
                          }, 'App::EvalServerAdvanced::Protocol::Priority' ),
         'files' => [
                      bless( {
                               'contents' => 'print \'hello world\'',
                               'filename' => '__code'
                             }, 'App::EvalServerAdvanced::Protocol::Eval::File' )
                    ],
         'sequence' => 173
       }, 'App::EvalServerAdvanced::Protocol::Eval' ),
bless( {
         'files' => [
                      bless( {
                               'filename' => '__code',
                               'contents' => 'print \'hello world\''
                             }, 'App::EvalServerAdvanced::Protocol::Eval::File' )
                    ],
         'sequence' => 222,
         'prio' => bless( {
                            'pr_realtime' => bless( {}, 'App::EvalServerAdvanced::Protocol::Priority::Priority_Realtime' )
                          }, 'App::EvalServerAdvanced::Protocol::Priority' ),
         'language' => 'perl'
       }, 'App::EvalServerAdvanced::Protocol::Eval' ),
bless( {
         'sequence' => 21,
         'files' => [
                      bless( {
                               'contents' => 'print \'hello world\'',
                               'filename' => '__code'
                             }, 'App::EvalServerAdvanced::Protocol::Eval::File' )
                    ],
         'prio' => bless( {
                            'pr_realtime' => bless( {}, 'App::EvalServerAdvanced::Protocol::Priority::Priority_Realtime' )
                          }, 'App::EvalServerAdvanced::Protocol::Priority' ),
         'language' => 'perl'
       }, 'App::EvalServerAdvanced::Protocol::Eval' ),
bless( {
         'sequence' => 161,
         'files' => [
                      bless( {
                               'contents' => 'print \'hello world\'',
                               'filename' => '__code'
                             }, 'App::EvalServerAdvanced::Protocol::Eval::File' )
                    ],
         'language' => 'perl',
         'prio' => bless( {
                            'pr_realtime' => bless( {}, 'App::EvalServerAdvanced::Protocol::Priority::Priority_Realtime' )
                          }, 'App::EvalServerAdvanced::Protocol::Priority' )
       }, 'App::EvalServerAdvanced::Protocol::Eval' ),
bless( {
         'sequence' => 227,
         'files' => [
                      bless( {
                               'contents' => 'print \'hello world\'',
                               'filename' => '__code'
                             }, 'App::EvalServerAdvanced::Protocol::Eval::File' )
                    ],
         'prio' => bless( {
                            'pr_realtime' => bless( {}, 'App::EvalServerAdvanced::Protocol::Priority::Priority_Realtime' )
                          }, 'App::EvalServerAdvanced::Protocol::Priority' ),
         'language' => 'perl'
       }, 'App::EvalServerAdvanced::Protocol::Eval' ),
], "All packets decoded properly");

my $re_data = join '', map {encode_message("eval" => $_)} @msgs;

is($re_data, $alldata, "Re-encoded message matches original");

done_testing;
