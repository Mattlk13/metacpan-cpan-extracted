package t::Templates::SubRowCellHtml;

use Moo;
use HTML::TableContent::Template;

caption title => (
    class => 'some-class',
    id => 'caption-id',
    text => 'table caption',
);

header id => (
    class => 'some-class',
    id => 'something-id',
);

header name => (
    class => 'okay',
);

header address => (
    class => 'what',
);

row one => (
    cells => {
        inner_html => 'special_row_cells',
    }
);

sub special_row_cells {
    return  ['<span id="first-%s">%s</span', 'header_template_attr', 'text']; 
}


sub render_row {
    my ($self, $element) = @_;

    return ['<div>%s</div>'];
}

sub _data {
    my $self = shift;

    return [
        {
            id => 1,
            name => 'rob',
            address => 'somewhere',
        },
        {
            id => 2,
            name => 'sam',
            address => 'somewhere else',
        },
        {
            id => 3,
            name => 'frank',
            address => 'out',
        },
    ];
}

1;



