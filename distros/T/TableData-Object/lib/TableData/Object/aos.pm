package TableData::Object::aos;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2021-01-10'; # DATE
our $DIST = 'TableData-Object'; # DIST
our $VERSION = '0.113'; # VERSION

use 5.010001;
use strict;
use warnings;

use parent 'TableData::Object::Base';

sub new {
    my ($class, $data) = @_;
    bless {
        data         => $data,
        cols_by_name => {elem=>0},
        cols_by_idx  => ["elem"],
    }, $class;
}

sub row_count {
    my $self = shift;
    scalar @{ $self->{data} };
}

sub row {
    my ($self, $idx) = @_;
    $self->{data}[$idx];
}

sub row_as_aos {
    my ($self, $idx) = @_;
    return undef if $idx < 0 || $idx >= @{ $self->{data} };
    [$self->{data}[$idx]];
}

sub row_as_hos {
    my ($self, $idx) = @_;
    return undef if $idx < 0 || $idx >= @{ $self->{data} };
    {elem=>$self->{data}[$idx]};
}

sub rows {
    my $self = shift;
    $self->{data};
}

sub rows_as_aoaos {
    my $self = shift;
    [map {[$_]} @{ $self->{data} }];
}

sub rows_as_aohos {
    my $self = shift;
    [map {{elem=>$_}} @{ $self->{data} }];
}

sub uniq_col_names {
    my $self = shift;
    my %mem;
    for (@{$self->{data}}) {
        return () unless defined;
        return () if $mem{$_}++;
    }
    ('elem');
}

sub const_col_names {
    my $self = shift;

    my $i = -1;
    my $val;
    my $val_undef;
    for (@{$self->{data}}) {
        $i++;
        if ($i == 0) {
            $val = $_;
            $val_undef = 1 unless defined $val;
        } else {
            if ($val_undef) {
                return () if defined;
            } else {
                return () unless defined;
                return () unless $val eq $_;
            }
        }
    }
    ('elem');
}

sub del_col {
    die "Cannot delete column in aos table";
}

sub rename_col {
    die "Cannot rename column in aos table";
}

sub switch_cols {
    die "Cannot switch column in aos table";
}

sub add_col {
    die "Cannot add_col in aos table";
}

sub set_col_val {
    my ($self, $name_or_idx, $value_sub) = @_;

    my $col_name = $self->col_name($name_or_idx);
    my $col_idx  = $self->col_idx($name_or_idx);

    die "Column '$name_or_idx' does not exist" unless defined $col_name;

    my $hash = $self->{data};
    for my $i (0..$#{ $self->{data} }) {
        $self->{data}[$i] = $value_sub->(
            table    => $self,
            row_idx  => $i,
            col_name => $col_name,
            col_idx  => $col_idx,
            value    => $self->{data}[$i],
        );
    }
}

1;
# ABSTRACT: Manipulate array of scalars via table object

__END__

=pod

=encoding UTF-8

=head1 NAME

TableData::Object::aos - Manipulate array of scalars via table object

=head1 VERSION

This document describes version 0.113 of TableData::Object::aos (from Perl distribution TableData-Object), released on 2021-01-10.

=head1 SYNOPSIS

To create:

 use TableData::Object qw(table);

 my $td = table([1,2,3]);

or:

 use TableData::Object::aos;

 my $td = TableData::Object::aos->new([1,2,3]);

=head1 DESCRIPTION

This class lets you manipulate an array of scalars as a table object. The table
will have a single column named C<elem>.

=for Pod::Coverage .*

=head1 METHODS

See L<TableData::Object::Base>.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/TableData-Object>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-TableData-Object>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://github.com/perlancar/perl-TableData-Object/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2021, 2020, 2019, 2017, 2016, 2015, 2014 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
