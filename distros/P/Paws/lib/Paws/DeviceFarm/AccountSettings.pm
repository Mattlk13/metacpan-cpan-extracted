package Paws::DeviceFarm::AccountSettings;
  use Moose;
  has AwsAccountNumber => (is => 'ro', isa => 'Str', request_name => 'awsAccountNumber', traits => ['NameInRequest']);
  has DefaultJobTimeoutMinutes => (is => 'ro', isa => 'Int', request_name => 'defaultJobTimeoutMinutes', traits => ['NameInRequest']);
  has MaxJobTimeoutMinutes => (is => 'ro', isa => 'Int', request_name => 'maxJobTimeoutMinutes', traits => ['NameInRequest']);
  has UnmeteredDevices => (is => 'ro', isa => 'Paws::DeviceFarm::PurchasedDevicesMap', request_name => 'unmeteredDevices', traits => ['NameInRequest']);
  has UnmeteredRemoteAccessDevices => (is => 'ro', isa => 'Paws::DeviceFarm::PurchasedDevicesMap', request_name => 'unmeteredRemoteAccessDevices', traits => ['NameInRequest']);
1;

### main pod documentation begin ###

=head1 NAME

Paws::DeviceFarm::AccountSettings

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::DeviceFarm::AccountSettings object:

  $service_obj->Method(Att1 => { AwsAccountNumber => $value, ..., UnmeteredRemoteAccessDevices => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::DeviceFarm::AccountSettings object:

  $result = $service_obj->Method(...);
  $result->Att1->AwsAccountNumber

=head1 DESCRIPTION

A container for account-level settings within AWS Device Farm.

=head1 ATTRIBUTES


=head2 AwsAccountNumber => Str

  The AWS account number specified in the C<AccountSettings> container.


=head2 DefaultJobTimeoutMinutes => Int

  The default number of minutes (at the account level) a test run will
execute before it times out. Default value is 60 minutes.


=head2 MaxJobTimeoutMinutes => Int

  The maximum number of minutes a test run will execute before it times
out.


=head2 UnmeteredDevices => L<Paws::DeviceFarm::PurchasedDevicesMap>

  Returns the unmetered devices you have purchased or want to purchase.


=head2 UnmeteredRemoteAccessDevices => L<Paws::DeviceFarm::PurchasedDevicesMap>

  Returns the unmetered remote access devices you have purchased or want
to purchase.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::DeviceFarm>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: https://github.com/pplu/aws-sdk-perl

Please report bugs to: https://github.com/pplu/aws-sdk-perl/issues

=cut

