use strict;
use warnings;
use Test::More;
use Test::Exception;
use Pegex::Parser;
use GraphQL::Grammar;
use GraphQL::Parser;
use Pegex::Tree::Wrap;
use Pegex::Input;
use Data::Dumper;

my $parser = Pegex::Parser->new(
  grammar => GraphQL::Grammar->new,
  receiver => GraphQL::Parser->new,
);
open my $fh, '<', 't/kitchen-sink.graphql';

my $got = do_lex(join('', <$fh>));
my $expected = eval join '', <DATA>;
local $Data::Dumper::Indent = $Data::Dumper::Sortkeys = $Data::Dumper::Terse = 1;
#open $fh, '>', 'tf'; print $fh Dumper $got; # uncomment to regenerate

is_deeply $got, $expected, 'lex big doc correct' or diag Dumper $got;

throws_ok { do_lex("\x{0007}") } qr/Parse document failed for some reason/, 'invalid char';

lives_ok { do_lex("\x{FEFF} query foo { id }") } 'accepts BOM';

throws_ok { do_lex("\n\n    ?  \n\n\n") } qr/line:\s*3.*column:\s*5/s, 'error respects whitespace';

$got = do_lex(string_make(' x '));
is string_lookup($got), ' x ', 'string preserve whitespace' or diag Dumper $got;

$got = do_lex(string_make('quote \\"'));
is string_lookup($got), 'quote \\"', 'string quote kept' or diag Dumper $got; # not de-quoted by lexer

throws_ok { do_lex(string_make('quote \\')) } qr/line:\s*1.*column:\s*21/s, 'error on unterminated string';

throws_ok { do_lex(q(query q { foo(name: 'hello') { id } })) } qr/line:\s*1.*column:\s*21/s, 'error on single quote';

throws_ok { do_lex("\x{0007}") } qr/line:\s*1.*column:\s*1/s, 'error on invalid char';

throws_ok { do_lex(string_make("\x{0000}")) } qr/line:\s*1.*column:\s*21/s, 'error on NUL char';

throws_ok { do_lex(string_make("hi\nthere")) } qr/line:\s*1.*column:\s*21/s, 'error on multi-line string';
throws_ok { do_lex(string_make("hi\rthere")) } qr/line:\s*1.*column:\s*21/s, 'error on MacOS multi-line string';

throws_ok { do_lex(string_make('\z')) } qr/line:\s*1.*column:\s*21/s, 'error on invalid escape';
throws_ok { do_lex(string_make('bad \\x esc')) } qr/line:\s*1.*column:\s*21/s, 'error on invalid escape';
throws_ok { do_lex(string_make('bad \\u1 esc')) } qr/line:\s*1.*column:\s*21/s, 'error on invalid escape';
throws_ok { do_lex(string_make('bad \\u0XX1 esc')) } qr/line:\s*1.*column:\s*21/s, 'error on invalid escape';
throws_ok { do_lex(string_make('bad \\uXXXX esc')) } qr/line:\s*1.*column:\s*21/s, 'error on invalid escape';
throws_ok { do_lex(string_make('bad \\uFXXX esc')) } qr/line:\s*1.*column:\s*21/s, 'error on invalid escape';
throws_ok { do_lex(string_make('bad \\uXXXF esc')) } qr/line:\s*1.*column:\s*21/s, 'error on invalid escape';

number_test('4', 'int', 'simple int');
number_test('4.123', 'float', 'simple float');
number_test('9', 'int', 'simple int');
number_test('0', 'int', 'simple int');
number_test('-4.123', 'float', 'negative float');
number_test('0.123', 'float', 'simple float 0');
number_test('123e4', 'float', 'float exp lower');
number_test('123E4', 'float', 'float exp upper');
number_test('123e-4', 'float', 'float negexp lower');
number_test('123e+4', 'float', 'float posexp lower');
number_test('-1.123e4', 'float', 'neg float exp lower');
number_test('-1.123E4', 'float', 'neg float exp upper');
number_test('-1.123e-4', 'float', 'neg float negexp lower');
number_test('-1.123e+4', 'float', 'neg float posexp lower');
number_test('-1.123e4567', 'float', 'neg float longexp lower');

throws_ok { do_lex(number_make('00')) } qr/line:\s*1.*column:\s*22/s, 'error on invalid int';
throws_ok { do_lex(number_make('+1')) } qr/line:\s*1.*column:\s*21/s, 'error on invalid int';
throws_ok { do_lex(number_make('1.')) } qr/line:\s*1.*column:\s*22/s, 'error on invalid int';
throws_ok { do_lex(number_make('.123')) } qr/line:\s*1.*column:\s*21/s, 'error on invalid float';
throws_ok { do_lex(number_make('1.A')) } qr/line:\s*1.*column:\s*22/s, 'error on invalid int';
throws_ok { do_lex(number_make('-A')) } qr/line:\s*1.*column:\s*21/s, 'error on invalid int';
throws_ok { do_lex(number_make('1.0e')) } qr/line:\s*1.*column:\s*25/s, 'error on invalid int';
throws_ok { do_lex(number_make('1.0eA')) } qr/line:\s*1.*column:\s*26/s, 'error on invalid int';

my $multibyte = "Has a \x{0A0A} multi-byte character.";
$got = do_lex(string_make($multibyte));
is string_lookup($got), $multibyte, 'multibyte kept' or diag Dumper $got;

done_testing;

sub number_test {
  my ($text, $type, $label) = @_;
  my $got = do_lex(number_make($text));
  cmp_ok query_lookup($got, $type), '==', $text, $label or diag Dumper $got;
}

sub number_make {
  my ($text) = @_;
  return query_make($text);
}

sub string_make {
  my ($text) = @_;
  return query_make(sprintf '"%s"', $text);
}

sub query_make {
  my ($text) = @_;
  return sprintf 'query q { foo(name: %s) { id } }', $text;
}

sub string_lookup {
  my ($got) = @_;
  return query_lookup($got, 'string');
}

sub query_lookup {
  my ($got, $type) = @_;
  return $got->[0]{node}{selections}[0]{node}{arguments}{name};
}

sub do_lex {
  my ($text) = @_;
  my $input = Pegex::Input->new(string => $text);
  return $parser->parse($input);
}

__DATA__
[
  {
    'kind' => 'operation',
    'node' => {
      'name' => 'queryName',
      'operationType' => 'query',
      'selections' => [
        {
          'kind' => 'field',
          'node' => {
            'alias' => 'whoever123is',
            'arguments' => {
              'id' => [
                123,
                456
              ]
            },
            'name' => 'node',
            'selections' => [
              {
                'kind' => 'field',
                'node' => {
                  'name' => 'id'
                }
              },
              {
                'kind' => 'inline_fragment',
                'node' => {
                  'directives' => [
                    {
                      'name' => 'defer'
                    }
                  ],
                  'on' => 'User',
                  'selections' => [
                    {
                      'kind' => 'field',
                      'node' => {
                        'name' => 'field2',
                        'selections' => [
                          {
                            'kind' => 'field',
                            'node' => {
                              'name' => 'id'
                            }
                          },
                          {
                            'kind' => 'field',
                            'node' => {
                              'alias' => 'alias',
                              'arguments' => {
                                'after' => \'foo',
                                'first' => 10
                              },
                              'directives' => [
                                {
                                  'arguments' => {
                                    'if' => \'foo'
                                  },
                                  'name' => 'include'
                                }
                              ],
                              'name' => 'field1',
                              'selections' => [
                                {
                                  'kind' => 'field',
                                  'node' => {
                                    'name' => 'id'
                                  }
                                },
                                {
                                  'kind' => 'fragment_spread',
                                  'node' => {
                                    'name' => 'frag'
                                  }
                                }
                              ]
                            }
                          }
                        ]
                      }
                    }
                  ]
                }
              },
              {
                'kind' => 'inline_fragment',
                'node' => {
                  'directives' => [
                    {
                      'arguments' => {
                        'unless' => \'foo'
                      },
                      'name' => 'skip'
                    }
                  ],
                  'selections' => [
                    {
                      'kind' => 'field',
                      'node' => {
                        'name' => 'id'
                      }
                    }
                  ]
                }
              },
              {
                'kind' => 'inline_fragment',
                'node' => {
                  'selections' => [
                    {
                      'kind' => 'field',
                      'node' => {
                        'name' => 'id'
                      }
                    }
                  ]
                }
              }
            ]
          }
        }
      ],
      'variables' => {
        'foo' => {
          'type' => 'ComplexType'
        },
        'site' => {
          'default_value' => \\'MOBILE',
          'type' => 'Site'
        }
      }
    }
  },
  {
    'kind' => 'operation',
    'node' => {
      'name' => 'likeStory',
      'operationType' => 'mutation',
      'selections' => [
        {
          'kind' => 'field',
          'node' => {
            'arguments' => {
              'story' => 123
            },
            'directives' => [
              {
                'name' => 'defer'
              }
            ],
            'name' => 'like',
            'selections' => [
              {
                'kind' => 'field',
                'node' => {
                  'name' => 'story',
                  'selections' => [
                    {
                      'kind' => 'field',
                      'node' => {
                        'name' => 'id'
                      }
                    }
                  ]
                }
              }
            ]
          }
        }
      ]
    }
  },
  {
    'kind' => 'operation',
    'node' => {
      'name' => 'StoryLikeSubscription',
      'operationType' => 'subscription',
      'selections' => [
        {
          'kind' => 'field',
          'node' => {
            'arguments' => {
              'input' => \'input'
            },
            'name' => 'storyLikeSubscribe',
            'selections' => [
              {
                'kind' => 'field',
                'node' => {
                  'name' => 'story',
                  'selections' => [
                    {
                      'kind' => 'field',
                      'node' => {
                        'name' => 'likers',
                        'selections' => [
                          {
                            'kind' => 'field',
                            'node' => {
                              'name' => 'count'
                            }
                          }
                        ]
                      }
                    },
                    {
                      'kind' => 'field',
                      'node' => {
                        'name' => 'likeSentence',
                        'selections' => [
                          {
                            'kind' => 'field',
                            'node' => {
                              'name' => 'text'
                            }
                          }
                        ]
                      }
                    }
                  ]
                }
              }
            ]
          }
        }
      ],
      'variables' => {
        'input' => {
          'type' => 'StoryLikeSubscribeInput'
        }
      }
    }
  },
  {
    'kind' => 'fragment',
    'node' => {
      'name' => 'frag',
      'on' => 'Friend',
      'selections' => [
        {
          'kind' => 'field',
          'node' => {
            'arguments' => {
              'bar' => \'b',
              'obj' => {
                'key' => 'value'
              },
              'size' => \'size'
            },
            'name' => 'foo'
          }
        }
      ]
    }
  },
  {
    'kind' => 'operation',
    'node' => {
      'selections' => [
        {
          'kind' => 'field',
          'node' => {
            'arguments' => {
              'falsey' => bless( do{\(my $o = 0)}, 'JSON::PP::Boolean' ),
              'nullish' => undef,
              'truthy' => bless( do{\(my $o = 1)}, 'JSON::PP::Boolean' )
            },
            'name' => 'unnamed'
          }
        },
        {
          'kind' => 'field',
          'node' => {
            'name' => 'query'
          }
        }
      ]
    }
  }
]
