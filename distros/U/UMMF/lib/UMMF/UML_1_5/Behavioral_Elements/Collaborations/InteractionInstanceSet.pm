# -*- perl -*-
# DO NOT EDIT - This file is generated by UMMF; http://ummf.sourceforge.net 
# From template: $Id: Perl.txt,v 1.77 2006/05/14 01:40:03 kstephens Exp $

package UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet;

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

UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet -- 

=head1 VERSION

1.5

=head1 SYNOPSIS

=head1 DESCRIPTION 

=head1 USAGE

=head1 EXPORT

=head1 METATYPE

L<UMMF::UML_1_5::Foundation::Core::Class|UMMF::UML_1_5::Foundation::Core::Class>

=head1 SUPERCLASSES

L<UMMF::UML_1_5::Foundation::Core::ModelElement|UMMF::UML_1_5::Foundation::Core::ModelElement>




=head1 ATTRIBUTES

I<NO ATTRIBUTES>


=head1 ASSOCIATIONS


=head2 C<interactionInstance> : I<THIS> C<0..*> E<lt>---E<gt>  C<context> : UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet C<1>



=over 4

=item metatype = L<UMMF::UML_1_5::Foundation::Core::AssociationEnd|UMMF::UML_1_5::Foundation::Core::AssociationEnd>

=item type = L<UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet|UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet>

=item multiplicity = C<1>

=item changeability = C<changeable>

=item targetScope = C<instance>

=item ordering = C<>

=item isNavigable = C<1>

=item aggregation = C<composite>

=item visibility = C<public>

=item container_type = C<Set::Object>

=back


=head2 C<interactionInstanceSet> : I<THIS> C<0..*> E<lt>---E<gt>  C<interaction> : UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction C<0..1>



=over 4

=item metatype = L<UMMF::UML_1_5::Foundation::Core::AssociationEnd|UMMF::UML_1_5::Foundation::Core::AssociationEnd>

=item type = L<UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction|UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction>

=item multiplicity = C<0..1>

=item changeability = C<changeable>

=item targetScope = C<instance>

=item ordering = C<>

=item isNavigable = C<1>

=item aggregation = C<none>

=item visibility = C<public>

=item container_type = C<Set::Object>

=back


=head2 C<interactionInstanceSet> : I<THIS> C<0..*> E<lt>---E<gt>  C<particpatingStimulus> : UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus C<1..*>



=over 4

=item metatype = L<UMMF::UML_1_5::Foundation::Core::AssociationEnd|UMMF::UML_1_5::Foundation::Core::AssociationEnd>

=item type = L<UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus|UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus>

=item multiplicity = C<1..*>

=item changeability = C<changeable>

=item targetScope = C<instance>

=item ordering = C<>

=item isNavigable = C<1>

=item aggregation = C<none>

=item visibility = C<public>

=item container_type = C<Set::Object>

=back



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
  UMMF::UML_1_5::Foundation::Core::ModelElement



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

  UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet->__validate_type($value);

Returns true if C<$value> is a valid representation of L<UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet|UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet>.

=cut
sub __validate_type($$)
{
  my ($self, $x) = @_;

  no warnings;

  UNIVERSAL::isa($x, 'UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet')  ;
}


=head2 C<__typecheck>

  UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet->__typecheck($value, $msg);

Calls C<confess()> with C<$msg> if C<<UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet->__validate_type($value)>> is false.

=cut
sub __typecheck
{
  my ($self, $x, $msg) = @_;

  confess("typecheck: $msg: type '" . 'UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet' . ": value '$x'")
    unless __validate_type($self, $x);
}


=head2 C<isaInteractionInstanceSet>


Returns true if receiver is a L<UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet|UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet>.
Other receivers will return false.

=cut
sub isaInteractionInstanceSet { 1 }


=head2 C<isaBehavioral_Elements__Collaborations__InteractionInstanceSet>


Returns true if receiver is a L<UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet|UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet>.
Other receivers will return false.
This is the fully qualified version of the C<isaInteractionInstanceSet> method.

=cut
sub isaBehavioral_Elements__Collaborations__InteractionInstanceSet { 1 }


#################################################################
# Introspection
#

=head2 C<__model_name> 

  my $name = $obj_or_package->__model_name;

Returns the UML Model name (C<'Behavioral_Elements::Collaborations::InteractionInstanceSet'>) for an object or package of
this Classifier.

=cut
sub __model_name { 'Behavioral_Elements::Collaborations::InteractionInstanceSet' }



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
     'UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet' =>
     {
       'table' => 'Behavioral_Elements__Collaborations__InteractionInstanceSet',
       'abstract' => 0,
       'slots' => 
       { 
	 # Attributes
	 
	 # Associations
	 	 	       'context'
       => {
	 'type_impl' => 'ref',
         'class' => 'UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet',

                                             'col' => 'context', 

                                                                                                                   }
      ,
                  	 	       'interaction'
       => {
	 'type_impl' => 'ref',
         'class' => 'UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction',

                  'null' => '1', 

                                    'col' => 'interaction', 

                                                                                                                   }
      ,
                  	 	       'particpatingStimulus'
       => {
	 'type_impl' => 'set',
         'class' => 'UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus',

                           'table' => 'Behavioral_Elements__InteractionInstanceSet_ParticpatingStimulus', 

                                                      'item' => 'particpatingStimulus', 

                  'coll' => 'interactionInstanceSet',

                                                                               }
      ,
                         },
       'bases' => [  'UMMF::UML_1_5::Foundation::Core::ModelElement',  ],
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



  # Associations

  # AssociationEnd 
  #  interactionInstance 0..*
  #  <--> 
  #  context 1 UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet.
    if ( defined $self->{'context'} ) {
    my $x = $self->{'context'};
    $self->{'context'} = undef;
    $self->set_context($x);
  }
  
  # AssociationEnd 
  #  interactionInstanceSet 0..*
  #  <--> 
  #  interaction 0..1 UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction.
    if ( defined $self->{'interaction'} ) {
    my $x = $self->{'interaction'};
    $self->{'interaction'} = undef;
    $self->set_interaction($x);
  }
  
  # AssociationEnd 
  #  interactionInstanceSet 0..*
  #  <--> 
  #  particpatingStimulus 1..* UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus.
    if ( defined $self->{'particpatingStimulus'} ) {
    my $x = $self->{'particpatingStimulus'};
        $self->{'particpatingStimulus'} = Set::Object->new();
        $self->set_particpatingStimulus(@$x);
  }
  

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
  }

  $self->UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet::___initialize;
  $self->UMMF::UML_1_5::Foundation::Core::Element::___initialize;
  $self->UMMF::UML_1_5::Foundation::Core::ModelElement::___initialize;

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
  $self->UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet::___create(@args);
  $self->UMMF::UML_1_5::Foundation::Core::Element::___create();
  $self->UMMF::UML_1_5::Foundation::Core::ModelElement::___create();

  $self;
}




#################################################################
# Attributes
#




#################################################################
# Association
#


=for html <hr/>

=cut

#################################################################
# AssociationEnd interactionInstance <---> context
# type = UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet
# multiplicity = 1
# ordering = 

=head2 C<context>

  my $val = $obj->context;

Returns the AssociationEnd C<context> value of type L<UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet|UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet>.

=cut
sub context ($)
{
  my ($self) = @_;
		  
  $self->{'context'};
}


=head2 C<set_context>

  $obj->set_context($val);

Sets the AssociationEnd C<context> value.
C<$val> must of type L<UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet|UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet>.
Returns C<$obj>.

=cut
sub set_context ($$)
{
  my ($self, $val) = @_;
		  
  no warnings; # Use of uninitialized value in string ne at ...
		  
  my $old;
  if ( ($old = $self->{'context'}) ne $val ) { # Recursion lock

    if ( defined $val ) { $self->__use('UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet')->__typecheck($val, "UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet.context") }

    # Recursion lock
        $self->{'context'} = $val
    ;

    # Remove and add associations with other ends.
        
    $old->remove_interactionInstance($self) if $old;
    $val->add_interactionInstance($self)    if $val;

    }
		  
  $self;
}


=head2 C<add_context>

  $obj->add_context($val);

Adds the AssociationEnd C<context> value.
C<$val> must of type L<UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet|UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet>.
Throws exception if a value already exists.
Returns C<$obj>.

=cut
sub add_context ($$)
{
  my ($self, $val) = @_;

  no warnings; # Use of uninitialized value in string ne at ...

  my $old;
  if ( ($old = $self->{'context'}) ne $val ) { # Recursion lock
    $self->__use('UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet')->__typecheck($val, "UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet.context");
      
    # confess("UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet::context: too many")
    # if defined $self->{'context'};

    # Recursion lock
        $self->{'context'} = $val
    ;

    # Remove and add associations with other ends.
        
    $old->remove_interactionInstance($self) if $old;
    $val->add_interactionInstance($self)    if $val;

  
  }

  $self;
}


=head2 C<remove_context>

  $obj->remove_context($val);

Removes the AssociationEnd C<context> value C<$val>.
Returns C<$obj>.

=cut
sub remove_context ($$)
{
  my ($self, $val) = @_;

  no warnings; # Use of uninitialized value in string ne at ...

  my $old;
  if ( ($old = $self->{'context'}) eq $val ) { # Recursion lock
    $val = $self->{'context'} = undef;         # Recursion lock

    # Remove and add associations with other ends.
        
    $old->remove_interactionInstance($self) if $old;
    $val->add_interactionInstance($self)    if $val;

  
  }
}


=head2 C<clear_context>

  $obj->clear_context;

Clears the AssociationEnd C<context> links to L<UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet|UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet>.
Returns C<$obj>.

=cut
sub clear_context ($@)
{
  my ($self) = @_;

  my $old;
  if ( defined ($old = $self->{'context'}) ) { # Recursion lock
    my $val = $self->{'context'} = undef;      # Recursion lock

    # Remove and add associations with other ends.
        
    $old->remove_interactionInstance($self) if $old;
    $val->add_interactionInstance($self)    if $val;

    }

  $self;
}


=head2 C<count_context>

  $obj->count_context;

Returns the number of elements of type L<UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet|UMMF::UML_1_5::Behavioral_Elements::Collaborations::CollaborationInstanceSet> associated with C<context>.

=cut
sub count_context ($)
{
  my ($self) = @_;

  my $x = $self->{'context'};

  defined $x ? 1 : 0;
}




=for html <hr/>

=cut

#################################################################
# AssociationEnd interactionInstanceSet <---> interaction
# type = UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction
# multiplicity = 0..1
# ordering = 

=head2 C<interaction>

  my $val = $obj->interaction;

Returns the AssociationEnd C<interaction> value of type L<UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction|UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction>.

=cut
sub interaction ($)
{
  my ($self) = @_;
		  
  $self->{'interaction'};
}


=head2 C<set_interaction>

  $obj->set_interaction($val);

Sets the AssociationEnd C<interaction> value.
C<$val> must of type L<UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction|UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction>.
Returns C<$obj>.

=cut
sub set_interaction ($$)
{
  my ($self, $val) = @_;
		  
  no warnings; # Use of uninitialized value in string ne at ...
		  
  my $old;
  if ( ($old = $self->{'interaction'}) ne $val ) { # Recursion lock

    if ( defined $val ) { $self->__use('UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction')->__typecheck($val, "UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet.interaction") }

    # Recursion lock
        $self->{'interaction'} = $val
    ;

    # Remove and add associations with other ends.
        
    $old->remove_interactionInstanceSet($self) if $old;
    $val->add_interactionInstanceSet($self)    if $val;

    }
		  
  $self;
}


=head2 C<add_interaction>

  $obj->add_interaction($val);

Adds the AssociationEnd C<interaction> value.
C<$val> must of type L<UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction|UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction>.
Throws exception if a value already exists.
Returns C<$obj>.

=cut
sub add_interaction ($$)
{
  my ($self, $val) = @_;

  no warnings; # Use of uninitialized value in string ne at ...

  my $old;
  if ( ($old = $self->{'interaction'}) ne $val ) { # Recursion lock
    $self->__use('UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction')->__typecheck($val, "UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet.interaction");
      
    # confess("UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet::interaction: too many")
    # if defined $self->{'interaction'};

    # Recursion lock
        $self->{'interaction'} = $val
    ;

    # Remove and add associations with other ends.
        
    $old->remove_interactionInstanceSet($self) if $old;
    $val->add_interactionInstanceSet($self)    if $val;

  
  }

  $self;
}


=head2 C<remove_interaction>

  $obj->remove_interaction($val);

Removes the AssociationEnd C<interaction> value C<$val>.
Returns C<$obj>.

=cut
sub remove_interaction ($$)
{
  my ($self, $val) = @_;

  no warnings; # Use of uninitialized value in string ne at ...

  my $old;
  if ( ($old = $self->{'interaction'}) eq $val ) { # Recursion lock
    $val = $self->{'interaction'} = undef;         # Recursion lock

    # Remove and add associations with other ends.
        
    $old->remove_interactionInstanceSet($self) if $old;
    $val->add_interactionInstanceSet($self)    if $val;

  
  }
}


=head2 C<clear_interaction>

  $obj->clear_interaction;

Clears the AssociationEnd C<interaction> links to L<UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction|UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction>.
Returns C<$obj>.

=cut
sub clear_interaction ($@)
{
  my ($self) = @_;

  my $old;
  if ( defined ($old = $self->{'interaction'}) ) { # Recursion lock
    my $val = $self->{'interaction'} = undef;      # Recursion lock

    # Remove and add associations with other ends.
        
    $old->remove_interactionInstanceSet($self) if $old;
    $val->add_interactionInstanceSet($self)    if $val;

    }

  $self;
}


=head2 C<count_interaction>

  $obj->count_interaction;

Returns the number of elements of type L<UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction|UMMF::UML_1_5::Behavioral_Elements::Collaborations::Interaction> associated with C<interaction>.

=cut
sub count_interaction ($)
{
  my ($self) = @_;

  my $x = $self->{'interaction'};

  defined $x ? 1 : 0;
}




=for html <hr/>

=cut

#################################################################
# AssociationEnd interactionInstanceSet <---> particpatingStimulus
# type = UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus
# multiplicity = 1..*
# ordering = 

=head2 C<particpatingStimulus>

  my @val = $obj->particpatingStimulus;
  my $ary_val = $obj->particpatingStimulus;

Returns the AssociationEnd C<particpatingStimulus> values of type L<UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus|UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus>.
In array context, returns all the objects in the Association.
In scalar context, returns an array ref of all the objects in the Association.

=cut
sub particpatingStimulus ($)
{
  my ($self) = @_;

    my $x = $self->{'particpatingStimulus'};

  # confess("Container for particpatingStimulus $x is not a blessed ref: " . Data::Dumper->new([ $self ], [qw($self)])->Maxdepth(2)->Dump()) if $x && ref($x) !~ /::/;
 
  wantarray ? ($x ? $x->members() : ()) : [ $x ? $x->members() : () ];
  
}


=head2 C<set_particpatingStimulus>

  $obj->set_particpatingStimulus(@val);

Sets the AssociationEnd C<particpatingStimulus> value.
Elements of C<@val> must of type L<UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus|UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus>.
Returns C<$obj>.

=cut
sub set_particpatingStimulus ($@)
{
  my ($self, @val) = @_;
  
  $self->clear_particpatingStimulus;
  $self->add_particpatingStimulus(@val);
}


=head2 C<add_particpatingStimulus>

  $obj->add_particpatingStimulus(@val);

Adds AssociationEnd C<particpatingStimulus> values.
Elements of C<@val> must of type L<UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus|UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus>.
Returns C<$obj>.

=cut
sub add_particpatingStimulus ($@)
{
  my ($self, @val) = @_;
  
    my $x = $self->{'particpatingStimulus'} ||= Set::Object->new();
    my $old; # Place holder for other MACRO.
  
  for my $val ( @val ) {
    # Recursion lock
        next if $x->includes($val);
        $self->__use('UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus')->__typecheck($val, "UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet.particpatingStimulus");

    # Recursion lock
        $x->insert($val);
    # weaken?
    
    # Remove and add associations with other ends.
        
    $old->remove_interactionInstanceSet($self) if $old;
    $val->add_interactionInstanceSet($self)    if $val;

    }
  
  $self;
}


=head2 C<remove_particpatingStimulus>

  $obj->remove_particpatingStimulus(@val);

Removes the AssociationEnd C<particpatingStimulus> values C<@val>.
Elements of C<@val> must of type L<UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus|UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus>.
Returns C<$obj>.

=cut
sub remove_particpatingStimulus ($@)
{
  my ($self, @val) = @_;
  
    my $x = $self->{'particpatingStimulus'} ||= Set::Object->new();
  
  for my $old ( @val ) {
    # Recursion lock
        next unless $x->includes($old);
    
    my $val = $old;
      
    $self->__use('UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus')->__typecheck($val, "UMMF::UML_1_5::Behavioral_Elements::Collaborations::InteractionInstanceSet.particpatingStimulus");

    # Recursion lock
        $x->remove($old);
    
    $val = undef;

    # Remove associations with other ends.

        
    $old->remove_interactionInstanceSet($self) if $old;
    $val->add_interactionInstanceSet($self)    if $val;

  ;

  }
  
  $self;
}


=head2 C<clear_particpatingStimulus>

  $obj->clear_particpatingStimulus;

Clears the AssociationEnd C<particpatingStimulus> links to L<UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus|UMMF::UML_1_5::Behavioral_Elements::Common_Behavior::Stimulus>.
Returns C<$obj>.

=cut
sub clear_particpatingStimulus ($) 
{
  my ($self) = @_;
  
    my $x = $self->{'particpatingStimulus'} ||= Set::Object->new();
  
  my $val; # Place holder for other MACRO.
  
    $self->{'particpatingStimulus'} = Set::Object->new(); # Recursion lock
  for my $old ( $x->members() ) {     # Recursion lock
  
    # Remove associations with other ends.

        
    $old->remove_interactionInstanceSet($self) if $old;
    $val->add_interactionInstanceSet($self)    if $val;

  ;

  }
  
  $self;
}


=head2 C<count_particpatingStimulus>

  $obj->count_particpatingStimulus;

Returns the number of elements associated with C<particpatingStimulus>.

=cut
sub count_particpatingStimulus ($)
{
  my ($self) = @_;

  my $x = $self->{'particpatingStimulus'};

    defined $x ? $x->size : 0;
  }







# End of Class InteractionInstanceSet


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

