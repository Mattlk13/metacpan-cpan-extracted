package PDF::Template::Element::Circle;

use strict;

BEGIN {
    use vars qw(@ISA);
    @ISA = qw(PDF::Template::Element);

    use PDF::Template::Element;
}

sub new
{
    my $class = shift;
    my $self = $class->SUPER::new(@_);

#    warn 'Warning: <circle> missing required attribute R' unless exists $self->{R};

    return $self;
}

sub render
{
    my $self = shift;
    my ($context) = @_;

    return 0 unless $self->should_render($context);

    return 1 if $context->{CALC_LAST_PAGE};

    my ($x, $y, $r) = map { $context->get($self, $_) } qw(X Y R);

    return 1 unless defined $r;

    my $p = $context->{PDF};

    pdflib_pl::PDF_save($p);

    $self->set_color($context, 'COLOR', 'stroke');

    my $fillcolor = $context->get($self, 'FILLCOLOR');
    $self->set_color($context, 'FILLCOLOR', 'fill');

    my $width = $context->get($self, 'WIDTH') || 1;
    pdflib_pl::PDF_setlinewidth($p, $width);

    pdflib_pl::PDF_circle($p, $x, $y, $r);

    if (defined $fillcolor)
    {
        pdflib_pl::PDF_fill_stroke($p);
    }
    else
    {
        pdflib_pl::PDF_stroke($p);
    }

    pdflib_pl::PDF_restore($p);

    return 1;
}

sub deltas
{
    my $self = shift;
    my ($context) = @_;

#    my ($x, $y, $r) = map { $context->get($self, $_) } qw(X Y R);
    my ($x, $y) = map { $context->get($self, $_) } qw(X Y);

#GGG Have $r involved here?
    return {
        X => $x - $context->{X},
        Y => $y - $context->{Y},
    };
}

1;
__END__

=head1 NAME

PDF::Template::Element::Circle

=head1 PURPOSE

To draw a circle.

=head1 NODE NAME

CIRCLE

=head1 INHERITANCE

PDF::Template::Element

=head1 ATTRIBUTES

=over 4

=item * R
This is the radius of the circle to be drawn

=item * COLOR
This is the color the circle should be drawn in. Defaults to black.

=item * FILLCOLOR
This is the color the circle should be filled in with. Defaults to none.

=item * WIDTH
This is the width of the line used to draw the circle. Defaults to 1 pixel.

=back 4

=head1 CHILDREN

None

=head1 AFFECTS

Nothing

=head1 DEPENDENCIES

None

=head1 USAGE

  <circle R="1i" color="255,0,0"/>

This will cause a 1-inch radius circle to be drawn at the current position in
red.

=head1 AUTHOR

Rob Kinyon (rob.kinyon@gmail.com)

=head1 SEE ALSO

=cut
