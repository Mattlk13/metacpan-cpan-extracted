use 5.008;
use warnings;
use strict;

package Class::Scaffold::YAML::Active::ExceptionContainer;
BEGIN {
  $Class::Scaffold::YAML::Active::ExceptionContainer::VERSION = '1.102280';
}
# ABSTRACT: Plugin that constructs an exception container
use YAML::Active qw/assert_arrayref array_activate/;
use parent 'Class::Scaffold::YAML::Active';

sub yaml_activate {
    my ($self, $phase) = @_;
    assert_arrayref($self);
    my $exceptions = array_activate($self, $phase);

 # Expect a list of hashrefs; each hash element is an exception with a
 # 'ref' key giving the exception class, and the rest being treated as args
 # to give to the exception when it is being recorded. Example:
 #
 #  exception_container: !perl/Class::Scaffold::YAML::Active::ExceptionContainer
 #    - ref: Class::Scaffold::Exception::Policy::Blah
 #      property1: value1
 #      property2: value2
    my $container = $self->delegate->make_obj('exception_container');
    for my $exception (@$exceptions) {
        my $class = $exception->{ref};
        delete $exception->{ref};
        $container->record($class, %$exception);
    }
    $container;
}
1;


__END__
=pod

=head1 NAME

Class::Scaffold::YAML::Active::ExceptionContainer - Plugin that constructs an exception container

=head1 VERSION

version 1.102280

=head1 METHODS

=head2 yaml_activate

FIXME

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org>.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see
L<http://search.cpan.org/dist/Class-Scaffold/>.

The development version lives at
L<http://github.com/hanekomu/Class-Scaffold/>.
Instead of sending patches, please fork this project using the standard git
and github infrastructure.

=head1 AUTHORS

=over 4

=item *

Marcel Gruenauer <marcel@cpan.org>

=item *

Florian Helmberger <fh@univie.ac.at>

=item *

Achim Adam <ac@univie.ac.at>

=item *

Mark Hofstetter <mh@univie.ac.at>

=item *

Heinz Ekker <ek@univie.ac.at>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Marcel Gruenauer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

