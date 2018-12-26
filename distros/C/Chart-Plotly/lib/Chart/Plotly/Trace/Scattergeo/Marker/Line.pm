package Chart::Plotly::Trace::Scattergeo::Marker::Line;
use Moose;
use MooseX::ExtraArgs;
use Moose::Util::TypeConstraints qw(enum union);
if ( !defined Moose::Util::TypeConstraints::find_type_constraint('PDL') ) {
    Moose::Util::TypeConstraints::type('PDL');
}

our $VERSION = '0.021';    # VERSION

# ABSTRACT: This attribute is one of the possible options for the trace scattergeo.

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
      "Determines whether the colorscale is a default palette (`autocolorscale: true`) or the palette determined by `marker.line.colorscale`. Has an effect only if in `marker.line.color`is set to a numerical array. In case `colorscale` is unspecified or `autocolorscale` is true, the default  palette will be chosen according to whether numbers in the `color` array are all positive, all negative or mixed.",
);

has cauto => (
    is  => "rw",
    isa => "Bool",
    documentation =>
      "Determines whether or not the color domain is computed with respect to the input data (here in `marker.line.color`) or the bounds set in `marker.line.cmin` and `marker.line.cmax`  Has an effect only if in `marker.line.color`is set to a numerical array. Defaults to `false` when `marker.line.cmin` and `marker.line.cmax` are set by the user.",
);

has cmax => (
    is  => "rw",
    isa => "Num",
    documentation =>
      "Sets the upper bound of the color domain. Has an effect only if in `marker.line.color`is set to a numerical array. Value should have the same units as in `marker.line.color` and if set, `marker.line.cmin` must be set as well.",
);

has cmin => (
    is  => "rw",
    isa => "Num",
    documentation =>
      "Sets the lower bound of the color domain. Has an effect only if in `marker.line.color`is set to a numerical array. Value should have the same units as in `marker.line.color` and if set, `marker.line.cmax` must be set as well.",
);

has color => (
    is  => "rw",
    isa => "Maybe[ArrayRef]",
    documentation =>
      "Sets themarker.linecolor. It accepts either a specific color or an array of numbers that are mapped to the colorscale relative to the max and min values of the array or relative to `marker.line.cmin` and `marker.line.cmax` if set.",
);

has colorscale => (
    is => "rw",
    documentation =>
      "Sets the colorscale. Has an effect only if in `marker.line.color`is set to a numerical array. The colorscale must be an array containing arrays mapping a normalized value to an rgb, rgba, hex, hsl, hsv, or named color string. At minimum, a mapping for the lowest (0) and highest (1) values are required. For example, `[[0, 'rgb(0,0,255)', [1, 'rgb(255,0,0)']]`. To control the bounds of the colorscale in color space, use`marker.line.cmin` and `marker.line.cmax`. Alternatively, `colorscale` may be a palette name string of the following list: Greys,YlGnBu,Greens,YlOrRd,Bluered,RdBu,Reds,Blues,Picnic,Rainbow,Portland,Jet,Hot,Blackbody,Earth,Electric,Viridis,Cividis.",
);

has colorsrc => ( is            => "rw",
                  isa           => "Str",
                  documentation => "Sets the source reference on plot.ly for  color .",
);

has reversescale => (
    is  => "rw",
    isa => "Bool",
    documentation =>
      "Reverses the color mapping if true. Has an effect only if in `marker.line.color`is set to a numerical array. If true, `marker.line.cmin` will correspond to the last color in the array and `marker.line.cmax` will correspond to the first color.",
);

has width => ( is            => "rw",
               isa           => "Num|ArrayRef[Num]",
               documentation => "Sets the width (in px) of the lines bounding the marker points.",
);

has widthsrc => ( is            => "rw",
                  isa           => "Str",
                  documentation => "Sets the source reference on plot.ly for  width .",
);

__PACKAGE__->meta->make_immutable();
1;

__END__

=pod

=encoding utf-8

=head1 NAME

Chart::Plotly::Trace::Scattergeo::Marker::Line - This attribute is one of the possible options for the trace scattergeo.

=head1 VERSION

version 0.021

=head1 SYNOPSIS

 use Chart::Plotly;
 use Chart::Plotly::Plot;
 use Chart::Plotly::Trace::Scattergeo;
 use Chart::Plotly::Trace::Scattergeo::Marker;
 my $scattergeo = Chart::Plotly::Trace::Scattergeo->new(
     mode => 'markers+text',
     text => [ 'Mount Everest', 'K2',      'Kangchenjunga', 'Lhotse', 'Makalu', 'Cho Oyu',
               'Dhaulagiri I',  'Manaslu', 'Nanga Parbat',  'Annapurna I'
     ],
     lon => [ 86.9252777778, 76.5133333333, 88.1475,       86.9330555556, 87.0888888889, 86.6608333333,
              83.4930555556, 84.5597222222, 74.5891666667, 83.8202777778
     ],
     lat => [ 27.9880555556, 35.8813888889, 27.7033333333, 27.9616666667, 27.8897222222, 28.0941666667,
              28.6966666667, 28.55,         35.2372222222, 28.5955555556
     ],
     name => "Highest mountains
         https://en.wikipedia.org/wiki/List_of_highest_mountains_on_Earth",
     textposition => [ 'top right',
                       'top center',
                       'bottom center',
                       'bottom left',
                       'right',
                       'left',
                       'left',
                       'right',
                       'bottom center',
                       'top center'
     ],
     marker => Chart::Plotly::Trace::Scattergeo::Marker->new(
                                                    size  => 7,
                                                    color => [
                                                        '#bebada', '#fdb462', '#fb8072', '#d9d9d9', '#bc80bd', '#b3de69',
                                                        '#8dd3c7', '#80b1d3', '#fccde5', '#ffffb3'
                                                    ]
     )
 );
 
 my $plot = Chart::Plotly::Plot->new( traces => [$scattergeo],
                                      layout => { title => 'Mountains',
                                                  geo   => { scope => 'asia', }
                                      }
 );
 Chart::Plotly::show_plot($plot);

=head1 DESCRIPTION

This attribute is part of the possible options for the trace scattergeo.

This file has been autogenerated from the official plotly.js source.

If you like Plotly, please support them: L<https://plot.ly/> 
Open source announcement: L<https://plot.ly/javascript/open-source-announcement/>

Full reference: L<https://plot.ly/javascript/reference/#scattergeo>

=head1 DISCLAIMER

This is an unofficial Plotly Perl module. Currently I'm not affiliated in any way with Plotly. 
But I think plotly.js is a great library and I want to use it with perl.

=head1 METHODS

=head2 TO_JSON

Serialize the trace to JSON. This method should be called only by L<JSON> serializer.

=head1 ATTRIBUTES

=over

=item * autocolorscale

Determines whether the colorscale is a default palette (`autocolorscale: true`) or the palette determined by `marker.line.colorscale`. Has an effect only if in `marker.line.color`is set to a numerical array. In case `colorscale` is unspecified or `autocolorscale` is true, the default  palette will be chosen according to whether numbers in the `color` array are all positive, all negative or mixed.

=item * cauto

Determines whether or not the color domain is computed with respect to the input data (here in `marker.line.color`) or the bounds set in `marker.line.cmin` and `marker.line.cmax`  Has an effect only if in `marker.line.color`is set to a numerical array. Defaults to `false` when `marker.line.cmin` and `marker.line.cmax` are set by the user.

=item * cmax

Sets the upper bound of the color domain. Has an effect only if in `marker.line.color`is set to a numerical array. Value should have the same units as in `marker.line.color` and if set, `marker.line.cmin` must be set as well.

=item * cmin

Sets the lower bound of the color domain. Has an effect only if in `marker.line.color`is set to a numerical array. Value should have the same units as in `marker.line.color` and if set, `marker.line.cmax` must be set as well.

=item * color

Sets themarker.linecolor. It accepts either a specific color or an array of numbers that are mapped to the colorscale relative to the max and min values of the array or relative to `marker.line.cmin` and `marker.line.cmax` if set.

=item * colorscale

Sets the colorscale. Has an effect only if in `marker.line.color`is set to a numerical array. The colorscale must be an array containing arrays mapping a normalized value to an rgb, rgba, hex, hsl, hsv, or named color string. At minimum, a mapping for the lowest (0) and highest (1) values are required. For example, `[[0, 'rgb(0,0,255)', [1, 'rgb(255,0,0)']]`. To control the bounds of the colorscale in color space, use`marker.line.cmin` and `marker.line.cmax`. Alternatively, `colorscale` may be a palette name string of the following list: Greys,YlGnBu,Greens,YlOrRd,Bluered,RdBu,Reds,Blues,Picnic,Rainbow,Portland,Jet,Hot,Blackbody,Earth,Electric,Viridis,Cividis.

=item * colorsrc

Sets the source reference on plot.ly for  color .

=item * reversescale

Reverses the color mapping if true. Has an effect only if in `marker.line.color`is set to a numerical array. If true, `marker.line.cmin` will correspond to the last color in the array and `marker.line.cmax` will correspond to the first color.

=item * width

Sets the width (in px) of the lines bounding the marker points.

=item * widthsrc

Sets the source reference on plot.ly for  width .

=back

=head1 AUTHOR

Pablo Rodríguez González <pablo.rodriguez.gonzalez@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Pablo Rodríguez González.

This is free software, licensed under:

  The MIT (X11) License

=cut
