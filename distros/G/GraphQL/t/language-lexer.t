use strict;
use warnings;
use Test::More;
use Test::Exception;
use Pegex::Parser;
use GraphQL::Grammar;
use Pegex::Tree::Wrap;
use Pegex::Input;
use Data::Dumper;

my $parser = Pegex::Parser->new(
  grammar => GraphQL::Grammar->new,
  receiver => Pegex::Tree::Wrap->new,
);
open my $fh, '<', 't/kitchen-sink.graphql';

my $got = do_lex(join('', <$fh>));
my $expected = eval join '', <DATA>;
local $Data::Dumper::Indent = $Data::Dumper::Sortkeys = $Data::Dumper::Terse = 1;
#open $fh, '>', 'tf'; # uncomment these two lines to regenerate
#print $fh Dumper $got;
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

done_testing;

sub number_test {
  my ($text, $type, $label) = @_;
  my $got = do_lex(number_make($text));
  is query_lookup($got, $type), $text, $label or diag Dumper $got;
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
  return $got->{graphql}[0][0]{definition}[0]{operationDefinition}[2]{selectionSet}[0][0]{selection}{field}[1]{arguments}[0][0]{argument}[1]{value}{$type};
}

sub do_lex {
  my ($text) = @_;
  my $input = Pegex::Input->new(string => $text);
  return $parser->parse($input);
}

__DATA__
{
  'graphql' => [
    [
      {
        'definition' => [
          {
            'operationDefinition' => [
              {
                'operationType' => 'query'
              },
              {
                'name' => 'queryName'
              },
              {
                'variableDefinitions' => [
                  [
                    {
                      'variableDefinition' => [
                        {
                          'variable' => [
                            {
                              'name' => 'foo'
                            }
                          ]
                        },
                        {
                          'type' => [
                            {
                              'namedType' => {
                                'name' => 'ComplexType'
                              }
                            }
                          ]
                        }
                      ]
                    },
                    {
                      'variableDefinition' => [
                        {
                          'variable' => [
                            {
                              'name' => 'site'
                            }
                          ]
                        },
                        {
                          'type' => [
                            {
                              'namedType' => {
                                'name' => 'Site'
                              }
                            }
                          ]
                        },
                        {
                          'defaultValue' => [
                            {
                              'value' => {
                                'enumValue' => {
                                  'name' => 'MOBILE'
                                }
                              }
                            }
                          ]
                        }
                      ]
                    }
                  ]
                ]
              },
              {
                'selectionSet' => [
                  [
                    {
                      'selection' => {
                        'field' => [
                          {
                            'alias' => [
                              {
                                'name' => 'whoever123is'
                              }
                            ]
                          },
                          {
                            'name' => 'node'
                          },
                          {
                            'arguments' => [
                              [
                                {
                                  'argument' => [
                                    {
                                      'name' => 'id'
                                    },
                                    {
                                      'value' => {
                                        'listValue' => [
                                          [
                                            {
                                              'value' => {
                                                'int' => '123'
                                              }
                                            },
                                            {
                                              'value' => {
                                                'int' => '456'
                                              }
                                            }
                                          ]
                                        ]
                                      }
                                    }
                                  ]
                                }
                              ]
                            ]
                          },
                          {
                            'selectionSet' => [
                              [
                                {
                                  'selection' => {
                                    'field' => [
                                      {
                                        'name' => 'id'
                                      }
                                    ]
                                  }
                                },
                                {
                                  'selection' => {
                                    'inlineFragment' => [
                                      {
                                        'typeCondition' => [
                                          {
                                            'namedType' => {
                                              'name' => 'User'
                                            }
                                          }
                                        ]
                                      },
                                      {
                                        'directives' => [
                                          {
                                            'directive' => [
                                              {
                                                'name' => 'defer'
                                              }
                                            ]
                                          }
                                        ]
                                      },
                                      {
                                        'selectionSet' => [
                                          [
                                            {
                                              'selection' => {
                                                'field' => [
                                                  {
                                                    'name' => 'field2'
                                                  },
                                                  {
                                                    'selectionSet' => [
                                                      [
                                                        {
                                                          'selection' => {
                                                            'field' => [
                                                              {
                                                                'name' => 'id'
                                                              }
                                                            ]
                                                          }
                                                        },
                                                        {
                                                          'selection' => {
                                                            'field' => [
                                                              {
                                                                'alias' => [
                                                                  {
                                                                    'name' => 'alias'
                                                                  }
                                                                ]
                                                              },
                                                              {
                                                                'name' => 'field1'
                                                              },
                                                              {
                                                                'arguments' => [
                                                                  [
                                                                    {
                                                                      'argument' => [
                                                                        {
                                                                          'name' => 'first'
                                                                        },
                                                                        {
                                                                          'value' => {
                                                                            'int' => '10'
                                                                          }
                                                                        }
                                                                      ]
                                                                    },
                                                                    {
                                                                      'argument' => [
                                                                        {
                                                                          'name' => 'after'
                                                                        },
                                                                        {
                                                                          'value' => {
                                                                            'variable' => [
                                                                              {
                                                                                'name' => 'foo'
                                                                              }
                                                                            ]
                                                                          }
                                                                        }
                                                                      ]
                                                                    }
                                                                  ]
                                                                ]
                                                              },
                                                              {
                                                                'directives' => [
                                                                  {
                                                                    'directive' => [
                                                                      {
                                                                        'name' => 'include'
                                                                      },
                                                                      {
                                                                        'arguments' => [
                                                                          [
                                                                            {
                                                                              'argument' => [
                                                                                {
                                                                                  'name' => 'if'
                                                                                },
                                                                                {
                                                                                  'value' => {
                                                                                    'variable' => [
                                                                                      {
                                                                                        'name' => 'foo'
                                                                                      }
                                                                                    ]
                                                                                  }
                                                                                }
                                                                              ]
                                                                            }
                                                                          ]
                                                                        ]
                                                                      }
                                                                    ]
                                                                  }
                                                                ]
                                                              },
                                                              {
                                                                'selectionSet' => [
                                                                  [
                                                                    {
                                                                      'selection' => {
                                                                        'field' => [
                                                                          {
                                                                            'name' => 'id'
                                                                          }
                                                                        ]
                                                                      }
                                                                    },
                                                                    {
                                                                      'selection' => {
                                                                        'fragmentSpread' => [
                                                                          {
                                                                            'fragmentName' => {
                                                                              'name' => 'frag'
                                                                            }
                                                                          }
                                                                        ]
                                                                      }
                                                                    }
                                                                  ]
                                                                ]
                                                              }
                                                            ]
                                                          }
                                                        }
                                                      ]
                                                    ]
                                                  }
                                                ]
                                              }
                                            }
                                          ]
                                        ]
                                      }
                                    ]
                                  }
                                },
                                {
                                  'selection' => {
                                    'inlineFragment' => [
                                      {
                                        'directives' => [
                                          {
                                            'directive' => [
                                              {
                                                'name' => 'skip'
                                              },
                                              {
                                                'arguments' => [
                                                  [
                                                    {
                                                      'argument' => [
                                                        {
                                                          'name' => 'unless'
                                                        },
                                                        {
                                                          'value' => {
                                                            'variable' => [
                                                              {
                                                                'name' => 'foo'
                                                              }
                                                            ]
                                                          }
                                                        }
                                                      ]
                                                    }
                                                  ]
                                                ]
                                              }
                                            ]
                                          }
                                        ]
                                      },
                                      {
                                        'selectionSet' => [
                                          [
                                            {
                                              'selection' => {
                                                'field' => [
                                                  {
                                                    'name' => 'id'
                                                  }
                                                ]
                                              }
                                            }
                                          ]
                                        ]
                                      }
                                    ]
                                  }
                                },
                                {
                                  'selection' => {
                                    'inlineFragment' => [
                                      {
                                        'selectionSet' => [
                                          [
                                            {
                                              'selection' => {
                                                'field' => [
                                                  {
                                                    'name' => 'id'
                                                  }
                                                ]
                                              }
                                            }
                                          ]
                                        ]
                                      }
                                    ]
                                  }
                                }
                              ]
                            ]
                          }
                        ]
                      }
                    }
                  ]
                ]
              }
            ]
          }
        ]
      },
      {
        'definition' => [
          {
            'operationDefinition' => [
              {
                'operationType' => 'mutation'
              },
              {
                'name' => 'likeStory'
              },
              {
                'selectionSet' => [
                  [
                    {
                      'selection' => {
                        'field' => [
                          {
                            'name' => 'like'
                          },
                          {
                            'arguments' => [
                              [
                                {
                                  'argument' => [
                                    {
                                      'name' => 'story'
                                    },
                                    {
                                      'value' => {
                                        'int' => '123'
                                      }
                                    }
                                  ]
                                }
                              ]
                            ]
                          },
                          {
                            'directives' => [
                              {
                                'directive' => [
                                  {
                                    'name' => 'defer'
                                  }
                                ]
                              }
                            ]
                          },
                          {
                            'selectionSet' => [
                              [
                                {
                                  'selection' => {
                                    'field' => [
                                      {
                                        'name' => 'story'
                                      },
                                      {
                                        'selectionSet' => [
                                          [
                                            {
                                              'selection' => {
                                                'field' => [
                                                  {
                                                    'name' => 'id'
                                                  }
                                                ]
                                              }
                                            }
                                          ]
                                        ]
                                      }
                                    ]
                                  }
                                }
                              ]
                            ]
                          }
                        ]
                      }
                    }
                  ]
                ]
              }
            ]
          }
        ]
      },
      {
        'definition' => [
          {
            'operationDefinition' => [
              {
                'operationType' => 'subscription'
              },
              {
                'name' => 'StoryLikeSubscription'
              },
              {
                'variableDefinitions' => [
                  [
                    {
                      'variableDefinition' => [
                        {
                          'variable' => [
                            {
                              'name' => 'input'
                            }
                          ]
                        },
                        {
                          'type' => [
                            {
                              'namedType' => {
                                'name' => 'StoryLikeSubscribeInput'
                              }
                            }
                          ]
                        }
                      ]
                    }
                  ]
                ]
              },
              {
                'selectionSet' => [
                  [
                    {
                      'selection' => {
                        'field' => [
                          {
                            'name' => 'storyLikeSubscribe'
                          },
                          {
                            'arguments' => [
                              [
                                {
                                  'argument' => [
                                    {
                                      'name' => 'input'
                                    },
                                    {
                                      'value' => {
                                        'variable' => [
                                          {
                                            'name' => 'input'
                                          }
                                        ]
                                      }
                                    }
                                  ]
                                }
                              ]
                            ]
                          },
                          {
                            'selectionSet' => [
                              [
                                {
                                  'selection' => {
                                    'field' => [
                                      {
                                        'name' => 'story'
                                      },
                                      {
                                        'selectionSet' => [
                                          [
                                            {
                                              'selection' => {
                                                'field' => [
                                                  {
                                                    'name' => 'likers'
                                                  },
                                                  {
                                                    'selectionSet' => [
                                                      [
                                                        {
                                                          'selection' => {
                                                            'field' => [
                                                              {
                                                                'name' => 'count'
                                                              }
                                                            ]
                                                          }
                                                        }
                                                      ]
                                                    ]
                                                  }
                                                ]
                                              }
                                            },
                                            {
                                              'selection' => {
                                                'field' => [
                                                  {
                                                    'name' => 'likeSentence'
                                                  },
                                                  {
                                                    'selectionSet' => [
                                                      [
                                                        {
                                                          'selection' => {
                                                            'field' => [
                                                              {
                                                                'name' => 'text'
                                                              }
                                                            ]
                                                          }
                                                        }
                                                      ]
                                                    ]
                                                  }
                                                ]
                                              }
                                            }
                                          ]
                                        ]
                                      }
                                    ]
                                  }
                                }
                              ]
                            ]
                          }
                        ]
                      }
                    }
                  ]
                ]
              }
            ]
          }
        ]
      },
      {
        'definition' => [
          {
            'fragmentDefinition' => [
              {
                'fragmentName' => {
                  'name' => 'frag'
                }
              },
              {
                'typeCondition' => [
                  {
                    'namedType' => {
                      'name' => 'Friend'
                    }
                  }
                ]
              },
              {
                'selectionSet' => [
                  [
                    {
                      'selection' => {
                        'field' => [
                          {
                            'name' => 'foo'
                          },
                          {
                            'arguments' => [
                              [
                                {
                                  'argument' => [
                                    {
                                      'name' => 'size'
                                    },
                                    {
                                      'value' => {
                                        'variable' => [
                                          {
                                            'name' => 'size'
                                          }
                                        ]
                                      }
                                    }
                                  ]
                                },
                                {
                                  'argument' => [
                                    {
                                      'name' => 'bar'
                                    },
                                    {
                                      'value' => {
                                        'variable' => [
                                          {
                                            'name' => 'b'
                                          }
                                        ]
                                      }
                                    }
                                  ]
                                },
                                {
                                  'argument' => [
                                    {
                                      'name' => 'obj'
                                    },
                                    {
                                      'value' => {
                                        'objectValue' => [
                                          [
                                            {
                                              'objectField' => [
                                                {
                                                  'name' => 'key'
                                                },
                                                {
                                                  'value' => {
                                                    'string' => 'value'
                                                  }
                                                }
                                              ]
                                            }
                                          ]
                                        ]
                                      }
                                    }
                                  ]
                                }
                              ]
                            ]
                          }
                        ]
                      }
                    }
                  ]
                ]
              }
            ]
          }
        ]
      },
      {
        'definition' => [
          {
            'operationDefinition' => {
              'selectionSet' => [
                [
                  {
                    'selection' => {
                      'field' => [
                        {
                          'name' => 'unnamed'
                        },
                        {
                          'arguments' => [
                            [
                              {
                                'argument' => [
                                  {
                                    'name' => 'truthy'
                                  },
                                  {
                                    'value' => {
                                      'boolean' => 'true'
                                    }
                                  }
                                ]
                              },
                              {
                                'argument' => [
                                  {
                                    'name' => 'falsey'
                                  },
                                  {
                                    'value' => {
                                      'boolean' => 'false'
                                    }
                                  }
                                ]
                              },
                              {
                                'argument' => [
                                  {
                                    'name' => 'nullish'
                                  }
                                ]
                              }
                            ]
                          ]
                        }
                      ]
                    }
                  },
                  {
                    'selection' => {
                      'field' => [
                        {
                          'name' => 'query'
                        }
                      ]
                    }
                  }
                ]
              ]
            }
          }
        ]
      }
    ]
  ]
}
