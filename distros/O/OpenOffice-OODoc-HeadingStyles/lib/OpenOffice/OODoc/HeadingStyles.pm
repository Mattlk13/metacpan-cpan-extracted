package OpenOffice::OODoc::HeadingStyles;

use strict;
use warnings;

# ABSTRACT: utilities for manipulating OpenOffice::OODoc objects

our $VERSION = '0.04';

use OpenOffice::OODoc;

use List::Util 'max';
use Scalar::Util 'looks_like_number';


# patch the original OpenOffice::OODoc module and add these subroutines
#
*OpenOffice::OODoc::Styles::establishHeadingStyle =
    \&OpenOffice::OODoc::HeadingStyles::establishHeadingStyle;

*OpenOffice::OODoc::Styles::createHeadingStyle =
    \&OpenOffice::OODoc::HeadingStyles::createHeadingStyle;


# the tabel below comes from introspecting the xml generated by Libre Office,
# using the defaults, without touching any preferences or style settings.
#
# Libre Office for MacOS, Version: 6.0.4.2
#
# this tabel can be overwritten, see below in the POD
#
our $HEADING_DEFINITIONS = {
    'Heading 1' => {
        paragraph   => { top    => '0.1665in', bottom => '0.0835in' },
        text        => { size   =>     '130%', weight =>     'bold' },
    },
    'Heading 2' => {
        paragraph   => { top    => '0.1390in', bottom => '0.0835in' },
        text        => { size   =>     '115%', weight =>     'bold' },
    },
    'Heading 3' => {
        paragraph   => { top    => '0.0972in', bottom => '0.0835in' },
        text        => { size   =>     '101%', weight =>     'bold' },
    },
    'Heading 4' => {
        paragraph   => { top    => '0.0835in', bottom => '0.0835in' },
        text        => { size   =>      '95%', weight =>     'bold', style  =>   'italic' },
    },
    'Heading 5' => {
        paragraph   => { top    => '0.0835in', bottom => '0.0417in' },
        text        => { size   =>      '85%', weight =>     'bold' },
    },
    'Heading 6' => {
        paragraph   => { top    => '0.0417in', bottom => '0.0417in' },
        text        => { size   =>      '85%', weight =>     'bold', style  =>   'italic' },
    },
};


sub establishHeadingStyle {
    my $oodoc_styles     = shift; # $self
    my $level_param      = shift;
    my $style_definition = shift;

    my $level = looks_like_number $level_param ? int $level_param : 0;
    warn "Changed level '$level_param' to '$level'" unless $level eq $level_param;

    my $oodoc_style_name = "Heading_20_$level";

    return (
        $oodoc_styles->getStyleElement($oodoc_style_name)
        or $oodoc_styles->createHeadingStyle( $level, $style_definition )
    )
}



sub createHeadingStyle {
    my $oodoc_styles     = shift; # $self
    my $level_param      = shift;
    my $style_definition = shift;

    my $level = looks_like_number $level_param ? int $level_param : 0;
    warn "Changed level '$level_param' to '$level'" unless $level eq $level_param;

    my $oodoc_style_name = "Heading_20_$level";
    my $display_name     = "Heading $level";

    $style_definition //= $HEADING_DEFINITIONS->{$display_name};

    $oodoc_styles->createStyle( $oodoc_style_name =>
        'class'                        => 'text',
        'display-name'                 => $display_name,
        'family'                       => 'paragraph',
        'next'                         => 'Text_20_body',
        'parent'                       => 'Heading',
    );
    $oodoc_styles->updateStyle( $oodoc_style_name =>
        'properties' => { '-area' => $_,
            _propertiesFromStyleArea( $style_definition, $_ )
        }
    ) for qw /paragraph text/;

    return $oodoc_styles->getStyleElement($display_name)
}

# following 'pseudo attributes' were found when doing some reverse engineering
# and by examining some documents that had been created, without changing the
# styling.
use constant PROPERTIES_MAP => {
    paragraph => {
        top        => 'fo:margin-top',
        bottom     => 'fo:margin-bottom',
    },
    text      => {
        size       => 'fo:font-size',
        weight     => 'fo:font-weight',
        style      => 'fo:font-style',
        family     => 'fo:font-family',
        name       => 'style:font-name',
        font_style => 'style:font-style-name',
    },
};

# _propertiesFromStyle
#
# return a set of properties for a given 'area', mapped from simple format into
# horrible OpenOffice::OODoc xml attributes
#
sub _propertiesFromStyleArea {
    my $style_definition = shift;
    my $area  = shift;

    my %properties = map {
        PROPERTIES_MAP->{$area}{$_} => $style_definition->{$area}{$_}
    } keys %{ $style_definition->{$area} };
    return %properties
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

OpenOffice::OODoc::HeadingStyles - utilities for manipulating OpenOffice::OODoc objects

=head1 VERSION

version 0.04

=head1 DESCRIPTION

This module helps to create Heading Styles in L<OpenOffice::OODoc> documents.
Instead of blindly creating new styles at will, one can call
C<establishHeadingStyle> that will honour any exisiting style, but will create
a new one if needed.

=head1 METHODS

=head2 establishHeadingStyle

returns an OpenOffice::OODoc Heading Style Element for a given level

    my $level = 2;
    my $style_definition = {
        paragraph   => { top    => '0.1390in', bottom => '0.0835in' },
        text        => { size   =>     '115%', weight =>     'bold' },
    };
    my $heading_style = $oodoc_style
        ->establishHeadingStyle( $level, $style_definition );

If the style was not already present in the 'Styles' part of the document, it
will be created and added into the document.

The style-definition is an optional argument. If not provided, it will use what
is found in C<HEADING_DEFINITIONS> package HashRef. That is pre-populated with
the defaults from Libre Office.

See below.

A newly created heading style inherrits from the C<Heading> style and will apply
font settings like Libre Office does: relative C<font-size>, C<font-weight> and
C<font-style> and more.

CAVEAT: C<$level> will be treated turned into integer values. This means that if
it does not start with a number will be treated as "Heading 0" styles and
decimals will be truncated. See C<int>

=head2 createHeadingStyle

Creates a new Heading Style in the 'styles' part for a given level. It accepts
an optional style-definition HashRef like the above.

=head1 MORE...

=head2 Heading Style Definitions

This module does some convenience mapping between params and that what
L<OpenOffice::OODoc> internally uses in their xml. A heading style for this
module look like the following hash structure:

    paragraph => {
        top        => '9.9999in',
        bottom     => '9.9999mm',
    },
    text      => {
        size       => 'huge',
        weight     => 'super-heavy',
        style      => 'strike-through',
        family     => 'fantasy',
        name       => 'Noteworthy',
        font_style => 'Condensed',
    },

=over

=item top

the marging at the top of the heading, for example:'0.1665in'.

=item bottom

the margin at the bottom of the heading, for example '0.0835in'.

=item size

the relative size of the 'parent Heading' style, like: '130%'.

=item weight

the font weight of the heading style, for example 'bold'.

=item style

the font styling for the heading, like 'italics'.

=item name

the name of the font to use, note that not all fonts are portable

=item family

the main family it is part of, like 'sans' and 'serif'

item font_style

the font it's own style name, like 'narow'. 'light', or 'heavy'

=back

=head2 $$HEADING_DEFINITIONS

This variable should hold a HashRef to a list of Heading Style Definitions. The
keys should be C<Heading 1> through C<Heading 6> when dealing with HTML tags. In
Libre Office, there are 10 diferent styles.

You can set this HashRef so C<createHeadingStyle> has defaults to pick from if
not provided when calling that method.

=head1 AUTHOR

Theo van Hoessel

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2020 by Mintlab B.V.

This is free software, licensed under:

  The European Union Public License (EUPL) v1.1

=cut
