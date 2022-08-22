package Chart::Plotly::Trace::Funnel::Marker::Line;
use Moose;
use MooseX::ExtraArgs;
use Moose::Util::TypeConstraints qw(enum union);
if ( !defined Moose::Util::TypeConstraints::find_type_constraint('PDL') ) {
    Moose::Util::TypeConstraints::type('PDL');
}

our $VERSION = '0.042';    # VERSION

# ABSTRACT: This attribute is one of the possible options for the trace funnel.

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
    is            => "rw",
    isa           => "Bool",
    documentation =>
      "Determines whether the colorscale is a default palette (`autocolorscale: true`) or the palette determined by `marker.line.colorscale`. Has an effect only if in `marker.line.color` is set to a numerical array. In case `colorscale` is unspecified or `autocolorscale` is true, the default palette will be chosen according to whether numbers in the `color` array are all positive, all negative or mixed.",
);

has cauto => (
    is            => "rw",
    isa           => "Bool",
    documentation =>
      "Determines whether or not the color domain is computed with respect to the input data (here in `marker.line.color`) or the bounds set in `marker.line.cmin` and `marker.line.cmax` Has an effect only if in `marker.line.color` is set to a numerical array. Defaults to `false` when `marker.line.cmin` and `marker.line.cmax` are set by the user.",
);

has cmax => (
    is            => "rw",
    isa           => "Num",
    documentation =>
      "Sets the upper bound of the color domain. Has an effect only if in `marker.line.color` is set to a numerical array. Value should have the same units as in `marker.line.color` and if set, `marker.line.cmin` must be set as well.",
);

has cmid => (
    is            => "rw",
    isa           => "Num",
    documentation =>
      "Sets the mid-point of the color domain by scaling `marker.line.cmin` and/or `marker.line.cmax` to be equidistant to this point. Has an effect only if in `marker.line.color` is set to a numerical array. Value should have the same units as in `marker.line.color`. Has no effect when `marker.line.cauto` is `false`.",
);

has cmin => (
    is            => "rw",
    isa           => "Num",
    documentation =>
      "Sets the lower bound of the color domain. Has an effect only if in `marker.line.color` is set to a numerical array. Value should have the same units as in `marker.line.color` and if set, `marker.line.cmax` must be set as well.",
);

has color => (
    is            => "rw",
    isa           => "Str|ArrayRef[Str]",
    documentation =>
      "Sets the marker.line color. It accepts either a specific color or an array of numbers that are mapped to the colorscale relative to the max and min values of the array or relative to `marker.line.cmin` and `marker.line.cmax` if set.",
);

has coloraxis => (
    is            => "rw",
    documentation =>
      "Sets a reference to a shared color axis. References to these shared color axes are *coloraxis*, *coloraxis2*, *coloraxis3*, etc. Settings for these shared color axes are set in the layout, under `layout.coloraxis`, `layout.coloraxis2`, etc. Note that multiple color scales can be linked to the same color axis.",
);

has colorscale => (
    is            => "rw",
    documentation =>
      "Sets the colorscale. Has an effect only if in `marker.line.color` is set to a numerical array. The colorscale must be an array containing arrays mapping a normalized value to an rgb, rgba, hex, hsl, hsv, or named color string. At minimum, a mapping for the lowest (0) and highest (1) values are required. For example, `[[0, 'rgb(0,0,255)'], [1, 'rgb(255,0,0)']]`. To control the bounds of the colorscale in color space, use `marker.line.cmin` and `marker.line.cmax`. Alternatively, `colorscale` may be a palette name string of the following list: Blackbody,Bluered,Blues,Cividis,Earth,Electric,Greens,Greys,Hot,Jet,Picnic,Portland,Rainbow,RdBu,Reds,Viridis,YlGnBu,YlOrRd.",
);

has colorsrc => ( is            => "rw",
                  isa           => "Str",
                  documentation => "Sets the source reference on Chart Studio Cloud for `color`.",
);

has reversescale => (
    is            => "rw",
    isa           => "Bool",
    documentation =>
      "Reverses the color mapping if true. Has an effect only if in `marker.line.color` is set to a numerical array. If true, `marker.line.cmin` will correspond to the last color in the array and `marker.line.cmax` will correspond to the first color.",
);

has width => ( is            => "rw",
               isa           => "Num|ArrayRef[Num]",
               documentation => "Sets the width (in px) of the lines bounding the marker points.",
);

has widthsrc => ( is            => "rw",
                  isa           => "Str",
                  documentation => "Sets the source reference on Chart Studio Cloud for `width`.",
);

__PACKAGE__->meta->make_immutable();
1;

__END__

=pod

=encoding utf-8

=head1 NAME

Chart::Plotly::Trace::Funnel::Marker::Line - This attribute is one of the possible options for the trace funnel.

=head1 VERSION

version 0.042

=head1 SYNOPSIS

 use Chart::Plotly;
 use Chart::Plotly::Plot;
 use JSON;
 use Chart::Plotly::Trace::Funnel;
 
 # Example from https://github.com/plotly/plotly.js/blob/b93e3a5a83b6561ac6258a59f274b5fc87630c3e/test/image/mocks/funnel_11.json
 my $trace1 = Chart::Plotly::Trace::Funnel->new({'orientation' => 'v', 'marker' => {'color' => 'rgb(255, 102, 97)', }, 'y' => [13.23, 22.7, 26.06, ], 'x' => ['Half Dose', 'Full Dose', 'Double Dose', ], 'name' => 'Orange Juice', });
 
 my $trace2 = Chart::Plotly::Trace::Funnel->new({'name' => 'Vitamin C', 'marker' => {'color' => 'rgb(0, 196, 200)', }, 'y' => [7.98, 16.77, 26.14, ], 'x' => ['Half Dose', 'Full Dose', 'Double Dose', ], 'orientation' => 'v', });
 
 my $trace3 = Chart::Plotly::Trace::Funnel->new({'name' => 'Std Dev - OJ', 'x' => ['Half Dose', 'Full Dose', 'Double Dose', ], 'y' => [1.4102837, 1.236752, 0.8396031, ], 'visible' => JSON::false, 'orientation' => 'v', });
 
 my $trace4 = Chart::Plotly::Trace::Funnel->new({'y' => [0.868562, 0.7954104, 1.5171757, ], 'x' => ['Half Dose', 'Full Dose', 'Double Dose', ], 'name' => 'Std Dev - VC', 'orientation' => 'v', 'visible' => JSON::false, });
 
 
 my $plot = Chart::Plotly::Plot->new(
     traces => [$trace1, $trace2, $trace3, $trace4, ],
     layout => 
         {'autosize' => JSON::false, 'hidesources' => JSON::false, 'plot_bgcolor' => 'rgb(217, 217, 217)', 'font' => {'color' => '#000', 'size' => 12, 'family' => 'Arial, sans-serif', }, 'width' => 600, 'separators' => '.,', 'legend' => {'xanchor' => 'left', 'font' => {'size' => 16, 'family' => '', 'color' => 'rgb(0, 0, 0)', }, 'bgcolor' => 'rgba(255, 255, 255, 0)', 'bordercolor' => 'rgba(0, 0, 0, 0)', 'yanchor' => 'auto', 'x' => 1.02, 'y' => 0.931907250442406, 'borderwidth' => 1, 'traceorder' => 'normal', }, 'funnelgroupgap' => 0, 'funnelgap' => 0.2, 'annotations' => [{'tag' => '', 'yatype' => 'linear', 'showarrow' => JSON::false, 'xanchor' => 'auto', 'bgcolor' => 'rgba(0,0,0,0)', 'arrowhead' => 1, 'yref' => 'paper', 'ax' => -10, 'align' => 'center', 'yanchor' => 'auto', 'xatype' => 'category', 'bordercolor' => '', 'ref' => 'paper', 'text' => '<b>Supplement</b>', 'x' => 1.3479735318445, 'y' => 0.998214285714286, 'opacity' => 1, 'arrowwidth' => 0, 'font' => {'size' => 18, 'family' => '', 'color' => '', }, 'ay' => -26.7109375, 'arrowcolor' => '', 'borderpad' => 1, 'borderwidth' => 1, 'xref' => 'paper', 'arrowsize' => 1, }, ], 'height' => 440, 'dragmode' => 'zoom', 'hovermode' => 'x', 'paper_bgcolor' => '#fff', 'boxmode' => 'overlay', 'showlegend' => JSON::true, 'titlefont' => {'family' => '', 'size' => 16, 'color' => '', }, 'title' => 'Grouped Funnel Chart', 'margin' => {'r' => 0, 't' => 80, 'b' => 80, 'l' => 80, 'autoexpand' => JSON::true, 'pad' => 2, }, 'yaxis' => {'gridcolor' => 'rgb(255, 255, 255)', 'autotick' => JSON::true, 'ticks' => '', 'tickfont' => {'color' => '', 'size' => 16, 'family' => '', }, 'mirror' => JSON::true, 'tickangle' => 0, 'domain' => [0, 1, ], 'anchor' => 'x', 'showgrid' => JSON::true, 'exponentformat' => 'e', 'tick0' => 0, 'showticklabels' => JSON::true, 'nticks' => 0, 'zerolinewidth' => 1, 'zeroline' => JSON::false, 'position' => 0, 'range' => [0, 29.1128165263158, ], 'dtick' => 5, 'showexponent' => 'all', 'showline' => JSON::false, 'linecolor' => '#000', 'type' => 'linear', 'linewidth' => 0.1, 'overlaying' => JSON::false, 'ticklen' => 5, 'rangemode' => 'normal', 'tickwidth' => 1, 'tickcolor' => '#000', 'title' => 'Length', 'autorange' => JSON::true, 'titlefont' => {'size' => 16, 'family' => '', 'color' => '', }, 'zerolinecolor' => '#000', 'gridwidth' => 1.9, }, 'funnelmode' => 'group', 'xaxis' => {'ticks' => '', 'autotick' => JSON::true, 'gridcolor' => 'rgb(255, 255, 255)', 'tickfont' => {'color' => '', 'family' => '', 'size' => 16, }, 'mirror' => JSON::true, 'anchor' => 'y', 'tickangle' => 0, 'domain' => [0, 1, ], 'showgrid' => JSON::true, 'exponentformat' => 'e', 'tick0' => 0, 'showticklabels' => JSON::true, 'range' => [-0.5, 2.5, ], 'nticks' => 0, 'zerolinewidth' => 1, 'zeroline' => JSON::false, 'position' => 0, 'showexponent' => 'all', 'dtick' => 1, 'showline' => JSON::false, 'type' => 'category', 'linecolor' => '#000', 'overlaying' => JSON::false, 'linewidth' => 0.1, 'ticklen' => 5, 'rangemode' => 'normal', 'titlefont' => {'size' => 16, 'family' => '', 'color' => '', }, 'autorange' => JSON::true, 'title' => 'Dose (mg)', 'tickwidth' => 1, 'tickcolor' => '#000', 'gridwidth' => 1.9, 'zerolinecolor' => '#000', }, }
 ); 
 
 Chart::Plotly::show_plot($plot);

=head1 DESCRIPTION

This attribute is part of the possible options for the trace funnel.

This file has been autogenerated from the official plotly.js source.

If you like Plotly, please support them: L<https://plot.ly/> 
Open source announcement: L<https://plot.ly/javascript/open-source-announcement/>

Full reference: L<https://plot.ly/javascript/reference/#funnel>

=head1 DISCLAIMER

This is an unofficial Plotly Perl module. Currently I'm not affiliated in any way with Plotly. 
But I think plotly.js is a great library and I want to use it with perl.

=head1 METHODS

=head2 TO_JSON

Serialize the trace to JSON. This method should be called only by L<JSON> serializer.

=head1 ATTRIBUTES

=over

=item * autocolorscale

Determines whether the colorscale is a default palette (`autocolorscale: true`) or the palette determined by `marker.line.colorscale`. Has an effect only if in `marker.line.color` is set to a numerical array. In case `colorscale` is unspecified or `autocolorscale` is true, the default palette will be chosen according to whether numbers in the `color` array are all positive, all negative or mixed.

=item * cauto

Determines whether or not the color domain is computed with respect to the input data (here in `marker.line.color`) or the bounds set in `marker.line.cmin` and `marker.line.cmax` Has an effect only if in `marker.line.color` is set to a numerical array. Defaults to `false` when `marker.line.cmin` and `marker.line.cmax` are set by the user.

=item * cmax

Sets the upper bound of the color domain. Has an effect only if in `marker.line.color` is set to a numerical array. Value should have the same units as in `marker.line.color` and if set, `marker.line.cmin` must be set as well.

=item * cmid

Sets the mid-point of the color domain by scaling `marker.line.cmin` and/or `marker.line.cmax` to be equidistant to this point. Has an effect only if in `marker.line.color` is set to a numerical array. Value should have the same units as in `marker.line.color`. Has no effect when `marker.line.cauto` is `false`.

=item * cmin

Sets the lower bound of the color domain. Has an effect only if in `marker.line.color` is set to a numerical array. Value should have the same units as in `marker.line.color` and if set, `marker.line.cmax` must be set as well.

=item * color

Sets the marker.line color. It accepts either a specific color or an array of numbers that are mapped to the colorscale relative to the max and min values of the array or relative to `marker.line.cmin` and `marker.line.cmax` if set.

=item * coloraxis

Sets a reference to a shared color axis. References to these shared color axes are *coloraxis*, *coloraxis2*, *coloraxis3*, etc. Settings for these shared color axes are set in the layout, under `layout.coloraxis`, `layout.coloraxis2`, etc. Note that multiple color scales can be linked to the same color axis.

=item * colorscale

Sets the colorscale. Has an effect only if in `marker.line.color` is set to a numerical array. The colorscale must be an array containing arrays mapping a normalized value to an rgb, rgba, hex, hsl, hsv, or named color string. At minimum, a mapping for the lowest (0) and highest (1) values are required. For example, `[[0, 'rgb(0,0,255)'], [1, 'rgb(255,0,0)']]`. To control the bounds of the colorscale in color space, use `marker.line.cmin` and `marker.line.cmax`. Alternatively, `colorscale` may be a palette name string of the following list: Blackbody,Bluered,Blues,Cividis,Earth,Electric,Greens,Greys,Hot,Jet,Picnic,Portland,Rainbow,RdBu,Reds,Viridis,YlGnBu,YlOrRd.

=item * colorsrc

Sets the source reference on Chart Studio Cloud for `color`.

=item * reversescale

Reverses the color mapping if true. Has an effect only if in `marker.line.color` is set to a numerical array. If true, `marker.line.cmin` will correspond to the last color in the array and `marker.line.cmax` will correspond to the first color.

=item * width

Sets the width (in px) of the lines bounding the marker points.

=item * widthsrc

Sets the source reference on Chart Studio Cloud for `width`.

=back

=head1 AUTHOR

Pablo Rodríguez González <pablo.rodriguez.gonzalez@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2022 by Pablo Rodríguez González.

This is free software, licensed under:

  The MIT (X11) License

=cut
