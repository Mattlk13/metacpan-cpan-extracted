package Params::Profile::Params_Check;

use strict;
use Params::Check;

our $VERSION = $Params::Profile::VERSION;

=head1 NAME

Params::Profile::Params_Check - Backend module for Params::Profile

=head1 SYNOPSIS

See C<Params::Profile>

=head1 DESCRIPTION

C<Params::Check> methods for C<Params::Profile>

=cut

### params = HASHREF, profiles = ARRAYREF
sub validate {
    my ($self, $params, %profile) = @_;
    Params::Check::check(\%profile, $params);
}

sub _merge_profiles {
    my ($self, @profiles) = @_;

    ### Insert first profile in (tobe) merged_profile
    my $merged_profile = shift(@profiles);
    foreach my $profile (@profiles) {
        foreach my $key (keys %{$profile}) {
            $merged_profile->{$key} = $profile->{$key};
        }
    }

    return $merged_profile;
}

sub get_profile {
    my ($self, $params, @profiles) = @_;
    return $self->_merge_profiles(@profiles);
}

sub check {
    my ($self, $params, %profile) = @_;
    Params::Check::check(\%profile, $params);
}

1;

__END__

=head1 AUTHOR

This module by

Michiel Ootjers E<lt>michiel@cpan.orgE<gt>.

and

Jos Boumans E<lt>kane@cpan.orgE<gt>.

=head1 ACKNOWLEDGEMENTS

Thanks to Jos Boumans for C<Params::Check>, and the authors of
C<Data::FormValidator>

=head1 COPYRIGHT

This module is
copyright (c) 2002 Michiel Ootjers E<lt>michiel@cpan.orgE<gt>.
All rights reserved.

This library is free software;
you may redistribute and/or modify it under the same
terms as Perl itself.

=cut
