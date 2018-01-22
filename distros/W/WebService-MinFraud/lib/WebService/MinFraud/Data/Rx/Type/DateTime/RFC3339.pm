package WebService::MinFraud::Data::Rx::Type::DateTime::RFC3339;

use 5.010;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '1.006000';

use Carp ();
use DateTime::Format::RFC3339;

use parent 'Data::Rx::CommonType::EasyNew';

sub assert_valid {
    my ( $self, $value ) = @_;

    return 1 if $value && eval { $self->{dt}->parse_datetime($value); };

    $self->fail(
        {
            error   => [qw(type)],
            message => 'Found value is not a RFC3339 datetime',
            value   => $value,
        }
    );
}

sub guts_from_arg {
    my ( $class, $arg ) = @_;
    $arg ||= {};

    if ( my @unexpected = keys %$arg ) {
        Carp::croak sprintf 'Unknown arguments %s in constructing %s',
            ( join ',' => @unexpected ), $class->type_uri;
    }

    return { dt => DateTime::Format::RFC3339->new, };
}

sub type_uri {
    ## no critic(ValuesAndExpressions::ProhibitCommaSeparatedStatements)
    'tag:maxmind.com,MAXMIND:rx/datetime/rfc3339';
}

1;

# ABSTRACT: A type to check if a string parses as a RFC3339 datetime

__END__

=pod

=encoding UTF-8

=head1 NAME

WebService::MinFraud::Data::Rx::Type::DateTime::RFC3339 - A type to check if a string parses as a RFC3339 datetime

=head1 VERSION

version 1.006000

=head1 SUPPORT

Bugs may be submitted through L<https://github.com/maxmind/minfraud-api-perl/issues>.

=head1 AUTHOR

Mateu Hunter <mhunter@maxmind.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 - 2018 by MaxMind, Inc.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
