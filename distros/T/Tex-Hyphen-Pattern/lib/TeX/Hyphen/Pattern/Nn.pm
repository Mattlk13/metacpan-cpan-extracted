## no critic qw(RequirePodSections)    # -*- cperl -*-
# This file is auto-generated by the Perl TeX::Hyphen::Pattern Suite hyphen
# pattern catalog generator. This code generator comes with the
# TeX::Hyphen::Pattern module distribution in the tools/ directory
#
# Do not edit this file directly.

package TeX::Hyphen::Pattern::Nn 0.100;
use strict;
use warnings;
use 5.014000;
use utf8;

use Moose;

my $pattern_file = q{};
while (<DATA>) {
    $pattern_file .= $_;
}

sub data {
    return $pattern_file;
}

sub version {
    return $TeX::Hyphen::Pattern::Nn::VERSION;
}

1;
## no critic qw(RequirePodAtEnd RequireASCII ProhibitFlagComments)

=encoding utf8

=head1 C<Nn> hyphenation pattern class

=head1 SUBROUTINES/METHODS

=over 4

=item $pattern-E<gt>data();

Returns the pattern data.

=item $pattern-E<gt>version();

Returns the version of the pattern package.

=back

=head1 Copyright

The copyright of the patterns is not covered by the copyright of this package
since this pattern is generated from the source at
L<svn://tug.org/texhyphen/trunk/hyph-utf8/tex/generic/hyph-utf8/patterns/tex/hyph-nn.tex>

The copyright of the source can be found in the DATA section in the source of
this package file.

=cut

__DATA__
% Adapted to the new pattern-loading scheme.
% Original file name was nnhyph.tex

% TeX hyphenation patterns for Norwegian Nynorsk
%
% Version 2007-02-10
%
% Copyright (C) 2007 Karl Ove Hufthammer.
% Copying and distribution of this file, with or without modification,
% are permitted in any medium without royalty, provided the copyright
% notice and this notice are preserved.
%
% This file contains hyphenation patterns for Norwegian Nynorsk.
% It uses the Norwegian hyphenation patterns from nohyphbx.tex,
% created by Rune Kleveland and Ole Michael Selberg. Please see
% that file for copyright information on those patterns.
%
% The patterns in nohyphbx are based on both Norwegian Bokmal
% and Norwegian Nynorsk, and works about equally well for both
% languages. This file, nnhyph.tex, contains only a few hyphenation
% exceptions, for words that needs to be hyphenated differently for
% the two languages.
%
% Please send bugs or suggestions to karl@huftis.org.
%

\input hyph-no.tex

\hyphenation{
att-en-de
bet-re
}


