package Locale::TextDomain::OO::Extract::TT; ## no critic (TidyCode)

use strict;
use warnings;
use Carp qw(confess);
use Moo;
use MooX::Types::MooseLike::Base qw(ArrayRef Str);
use namespace::autoclean;

our $VERSION = '2.011';

extends qw(
    Locale::TextDomain::OO::Extract::Base::RegexBasedExtractor
);
with qw(
    Locale::TextDomain::OO::Extract::Role::File
);

has filter => (
    is      => 'rw',
    isa     => ArrayRef[Str],
    lazy    => 1,
    default => sub {[ 'all' ]},
);

sub _filtered_start_rule {
    my $self = shift;

    my %filter_of = map { $_ => 1 } @{ $self->filter };
    my $list_if = sub {
        my ( $key, @list ) = @_;
        my $condition
            = $filter_of{all} && ! $filter_of{"!$key"}
            || $filter_of{$key};
        return $condition ? @list : ();
    };
    my $with_bracket = join "\n| ", (
        $list_if->('Gettext',                           'N? __ n? p? x?'),
        $list_if->('Gettext::DomainAndCategory',        'N? __ d? c? n? p? x?'),
        $list_if->('Gettext::Loc',                      'N? loc_ n? p? x?'),
        $list_if->('Gettext::Loc::DomainAndCategory',   'N? loc_ d? c? n? p? x?'),
        $list_if->('BabelFish::Loc',                    'N? loc_b p?'),
        $list_if->('BabelFish::Loc::DomainAndCategory', 'N? loc_b d? c? p?'),
        $list_if->('Maketext',                          'l'),
    );
    $with_bracket ||= '(?!)';

    return qr{
        \b
        (?: $with_bracket ) \s* [(]
    }xms;
}

my $category_rule
    = my $context_rule
    = my $domain_rule
    = my $domain_or_category_rule
    = my $plural_rule
    = my $singular_rule
    = my $text_rule
    = [
        [
            # 'text with 0 .. n escaped chars'
            qr{
                \s* ( ['] )
                (
                    [^\\']*              # normal text
                    (?: \\ . [^\\']* )*  # maybe followed by escaped char and normal text
                )
                [']
            }xms,
        ],
        'or',
        [
            # "text with 0 .. n escaped chars"
            qr{
                \s* ( ["] )
                (
                    [^\\"]*              # normal text
                    (?: \\ . [^\\"]* )*  # maybe followed by escaped char and normal text
                )
                ["]
            }xms,
        ],
        'or',
        [
            # q{text with 0 .. n {placeholders} and/or 0 .. n escaped chars}
            ## no critic (EscapedMetacharacters)
            qr{
                \s* ( qq? \{ )        # q curly bracket quoted
                (
                    (?:
                        [^\{\}\\]     # normal text
                        | \\ .        # escaped char
                        | \{ (?-1) \} # any pairs of curly brackets with the same stuff inside
                    )*
                )
                \}                    # end of quote
            }xms,
            ## use critic (EscapedMetacharacters)
        ],
    ];
my $comma_rule = qr{ \s* [,] }xms;
my $count_rule = qr{ \s* ( [^,)]+ ) }xms;
my $close_rule = qr{ \s* [,]? \s* ( [^)]* ) [)] }xms;

my $rules = [
    # loc_, __
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( x? ) \s* [(] }xms,
        'and',
        $text_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( n x? ) \s* [(] }xms,
        'and',
        $singular_rule,
        'and',
        $comma_rule,
        'and',
        $plural_rule,
        'and',
        $comma_rule,
        'and',
        $count_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( p x? ) \s* [(] }xms,
        'and',
        $context_rule,
        'and',
        $comma_rule,
        'and',
        $text_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( np x? ) \s* [(] }xms,
        'and',
        $context_rule,
        'and',
        $comma_rule,
        'and',
        $singular_rule,
        'and',
        $comma_rule,
        'and',
        $plural_rule,
        'and',
        $comma_rule,
        'and',
        $count_rule,
        'and',
        $close_rule,
        'end',
    ],

    # loc_d, __d
    'or',
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( d x? ) \s* [(] }xms,
        'and',
        $domain_rule,
        'and',
        $comma_rule,
        'and',
        $text_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( dn x? ) \s* [(] }xms,
        'and',
        $domain_rule,
        'and',
        $comma_rule,
        'and',
        $singular_rule,
        'and',
        $comma_rule,
        'and',
        $plural_rule,
        'and',
        $comma_rule,
        'and',
        $count_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( dp x? ) \s* [(] }xms,
        'and',
        $domain_rule,
        'and',
        $comma_rule,
        'and',
        $context_rule,
        'and',
        $comma_rule,
        'and',
        $text_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( dnp x? ) \s* [(] }xms,
        'and',
        $domain_rule,
        'and',
        $comma_rule,
        'and',
        $context_rule,
        'and',
        $comma_rule,
        'and',
        $singular_rule,
        'and',
        $comma_rule,
        'and',
        $plural_rule,
        'and',
        $comma_rule,
        'and',
        $count_rule,
        'and',
        $close_rule,
        'end',
    ],

    # loc_c, __c
    'or',
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( c x? ) \s* [(] }xms,
        'and',
        $text_rule,
        'and',
        $comma_rule,
        'and',
        $category_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( cn x? ) \s* [(] }xms,
        'and',
        $singular_rule,
        'and',
        $comma_rule,
        'and',
        $plural_rule,
        'and',
        $comma_rule,
        'and',
        $count_rule,
        'and',
        $comma_rule,
        'and',
        $category_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( cp x? ) \s* [(] }xms,
        'and',
        $context_rule,
        'and',
        $comma_rule,
        'and',
        $text_rule,
        'and',
        $comma_rule,
        'and',
        $category_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( cnp x? ) \s* [(] }xms,
        'and',
        $context_rule,
        'and',
        $comma_rule,
        'and',
        $singular_rule,
        'and',
        $comma_rule,
        'and',
        $plural_rule,
        'and',
        $comma_rule,
        'and',
        $count_rule,
        'and',
        $comma_rule,
        'and',
        $category_rule,
        'and',
        $close_rule,
        'end',
    ],

    # loc_dc, __dc
    'or',
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( dc x? ) \s* [(] }xms,
        'and',
        $domain_rule,
        'and',
        $comma_rule,
        'and',
        $text_rule,
        'and',
        $comma_rule,
        'and',
        $category_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( dcn x? ) \s* [(] }xms,
        'and',
        $domain_rule,
        'and',
        $comma_rule,
        'and',
        $singular_rule,
        'and',
        $comma_rule,
        'and',
        $plural_rule,
        'and',
        $comma_rule,
        'and',
        $count_rule,
        'and',
        $comma_rule,
        'and',
        $category_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( dcp x? ) \s* [(] }xms,
        'and',
        $domain_rule,
        'and',
        $comma_rule,
        'and',
        $context_rule,
        'and',
        $comma_rule,
        'and',
        $text_rule,
        'and',
        $comma_rule,
        'and',
        $category_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? (?: loc_ | __ ) ( dcnp x? ) \s* [(] }xms,
        'and',
        $domain_rule,
        'and',
        $comma_rule,
        'and',
        $context_rule,
        'and',
        $comma_rule,
        'and',
        $singular_rule,
        'and',
        $comma_rule,
        'and',
        $plural_rule,
        'and',
        $comma_rule,
        'and',
        $count_rule,
        'and',
        $comma_rule,
        'and',
        $category_rule,
        'and',
        $close_rule,
        'end',
    ],

    # loc_b... (BabelFish)
    'or',
    [
        'begin',
        qr{ \b N? loc_b () \s* [(] }xms,
        'and',
        $text_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? loc_b ( p ) \s* [(] }xms,
        'and',
        $context_rule,
        'and',
        $comma_rule,
        'and',
        $text_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? loc_b ( d ) \s* [(] }xms,
        'and',
        $domain_rule,
        'and',
        $comma_rule,
        'and',
        $text_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? loc_b ( dp ) \s* [(] }xms,
        'and',
        $domain_rule,
        'and',
        $comma_rule,
        'and',
        $context_rule,
        'and',
        $comma_rule,
        'and',
        $text_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? loc_b ( c ) \s* [(] }xms,
        'and',
        $text_rule,
        'and',
        $comma_rule,
        'and',
        $category_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? loc_b ( cp ) \s* [(] }xms,
        'and',
        $context_rule,
        'and',
        $comma_rule,
        'and',
        $text_rule,
        'and',
        $comma_rule,
        'and',
        $category_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? loc_b ( dc ) \s* [(] }xms,
        'and',
        $domain_rule,
        'and',
        $comma_rule,
        'and',
        $text_rule,
        'and',
        $comma_rule,
        'and',
        $category_rule,
        'and',
        $close_rule,
        'end',
    ],
    'or',
    [
        'begin',
        qr{ \b N? loc_b ( dcp ) \s* [(] }xms,
        $domain_rule,
        'and',
        $comma_rule,
        'and',
        $context_rule,
        'and',
        $comma_rule,
        'and',
        $text_rule,
        'and',
        $comma_rule,
        'and',
        $category_rule,
        'and',
        $close_rule,
        'end',
    ],

    # l (Maketext)
    'or',
    [
        'begin',
        qr{ \b l () \s* [(] }xms,
        'and',
        $text_rule,
        'and',
        $close_rule,
        'end',
    ]
];

# handle different newlines
sub preprocess {
    my $self = shift;

    my $content_ref = $self->content_ref;

    ${$content_ref} =~ s{ \r? \n }{\n}xmsg;

    # replace heredoc's without killing the line number
    # <<'...'
    REPLACE: {
        ${$content_ref} =~ s{
            << \s* ' ( \w+ ) ' ( [^\n]* ) \n
            ( .*? )
            ^ \1 $
        }
        {
            qq{\n'}
            . do { my $text = $3; $text =~ s{'}{\\'}xmsg; $text }
            . q{'}
            . $2
        }xmsge and redo REPLACE;
    }
    # <<...
    # <<"..."
    REPLACE: {
        ${$content_ref} =~ s{
            << \s* ( ["]? ) ( \w+ ) \1 ( [^\n]* ) \n
            ( .*? )
            ^ \2 $
        }
        {
            qq{\n"}
            . do { my $text = $4; $text =~ s{"}{\\"}xmsg; $text }
            . q{"}
            . $3
        }xmsge and redo REPLACE;
    }

    return $self;
}

sub interpolate_escape_sequence {
    my ( undef, $string, $quot ) = @_;

    # nothing to interpolate
    defined $string
        or return $string;
    defined $quot
        or confess 'Quote expected';

    my $is_interpolate = $quot eq q{"} || $quot eq 'qq{';
    if ( ! $is_interpolate ) {
        # '...'
        if ( $quot eq q{'} ) {
            $string =~ s{ \\ ( ['] ) }{$1}xmsg;
            return $string;
        }
        # q{...}
        if ( $quot eq 'q{' ) {
            $string =~ s{ \\ ( [\{\}] ) }{$1}xmsg; ## no critic (EscapedMetacharacters)
            return $string;
        }
        confess "Unknown quot $quot";
    }

    # "..."
    # qq{...}
    my %char_of = (
        b => "\b",
        f => "\f",
        n => "\n",
        r => "\r",
        t => "\t",
    );
    $string =~ s{
        \\
        (?:
            ( [bfnrt] ) # Backspace
                        # Form feed
                        # New line
                        # Carriage return
                        # Horizontal tab
            | ( [xN] )  # do not handle \x.., \x{...}, \N{...}
            | (.)       # Backslash itself
                        # Single quotation mark
                        # Double quotation mark
                        # anything else that needs no escape
        )
    }{
        $1   ? $char_of{$1}
        : $2 ? "\\$2"
        :      $3
    }xmsge;

    return $string;
}

sub stack_item_mapping {
    my $self = shift;

    my $match = $_->{match};
    # The chars e.g. after loc_ were stored to make a decision now.
    my $extra_parameter = shift @{$match};
    @{$match}
        or return;

    my $count;
    $self->add_message({
        reference    => ( sprintf '%s:%s', $self->filename, $_->{line_number} ),
        domain       => $extra_parameter =~ m{ d }xms
            ? scalar $self->interpolate_escape_sequence(
                reverse splice @{$match}, 0, 2
            )
            : $self->domain,
        msgctxt      => $extra_parameter =~ m{ p }xms
            ? scalar $self->interpolate_escape_sequence(
                reverse splice @{$match}, 0, 2
            )
            : undef,
        msgid        => scalar $self->interpolate_escape_sequence(
            reverse splice @{$match}, 0, 2
        ),
        msgid_plural => $extra_parameter =~ m{ n }xms
            ? do {
                my $plural = $self->interpolate_escape_sequence(
                    reverse splice @{$match}, 0, 2
                );
                $count = shift @{$match};
                $plural;
            }
            : undef,
        category     => $extra_parameter =~ m{ c }xms
            ? scalar $self->interpolate_escape_sequence(
                reverse splice @{$match}, 0, 2
            )
            : $self->category,
        automatic    => do {
            my $placeholders = shift @{$match};
            my $string = join ', ', map { ## no critic (MutatingListFunctions)
                defined $_
                ? do {
                    s{ \s+ }{ }xmsg;
                    s{ \s+ \z }{}xms;
                    length $_ ? $_ : ();
                }
                : ();
            } ( $count, $placeholders );
            $string =~ s{ \A ( .{70} ) .+ \z }{$1 ...}xms;
            $string;
        },
    });

    return;
}

sub extract {
    my $self = shift;

    $self->start_rule( $self->_filtered_start_rule );
    $self->rules($rules);
    $self->preprocess;
    $self->SUPER::extract;
    for ( @{ $self->stack } ) {
        $self->stack_item_mapping;
    }

    return $self;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME
Locale::TextDomain::OO::Extract::TT
- Extracts internationalization data from TemplateToolkit code

$Id: TT.pm 693 2017-09-02 09:20:30Z steffenw $

$HeadURL: svn+ssh://steffenw@svn.code.sf.net/p/perl-gettext-oo/code/extract/trunk/lib/Locale/TextDomain/OO/Extract/TT.pm $

=head1 VERSION

2.011

=head1 DESCRIPTION

This module extracts internationalization data from Template code.

Implemented rules:

 # Gettext::Loc
 loc_('...
 loc_x('...
 loc_n('...
 loc_nx('...
 loc_p('...
 loc_px('...
 loc_np('...
 loc_npx('...

 # Gettext::Loc::DomainAndCategory
 loc_d('...
 loc_dx('...
 loc_dn('...
 loc_dnx('...
 loc_dp('...
 loc_dpx('...
 loc_dnp('...
 loc_dnpx('...

 loc_c('...
 loc_cx('...
 loc_cn('...
 loc_cnx('...
 loc_cp('...
 loc_cpx('...
 loc_cnp('...
 loc_cnpx('...

 loc_dc('...
 loc_dcx('...
 loc_dcn('...
 loc_dcnx('...
 loc_dcp('...
 loc_dcpx('...
 loc_dcnp('...
 loc_dcnpx('...

 # Gettext
 __('...
 __x('...
 __n('...
 __nx('...
 __p('...
 __px('...
 __np('...
 __npx('...

 # Gettext::DomainAndCategory
 __d('...
 __dx('...
 __dn('...
 __dnx('...
 __dp('...
 __dpx('...
 __dnp('...
 __dnpx('...

 __c('...
 __cx('...
 __cn('...
 __cnx('...
 __cp('...
 __cpx('...
 __cnp('...
 __cnpx('...

 __dc('...
 __dcx('...
 __dcn('...
 __dcnx('...
 __dcp('...
 __dcpx('...
 __dcnp('...
 __dcnpx('...

 # BabelFish
 loc_b('...
 loc_bp('...

 # BabelFish::DomainAndCategory
 loc_bd('...
 loc_bdp('...

 loc_bc('...
 loc_bcp('...

 loc_bdc('...
 loc_bdcp('...

 # Maketext
 l('...

N before loc..., __... and maketext... is allowed. E.g. Nloc_ and so on.
Whitespace is allowed everywhere.
Quote and escape any text like: ' text {placeholder} \\ \' ' or q{ text {placeholder} \\ \} \{ }

=head1 SYNOPSIS

    use Locale::TextDomain::OO::Extract::TT;
    use Path::Tiny qw(path);

    my $extractor = Locale::TextDomain::OO::Extract::TT->new(
        # optional filter parameter, the default is ['all'],
        # the following means:
        # extract for all plugins but not for Plugin
        # Locale::TextDomain::OO::Plugin::Maketext
        filter => [ qw(
            all
            !Maketext
        ) ],
    );
    for ( @files ) {
        $extractor->clear;
        $extractor->filename($_);            # dir/filename for reference
        $extractor->content_ref( \( path($_)->slurp_utf8 ) );
        $extractor->project('my project');   # set or default undef is used
        $extractor->category('LC_MESSAGES'); # set or default q{} is used
        $extractor->domain('my domain');     # set or default q{} is used
        $extractor->extract;
    }
    ... = $extractor->lexicon_ref;

=head1 SUBROUTINES/METHODS

=head2 method new

All parameters are optional.
See Locale::TextDomain::OO::Extract to replace the defaults.

    my $extractor = Locale::TextDomain::OO::Extract::TT->new;

=head2 method filter

Ignore some of 'all' or define what to scan.
See SYNOPSIS and DESCRIPTION for how and what.

    my $array_ref = $extractor->filter;

    $extractor->filter(['all']); # the default

=head2 method preprocess (called by method extract)

This method removes the POD and all after __END__.

    $extractor->preprocess;

=head2 method interpolate_escape_sequence (called by method extract)

This method helps e.g. \n to be a real newline in string.

    $string = $extractor->interpolate_escape_sequence($string, $quot);

=head2 method stack_item_mapping (called by method extract)

This method maps the matched stuff as lexicon item.

    $extractor->stack_item_mapping;

=head2 method extract

This method runs the extraction.

    $extractor->extract;

=head1 EXAMPLE

Inside of this distribution is a directory named example.
Run this *.pl files.

=head1 DIAGNOSTICS

none

=head1 CONFIGURATION AND ENVIRONMENT

none

=head1 DEPENDENCIES

L<Carp|Carp>

L<Moo|Moo>

L<MooX::Types::MooseLike::Base|MooX::Types::MooseLike::Base>

L<namespace::autoclean|namespace::autoclean>

L<Locale::TextDomain::OO::Extract::Base::RegexBasedExtractor|Locale::TextDomain::OO::Extract::Base::RegexBasedExtractor>

L<Locale::TextDomain::OO::Extract::Role::File|Locale::TextDomain::OO::Extract::Role::File>

=head1 INCOMPATIBILITIES

not known

=head1 BUGS AND LIMITATIONS

none

=head1 SEE ALSO

L<Locale::TextDoamin::OO|Locale::TextDoamin::OO>

L<Template|Template>

=head1 AUTHOR

Steffen Winkler

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2009 - 2017,
Steffen Winkler
C<< <steffenw at cpan.org> >>.
All rights reserved.

This module is free software;
you can redistribute it and/or modify it
under the same terms as Perl itself.
