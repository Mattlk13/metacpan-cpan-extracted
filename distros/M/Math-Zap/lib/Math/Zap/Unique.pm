
=head1 Unique

Unique id    

PhilipRBrenan@yahoo.com, 2004, Perl license


=head2 Synopsis

Example t/unique.t

 #_ Unique _____________________________________________________________
 # Unique           
 # philiprbrenan@yahoo.com, 2004, Perl License    
 #______________________________________________________________________
 
 use Math::Zap::Unique;
 use Test::Simple tests=>3;
    
 ok(unique() ne unique());
 ok(unique() ne unique());
 ok(unique() ne unique());
 



=head2 Description

Returns a unique id each time it is called.

=cut


package Math::Zap::Unique;
$VERSION=1.07;
use Carp;


=head2 Constructors


=head3 unique

Return new unique id

=cut


my $unique = 0;

sub unique() {++$unique}


=head3 new

Return new unique id, synonym for L</unique>

=cut


sub new {unique()}


=head2 Exports

Export L</unique>

=cut


use Math::Zap::Exports qw(
  unique ()
 );

#_ Unique _____________________________________________________________
# Package loaded successfully
#______________________________________________________________________

1;


=head2 Credits

=head3 Author

philiprbrenan@yahoo.com

=head3 Copyright

philiprbrenan@yahoo.com, 2004

=head3 License

Perl License.


=cut
