package Chart::Plotly::Trace::Funnel::Marker::Colorbar::Tickformatstop;
use Moose;
use MooseX::ExtraArgs;
use Moose::Util::TypeConstraints qw(enum union);
if ( !defined Moose::Util::TypeConstraints::find_type_constraint('PDL') ) {
    Moose::Util::TypeConstraints::type('PDL');
}

our $VERSION = '0.035';    # VERSION

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

has dtickrange => (
    is  => "rw",
    isa => "ArrayRef|PDL",
    documentation =>
      "range [*min*, *max*], where *min*, *max* - dtick values which describe some zoom level, it is possible to omit *min* or *max* value by passing *null*",
);

has enabled => (
        is  => "rw",
        isa => "Bool",
        documentation =>
          "Determines whether or not this stop is used. If `false`, this stop is ignored even within its `dtickrange`.",
);

has name => (
    is  => "rw",
    isa => "Str",
    documentation =>
      "When used in a template, named items are created in the output figure in addition to any items the figure already has in this array. You can modify these items in the output figure by making your own item with `templateitemname` matching this `name` alongside your modifications (including `visible: false` or `enabled: false` to hide it). Has no effect outside of a template.",
);

has templateitemname => (
    is  => "rw",
    isa => "Str",
    documentation =>
      "Used to refer to a named item in this array in the template. Named items from the template will be created even without a matching item in the input figure, but you can modify one by making an item with `templateitemname` matching its `name`, alongside your modifications (including `visible: false` or `enabled: false` to hide it). If there is no template or no matching item, this item will be hidden unless you explicitly show it with `visible: true`.",
);

has value => ( is            => "rw",
               isa           => "Str",
               documentation => "string - dtickformat for described zoom level, the same as *tickformat*",
);

__PACKAGE__->meta->make_immutable();
1;

__END__

=pod

=encoding utf-8

=head1 NAME

Chart::Plotly::Trace::Funnel::Marker::Colorbar::Tickformatstop - This attribute is one of the possible options for the trace funnel.

=head1 VERSION

version 0.035

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

=item * dtickrange

range [*min*, *max*], where *min*, *max* - dtick values which describe some zoom level, it is possible to omit *min* or *max* value by passing *null*

=item * enabled

Determines whether or not this stop is used. If `false`, this stop is ignored even within its `dtickrange`.

=item * name

When used in a template, named items are created in the output figure in addition to any items the figure already has in this array. You can modify these items in the output figure by making your own item with `templateitemname` matching this `name` alongside your modifications (including `visible: false` or `enabled: false` to hide it). Has no effect outside of a template.

=item * templateitemname

Used to refer to a named item in this array in the template. Named items from the template will be created even without a matching item in the input figure, but you can modify one by making an item with `templateitemname` matching its `name`, alongside your modifications (including `visible: false` or `enabled: false` to hide it). If there is no template or no matching item, this item will be hidden unless you explicitly show it with `visible: true`.

=item * value

string - dtickformat for described zoom level, the same as *tickformat*

=back

=head1 AUTHOR

Pablo Rodríguez González <pablo.rodriguez.gonzalez@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2019 by Pablo Rodríguez González.

This is free software, licensed under:

  The MIT (X11) License

=cut
