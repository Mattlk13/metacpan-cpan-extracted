{
package Audio::Nama::TrackRegion;
use Role::Tiny;
use v5.36;
our $VERSION = 1.0;
use Audio::Nama::Globals qw(:all);
use Carp;

# these behaviors are associated with WAV playback

sub is_region { defined $_[0]->{region_start} }

sub region_start_time {
	my $track = shift;
	return unless $track->is_region;
	#return if $track->rec_status ne PLAY;
	#carp $track->name, ": expected PLAY status" if $track->rec_status ne PLAY;
	Audio::Nama::Mark::time_from_tag( $track->region_start )
}
sub region_end_time {
	my $track = shift;
	return unless $track->is_region;
	#return if $track->rec_status ne PLAY;
	#carp $track->name, ": expected PLAY status" if $track->rec_status ne PLAY;
	no warnings 'uninitialized'; 
	if ( $track->region_end eq 'END' ){
		return $track->wav_length;
	} else {
		Audio::Nama::Mark::time_from_tag( $track->region_end )
	}
}
sub playat_time {
	my $track = shift;
	#carp $track->name, ": expected PLAY status" if $track->rec_status ne PLAY;
	#return if $track->rec_status ne PLAY;
	Audio::Nama::Mark::time_from_tag( $track->playat )
}

# the following methods adjust
# region start and playat values during edit mode

sub shifted_length {
	my $track = shift;
	my $setup_length;
	if ($track->region_start){
		$setup_length = 	$track->shifted_region_end_time
				  - $track->shifted_region_start_time
	} else {
		$setup_length = 	$track->wav_length;
	}
	no warnings 'uninitialized';
	$setup_length += $track->shifted_playat_time;
}

sub shifted_region_start_time {
	my $track = shift;
	return $track->region_start_time unless $mode->{offset_run};
	Audio::Nama::new_region_start(Audio::Nama::edit_vars($track));
	
}
sub shifted_playat_time { 
	my $track = shift;
	return $track->playat_time unless $mode->{offset_run};
	Audio::Nama::new_playat(Audio::Nama::edit_vars($track));
}
sub shifted_region_end_time {
	my $track = shift;
	return $track->region_end_time unless $mode->{offset_run};
	Audio::Nama::new_region_end(Audio::Nama::edit_vars($track));
}

sub region_is_out_of_bounds {
	return unless $mode->{offset_run};
	my $track = shift;
	Audio::Nama::case(Audio::Nama::edit_vars($track)) =~ /out_of_bounds/
}

}
1