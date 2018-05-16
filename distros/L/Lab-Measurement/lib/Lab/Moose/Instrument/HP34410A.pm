package Lab::Moose::Instrument::HP34410A;
$Lab::Moose::Instrument::HP34410A::VERSION = '3.642';
#ABSTRACT: HP 34410A digital multimeter.

use 5.010;

use Moose;
use Moose::Util::TypeConstraints;
use MooseX::Params::Validate;
use Lab::Moose::Instrument qw/validated_getter validated_setter/;
use Carp;
use Lab::Moose::Instrument::Cache;
use namespace::autoclean;

extends 'Lab::Moose::Instrument';

with qw(
    Lab::Moose::Instrument::Common
    Lab::Moose::Instrument::SCPI::Sense::Function
    Lab::Moose::Instrument::SCPI::Sense::Range
    Lab::Moose::Instrument::SCPI::Sense::NPLC
);

sub BUILD {
    my $self = shift;
    $self->clear();
    $self->cls();
}

around default_connection_options => sub {
    my $orig     = shift;
    my $self     = shift;
    my $options  = $self->$orig();
    my $usb_opts = { vid => 0x03f0 };    # what is PID??

    $options->{USB} = $usb_opts;
    $options->{'VISA::USB'} = $usb_opts;
    $options->{'Socket'} = { port => 5025 };

    return $options;
};



sub get_value {
    my ( $self, %args ) = validated_getter( \@_ );
    return $self->query( command => ':read?', %args );
}

__PACKAGE__->meta()->make_immutable();

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Lab::Moose::Instrument::HP34410A - HP 34410A digital multimeter.

=head1 VERSION

version 3.642

=head1 SYNOPSIS

 my $dmm = instrument(
    type => 'HP34410A',
    connection_type => 'VXI11',
    connection_options => {host => '192.168.3.27'},
    );
    
 my $voltage = $dmm->get_value();

=head1 METHODS

Used roles:

=over

=item L<Lab::Moose::Instrument::SCPI::Sense::Function>

=item L<Lab::Moose::Instrument::SCPI::Sense::Range>

=item L<Lab::Moose::Instrument::SCPI::Sense::NPLC>

=back

=head2 get_value

 my $voltage = $dmm->get_value();

Perform voltage/current measurement.

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by the Lab::Measurement team; in detail:

  Copyright 2017-2018  Simon Reinhardt


This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
