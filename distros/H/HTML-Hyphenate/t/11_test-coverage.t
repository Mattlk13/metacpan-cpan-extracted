use strict;
use warnings;
use utf8;

use Test::More;
# We need this otherwise testcover doesn't pick things up:
use HTML::Hyphenate;

sub cover {
    my $obj = HTML::Hyphenate->new();
    $obj->html(q{<p>hyphenated hyphenation</p>});
    $obj->style(q{german});
    $obj->min_length(10);
    $obj->min_pre(2);
    $obj->min_post(2);
    $obj->default_lang(q{en_US});
    $obj->default_included(1);
    $obj->classes_included([qw(foo bar)]);
    $obj->classes_excluded([qw(baz qu)]);
    my $tex = TeX::Hyphen->new();
    $obj->register_tex_hyphen();
    $obj->register_tex_hyphen('en_US');
    $obj->register_tex_hyphen('en_US', $tex);
    $obj->register_tex_hyphen('en_US', $obj);
    $obj->hyphenated();
    $obj->html();
    $obj->hyphenated(q{<p>Directly passed to hyphenated method</p>});
    $obj->meta();
}

use TeX::Hyphen;
if ( !eval { require Test::TestCoverage; 1 } ) {
	plan skip_all => q{Test::TestCoverage required for testing test coverage};
}
plan tests => 1;
Test::TestCoverage::test_coverage('HTML::Hyphenate');
cover();
Test::TestCoverage::ok_test_coverage('HTML::Hyphenate');
