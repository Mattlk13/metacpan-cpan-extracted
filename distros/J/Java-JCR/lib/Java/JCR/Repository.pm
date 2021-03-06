package Java::JCR::Repository;

# This code was automatically generated by a combination of the
# JCRPackageGenerator.java and package-generator.pl programs. These are both
# distributed in the inc/ directory of the Java-JCR distribution. You should
# be able to find the latest Java-JCR distribution at:
#
#   http://search.cpan.org/~hanenkamp/Java-JCR/
#

use strict;
use warnings;

use base qw( Java::JCR::Base );

our $VERSION = '0.07';

use Carp;
use Inline (
    Java => 'STUDY',
    STUDY => [],
);
use Inline::Java qw( study_classes );

study_classes(['javax.jcr.Repository'], 'Java::JCR');

*SPEC_VERSION_DESC = *Java::JCR::javax::jcr::Repository::SPEC_VERSION_DESC;
*SPEC_NAME_DESC = *Java::JCR::javax::jcr::Repository::SPEC_NAME_DESC;
*REP_VENDOR_DESC = *Java::JCR::javax::jcr::Repository::REP_VENDOR_DESC;
*REP_VENDOR_URL_DESC = *Java::JCR::javax::jcr::Repository::REP_VENDOR_URL_DESC;
*REP_NAME_DESC = *Java::JCR::javax::jcr::Repository::REP_NAME_DESC;
*REP_VERSION_DESC = *Java::JCR::javax::jcr::Repository::REP_VERSION_DESC;
*LEVEL_1_SUPPORTED = *Java::JCR::javax::jcr::Repository::LEVEL_1_SUPPORTED;
*LEVEL_2_SUPPORTED = *Java::JCR::javax::jcr::Repository::LEVEL_2_SUPPORTED;
*OPTION_TRANSACTIONS_SUPPORTED = *Java::JCR::javax::jcr::Repository::OPTION_TRANSACTIONS_SUPPORTED;
*OPTION_VERSIONING_SUPPORTED = *Java::JCR::javax::jcr::Repository::OPTION_VERSIONING_SUPPORTED;
*OPTION_OBSERVATION_SUPPORTED = *Java::JCR::javax::jcr::Repository::OPTION_OBSERVATION_SUPPORTED;
*OPTION_LOCKING_SUPPORTED = *Java::JCR::javax::jcr::Repository::OPTION_LOCKING_SUPPORTED;
*OPTION_QUERY_SQL_SUPPORTED = *Java::JCR::javax::jcr::Repository::OPTION_QUERY_SQL_SUPPORTED;
*QUERY_XPATH_POS_INDEX = *Java::JCR::javax::jcr::Repository::QUERY_XPATH_POS_INDEX;
*QUERY_XPATH_DOC_ORDER = *Java::JCR::javax::jcr::Repository::QUERY_XPATH_DOC_ORDER;

sub get_descriptor_keys {
    my $self = shift;
    my @args = Java::JCR::Base::_process_args(@_);

    my $result = eval { $self->{obj}->getDescriptorKeys(@args) };
    if ($@) { my $e = Java::JCR::Exception->new($@); croak $e }

    return $result;
}

sub get_descriptor {
    my $self = shift;
    my @args = Java::JCR::Base::_process_args(@_);

    my $result = eval { $self->{obj}->getDescriptor(@args) };
    if ($@) { my $e = Java::JCR::Exception->new($@); croak $e }

    return $result;
}

sub login {
    my $self = shift;
    my @args = Java::JCR::Base::_process_args(@_);

    my $result = eval { $self->{obj}->login(@args) };
    if ($@) { my $e = Java::JCR::Exception->new($@); croak $e }

    return Java::JCR::Base::_process_return($result, "javax.jcr.Session", "Java::JCR::Session");
}

1;
__END__

=head1 NAME

Java::JCR::Repository - Perl wrapper for javax.jcr.Repository

=head1 DESCRIPTION

This is an automatically generated package wrapping javax.jcr.Repository with a nice Perlish API.

For full documentation of what this class does, see the Java API documentation: L<http://www.day.com/maven/jsr170/javadocs/jcr-1.0/javax/jcr/Repository.html>

The deviations from the API documentation include the following:

=over

=item *

You will need to use Perl, intead of Java, to make any use of this API. (Duh.)

=item *

The package to use is L<Java::JCR::Repository>, rather than I<javax.jcr.Repository>.

=item *

All method names have been changed from Java-style C<camelCase()> to Perl-style C<lower_case()>. 

Thus, if the function were named C<getName()> in the Java API, it will be named C<get_name()> in this API. As another example, C<nextEventListener()> in the Java API will be C<next_event_listener()> in this API.

=item *

Handle exceptions just like typical Perl. L<Java::JCR::Exception> takes care of making sure that works as expected.

=back

=head1 SEE ALSO

L<Java::JCR>, L<http://www.day.com/maven/jsr170/javadocs/jcr-1.0/javax/jcr/Repository.html>

=head1 AUTHOR

Andrew Sterling Hanenkamp, E<lt>hanenkamp@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright 2006 Andrew Sterling Hanenkamp E<lt>hanenkamp@cpan.orgE<gt>.  All 
Rights Reserved.

This module is free software; you can redistribute it and/or modify it under
the same terms as Perl itself. See L<perlartistic>.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.

=cut

