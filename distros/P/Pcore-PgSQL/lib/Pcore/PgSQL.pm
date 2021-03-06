package Pcore::PgSQL v0.22.3;

use Pcore -dist, -class;

has data_dir => ( required => 1 );    # Str

sub run ( $self ) {
    my $db_dir = "$self->{data_dir}/db/";

    # create and prepare data dir
    P->file->mkdir( $self->{data_dir} ) if !-d $self->{data_dir};
    my $uid = getpwnam 'postgres';
    chown $uid, $uid, $self->{data_dir} or die;

    # init db
    if ( $self->is_empty ) {
        my $pwfile = "$self->{data_dir}/pgsql-password.txt";

        my $superuser_password;

        if ( defined $ENV{PGSQL_POSTGRES_PASSWORD} ) {
            $superuser_password = $ENV{PGSQL_POSTGRES_PASSWORD};
        }
        else {
            $superuser_password = P->random->bytes_hex(32);

            say "GENERATED POSTGRES PASSWORD: $superuser_password\n";
        }

        P->file->write_bin( $pwfile, $superuser_password );

        chown $uid, $uid, $pwfile or die;

        my $proc = P->sys->run_proc( [ 'su', 'postgres', '-c', "initdb --encoding UTF8 --no-locale -U postgres --pwfile $pwfile -D $db_dir" ] )->wait;

        unlink $pwfile or 1;

        exit 3 if !$proc;

        P->file->write_text(
            "$db_dir/pg_hba.conf",
            [   q[local all all trust],           # trust any user, connected via unix socket
                q[host all all 0.0.0.0/0 md5],    # require password, when user is connected via TCP
            ]
        );

        P->file->mkdir("$db_dir/conf.d") or die;
        chown $uid, $uid, "$db_dir/conf.d" or die;

        P->file->append_text( "$db_dir/postgresql.conf", [q[include_dir = 'conf.d']] );
    }

    # default listen settings
    my $postgres_conf = [                         #
        q[listen_addresses='*'],
        q[unix_socket_directories='/var/run/postgresql'],
    ];

    # timescaledb extension
    push $postgres_conf->@*, q[shared_preload_libraries = 'timescaledb'] if $ENV{TIMESCALEDB};

    P->file->write_text( "$db_dir/conf.d/00init.conf", $postgres_conf );
    chown $uid, $uid, "$db_dir/conf.d/00init.conf" or die;

    # create and prepare unix socket dir
    P->file->mkdir('/var/run/postgresql') if !-d '/var/run/postgresql';
    chown $uid, $uid, '/var/run/postgresql' or die;

    # run server
    return P->sys->run_proc( [ 'su', 'postgres', '-c', "postgres -D $db_dir" ] )->wait;
}

sub is_empty ($self) {
    return P->file->read_dir( $self->{data_dir} )->@* ? 0 : 1;
}

1;
__END__
=pod

=encoding utf8

=head1 NAME

Pcore::PgSQL

=head1 SYNOPSIS

=head1 DESCRIPTION

    docker create --name pgsql -v pgsql:/var/local/pcore-pgsql/data/ -v /var/run/postgresql/:/var/run/postgresql/ -p 5432:5432/tcp softvisio/pcore-pgsql

    # how to connect with standard client:
    psql -U postgres
    psql -h /var/run/postgresql -U postgres

    # connect via TCP
    my $dbh = P->handle('pgsql://username:password@host:port?db=dbname');

    # connect via unix socket
    my $dbh = P->handle('pgsql://username:password@/var/run/postgresql?db=dbname');

=head1 SEE ALSO

=head1 AUTHOR

zdm <zdm@cpan.org>

=head1 CONTRIBUTORS

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by zdm.

=cut
