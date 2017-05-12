use strict;
use warnings;
use FFI::CheckLib;
use FFI::Platypus;

# NOTE: I ported this from the like named eg/notify.pl that came with FFI::Raw
# and it seems to work most of the time, but also seems to SIGSEGV sometimes.
# I saw the same behavior in the FFI::Raw version, and am not really familiar
# with the libnotify API to say what is the cause.  Patches welcome to fix it.

my $ffi = FFI::Platypus->new;
$ffi->lib(find_lib_or_exit lib => 'notify');

$ffi->attach(notify_init   => ['string'] => 'void');
$ffi->attach(notify_uninit => []       => 'void');
$ffi->attach([notify_notification_new    => 'notify_new']    => ['string', 'string', 'string']           => 'opaque');
$ffi->attach([notify_notification_update => 'notify_update'] => ['opaque', 'string', 'string', 'string'] => 'void');
$ffi->attach([notify_notification_show   => 'notify_show']   => ['opaque', 'opaque']                     => 'void');

notify_init('FFI::Platypus');
my $n = notify_new('','','');
notify_update($n, 'FFI::Platypus', 'It works!!!', 'media-playback-start');
notify_show($n, undef);
notify_uninit();
