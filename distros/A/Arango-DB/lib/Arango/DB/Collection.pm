# ABSTRACT: ArangoDB Collection object
package Arango::DB::Collection;
$Arango::DB::Collection::VERSION = '0.006';
use warnings;
use strict;

sub _new {
    my ($class, %opts) = @_;
    return bless {%opts} => $class;
}

sub create_document {
    my ($self, $body) = @_;
    die "Arango::DB | Refusing to store undefined body" unless defined($body);
    return $self->{arango}->_api('create_document', { database => $self->{database}, collection => $self->{name}, body => $body})
}

sub document_paths {
    my ($self) = @_;
    return $self->{arango}->_api('all_keys', { database => $self->{database}, collection => $self->{name}, type => "path"})->{result}
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Arango::DB::Collection - ArangoDB Collection object

=head1 VERSION

version 0.006

=head1 USAGE

This class should not be created directly. The L<Arango::DB> module is responsible for
creating instances of this object.

C<Arango::DB::Collection> answers to the following methods:

=head2 C<create_document>

   $collection->create_document( { 'Hello' => 'World' } );
   $collection->create_document( q!"{ "Hello": "World" }! );

Stores a document in specified collection

=head2 C<document_paths>

   my $paths = $collection->document_paths;

Lists all collection document as their paths in the database. Returns a hash reference.

=head1 AUTHOR

Alberto Simões <ambs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2019 by Alberto Simões.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
