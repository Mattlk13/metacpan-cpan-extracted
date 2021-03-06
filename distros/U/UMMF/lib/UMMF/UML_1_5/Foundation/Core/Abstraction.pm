# -*- perl -*-
# DO NOT EDIT - This file is generated by UMMF; http://ummf.sourceforge.net 
# From template: $Id: Perl.txt,v 1.77 2006/05/14 01:40:03 kstephens Exp $

package UMMF::UML_1_5::Foundation::Core::Abstraction;

#use 5.6.1;
use strict;
use warnings;

#################################################################
# Version
#

our $VERSION = do { my @r = (q{1.5} =~ /\d+/g); sprintf "%d." . "%03d" x $#r, @r };


#################################################################
# Documentation
#

=head1 NAME

UMMF::UML_1_5::Foundation::Core::Abstraction -- 

=head1 VERSION

1.5

=head1 SYNOPSIS

=head1 DESCRIPTION 

=head1 USAGE

=head1 EXPORT

=head1 METATYPE

L<UMMF::UML_1_5::Foundation::Core::Class|UMMF::UML_1_5::Foundation::Core::Class>

=head1 SUPERCLASSES

L<UMMF::UML_1_5::Foundation::Core::Dependency|UMMF::UML_1_5::Foundation::Core::Dependency>




=head1 ATTRIBUTES


=head2 C<mapping> : UMMF::UML_1_5::Foundation::Data_Types::MappingExpression 


=over 4

=item metatype = L<UMMF::UML_1_5::Foundation::Core::Attribute|UMMF::UML_1_5::Foundation::Core::Attribute>

=item type = L<UMMF::UML_1_5::Foundation::Data_Types::MappingExpression|UMMF::UML_1_5::Foundation::Data_Types::MappingExpression>

=item visibility = C<private>

=item multiplicity = C<1>

=item changeability = C<changeable>

=item targetScope = C<instance>

=item ordering = C<unordered>

=item initialValue = I<UNSPECIFIED>

=item container_type = C<Set::Object>

=back



=head1 ASSOCIATIONS

I<NO ASSOCIATIONS>


=head1 METHODS

=cut



#################################################################
# Dependencies
#





use Carp qw(croak confess);
use Set::Object 1.05;
use Class::Multimethods 1.70;
use Data::Dumper;
use Scalar::Util qw(weaken);
use UMMF::UML_1_5::__ObjectBase qw(:__ummf_array);


#################################################################
# Generalizations
#

use base qw(
  UMMF::UML_1_5::Foundation::Core::Dependency



);


#################################################################
# Exports
#

our @EXPORT_OK = qw(
);
our %EXPORT_TAGS = ( 'all' => \@EXPORT_OK );





#################################################################
# Validation
#


=head2 C<__validate_type>

  UMMF::UML_1_5::Foundation::Core::Abstraction->__validate_type($value);

Returns true if C<$value> is a valid representation of L<UMMF::UML_1_5::Foundation::Core::Abstraction|UMMF::UML_1_5::Foundation::Core::Abstraction>.

=cut
sub __validate_type($$)
{
  my ($self, $x) = @_;

  no warnings;

  UNIVERSAL::isa($x, 'UMMF::UML_1_5::Foundation::Core::Abstraction')  ;
}


=head2 C<__typecheck>

  UMMF::UML_1_5::Foundation::Core::Abstraction->__typecheck($value, $msg);

Calls C<confess()> with C<$msg> if C<<UMMF::UML_1_5::Foundation::Core::Abstraction->__validate_type($value)>> is false.

=cut
sub __typecheck
{
  my ($self, $x, $msg) = @_;

  confess("typecheck: $msg: type '" . 'UMMF::UML_1_5::Foundation::Core::Abstraction' . ": value '$x'")
    unless __validate_type($self, $x);
}


=head2 C<isaAbstraction>


Returns true if receiver is a L<UMMF::UML_1_5::Foundation::Core::Abstraction|UMMF::UML_1_5::Foundation::Core::Abstraction>.
Other receivers will return false.

=cut
sub isaAbstraction { 1 }


=head2 C<isaFoundation__Core__Abstraction>


Returns true if receiver is a L<UMMF::UML_1_5::Foundation::Core::Abstraction|UMMF::UML_1_5::Foundation::Core::Abstraction>.
Other receivers will return false.
This is the fully qualified version of the C<isaAbstraction> method.

=cut
sub isaFoundation__Core__Abstraction { 1 }


#################################################################
# Introspection
#

=head2 C<__model_name> 

  my $name = $obj_or_package->__model_name;

Returns the UML Model name (C<'Foundation::Core::Abstraction'>) for an object or package of
this Classifier.

=cut
sub __model_name { 'Foundation::Core::Abstraction' }



=head2 C<__isAbstract>

  $package->__isAbstract;

Returns C<0>.

=cut
sub __isAbstract { 0; }


my $__tangram_schema;
=head2 C<__tangram_schema>

  my $tangram_schema $obj_or_package->__tangram_schema

Returns a HASH ref that describes this Classifier for Tangram.

See L<UMMF::Export::Perl::Tangram|UMMF::Export::Perl::Tangram>

=cut
sub __tangram_schema
{
  my ($self) = @_;

  $__tangram_schema ||=
  {
   'classes' =>
   [
     'UMMF::UML_1_5::Foundation::Core::Abstraction' =>
     {
       'table' => 'Foundation__Core__Abstraction',
       'abstract' => 0,
       'slots' => 
       { 
	 # Attributes
	 	       'mapping'
       => {
	 'type_impl' => 'ref',
         'class' => 'UMMF::UML_1_5::Foundation::Data_Types::MappingExpression',

                                             'col' => 'mapping', 

                                                                                                                   }
      ,
         
	 # Associations
	        },
       'bases' => [  'UMMF::UML_1_5::Foundation::Core::Dependency',  ],
       'sql' => {

       },
     },
   ],

   'sql' =>
   {
    # Note Tangram::Ref::get_exporter() has
    # "UPDATE $table SET $self->{col} = $refid WHERE id = $id",
    # The id_col is hard-coded, 
    # Thus id_col will not work.
    #'id_col' => '__sid',
    #'class_col' => '__stype',
   },
     # 'set_id' => sub { }
     # 'get_id' => sub { }

      
  };
}


#################################################################
# Class Attributes
#


      

#################################################################
# Class Associations
#


    

#################################################################
# Initialization
#


=head2 C<___initialize>

Initialize all Attributes and AssociationEnds in a instance of this Classifier.
Does B<not> initalize slots in its Generalizations.

See also: C<__initialize>.

=cut
sub ___initialize
{
  my ($self) = @_;

  # Attributes

    # Attribute mapping
  if ( exists $self->{'mapping'} ) {
    my $x = $self->{'mapping'};
    $self->{'mapping'} = undef;
        $self->set_mapping($x);
      } else {
      }
  


  # Associations


  $self;
}


my $__initialize_use;

=head2 C<__initialize>

Initialize all slots in this Classifier and all its Generalizations.

See also: C<___initialize>.

=cut
sub __initialize
{
  my ($self) = @_;

  # $DB::single = 1;

  unless ( ! $__initialize_use ) {
    $__initialize_use = 1;
    $self->__use('UMMF::UML_1_5::Foundation::Core::Element');
    $self->__use('UMMF::UML_1_5::Foundation::Core::ModelElement');
    $self->__use('UMMF::UML_1_5::Foundation::Core::Relationship');
    $self->__use('UMMF::UML_1_5::Foundation::Core::Dependency');
  }

  $self->UMMF::UML_1_5::Foundation::Core::Abstraction::___initialize;
  $self->UMMF::UML_1_5::Foundation::Core::Element::___initialize;
  $self->UMMF::UML_1_5::Foundation::Core::ModelElement::___initialize;
  $self->UMMF::UML_1_5::Foundation::Core::Relationship::___initialize;
  $self->UMMF::UML_1_5::Foundation::Core::Dependency::___initialize;

  $self;
}
      

=head2 C<__create>

Calls all <<create>> Methods for this Classifier and all Generalizations.

See also: C<___create>.

=cut
sub __create
{
  my ($self, @args) = @_;

  # $DB::single = 1;
  $self->UMMF::UML_1_5::Foundation::Core::Abstraction::___create(@args);
  $self->UMMF::UML_1_5::Foundation::Core::Element::___create();
  $self->UMMF::UML_1_5::Foundation::Core::ModelElement::___create();
  $self->UMMF::UML_1_5::Foundation::Core::Relationship::___create();
  $self->UMMF::UML_1_5::Foundation::Core::Dependency::___create();

  $self;
}




#################################################################
# Attributes
#



=for html <hr/>

=cut

#################################################################
# Attribute mapping
# type = UMMF::UML_1_5::Foundation::Data_Types::MappingExpression
# multiplicity = 1
# ordering = unordered
# ownerScope = instance
# initialValue = 

=head2 C<mapping>

  my $val = $obj->mapping;

Returns the L<UMMF::UML_1_5::Foundation::Data_Types::MappingExpression|UMMF::UML_1_5::Foundation::Data_Types::MappingExpression> value of Attribute C<mapping>.

=cut
sub mapping ($)
{
  my ($self) = @_;

  ;

  my $val = $self->{'mapping'};

  ;

  $val;
}


=head2 C<set_mapping>

  $obj->set_mapping($val);

Sets the value of Attribute C<mapping>.
C<$val> must be of type L<UMMF::UML_1_5::Foundation::Data_Types::MappingExpression|UMMF::UML_1_5::Foundation::Data_Types::MappingExpression> or C<undef>.
Returns C<$obj>.

=cut
sub set_mapping ($$)
{
  my ($self, $val) = @_;

  ;

  if ( defined $val ) {
    $self->__use('UMMF::UML_1_5::Foundation::Data_Types::MappingExpression')->__typecheck($val, "UMMF::UML_1_5::Foundation::Core::Abstraction.mapping");
  }

    $self->{'mapping'} = $val
  ;

  ;

  $self;
}


=head2 C<count_mapping>

  $obj->count_mapping;

Returns the number of elements (0 or 1) in C<mapping>.

=cut
sub count_mapping ($)
{
  my ($self) = @_;

  ;

  my $val = $self->{'mapping'};

  ;

  defined $val ? 1 : 0;
}




#################################################################
# Association
#





# End of Class Abstraction


=pod

=for html <hr/>

I<END OF DOCUMENT>

=cut

############################################################################

1; # is true!

############################################################################

### Keep these comments at end of file: kstephens@users.sourceforge.net 2003/04/06 ###
### Local Variables: ###
### mode:perl ###
### perl-indent-level:2 ###
### perl-continued-statement-offset:0 ###
### perl-brace-offset:0 ###
### perl-label-offset:0 ###
### End: ###

