package Microsoft::AdCenter::V6::ReportingService::ReportTime;
# Copyright (C) 2012 Xerxes Tsang
# This program is free software; you can redistribute it and/or modify it
# under the terms of Perl Artistic License.

use strict;
use warnings;

use base qw/Microsoft::AdCenter::ComplexType/;

=head1 NAME

Microsoft::AdCenter::V6::ReportingService::ReportTime - Represents "ReportTime" in Microsoft AdCenter Reporting Service.

=cut

sub _type_name {
    return 'ReportTime';
}

sub _namespace_uri {
    return 'https://adcenter.microsoft.com/v6';
}

our @_attributes = (qw/
    CustomDateRangeEnd
    CustomDateRangeStart
    CustomDates
    PredefinedTime
/);

sub _attributes {
    my $self = shift;
    return ($self->SUPER::_attributes, @_attributes);
}

our %_attribute_type = (
    CustomDateRangeEnd => 'Date',
    CustomDateRangeStart => 'Date',
    CustomDates => 'ArrayOfDate',
    PredefinedTime => 'ReportTimePeriod',
);

sub _attribute_type {
    my ($self, $attribute) = @_;
    if (exists $_attribute_type{$attribute}) {
        return $_attribute_type{$attribute};
    }
    return $self->SUPER::_attribute_type($attribute);
}

our %_attribute_min_occurs = (
    CustomDateRangeEnd => 0,
    CustomDateRangeStart => 0,
    CustomDates => 0,
    PredefinedTime => 0,
);

sub _attribute_min_occurs {
    my ($self, $attribute) = @_;
    if (exists $_attribute_min_occurs{$attribute}) {
        return $_attribute_min_occurs{$attribute};
    }
    return $self->SUPER::_attribute_min_occurs($attribute);
}

__PACKAGE__->mk_accessors(@_attributes);

1;

=head1 SYNOPSIS

See L<http://msdn.microsoft.com/en-us/library/ee730327.aspx> for documentation of the various data objects.

=cut

=head1 METHODS

=head2 new

Creates a new instance

=head2 CustomDateRangeEnd

Gets/sets CustomDateRangeEnd (Date)

=head2 CustomDateRangeStart

Gets/sets CustomDateRangeStart (Date)

=head2 CustomDates

Gets/sets CustomDates (ArrayOfDate)

=head2 PredefinedTime

Gets/sets PredefinedTime (ReportTimePeriod)

=cut

