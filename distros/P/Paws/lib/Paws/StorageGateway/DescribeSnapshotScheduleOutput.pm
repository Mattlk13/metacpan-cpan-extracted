
package Paws::StorageGateway::DescribeSnapshotScheduleOutput;
  use Moose;
  has Description => (is => 'ro', isa => 'Str');
  has RecurrenceInHours => (is => 'ro', isa => 'Int');
  has StartAt => (is => 'ro', isa => 'Int');
  has Timezone => (is => 'ro', isa => 'Str');
  has VolumeARN => (is => 'ro', isa => 'Str');

  has _request_id => (is => 'ro', isa => 'Str');

### main pod documentation begin ###

=head1 NAME

Paws::StorageGateway::DescribeSnapshotScheduleOutput

=head1 ATTRIBUTES


=head2 Description => Str

The snapshot description.


=head2 RecurrenceInHours => Int

The number of hours between snapshots.


=head2 StartAt => Int

The hour of the day at which the snapshot schedule begins represented
as I<hh>, where I<hh> is the hour (0 to 23). The hour of the day is in
the time zone of the gateway.


=head2 Timezone => Str

A value that indicates the time zone of the gateway.


=head2 VolumeARN => Str

The Amazon Resource Name (ARN) of the volume that was specified in the
request.


=head2 _request_id => Str


=cut

1;