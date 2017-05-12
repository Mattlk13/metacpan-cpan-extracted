package Paws::API::Caller;
  use Moose::Role;
  use Carp;
  use Paws::Net::APIRequest;

  has caller => (is => 'ro', required => 1);

  has credentials => (
    is => 'ro',
    does => 'Paws::Credential',
    required => 1,
    handles => [ 'access_key', 'secret_key', 'session_token' ],
  );

  requires 'new_from_result_struct';

  # converts the params the user passed to the call into objects that represent the call
  sub new_with_coercions {
    my ($self, $class, %params) = @_;

    Paws->load_class($class);
    my %p;

    if ($class->does('Paws::API::StrToObjMapParser')) {
      my ($subtype) = ($class->meta->find_attribute_by_name('Map')->type_constraint =~ m/^HashRef\[(.*?)\]$/);
      if (my ($array_of) = ($subtype =~ m/^ArrayRef\[(.*?)\]$/)){
        $p{ Map } = { map { $_ => [ map { $self->new_with_coercions("$array_of", %$_) } @{ $params{ $_ } } ] } keys %params };
      } else {
        $p{ Map } = { map { $_ => $self->new_with_coercions("$subtype", %{ $params{ $_ } }) } keys %params };
      }
    } elsif ($class->does('Paws::API::StrToNativeMapParser')) {
      $p{ Map } = { %params };
    } else {
      foreach my $att (keys %params){
        my $att_meta = $class->meta->find_attribute_by_name($att);
  
        croak "$class doesn't have an $att" if (not defined $att_meta);
        my $type = $att_meta->type_constraint;
  
        if ($type eq 'Bool') {
          $p{ $att } = ($params{ $att } == 1)?1:0;
        } elsif ($type eq 'Str' or $type eq 'Num' or $type eq 'Int') {
          $p{ $att } = $params{ $att };
        } elsif ($type =~ m/^ArrayRef\[(.*?)\]$/){
          my $subtype = "$1";
          if ($subtype eq 'Str' or $subtype eq 'Str|Undef' or $subtype eq 'Num' or $subtype eq 'Int' or $subtype eq 'Bool') {
            $p{ $att } = $params{ $att };
          } else {
            $p{ $att } = [ map { $self->new_with_coercions("$subtype", %{ $_ }) } @{ $params{ $att } } ];
          }
        } elsif ($type->isa('Moose::Meta::TypeConstraint::Enum')){
          $p{ $att } = $params{ $att };
        } else {
          $p{ $att } = $self->new_with_coercions("$type", %{ $params{ $att } });
        }
      }
    }
    return $class->new(%p);
  }

  sub to_hash {
    my ($self, $params) = @_;
    my $refHash = {};

    if      ($params->does('Paws::API::StrToNativeMapParser')) {
      return $params->Map;
    } elsif ($params->does('Paws::API::StrToObjMapParser')) {
      return { map { ($_ => $self->to_hash($params->Map->{$_})) } keys %{ $params->Map } };
    }

    foreach my $att (grep { $_ !~ m/^_/ } $params->meta->get_attribute_list) {
      my $key = $att;
      if (defined $params->$att) {
        my $att_type = $params->meta->get_attribute($att)->type_constraint;
        if ($att_type eq 'Bool') {
          $refHash->{ $key } = ($params->$att)?1:0;
        } elsif ($self->_is_internal_type($att_type)) {
          $refHash->{ $key } = $params->$att;
        } elsif ($att_type =~ m/^ArrayRef\[(.*)\]/) {
          if ($self->_is_internal_type("$1")){
            $refHash->{ $key } = $params->$att;
          } else {
            $refHash->{ $key } = [ map { $self->to_hash($_) } @{ $params->$att } ];
          }
        } elsif ($att_type->isa('Moose::Meta::TypeConstraint::Enum')) {
          $refHash->{ $key } = $params->$att;
        } else {
          $refHash->{ $key } = $self->to_hash($params->$att);
        }
      }
    }
    return $refHash;
  }

  sub response_to_object {
    my ($self, $unserialized_struct, $call_object, $http_status, $content, $headers) = @_;

    $call_object = $call_object->meta->name;
    my $request_id = $headers->{'x-amz-request-id'} 
                      || $headers->{'x-amzn-requestid'}
                      || $unserialized_struct->{'requestId'} 
                      || $unserialized_struct->{'RequestId'} 
                      || $unserialized_struct->{'RequestID'}
                      || $unserialized_struct->{ ResponseMetadata }->{ RequestId };
    

    if ($call_object->_returns){
      if ($call_object->_result_key){
        $unserialized_struct = $unserialized_struct->{ $call_object->_result_key };
      }

      $unserialized_struct->{ _request_id } = $request_id;
      
      Paws->load_class($call_object->_returns);
      my $o_result = $self->new_from_result_struct($call_object->_returns, $unserialized_struct);
      return $o_result;
    } else {
      return 1;
    }
  }

1;
