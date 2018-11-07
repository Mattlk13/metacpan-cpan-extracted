use utf8;

package SemanticWeb::Schema::BusinessEntityType;

# ABSTRACT: A business entity type is a conceptual entity representing the legal form

use Moo;

extends qw/ SemanticWeb::Schema::Enumeration /;


use MooX::JSON_LD 'BusinessEntityType';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v0.0.4';




1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::BusinessEntityType - A business entity type is a conceptual entity representing the legal form

=head1 VERSION

version v0.0.4

=head1 DESCRIPTION

=for html A business entity type is a conceptual entity representing the legal form,
the size, the main line of business, the position in the value chain, or
any combination thereof, of an organization or business person.<br/><br/>
Commonly used values:<br/><br/> <ul>
<li>http://purl.org/goodrelations/v1#Business</li>
<li>http://purl.org/goodrelations/v1#Enduser</li>
<li>http://purl.org/goodrelations/v1#PublicInstitution</li>
<li>http://purl.org/goodrelations/v1#Reseller</li> </ul> 

=head1 SEE ALSO

L<SemanticWeb::Schema::Enumeration>

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
