package Chart::Plotly::Trace::Scattermapbox::Marker;
use Moose;
use MooseX::ExtraArgs;
use Moose::Util::TypeConstraints qw(enum union);
if ( !defined Moose::Util::TypeConstraints::find_type_constraint('PDL') ) {
    Moose::Util::TypeConstraints::type('PDL');
}

use Chart::Plotly::Trace::Scattermapbox::Marker::Colorbar;

our $VERSION = '0.017';    # VERSION

# ABSTRACT: This attribute is one of the possible options for the trace scattermapbox.

sub TO_JSON {
    my $self       = shift;
    my $extra_args = $self->extra_args // {};
    my $meta       = $self->meta;
    my %hash       = %$self;
    for my $name ( sort keys %hash ) {
        my $attr = $meta->get_attribute($name);
        if ( defined $attr ) {
            my $value = $hash{$name};
            my $type  = $attr->type_constraint;
            if ( $type && $type->equals('Bool') ) {
                $hash{$name} = $value ? \1 : \0;
            }
        }
    }
    %hash = ( %hash, %$extra_args );
    delete $hash{'extra_args'};
    if ( $self->can('type') && ( !defined $hash{'type'} ) ) {
        $hash{type} = $self->type();
    }
    return \%hash;
}

has autocolorscale => (
    is  => "rw",
    isa => "Bool",
    documentation =>
      "Has an effect only if `marker.color` is set to a numerical array. Determines whether the colorscale is a default palette (`autocolorscale: true`) or the palette determined by `marker.colorscale`. In case `colorscale` is unspecified or `autocolorscale` is true, the default  palette will be chosen according to whether numbers in the `color` array are all positive, all negative or mixed.",
);

has cauto => (
    is  => "rw",
    isa => "Bool",
    documentation =>
      "Has an effect only if `marker.color` is set to a numerical array and `cmin`, `cmax` are set by the user. In this case, it controls whether the range of colors in `colorscale` is mapped to the range of values in the `color` array (`cauto: true`), or the `cmin`/`cmax` values (`cauto: false`). Defaults to `false` when `cmin`, `cmax` are set by the user.",
);

has cmax => (
    is  => "rw",
    isa => "Num",
    documentation =>
      "Has an effect only if `marker.color` is set to a numerical array. Sets the upper bound of the color domain. Value should be associated to the `marker.color` array index, and if set, `marker.cmin` must be set as well.",
);

has cmin => (
    is  => "rw",
    isa => "Num",
    documentation =>
      "Has an effect only if `marker.color` is set to a numerical array. Sets the lower bound of the color domain. Value should be associated to the `marker.color` array index, and if set, `marker.cmax` must be set as well.",
);

has color => (
    is  => "rw",
    isa => "Maybe[ArrayRef]",
    documentation =>
      "Sets the marker color. It accepts either a specific color or an array of numbers that are mapped to the colorscale relative to the max and min values of the array or relative to `cmin` and `cmax` if set.",
);

has colorbar => ( is  => "rw",
                  isa => "Maybe[HashRef]|Chart::Plotly::Trace::Scattermapbox::Marker::Colorbar", );

has colorscale => (
    is => "rw",
    documentation =>
      "Sets the colorscale and only has an effect if `marker.color` is set to a numerical array. The colorscale must be an array containing arrays mapping a normalized value to an rgb, rgba, hex, hsl, hsv, or named color string. At minimum, a mapping for the lowest (0) and highest (1) values are required. For example, `[[0, 'rgb(0,0,255)', [1, 'rgb(255,0,0)']]`. To control the bounds of the colorscale in color space, use `marker.cmin` and `marker.cmax`. Alternatively, `colorscale` may be a palette name string of the following list: Greys, YlGnBu, Greens, YlOrRd, Bluered, RdBu, Reds, Blues, Picnic, Rainbow, Portland, Jet, Hot, Blackbody, Earth, Electric, Viridis, Cividis",
);

has colorsrc => ( is            => "rw",
                  isa           => "Str",
                  documentation => "Sets the source reference on plot.ly for  color .",
);

has opacity => ( is            => "rw",
                 isa           => "Num|ArrayRef[Num]",
                 documentation => "Sets the marker opacity.",
);

has opacitysrc => ( is            => "rw",
                    isa           => "Str",
                    documentation => "Sets the source reference on plot.ly for  opacity .",
);

has reversescale => (
    is  => "rw",
    isa => "Bool",
    documentation =>
      "Has an effect only if `marker.color` is set to a numerical array. Reverses the color mapping if true (`cmin` will correspond to the last color in the array and `cmax` will correspond to the first color).",
);

has showscale => (
    is  => "rw",
    isa => "Bool",
    documentation =>
      "Has an effect only if `marker.color` is set to a numerical array. Determines whether or not a colorbar is displayed.",
);

has size => ( is            => "rw",
              isa           => "Num|ArrayRef[Num]",
              documentation => "Sets the marker size (in px).",
);

has sizemin => (
    is  => "rw",
    isa => "Num",
    documentation =>
      "Has an effect only if `marker.size` is set to a numerical array. Sets the minimum size (in px) of the rendered marker points.",
);

has sizemode => (
    is  => "rw",
    isa => enum( [ "diameter", "area" ] ),
    documentation =>
      "Has an effect only if `marker.size` is set to a numerical array. Sets the rule for which the data in `size` is converted to pixels.",
);

has sizeref => (
    is  => "rw",
    isa => "Num",
    documentation =>
      "Has an effect only if `marker.size` is set to a numerical array. Sets the scale factor used to determine the rendered size of marker points. Use with `sizemin` and `sizemode`.",
);

has sizesrc => ( is            => "rw",
                 isa           => "Str",
                 documentation => "Sets the source reference on plot.ly for  size .",
);

has symbol => (
    is  => "rw",
    isa => "Str|ArrayRef[Str]",
    documentation =>
      "Sets the marker symbol. Full list: https://www.mapbox.com/maki-icons/ Note that the array `marker.color` and `marker.size` are only available for *circle* symbols.",
);

has symbolsrc => ( is            => "rw",
                   isa           => "Str",
                   documentation => "Sets the source reference on plot.ly for  symbol .",
);

__PACKAGE__->meta->make_immutable();
1;

__END__

=pod

=encoding utf-8

=head1 NAME

Chart::Plotly::Trace::Scattermapbox::Marker - This attribute is one of the possible options for the trace scattermapbox.

=head1 VERSION

version 0.017

=head1 SYNOPSIS

 use Chart::Plotly;
 use Chart::Plotly::Plot;
 use Chart::Plotly::Trace::Scattermapbox;
 use Chart::Plotly::Trace::Scattermapbox::Marker;
 my $mapbox_access_token =
   'Insert your access token here';
 my $scattermapbox = Chart::Plotly::Trace::Scattermapbox->new(
                 mode => 'markers',
                 text => [ "The coffee bar",
                           "Bistro Bohem", "Black Cat", "Snap", "Columbia Heights Coffee",
                           "Azi's Cafe", "Blind Dog Cafe",
                           "Le Caprice", "Filter", "Peregrine", "Tryst", "The Coupe", "Big Bear Cafe"
                 ],
                 lon => [ '-77.02827', '-77.02013', '-77.03155', '-77.04227', '-77.02854',  '-77.02419',
                          '-77.02518', '-77.03304', '-77.04509', '-76.99656', '-77.042438', '-77.02821',
                          '-77.01239'
                 ],
                 lat => [ '38.91427', '38.91538', '38.91458', '38.92239', '38.93222', '38.90842', '38.91931', '38.93260',
                          '38.91368', '38.88516', '38.921894', '38.93206', '38.91275'
                 ],
                 marker => Chart::Plotly::Trace::Scattermapbox::Marker->new( size => 9 ),
 );
 my $plot = Chart::Plotly::Plot->new( traces => [$scattermapbox],
                                      layout => { autosize  => 'True',
                                                  hovermode => 'closest',
                                                  mapbox    => {
                                                              accesstoken => $mapbox_access_token,
                                                              bearing     => 0,
                                                              center      => {
                                                                          lat => 38.92,
                                                                          lon => -77.07
                                                              },
                                                              pitch => 0,
                                                              zoom  => 10
                                                  }
                                      }
 );
 Chart::Plotly::show_plot($plot);

=head1 DESCRIPTION

This attribute is part of the possible options for the trace scattermapbox.

This file has been autogenerated from the official plotly.js source.

If you like Plotly, please support them: L<https://plot.ly/> 
Open source announcement: L<https://plot.ly/javascript/open-source-announcement/>

Full reference: L<https://plot.ly/javascript/reference/#scattermapbox>

=head1 DISCLAIMER

This is an unofficial Plotly Perl module. Currently I'm not affiliated in any way with Plotly. 
But I think plotly.js is a great library and I want to use it with perl.

=head1 METHODS

=head2 TO_JSON

Serialize the trace to JSON. This method should be called only by L<JSON> serializer.

=head1 ATTRIBUTES

=over

=item * autocolorscale

Has an effect only if `marker.color` is set to a numerical array. Determines whether the colorscale is a default palette (`autocolorscale: true`) or the palette determined by `marker.colorscale`. In case `colorscale` is unspecified or `autocolorscale` is true, the default  palette will be chosen according to whether numbers in the `color` array are all positive, all negative or mixed.

=item * cauto

Has an effect only if `marker.color` is set to a numerical array and `cmin`, `cmax` are set by the user. In this case, it controls whether the range of colors in `colorscale` is mapped to the range of values in the `color` array (`cauto: true`), or the `cmin`/`cmax` values (`cauto: false`). Defaults to `false` when `cmin`, `cmax` are set by the user.

=item * cmax

Has an effect only if `marker.color` is set to a numerical array. Sets the upper bound of the color domain. Value should be associated to the `marker.color` array index, and if set, `marker.cmin` must be set as well.

=item * cmin

Has an effect only if `marker.color` is set to a numerical array. Sets the lower bound of the color domain. Value should be associated to the `marker.color` array index, and if set, `marker.cmax` must be set as well.

=item * color

Sets the marker color. It accepts either a specific color or an array of numbers that are mapped to the colorscale relative to the max and min values of the array or relative to `cmin` and `cmax` if set.

=item * colorbar

=item * colorscale

Sets the colorscale and only has an effect if `marker.color` is set to a numerical array. The colorscale must be an array containing arrays mapping a normalized value to an rgb, rgba, hex, hsl, hsv, or named color string. At minimum, a mapping for the lowest (0) and highest (1) values are required. For example, `[[0, 'rgb(0,0,255)', [1, 'rgb(255,0,0)']]`. To control the bounds of the colorscale in color space, use `marker.cmin` and `marker.cmax`. Alternatively, `colorscale` may be a palette name string of the following list: Greys, YlGnBu, Greens, YlOrRd, Bluered, RdBu, Reds, Blues, Picnic, Rainbow, Portland, Jet, Hot, Blackbody, Earth, Electric, Viridis, Cividis

=item * colorsrc

Sets the source reference on plot.ly for  color .

=item * opacity

Sets the marker opacity.

=item * opacitysrc

Sets the source reference on plot.ly for  opacity .

=item * reversescale

Has an effect only if `marker.color` is set to a numerical array. Reverses the color mapping if true (`cmin` will correspond to the last color in the array and `cmax` will correspond to the first color).

=item * showscale

Has an effect only if `marker.color` is set to a numerical array. Determines whether or not a colorbar is displayed.

=item * size

Sets the marker size (in px).

=item * sizemin

Has an effect only if `marker.size` is set to a numerical array. Sets the minimum size (in px) of the rendered marker points.

=item * sizemode

Has an effect only if `marker.size` is set to a numerical array. Sets the rule for which the data in `size` is converted to pixels.

=item * sizeref

Has an effect only if `marker.size` is set to a numerical array. Sets the scale factor used to determine the rendered size of marker points. Use with `sizemin` and `sizemode`.

=item * sizesrc

Sets the source reference on plot.ly for  size .

=item * symbol

Sets the marker symbol. Full list: https://www.mapbox.com/maki-icons/ Note that the array `marker.color` and `marker.size` are only available for *circle* symbols.

=item * symbolsrc

Sets the source reference on plot.ly for  symbol .

=back

=head1 AUTHOR

Pablo Rodríguez González <pablo.rodriguez.gonzalez@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2017 by Pablo Rodríguez González.

This is free software, licensed under:

  The MIT (X11) License

=cut
