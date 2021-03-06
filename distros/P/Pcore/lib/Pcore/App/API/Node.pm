package Pcore::App::API::Node;

use Pcore -class;
use Crypt::Argon2;

# http://argon2-cffi.readthedocs.io/en/stable/parameters.html
# https://pthree.org/2016/06/29/further-investigation-into-scrypt-and-argon2-password-hashing/

has argon2_time        => 3;        # PositiveInt;
has argon2_memory      => '64M';    # Str;
has argon2_parallelism => 1;        # PositiveInt, default;

sub API_create_hash ( $self, $str, $args = undef ) {
    my $salt = P->random->bytes(32);

    my $hash = Crypt::Argon2::argon2i_pass( $str, $salt, $args->{argon2_time} // $self->{argon2_time}, $args->{argon2_memory} // $self->{argon2_memory}, $args->{argon2_parallelism} // $self->{argon2_parallelism}, 32 );

    return 200, $hash;
}

sub API_verify_hash ( $self, $str, $hash ) {
    return 200, eval { Crypt::Argon2::argon2i_verify( $hash, $str ) } ? 1 : 0;
}

1;
__END__
=pod

=encoding utf8

=head1 NAME

Pcore::App::API::Node - API RPC node

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=head1 METHODS

=head1 SEE ALSO

=cut
