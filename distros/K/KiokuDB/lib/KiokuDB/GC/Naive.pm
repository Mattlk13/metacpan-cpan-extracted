package KiokuDB::GC::Naive;
BEGIN {
  $KiokuDB::GC::Naive::AUTHORITY = 'cpan:NUFFIN';
}
$KiokuDB::GC::Naive::VERSION = '0.57';
use Moose;
# ABSTRACT: Naive mark and sweep garbage collection

use KiokuDB::GC::Naive::Mark;
use KiokuDB::GC::Naive::Sweep;

use namespace::clean -except => 'meta';

with qw(KiokuDB::Role::Verbosity);

has backend => (
    does => "KiokuDB::Backend::Role::Scan",
    is   => "ro",
    required => 1,
);

has [qw(mark_scan sweep_scan)] => (
    is  => "ro",
    lazy_build => 1,
);

sub _build_mark_scan {
    my $self = shift;

    KiokuDB::GC::Naive::Mark->new(
        backend => $self->backend,
        verbose => $self->verbose,
    );
}

sub _build_sweep_scan {
    my $self = shift;

    my $mark_results = $self->mark_results;

    $self->v("sweeping...\n");

    KiokuDB::GC::Naive::Sweep->new(
        backend => $self->backend,
        verbose => $self->verbose,
        mark_results => $mark_results,
    );
}

has mark_results => (
    isa => "KiokuDB::GC::Naive::Mark::Results",
    is  => "ro",
    handles => qr/.*/,
    lazy_build => 1,
);

sub _build_mark_results {
    my $self = shift;

    $self->v("marking reachable objects...\n");

    return $self->mark_scan->results;
}

has sweep_results => (
    isa => "KiokuDB::GC::Naive::Sweep::Results",
    is  => "ro",
    handles => qr/.*/,
    lazy_build => 1,
);

sub _build_sweep_results {
    my $self = shift;

    return $self->sweep_scan->results;
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__

=pod

=encoding UTF-8

=head1 NAME

KiokuDB::GC::Naive - Naive mark and sweep garbage collection

=head1 VERSION

version 0.57

=head1 SYNOPSIS

    use KiokuDB::GC::Naive;

    my $gc = KiokuDB::GC::Naive->new(
        backend => $backend,
    );

    $backend->delete( $gc->garbage->members );

=head1 DESCRIPTION

This class implements full mark and sweep garbage collection for a backend
supporting L<KiokuDB::Backend::Role::Scan>.

=head1 AUTHOR

Yuval Kogman <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Yuval Kogman, Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
