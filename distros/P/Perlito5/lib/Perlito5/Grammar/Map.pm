# Do not edit this file - Generated by Perlito5 9.027

{
    package main;
    package Perlito5::Grammar::Map;
    use strict ;
    sub Perlito5::Grammar::Map::map_or_grep {
        my $str = $_[0];
        my $pos = $_[1];
        my $MATCH = {"str" => $str, "from" => $pos, "to" => $pos, };
        my $tmp = ((do {
            my $tmp100 = $MATCH->{"to"};
            ((("m" eq $str->[($MATCH->{"to"}) + 0]) && ("a" eq $str->[($MATCH->{"to"}) + 1]) && ("p" eq $str->[($MATCH->{"to"}) + 2]) && ($MATCH->{"to"} += 3))) || ($MATCH->{"to"} = $tmp100, (("g" eq $str->[($MATCH->{"to"}) + 0]) && ("r" eq $str->[($MATCH->{"to"}) + 1]) && ("e" eq $str->[($MATCH->{"to"}) + 2]) && ("p" eq $str->[($MATCH->{"to"}) + 3]) && ($MATCH->{"to"} += 4)))
        }));
        $tmp ? $MATCH : undef
    }
    sub Perlito5::Grammar::Map::term_map_or_grep {
        my $str = $_[0];
        my $pos = $_[1];
        my $MATCH = {"str" => $str, "from" => $pos, "to" => $pos, };
        my $tmp = (((do {
            my $m2 = Perlito5::Grammar::Map::map_or_grep($str, $MATCH->{"to"});
            if ($m2) {
                $MATCH->{"to"} = $m2->{"to"};
                $MATCH->{"map_or_grep"} = $m2;
                1
            }
            else {;
                0
            }
        }) && (do {
            my $m2 = Perlito5::Grammar::Space::opt_ws($str, $MATCH->{"to"});
            if ($m2) {
                $MATCH->{"to"} = $m2->{"to"};
                1
            }
            else {;
                0
            }
        }) && (do {
            my $tmp106 = $MATCH->{"to"};
            (((do {
                my $m2 = Perlito5::Grammar::block($str, $MATCH->{"to"});
                if ($m2) {
                    $MATCH->{"to"} = $m2->{"to"};
                    $MATCH->{"Perlito5::Grammar::block"} = $m2;
                    1
                }
                else {;
                    0
                }
            }) && (do {
                my $m2 = Perlito5::Grammar::Expression::list_parse($str, $MATCH->{"to"});
                if ($m2) {
                    $MATCH->{"to"} = $m2->{"to"};
                    $MATCH->{"Perlito5::Grammar::Expression::list_parse"} = $m2;
                    1
                }
                else {;
                    0
                }
            }) && (do {
                $MATCH->{"capture"} = ["term", Perlito5::AST::Apply::->new("code", Perlito5::Match::flat($MATCH->{"map_or_grep"}), "special_arg", $MATCH->{"Perlito5::Grammar::block"}->{"capture"}, "arguments", Perlito5::Grammar::Expression::expand_list($MATCH->{"Perlito5::Grammar::Expression::list_parse"}->{"capture"}), "namespace", '')];
                1
            }))) || ($MATCH->{"to"} = $tmp106, ((("(" eq $str->[($MATCH->{"to"}) + 0]) && ($MATCH->{"to"} += 1)) && (do {
                my $m2 = Perlito5::Grammar::Space::opt_ws($str, $MATCH->{"to"});
                if ($m2) {
                    $MATCH->{"to"} = $m2->{"to"};
                    1
                }
                else {;
                    0
                }
            }) && (do {
                my $m2 = Perlito5::Grammar::block($str, $MATCH->{"to"});
                if ($m2) {
                    $MATCH->{"to"} = $m2->{"to"};
                    $MATCH->{"Perlito5::Grammar::block"} = $m2;
                    1
                }
                else {;
                    0
                }
            }) && (do {
                my $m2 = Perlito5::Grammar::Expression::list_parse($str, $MATCH->{"to"});
                if ($m2) {
                    $MATCH->{"to"} = $m2->{"to"};
                    $MATCH->{"Perlito5::Grammar::Expression::list_parse"} = $m2;
                    1
                }
                else {;
                    0
                }
            }) && ((")" eq $str->[($MATCH->{"to"}) + 0]) && ($MATCH->{"to"} += 1)) && (do {
                $MATCH->{"capture"} = ["term", Perlito5::AST::Apply::->new("code", Perlito5::Match::flat($MATCH->{"map_or_grep"}), "special_arg", $MATCH->{"Perlito5::Grammar::block"}->{"capture"}, "arguments", Perlito5::Grammar::Expression::expand_list($MATCH->{"Perlito5::Grammar::Expression::list_parse"}->{"capture"}), "namespace", '')];
                1
            })))
        })));
        $tmp ? $MATCH : undef
    }
    sub Perlito5::Grammar::Map::non_core_ident {
        my $str = $_[0];
        my $pos = $_[1];
        my $MATCH = {"str" => $str, "from" => $pos, "to" => $pos, };
        my $tmp = (((do {
            my $m2 = Perlito5::Grammar::full_ident($str, $MATCH->{"to"});
            if ($m2) {
                $MATCH->{"to"} = $m2->{"to"};
                $MATCH->{"Perlito5::Grammar::full_ident"} = $m2;
                1
            }
            else {;
                0
            }
        }) && (do {
            my $name = Perlito5::Match::flat($MATCH->{"Perlito5::Grammar::full_ident"});
            (exists($Perlito5::CORE_PROTO->{$name}) || exists($Perlito5::CORE_PROTO->{"CORE::" . $name})) && return;
            1
        })));
        $tmp ? $MATCH : undef
    }
    sub Perlito5::Grammar::Map::term_sort {
        my $str = $_[0];
        my $pos = $_[1];
        my $MATCH = {"str" => $str, "from" => $pos, "to" => $pos, };
        my $tmp = (((("s" eq $str->[($MATCH->{"to"}) + 0]) && ("o" eq $str->[($MATCH->{"to"}) + 1]) && ("r" eq $str->[($MATCH->{"to"}) + 2]) && ("t" eq $str->[($MATCH->{"to"}) + 3]) && ($MATCH->{"to"} += 4)) && (do {
            my $m2 = Perlito5::Grammar::Space::opt_ws($str, $MATCH->{"to"});
            if ($m2) {
                $MATCH->{"to"} = $m2->{"to"};
                1
            }
            else {;
                0
            }
        }) && (do {
            my $tmp125 = $MATCH->{"to"};
            (((("(" eq $str->[($MATCH->{"to"}) + 0]) && ($MATCH->{"to"} += 1)) && (do {
                my $m2 = Perlito5::Grammar::Space::opt_ws($str, $MATCH->{"to"});
                if ($m2) {
                    $MATCH->{"to"} = $m2->{"to"};
                    1
                }
                else {;
                    0
                }
            }) && (do {
                my $tmp126 = $MATCH->{"to"};
                (((do {
                    my $m2 = Perlito5::Grammar::Map::non_core_ident($str, $MATCH->{"to"});
                    if ($m2) {
                        $MATCH->{"to"} = $m2->{"to"};
                        $MATCH->{"Perlito5::Grammar::Map::non_core_ident"} = $m2;
                        1
                    }
                    else {;
                        0
                    }
                }) && (do {
                    my $m2 = Perlito5::Grammar::Space::ws($str, $MATCH->{"to"});
                    if ($m2) {
                        $MATCH->{"to"} = $m2->{"to"};
                        1
                    }
                    else {;
                        0
                    }
                }) && (do {
                    my $name = Perlito5::Match::flat($MATCH->{"Perlito5::Grammar::Map::non_core_ident"});
                    $MATCH->{"_tmp"} = $name;
                    1
                }))) || ($MATCH->{"to"} = $tmp126, ((do {
                    my $m2 = Perlito5::Grammar::block($str, $MATCH->{"to"});
                    if ($m2) {
                        $MATCH->{"to"} = $m2->{"to"};
                        $MATCH->{"Perlito5::Grammar::block"} = $m2;
                        1
                    }
                    else {;
                        0
                    }
                }) && (do {
                    $MATCH->{"_tmp"} = $MATCH->{"Perlito5::Grammar::block"}->{"capture"};
                    1
                }))) || ($MATCH->{"to"} = $tmp126, ((do {
                    my $tmp = $MATCH;
                    $MATCH = {"from" => $tmp->{"to"}, "to" => $tmp->{"to"}, };
                    my $res = (("\$" eq $str->[($MATCH->{"to"}) + 0]) && ($MATCH->{"to"} += 1));
                    $MATCH = $tmp;
                    $res ? 1 : 0
                }) && (do {
                    my $m2 = Perlito5::Grammar::Sigil::term_sigil($str, $MATCH->{"to"});
                    if ($m2) {
                        $MATCH->{"to"} = $m2->{"to"};
                        $MATCH->{"Perlito5::Grammar::Sigil::term_sigil"} = $m2;
                        1
                    }
                    else {;
                        0
                    }
                }) && (do {
                    my $var = Perlito5::Match::flat($MATCH->{"Perlito5::Grammar::Sigil::term_sigil"})->[1];
                    ref($var) ne "Perlito5::AST::Var" && return;
                    $MATCH->{"_tmp"} = $var;
                    1
                })))
            }) && (do {
                my $m2 = Perlito5::Grammar::Expression::list_parse($str, $MATCH->{"to"});
                if ($m2) {
                    $MATCH->{"to"} = $m2->{"to"};
                    $MATCH->{"Perlito5::Grammar::Expression::list_parse"} = $m2;
                    1
                }
                else {;
                    0
                }
            }) && ((")" eq $str->[($MATCH->{"to"}) + 0]) && ($MATCH->{"to"} += 1)) && (do {
                $MATCH->{"capture"} = ["term", Perlito5::AST::Apply::->new("code", "sort", "special_arg", $MATCH->{"_tmp"}, "arguments", Perlito5::Grammar::Expression::expand_list($MATCH->{"Perlito5::Grammar::Expression::list_parse"}->{"capture"}), "namespace", '')];
                1
            }))) || ($MATCH->{"to"} = $tmp125, ((do {
                my $tmp127 = $MATCH->{"to"};
                (((do {
                    my $m2 = Perlito5::Grammar::block($str, $MATCH->{"to"});
                    if ($m2) {
                        $MATCH->{"to"} = $m2->{"to"};
                        $MATCH->{"Perlito5::Grammar::block"} = $m2;
                        1
                    }
                    else {;
                        0
                    }
                }) && (do {
                    $MATCH->{"_tmp"} = $MATCH->{"Perlito5::Grammar::block"}->{"capture"};
                    1
                }))) || ($MATCH->{"to"} = $tmp127, ((do {
                    my $m2 = Perlito5::Grammar::Map::non_core_ident($str, $MATCH->{"to"});
                    if ($m2) {
                        $MATCH->{"to"} = $m2->{"to"};
                        $MATCH->{"Perlito5::Grammar::Map::non_core_ident"} = $m2;
                        1
                    }
                    else {;
                        0
                    }
                }) && (do {
                    my $name = Perlito5::Match::flat($MATCH->{"Perlito5::Grammar::Map::non_core_ident"});
                    $MATCH->{"_tmp"} = $name;
                    1
                }))) || ($MATCH->{"to"} = $tmp127, ((do {
                    my $tmp = $MATCH;
                    $MATCH = {"from" => $tmp->{"to"}, "to" => $tmp->{"to"}, };
                    my $res = (("\$" eq $str->[($MATCH->{"to"}) + 0]) && ($MATCH->{"to"} += 1));
                    $MATCH = $tmp;
                    $res ? 1 : 0
                }) && (do {
                    my $m2 = Perlito5::Grammar::Sigil::term_sigil($str, $MATCH->{"to"});
                    if ($m2) {
                        $MATCH->{"to"} = $m2->{"to"};
                        $MATCH->{"Perlito5::Grammar::Sigil::term_sigil"} = $m2;
                        1
                    }
                    else {;
                        0
                    }
                }) && (do {
                    my $var = Perlito5::Match::flat($MATCH->{"Perlito5::Grammar::Sigil::term_sigil"})->[1];
                    ref($var) ne "Perlito5::AST::Var" && return;
                    $MATCH->{"_tmp"} = $var;
                    1
                }))) || ($MATCH->{"to"} = $tmp127, (do {
                    $MATCH->{"_tmp"} = Perlito5::AST::Block::->new("stmts", [Perlito5::AST::Apply::->new("code", "infix:<cmp>", "arguments", [Perlito5::AST::Var::->new("name", "a", "namespace", $Perlito5::PKG, "sigil", "\$"), Perlito5::AST::Var::->new("name", "b", "namespace", $Perlito5::PKG, "sigil", "\$")])]);
                    1
                }))
            }) && (do {
                my $m2 = Perlito5::Grammar::Expression::list_parse($str, $MATCH->{"to"});
                if ($m2) {
                    $MATCH->{"to"} = $m2->{"to"};
                    $MATCH->{"Perlito5::Grammar::Expression::list_parse"} = $m2;
                    1
                }
                else {;
                    0
                }
            }) && (do {
                $MATCH->{"capture"} = ["term", Perlito5::AST::Apply::->new("code", "sort", "special_arg", $MATCH->{"_tmp"}, "arguments", Perlito5::Grammar::Expression::expand_list($MATCH->{"Perlito5::Grammar::Expression::list_parse"}->{"capture"}), "namespace", '')];
                1
            })))
        })));
        $tmp ? $MATCH : undef
    }
    Perlito5::Grammar::Precedence::add_term("map", \&term_map_or_grep);
    Perlito5::Grammar::Precedence::add_term("grep", \&term_map_or_grep);
    Perlito5::Grammar::Precedence::add_term("sort", \&term_sort);
    1
}
;1
