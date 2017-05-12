package Test::Stream::Compare::Value;
use strict;
use warnings;

use Scalar::Util qw/looks_like_number/;

use Carp qw/carp/;

use base 'Test::Stream::Compare';
use Test::Stream::HashBase accessors => [qw/input/];

sub init {
    my $self = shift;
    carp "Test::Stream::Compare::Value is considered deprecated and dangerous";
    $self->SUPER::init(@_);
}

sub name {
    my $self = shift;
    my $in = $self->{+INPUT};
    return '<UNDEF>' unless defined $in;
    return "$in";
}

sub operator {
    my $self = shift;

    return '' unless @_;

    my ($got) = @_;
    my $input = $self->{+INPUT};

    return '' if defined($input) xor defined($got);
    return '==' unless defined($input) && defined($got);
    return '==' if looks_like_number($got) && looks_like_number($input);
    return 'eq';
}

sub verify {
    my $self = shift;
    my %params = @_;
    my ($got, $exists) = @params{qw/got exists/};

    return 0 unless $exists;
    return 0 if ref $got;

    my $input = $self->{+INPUT};
    return !defined($got) unless defined $input;
    return 0 unless defined($got);

    my $op = $self->operator($got);

    return $input == $got if $op eq '==';
    return $input eq $got;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Test::Stream::Compare::Value - Compare a value in deep comparisons.

=head1 DEPRECATED

This module would guess if a scalar was a string or number, this is dangerous.
Please see L<Test::Stream::Compare::String> and
L<Test::Stream::Compare::Number> instead.

=head1 DESCRIPTION

This is used to represent specific values in deep comparison. This can
represent any non-reference scalar value such as undef, a string, or a number.

=head1 SOURCE

The source code repository for Test::Stream can be found at
F<http://github.com/Test-More/Test-Stream/>.

=head1 MAINTAINERS

=over 4

=item Chad Granum E<lt>exodist@cpan.orgE<gt>

=back

=head1 AUTHORS

=over 4

=item Chad Granum E<lt>exodist@cpan.orgE<gt>

=back

=head1 COPYRIGHT

Copyright 2015 Chad Granum E<lt>exodist7@gmail.comE<gt>.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

See F<http://dev.perl.org/licenses/>

=cut
