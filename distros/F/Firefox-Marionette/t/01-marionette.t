#! /usr/bin/perl

use strict;
use warnings;
use Digest::SHA();
use MIME::Base64();
use Test::More tests => 338;
use Cwd();
use Firefox::Marionette qw(:all);
use Config;
use HTTP::Daemon();
use HTTP::Status();
use HTTP::Response();

my $segv_detected;
my $at_least_one_success;

my $test_time_limit = 90;

sub out_of_time {
	diag("Testing has been running for " . (time - $^T) . " seconds");
	if (time - $^T > $test_time_limit) {
		return 1;
	} else {
		return;
	}
}

my ($major_version, $minor_version, $patch_version); 
sub start_firefox {
	my ($require_visible, %parameters) = @_;
	if ($ENV{FIREFOX_BINARY}) {
		$parameters{firefox_binary} = $ENV{FIREFOX_BINARY};
		diag("Overriding firefox binary to $parameters{firefox_binary}");
	}
	if (defined $parameters{capabilities}) {
		if ($major_version < 52) {
			delete $parameters{capabilities}->{page_load_strategy};
			delete $parameters{capabilities}->{moz_webdriver_click};
			delete $parameters{capabilities}->{moz_accessibility_checks};
			delete $parameters{capabilities}->{accept_insecure_certs};
			delete $parameters{capabilities}->{moz_use_non_spec_compliant_pointer_origin};
		}
	}
	if ($ENV{FIREFOX_VISIBLE}) {
		$require_visible = 1;
		if (!$parameters{visible}) {
			$parameters{visible} = 1;
		}
		if ((defined $parameters{capabilities}) && ($parameters{capabilities}->moz_headless())) {
			my $old = $parameters{capabilities};
			my $new = { moz_headless => 0 };
			if (defined $old->proxy()) {
				$new->{proxy} = $old->proxy();
			}
			if (defined $old->moz_use_non_spec_compliant_pointer_origin()) {
				$new->{moz_use_non_spec_compliant_pointer_origin} = $old->moz_use_non_spec_compliant_pointer_origin();
			}
			if (defined $old->accept_insecure_certs()) {
				$new->{accept_insecure_certs} = $old->accept_insecure_certs();
			}
			if (defined $old->page_load_strategy()) {
				$new->{page_load_strategy} = $old->page_load_strategy();
			}
			if (defined $old->moz_webdriver_click()) {
				$new->{moz_webdriver_click} = $old->moz_webdriver_click();
			}
			if (defined $old->moz_accessibility_checks()) {
				$new->{moz_accessibility_checks} = $old->moz_accessibility_checks();
			}
			$parameters{capabilities} = Firefox::Marionette::Capabilities->new($new);
		}
		diag("Overriding firefox visibility");
	}
	my $skip_message;
	if ($segv_detected) {
		$skip_message = "Previous SEGV detected.  Trying to shutdown tests as fast as possible";
		return ($skip_message, undef);
	}
	if (out_of_time()) {
		$skip_message = "Running out of time.  Trying to shutdown tests as fast as possible";
		return ($skip_message, undef);
	}
        my $firefox;
	eval {
		$firefox = Firefox::Marionette->new(%parameters);
	};
	my $exception = $@;
	chomp $exception;
	if ($exception) {
		my ($package, $file, $line) = caller;
		my $source = $package eq 'main' ? $file : $package;
		diag("Exception in $source at line $line during new:$exception");
	}
	if ($exception =~ /^(Firefox exited with a 11|Firefox killed by a SEGV signal \(11\))/) {
		diag("Caught a SEGV type exception");
		if ($at_least_one_success) {
			$skip_message = "SEGV detected.  No need to restart";
			$segv_detected = 1;
			return ($skip_message, undef);
		} else {
			diag("Running any appliable memory checks");
			if ($^O eq 'linux') {
				diag("grep -r Mem /proc/meminfo");
				diag(`grep -r Mem /proc/meminfo`);
				diag("ulimit -a | grep -i mem");
				diag(`ulimit -a | grep -i mem`);
			} elsif ($^O =~ /bsd/i) {
				diag("sysctl hw | egrep 'hw.(phys|user|real)'");
				diag(`sysctl hw | egrep 'hw.(phys|user|real)'`);
				diag("ulimit -a | grep -i mem");
				diag(`ulimit -a | grep -i mem`);
			}
			my $time_to_recover = 2; # magic number.  No science behind it. Trying to give time to allow O/S to recover.
			diag("About to sleep for $time_to_recover seconds to allow O/S to recover");
			sleep $time_to_recover;
			$firefox = undef;
			eval {
				$firefox = Firefox::Marionette->new(%parameters);
			};
			if ($firefox) {
				$segv_detected = 1;
			} else {
				diag("Caught a second exception:$@");
				$skip_message = "Skip tests that depended on firefox starting successfully:$@";
			}
		}
	} elsif ($exception) {
		if (($^O eq 'MSWin32') || ($^O eq 'cygwin') || ($^O eq 'darwin')) {
			diag("Failed to start in $^O:$exception");
		} else {
			`Xvfb -help 2>/dev/null | grep displayfd`;
			if ($? == 0) {
				if ($require_visible) {
					diag("Failed to start a visible firefox in $^O but Xvfb succeeded:$exception");
				}
			} elsif ($? == 1) {
				`dbus-launch 2>/dev/null >/dev/null`;
				if ($? == 0) {
					if ($^O eq 'freebsd') {
						my $mount = `mount`;
						if ($mount =~ /fdescfs/) {
							diag("Failed to start with fdescfs mounted and a working Xvfb and D-Bus:$exception");
						} else {
							$skip_message = "Unable to launch a visible firefox in $^O without fdescfs mounted:$exception";
						}
					} else {
						diag("Failed to start with a working Xvfb and D-Bus:$exception");
					}
				} else {
					$skip_message = "Unable to launch a visible firefox in $^O with an incorrectly setup D-Bus:$exception";
				}
			} elsif ($require_visible) {
				diag("Failed to start a visible firefox in $^O but Xvfb succeeded:$exception");
				$skip_message = "Skip tests that depended on firefox starting successfully:$exception";
			} elsif ($ENV{DISPLAY}) {
				diag("Failed to start a hidden firefox in $^O with X11 DISPLAY $ENV{DISPLAY} is available:$exception");
				$skip_message = "Skip tests that depended on firefox starting successfully:$exception";
			} else {
				diag("Failed to start a hidden firefox in $^O:$exception");
			}
		}
	}
	return ($skip_message, $firefox);
}

umask 0;
my $binary = 'firefox';
if ($ENV{FIREFOX_BINARY}) {
	$binary = $ENV{FIREFOX_BINARY};
} elsif ( $^O eq 'MSWin32' ) {
    my $program_files_key;
    foreach my $possible ( 'ProgramFiles(x86)', 'ProgramFiles' ) {
        if ( $ENV{$possible} ) {
            $program_files_key = $possible;
            last;
        }
    }
    $binary = File::Spec->catfile(
        $ENV{$program_files_key},
        'Mozilla Firefox',
        'firefox.exe'
    );
}
elsif ( $^O eq 'darwin' ) {
    $binary = '/Applications/Firefox.app/Contents/MacOS/firefox';
} elsif ($^O eq 'cygwin') {
	if (-e "$ENV{PROGRAMFILES} (x86)") {
		$binary = "$ENV{PROGRAMFILES} (x86)/Mozilla Firefox/firefox.exe";
	} else {
		$binary = "$ENV{PROGRAMFILES}/Mozilla Firefox/firefox.exe";
	}
}
my $version_string = `"$binary" -version`;
diag("Version is $version_string");
if ($^O eq 'MSWin32') {
} elsif ($^O eq 'darwin') {
} else {
	if (exists $ENV{XAUTHORITY}) {
		diag("XAUTHORITY is $ENV{XAUTHORITY}");
	}
	if (exists $ENV{DISPLAY}) {
		diag("DISPLAY is $ENV{DISPLAY}");
	}
	`dbus-launch >/dev/null`;
	if ($? == 0) {
		diag("D-Bus is working");
	} else {
		diag("D-Bus appears to be broken.  'dbus-launch' was unable to successfully complete:$?");
	}
	if ($^O eq 'freebsd') {
		diag("xorg-vfbserver version is " . `pkg info xorg-vfbserver | perl -nle 'print "\$1" if (/Version\\s+:\\s+(\\S+)\\s*/);'`);
		diag("xauth version is " . `pkg info xauth | perl -nle 'print "\$1" if (/Version\\s+:\\s+(\\S+)\\s*/);'`);
		my $machine_id_path = '/etc/machine-id';
		if (-e $machine_id_path) {
			diag("$machine_id_path is ok");
		} else {
			diag("$machine_id_path has not been created.  Please run 'sudo dbus-uuidgen --ensure=$machine_id_path'");
		}
		print "mount | grep fdescfs\n";
		my $result = `mount | grep fdescfs`;
		if ($result =~ /fdescfs/) {
			diag("fdescfs has been mounted.  /dev/fd/ should work correctly for xvfb/xauth");
		} else {
			diag("It looks like 'sudo mount -t fdescfs fdesc /dev/fd' needs to be executed")
		}
	} elsif ($^O eq 'dragonfly') {
		diag("xorg-vfbserver version is " . `pkg info xorg-vfbserver | perl -nle 'print "\$1" if (/Version\\s+:\\s+(\\S+)\\s*/);'`);
		diag("xauth version is " . `pkg info xauth | perl -nle 'print "\$1" if (/Version\\s+:\\s+(\\S+)\\s*/);'`);
		my $machine_id_path = '/etc/machine-id';
		if (-e $machine_id_path) {
			diag("$machine_id_path is ok");
		} else {
			diag("$machine_id_path has not been created.  Please run 'sudo dbus-uuidgen --ensure=$machine_id_path'");
		}
	} elsif ($^O eq 'linux') {
		if (-f '/etc/debian_version') {
			diag("Debian Version is " . `cat /etc/debian_version`);
		} elsif (-f '/etc/redhat-release') {
			diag("Redhat Version is " . `cat /etc/redhat-release`);
		}
		`dpkg --help >/dev/null 2>/dev/null`;
		if ($? == 0) {	
			diag("Xvfb deb version is " . `dpkg -s Xvfb | perl -nle 'print if s/^Version:[ ]//smx'`);
		} else {
			`rpm --help >/dev/null 2>/dev/null`;
			if (($? == 0) && (-f '/usr/bin/Xvfb')) {
				diag("Xvfb rpm version is " . `rpm -qf /usr/bin/Xvfb`);
			}
		}
	}
}
if ($^O eq 'linux') {
	diag("grep -r Mem /proc/meminfo");
	diag(`grep -r Mem /proc/meminfo`);
	diag("ulimit -a | grep -i mem");
	diag(`ulimit -a | grep -i mem`);
} elsif ($^O =~ /bsd/i) {
	diag("sysctl hw | egrep 'hw.(phys|user|real)'");
	diag(`sysctl hw | egrep 'hw.(phys|user|real)'`);
	diag("ulimit -a | grep -i mem");
	diag(`ulimit -a | grep -i mem`);
}
my $count = 0;
foreach my $name (Firefox::Marionette::Profile->names()) {
	my $profile = Firefox::Marionette::Profile->existing($name);
	$count += 1;
}
ok(1, "Read $count existing profiles");
diag("This firefox installation has $count existing profiles");
my $profile;
eval {
	$profile = Firefox::Marionette::Profile->existing();
};
ok(1, "Read existing profile if any");
my $firefox;
eval {
	$firefox = Firefox::Marionette->new(firefox_binary => '/firefox/is/not/here');
};
chomp $@;
ok((($@) and (not($firefox))), "Firefox::Marionette->new() threw an exception when launched with an incorrect path to a binary:$@");
eval {
	$firefox = Firefox::Marionette->new(firefox_binary => $^X);
};
chomp $@;
ok((($@) and (not($firefox))), "Firefox::Marionette->new() threw an exception when launched with a path to a non firefox binary:$@");
my $skip_message;
ok($profile = Firefox::Marionette::Profile->new(), "Firefox::Marionette::Profile->new() correctly returns a new profile");
ok(((defined $profile->get_value('marionette.port')) && ($profile->get_value('marionette.port') == 0)), "\$profile->get_value('marionette.port') correctly returns 0");
ok($profile->set_value('browser.link.open_newwindow', 2), "\$profile->set_value('browser.link.open_newwindow', 2) to force new windows to appear");
ok($profile->set_value('browser.link.open_external', 2), "\$profile->set_value('browser.link.open_external', 2) to force new windows to appear");
ok($profile->set_value('browser.block.target_new_window', 'false'), "\$profile->set_value('browser.block.target_new_window', 'false') to force new windows to appear");
$profile->set_value('browser.link.open_newwindow', 2); # open in a new window
$profile->set_value('browser.link.open_newwindow.restriction', 1); # don't restrict new windows
$profile->set_value('dom.disable_open_during_load', 'false'); # don't block popups during page load
$profile->set_value('privacy.popups.disable_from_plugin', 0); # no restrictions
$profile->set_value('security.OCSP.GET.enabled', 'false'); 
$profile->clear_value('security.OCSP.enabled');  # just testing
$profile->set_value('security.OCSP.enabled', 0); 
SKIP: {
	($skip_message, $firefox) = start_firefox(0, debug => 1, profile => $profile, mime_types => [ 'application/pkcs10', 'application/pdf' ]);
	if (!$skip_message) {
		$at_least_one_success = 1;
	}
	if ($skip_message) {
		skip($skip_message, 38);
	}
	ok($firefox, "Firefox has started in Marionette mode");
	ok((scalar grep { /^application\/pkcs10$/ } $firefox->mime_types()), "application/pkcs10 has been added to mime_types");
	ok((scalar grep { /^application\/pdf$/ } $firefox->mime_types()), "application/pdf was already in mime_types");
	ok((scalar grep { /^application\/x\-gzip$/ } $firefox->mime_types()), "application/x-gzip was already in mime_types");
	ok((!scalar grep { /^text\/html$/ } $firefox->mime_types()), "text/html should not be in mime_types");
	my $capabilities = $firefox->capabilities();
	ok(!defined $capabilities->proxy(), "\$capabilities->proxy() is undefined");
	diag("Browser version is " . $capabilities->browser_version());
	($major_version, $minor_version, $patch_version) = split /[.]/smx, $capabilities->browser_version(); 
	diag("Operating System is " . $capabilities->platform_name() . q[ ] . $capabilities->platform_version());
	diag("Profile Directory is " . $capabilities->moz_profile());
	diag("Mozilla PID is " . $capabilities->moz_process_id());
	diag("Addons are " . $firefox->addons() ? 'working' : 'disabled');
	if ($firefox->xvfb()) {
		diag("Internal xvfb PID is " . $firefox->xvfb());
	}
	ok($firefox->application_type(), "\$firefox->application_type() returns " . $firefox->application_type());
	ok($firefox->marionette_protocol(), "\$firefox->marionette_protocol() returns " . $firefox->marionette_protocol());
	ok($firefox->window_type() eq 'navigator:browser', "\$firefox->window_type() returns 'navigator:browser':" . $firefox->window_type());
	ok($firefox->sleep_time_in_ms() == 1, "\$firefox->sleep_time_in_ms() is 1 millisecond");
	my $new_x = 3;
	my $new_y = 9;
	my $new_height = 452;
	my $new_width = 326;
	my $new = Firefox::Marionette::Window::Rect->new( pos_x => $new_x, pos_y => $new_y, height => $new_height, width => $new_width );
	my $old = $firefox->window_rect($new);
	TODO: {
		local $TODO = $major_version < 55 ? $capabilities->browser_version() . " probably does not have support for \$firefox->window_rect()->pos_x()" : q[];
		ok(defined $old->pos_x() && $old->pos_x() =~ /^\-?\d+([.]\d+)?$/, "Window used to have a X position of " . (defined $old->pos_x() ? $old->pos_x() : q[]));
		ok(defined $old->pos_y() && $old->pos_y() =~ /^\-?\d+([.]\d+)?$/, "Window used to have a Y position of " . (defined $old->pos_y() ? $old->pos_y() : q[]));
	}
	ok($old->width() =~ /^\d+([.]\d+)?$/, "Window used to have a width of " . $old->width());
	ok($old->height() =~ /^\d+([.]\d+)?$/, "Window used to have a height of " . $old->height());
	my $new2 = $firefox->window_rect();
	TODO: {
		local $TODO = $major_version < 55 ? $capabilities->browser_version() . " probably does not have support for \$firefox->window_rect()->pos_x()" : q[];
		ok(defined $new2->pos_x() && $new2->pos_x() == $new->pos_x(), "Window has a X position of " . $new->pos_x());
		ok(defined $new2->pos_y() && $new2->pos_y() == $new->pos_y(), "Window has a Y position of " . $new->pos_y());
	}
	ok($new2->width() == $new->width(), "Window has a width of " . $new->width());
	ok($new2->height() == $new->height(), "Window has a height of " . $new->height());
	TODO: {
		local $TODO = $major_version < 57 ? $capabilities->browser_version() . " probably does not have support for \$firefox->window_rect()->wstate()" : q[];
		ok(defined $old->wstate() && $old->wstate() =~ /^\w+$/, "Window has a state of " . ($old->wstate() || q[]));
	}
	my $rect = $firefox->window_rect();
	TODO: {
		local $TODO = $major_version < 55 ? $capabilities->browser_version() . " probably does not have support for \$firefox->window_rect()->pos_x()" : q[];
		ok(defined $rect->pos_x() && $rect->pos_x() =~ /^[-]?\d+([.]\d+)?$/, "Window has a X position of " . ($rect->pos_x() || q[]));
		ok(defined $rect->pos_y() && $rect->pos_y() =~ /^[-]?\d+([.]\d+)?$/, "Window has a Y position of " . ($rect->pos_y() || q[]));
	}
	ok($rect->width() =~ /^\d+([.]\d+)?$/, "Window has a width of " . $rect->width());
	ok($rect->height() =~ /^\d+([.]\d+)?$/, "Window has a height of " . $rect->height());
	my $page_timeout = 45_043;
	my $script_timeout = 48_021;
	my $implicit_timeout = 41_001;
	$new = Firefox::Marionette::Timeouts->new(page_load => $page_timeout, script => $script_timeout, implicit => $implicit_timeout);
	my $timeouts = $firefox->timeouts($new);
	ok((ref $timeouts) eq 'Firefox::Marionette::Timeouts', "\$firefox->timeouts() returns a Firefox::Marionette::Timeouts object");
	ok($timeouts->page_load() == 300_000, "\$timeouts->page_load() is 5 minutes");
	ok($timeouts->script() == 30_000, "\$timeouts->script() is 30 seconds");
	ok(defined $timeouts->implicit() && $timeouts->implicit() == 0, "\$timeouts->implicit() is 0 milliseconds");
	$timeouts = $firefox->timeouts($new);
	ok($timeouts->page_load() == $page_timeout, "\$timeouts->page_load() is $page_timeout");
	ok($timeouts->script() == $script_timeout, "\$timeouts->script() is $script_timeout");
	ok($timeouts->implicit() == $implicit_timeout, "\$timeouts->implicit() is $implicit_timeout");
	ok(!defined $firefox->child_error(), "Firefox does not have a value for child_error");
	ok($firefox->alive(), "Firefox is still alive");
	ok(not($firefox->script('window.open("https://duckduckgo.com", "_blank");')), "Opening new window to duckduckgo.com via 'window.open' script");
	ok($firefox->close_current_window_handle(), "Closed new tab/window");
	SKIP: {
		if ($major_version < 55) {
			skip("Deleting and re-creating sessions can hang firefox for old versions", 1);
		}
		ok($firefox->delete_session()->new_session(), "\$firefox->delete_session()->new_session() has cleared the old session and created a new session");
	}
	my $child_error = $firefox->quit();
	if ($child_error != 0) {
		diag("Firefox exited with a \$? of $child_error");
	}
	ok($child_error =~ /^\d+$/, "Firefox has closed with an integer exit status of " . $child_error);
	ok($firefox->child_error() == $child_error, "Firefox returns $child_error for the child error, matching the return value of quit():$child_error:" . $firefox->child_error());
	ok(!$firefox->alive(), "Firefox is not still alive");
}

SKIP: {
	my $daemon = HTTP::Daemon->new() || die "Failed to create HTTP::Daemon";
	my $localPort = URI->new($daemon->url())->port();
	my $proxy = Firefox::Marionette::Proxy->new( http => 'localhost:' . $localPort, https => 'proxy.example.org:4343', ftp => 'ftp.example.org:2121', none => [ 'local.example.org' ], socks => 'socks.example.org:1081' );
	($skip_message, $firefox) = start_firefox(0, debug => 1, sleep_time_in_ms => 5, profile => $profile, capabilities => Firefox::Marionette::Capabilities->new(proxy => $proxy, moz_headless => 1, accept_insecure_certs => 1, page_load_strategy => 'eager', moz_webdriver_click => 1, moz_accessibility_checks => 1, moz_use_non_spec_compliant_pointer_origin => 1));
	if (!$skip_message) {
		$at_least_one_success = 1;
	}
	if ($skip_message) {
		skip($skip_message, 19);
	}
	ok($firefox, "Firefox has started in Marionette mode with definable capabilities set to known values");
	ok($firefox->sleep_time_in_ms() == 5, "\$firefox->sleep_time_in_ms() is 5 milliseconds");
	my $capabilities = $firefox->capabilities();
	ok((ref $capabilities) eq 'Firefox::Marionette::Capabilities', "\$firefox->capabilities() returns a Firefox::Marionette::Capabilities object");
	SKIP: {
		if (!grep /^page_load_strategy$/, $capabilities->enumerate()) {
			diag("\$capabilities->page_load_strategy is not supported for " . $capabilities->browser_version());
			skip("\$capabilities->page_load_strategy is not supported for " . $capabilities->browser_version(), 1);
		}
		ok($capabilities->page_load_strategy() eq 'eager', "\$capabilities->page_load_strategy() is 'eager'");
	}
	SKIP: {
		if (!grep /^accept_insecure_certs$/, $capabilities->enumerate()) {
			diag("\$capabilities->accept_insecure_certs is not supported for " . $capabilities->browser_version());
			skip("\$capabilities->accept_insecure_certs is not supported for " . $capabilities->browser_version(), 1);
		}
		ok($capabilities->accept_insecure_certs() == 1, "\$capabilities->accept_insecure_certs() is set to true");
	}
	SKIP: {
		if (!grep /^moz_webdriver_click$/, $capabilities->enumerate()) {
			diag("\$capabilities->moz_webdriver_click is not supported for " . $capabilities->browser_version());
			skip("\$capabilities->moz_webdriver_click is not supported for " . $capabilities->browser_version(), 1);
		}
		ok($capabilities->moz_webdriver_click() == 1, "\$capabilities->moz_webdriver_click() is set to true");
	}
	SKIP: {
		if (!grep /^moz_use_non_spec_compliant_pointer_origin$/, $capabilities->enumerate()) {
			diag("\$capabilities->moz_use_non_spec_compliant_pointer_origin is not supported for " . $capabilities->browser_version());
			skip("\$capabilities->moz_use_non_spec_compliant_pointer_origin is not supported for " . $capabilities->browser_version(), 1);
		}
		ok($capabilities->moz_use_non_spec_compliant_pointer_origin() == 1, "\$capabilities->moz_use_non_spec_compliant_pointer_origin() is set to true");
	}
	SKIP: {
		if (!grep /^moz_accessibility_checks$/, $capabilities->enumerate()) {
			diag("\$capabilities->moz_accessibility_checks is not supported for " . $capabilities->browser_version());
			skip("\$capabilities->moz_accessibility_checks is not supported for " . $capabilities->browser_version(), 1);
		}
		ok($capabilities->moz_accessibility_checks() == 1, "\$capabilities->moz_accessibility_checks() is set to true");
	}
	TODO: {
		local $TODO = $major_version < 56 ? $capabilities->browser_version() . " does not have support for -headless argument" : q[];
		ok($capabilities->moz_headless() == 1 || $ENV{FIREFOX_VISIBLE} || 0, "\$capabilities->moz_headless() is set to " . ($ENV{FIREFOX_VISIBLE} ? 'true' : 'false'));
	}
	$capabilities = $firefox->capabilities();
	ok((ref $capabilities) eq 'Firefox::Marionette::Capabilities', "\$firefox->capabilities() returns a Firefox::Marionette::Capabilities object");
	ok($capabilities->proxy()->type() eq 'manual', "\$capabilities->proxy()->type() is 'manual'");
	ok($capabilities->proxy()->http() eq 'localhost:' . $localPort, "\$capabilities->proxy()->http() is 'localhost:" . $localPort . "':" . $capabilities->proxy()->http());
	ok($capabilities->proxy()->https() eq 'proxy.example.org:4343', "\$capabilities->proxy()->https() is 'proxy.example.org:4343'");
	ok($capabilities->proxy()->ftp() eq 'ftp.example.org:2121', "\$capabilities->proxy()->ftp() is 'ftp.example.org:2121'");
	my $none = 0;
	foreach my $host ($capabilities->proxy()->none()) {
		$none += 1;
	}
	ok($capabilities->proxy()->socks() eq 'socks.example.org:1081', "\$capabilities->proxy()->socks() is 'socks.example.org:1081':" . $capabilities->proxy()->socks() );
	ok($capabilities->proxy()->socks_version() == 5, "\$capabilities->proxy()->socks_version() is 5");
	TODO: {
		local $TODO = $major_version < 58 ? $capabilities->browser_version() . " does not have support for \$firefox->capabilities()->none()" : q[];
		ok($none == 1, "\$capabilities->proxy()->none() is a reference to a list with 1 element");
	}
	SKIP: {
		if ((exists $Config::Config{'d_fork'}) && (defined $Config::Config{'d_fork'}) && ($Config::Config{'d_fork'} eq 'define')) {
			my @sig_nums  = split q[ ], $Config{sig_num};
			my @sig_names = split q[ ], $Config{sig_name};
			my %signals_by_name;
			my $idx = 0;
			foreach my $sig_name (@sig_names) {
				$signals_by_name{$sig_name} = $sig_nums[$idx];
				$idx += 1;
			}
			if (my $pid = fork) {
				$firefox->go('http://wtf.example.org');
				ok($firefox->html() =~ /success/smx, "Correctly accessed the Proxy");
				diag($firefox->html());
				while(kill $signals_by_name{TERM}, $pid) {
					waitpid $pid, POSIX::WNOHANG();
					sleep 1;
				}
			} elsif (defined $pid) {
				eval {
					alarm 5;
					$0 = "[Test HTTP Proxy for " . getppid . "]";
					while (my $connection = $daemon->accept()) {
						diag("Accepted connection");
						if (my $child = fork) {
						} elsif (defined $child) {
							eval {
								alarm 5;
								while (my $request = $connection->get_request()) {
									diag("Got request for " . $request->uri());
									my $response = HTTP::Response->new(200, "OK", undef, "success");
									$connection->send_response($response);
								}
								$connection->close;
								$connection = undef;
							};
							exit 0;
						} else {
							diag("Failed to fork connection:$!");
							die "Failed to fork:$!";
						}
					}
				} or do {
					chomp $@;
					warn "$@\n";
				};
				exit 1;
			} else {
				diag("Failed to fork http proxy:$!");
				die "Failed to fork:$!";
			}
		} else {
			skip("No forking available for $^O", 1);
			diag("No forking available for $^O");
		}
	}
	ok($firefox->quit() == 0, "Firefox has closed with an exit status of 0:" . $firefox->child_error());
}

SKIP: {
	($skip_message, $firefox) = start_firefox(0, debug => 1, capabilities => Firefox::Marionette::Capabilities->new(proxy => Firefox::Marionette::Proxy->new( pac => URI->new('https://proxy.example.org')), moz_headless => 1));
	if (!$skip_message) {
		$at_least_one_success = 1;
	}
	if ($skip_message) {
		skip($skip_message, 5);
	}
	ok($firefox, "Firefox has started in Marionette mode with definable capabilities set to known values");
	my $capabilities = $firefox->capabilities();
	ok((ref $capabilities) eq 'Firefox::Marionette::Capabilities', "\$firefox->capabilities() returns a Firefox::Marionette::Capabilities object");
	ok($capabilities->proxy()->type() eq 'pac', "\$capabilities->proxy()->type() is 'pac'");
	ok($capabilities->proxy()->pac()->host() eq 'proxy.example.org', "\$capabilities->proxy()->pac()->host() is 'proxy.example.org'");
	ok($firefox->quit() == 0, "Firefox has closed with an exit status of 0:" . $firefox->child_error());
}

SKIP: {
	($skip_message, $firefox) = start_firefox(0, debug => 0, profile => $profile);
	if (!$skip_message) {
		$at_least_one_success = 1;
	}
	if ($skip_message) {
		skip($skip_message, 240);
	}
	ok($firefox, "Firefox has started in Marionette mode without defined capabilities, but with a defined profile and debug turned off");
	ok($firefox->go(URI->new("https://www.w3.org/WAI/UA/TS/html401/cp0101/0101-FRAME-TEST.html")), "https://www.w3.org/WAI/UA/TS/html401/cp0101/0101-FRAME-TEST.html has been loaded");
	ok($firefox->interactive() && $firefox->loaded(), "\$firefox->interactive() and \$firefox->loaded() are ok");
	ok($firefox->window_handle() =~ /^\d+$/, "\$firefox->window_handle() is an integer:" . $firefox->window_handle());
	ok($firefox->chrome_window_handle() =~ /^\d+$/, "\$firefox->chrome_window_handle() is an integer:" . $firefox->chrome_window_handle());
	ok($firefox->chrome_window_handle() == $firefox->current_chrome_window_handle(), "\$firefox->chrome_window_handle() is equal to \$firefox->current_chrome_window_handle()");
	ok(scalar $firefox->chrome_window_handles() == 1, "There is one window/tab open at the moment");
	ok(scalar $firefox->window_handles() == 1, "There is one actual window open at the moment");
	my ($original_chrome_window_handle) = $firefox->chrome_window_handles();
	foreach my $handle ($firefox->chrome_window_handles()) {
		ok($handle =~ /^\d+$/, "\$firefox->chrome_window_handles() returns a list of integers:" . $handle);
	}
	my ($original_window_handle) = $firefox->window_handles();
	foreach my $handle ($firefox->window_handles()) {
		ok($handle =~ /^\d+$/, "\$firefox->window_handles() returns a list of integers:" . $handle);
	}
	ok(not($firefox->script('window.open("https://duckduckgo.com", "_blank");')), "Opening new window to duckduckgo.com via 'window.open' script");
	ok(scalar $firefox->chrome_window_handles() == 2, "There are two windows/tabs open at the moment");
	ok(scalar $firefox->window_handles() == 2, "There are two actual windows open at the moment");
	my $new_chrome_window_handle;
	foreach my $handle ($firefox->chrome_window_handles()) {
		ok($handle =~ /^\d+$/, "\$firefox->chrome_window_handles() returns a list of integers:" . $handle);
		if ($handle != $original_chrome_window_handle) {
			$new_chrome_window_handle = $handle;
		}
	}
	ok($new_chrome_window_handle, "New chrome window handle $new_chrome_window_handle detected");
	my $new_window_handle;
	foreach my $handle ($firefox->window_handles()) {
		ok($handle =~ /^\d+$/, "\$firefox->window_handles() returns a list of integers:" . $handle);
		if ($handle != $original_window_handle) {
			$new_window_handle = $handle;
		}
	}
	ok($new_window_handle, "New window handle $new_window_handle detected");
	TODO: {
		my $screen_orientation = q[];
		eval {
			$screen_orientation = $firefox->screen_orientation();
			ok($screen_orientation, "\$firefox->screen_orientation() is " . $screen_orientation);
		} or do {
			if (($@->isa('Firefox::Marionette::Exception')) && ($@ =~ /Only supported in Fennec.* in .* at line \d+/)) {
				local $TODO = "Only supported in Fennec";
				ok($screen_orientation, "\$firefox->screen_orientation() is " . $screen_orientation);
			} elsif ($major_version < 52) {
				my $exception = "$@";
				chomp $exception;
				diag("\$firefox->screen_orientation() is unavailable in " . $firefox->browser_version() . ":$exception");
				local $TODO = "\$firefox->screen_orientation() is unavailable in " . $firefox->browser_version() . ":$exception";
				ok($screen_orientation, "\$firefox->screen_orientation() is " . $screen_orientation);
			} else {
				ok($screen_orientation, "\$firefox->screen_orientation() is " . $screen_orientation);
			}
		};
	}
	ok($firefox->switch_to_window($original_window_handle), "\$firefox->switch_to_window() used to move back to the original window:$@");
	TODO: {
		my $element;
		eval {
			$element = $firefox->find('//frame[@name="target1"]')->switch_to_shadow_root();
		};
		if ($@) {
			diag("Switch to shadow root is broken:$@");
		}
		local $TODO = "Switch to shadow root can be broken";
		ok($element, "Switched to target1 shadow root");
	}
	ok($firefox->list('//frame[@name="target1"]')->switch_to_frame(), "Switched to target1 frame");
	ok($firefox->active_frame()->isa('Firefox::Marionette::Element'), "\$firefox->active_frame() returns a Firefox::Marionette::Element object");
	ok($firefox->switch_to_parent_frame(), "Switched to parent frame");
	foreach my $handle ($firefox->close_current_chrome_window_handle()) {
		local $TODO = $major_version < 52 ? "\$firefox->close_current_chrome_window_handle() can return a undef value for versions less than 52" : "";
		ok(defined $handle && $handle == $new_chrome_window_handle, "Closed original window, which means the remaining chrome window handle should be $new_chrome_window_handle:" . ($handle || ''));
	}
	ok($firefox->switch_to_window($new_window_handle), "\$firefox->switch_to_window() used to move back to the original window");
	ok($firefox->go("https://metacpan.org/"), "metacpan.org has been loaded in the new window");
	my $uri = $firefox->uri();
	ok($uri eq 'https://metacpan.org/', "\$firefox->uri() is equal to https://metacpan.org/:$uri");
	ok($firefox->title() =~ /Search/, "metacpan.org has a title containing Search");
	ok($firefox->context('chrome') eq 'content', "Initial context of the browser is 'content'");
	ok($firefox->context('content') eq 'chrome', "Changed context of the browser is 'chrome'");
	ok($firefox->page_source() =~ /lucky/smx, "metacpan.org contains the phrase 'lucky' in page source");
	ok($firefox->html() =~ /lucky/smx, "metacpan.org contains the phrase 'lucky' in html");
	ok($firefox->refresh(), "\$firefox->refresh()");
	my $element = $firefox->active_element();
	ok($element, "\$firefox->active_element() returns an element");
	ok(not(defined $firefox->active_frame()), "\$firefox->active_frame() is undefined for " . $firefox->uri());
	ok($firefox->find('//input[@id="search-input"]', BY_XPATH())->type('Test::More'), "Sent 'Test::More' to the 'search-input' field directly to the element");
	my $autofocus;
	ok($autofocus = $firefox->find_element('//input[@id="search-input"]')->attribute('autofocus'), "The value of the autofocus attribute is '$autofocus'");
	ok($autofocus = $firefox->find('//input[@id="search-input"]')->property('autofocus'), "The value of the autofocus property is '$autofocus'");
	ok($firefox->find_by_class('main-content')->find('//input[@id="search-input"]')->property('id') eq 'search-input', "Correctly found nested element with find");
	my $count = 0;
	foreach my $element ($firefox->find_by_class('main-content')->list('//input[@id="search-input"]')) {
		ok($element->property('id') eq 'search-input', "Correctly found nested element with list");
		$count += 1;
	}
	ok($count == 1, "Found elements with nested list:$count");
	$count = 0;
	foreach my $element ($firefox->find_by_class('main-content')->find('//input[@id="search-input"]')) {
		ok($element->property('id') eq 'search-input', "Correctly found nested element with find");
		$count += 1;
	}
	ok($count == 1, "Found elements with nested find:$count");
	$count = 0;
	foreach my $element ($firefox->find('//input[@id="search-input"]')) {
		ok($element->property('id') eq 'search-input', "Correctly found element with wantarray find");
		$count += 1;
	}
	ok($count == 1, "Found elements with wantarray find:$count");
	ok($firefox->find('search-input', 'id')->property('id') eq 'search-input', "Correctly found element when searching by id");
	ok($firefox->find('search-input', BY_ID())->property('id') eq 'search-input', "Correctly found element when searching by id");
	ok($firefox->list_by_id('search-input')->property('id') eq 'search-input', "Correctly found element with list_by_id");
	ok($firefox->find_by_id('search-input')->property('id') eq 'search-input', "Correctly found element with find_by_id");
	ok($firefox->find_by_class('main-content')->find_by_id('search-input')->property('id') eq 'search-input', "Correctly found nested element with find_by_id");
	ok($firefox->find_id('search-input')->property('id') eq 'search-input', "Correctly found element with find_id");
	ok($firefox->find_class('main-content')->find_id('search-input')->property('id') eq 'search-input', "Correctly found nested element with find_id");
	$count = 0;
	foreach my $element ($firefox->find_by_class('main-content')->list_by_id('search-input')) {
		ok($element->property('id') eq 'search-input', "Correctly found nested element with list_by_id");
		$count += 1;
	}
	ok($count == 1, "Found elements with nested list_by_id:$count");
	$count = 0;
	foreach my $element ($firefox->find_by_class('main-content')->find_by_id('search-input')) {
		ok($element->property('id') eq 'search-input', "Correctly found nested element with find_by_id");
		$count += 1;
	}
	ok($count == 1, "Found elements with nested find_by_id:$count");
	$count = 0;
	foreach my $element ($firefox->find_class('main-content')->find_id('search-input')) {
		ok($element->property('id') eq 'search-input', "Correctly found nested element with find_id");
		$count += 1;
	}
	ok($count == 1, "Found elements with nested find_id:$count");
	$count = 0;
	foreach my $element ($firefox->find_by_id('search-input')) {
		ok($element->property('id') eq 'search-input', "Correctly found element with wantarray find_by_id");
		$count += 1;
	}
	ok($count == 1, "Found elements with wantarray find_by_id:$count");
	ok($firefox->find('q', 'name')->property('id') eq 'search-input', "Correctly found element when searching by id");
	ok($firefox->find('q', BY_NAME())->property('id') eq 'search-input', "Correctly found element when searching by id");
	ok($firefox->list_by_name('q')->property('id') eq 'search-input', "Correctly found element with list_by_name");
	ok($firefox->find_by_name('q')->property('id') eq 'search-input', "Correctly found element with find_by_name");
	ok($firefox->find_by_class('main-content')->find_by_name('q')->property('id') eq 'search-input', "Correctly found nested element with find_by_name");
	ok($firefox->find_name('q')->property('id') eq 'search-input', "Correctly found element with find_name");
	ok($firefox->find_class('main-content')->find_name('q')->property('id') eq 'search-input', "Correctly found nested element with find_name");
	$count = 0;
	foreach my $element ($firefox->find_by_class('main-content')->list_by_name('q')) {
		ok($element->property('id') eq 'search-input', "Correctly found nested element with list_by_name");
		$count += 1;
	}
	ok($count == 1, "Found elements with nested list_by_name:$count");
	$count = 0;
	foreach my $element ($firefox->find_by_class('main-content')->find_by_name('q')) {
		ok($element->property('id') eq 'search-input', "Correctly found nested element with find_by_name");
		$count += 1;
	}
	ok($count == 1, "Found elements with nested find_by_name:$count");
	$count = 0;
	foreach my $element ($firefox->find_by_name('q')) {
		ok($element->property('id') eq 'search-input', "Correctly found element with wantarray find_by_name");
		$count += 1;
	}
	ok($count == 1, "Found elements with wantarray find_by_name:$count");
	$count = 0;
	foreach my $element ($firefox->find_name('q')) {
		ok($element->property('id') eq 'search-input', "Correctly found element with wantarray find_name");
		$count += 1;
	}
	ok($count == 1, "Found elements with wantarray find_name:$count");
	ok($firefox->find('input', 'tag name')->property('id'), "Correctly found element when searching by tag name");
	ok($firefox->find('input', BY_TAG())->property('id'), "Correctly found element when searching by tag name");
	ok($firefox->list_by_tag('input')->property('id'), "Correctly found element with list_by_tag");
	ok($firefox->find_by_tag('input')->property('id'), "Correctly found element with find_by_tag");
	ok($firefox->find_by_class('main-content')->find_by_tag('input')->property('id'), "Correctly found nested element with find_by_tag");
	ok($firefox->find_tag('input')->property('id'), "Correctly found element with find_tag");
	ok($firefox->find_class('main-content')->find_tag('input')->property('id'), "Correctly found nested element with find_tag");
	$count = 0;
	foreach my $element ($firefox->find_by_class('main-content')->list_by_tag('input')) {
		ok($element->property('id'), "Correctly found nested element with list_by_tag");
		$count += 1;
	}
	ok($count == 2, "Found elements with nested list_by_tag:$count");
	$count = 0;
	foreach my $element ($firefox->find_by_class('main-content')->find_by_tag('input')) {
		ok($element->property('id'), "Correctly found nested element with find_by_tag");
		$count += 1;
	}
	ok($count == 2, "Found elements with nested find_by_tag:$count");
	$count = 0;
	foreach my $element ($firefox->find_by_tag('input')) {
		ok($element->property('id'), "Correctly found element with wantarray find_by_tag");
		$count += 1;
	}
	ok($count == 2, "Found elements with wantarray find_by_tag:$count");
	$count = 0;
	foreach my $element ($firefox->find_tag('input')) {
		ok($element->property('id'), "Correctly found element with wantarray find_tag");
		$count += 1;
	}
	ok($count == 2, "Found elements with wantarray find_by_tag:$count");
	ok($firefox->find('form-control home-search-input', 'class name')->property('id'), "Correctly found element when searching by class name");
	ok($firefox->find('form-control home-search-input', BY_CLASS())->property('id'), "Correctly found element when searching by class name");
	ok($firefox->list_by_class('form-control home-search-input')->property('id'), "Correctly found element with list_by_class");
	ok($firefox->find_by_class('form-control home-search-input')->property('id'), "Correctly found element with find_by_class");
	ok($firefox->find_by_class('main-content')->find_by_class('form-control home-search-input')->property('id'), "Correctly found nested element with find_by_class");
	ok($firefox->find_class('form-control home-search-input')->property('id'), "Correctly found element with find_class");
	ok($firefox->find_class('main-content')->find_class('form-control home-search-input')->property('id'), "Correctly found nested element with find_class");
	$count = 0;
	foreach my $element ($firefox->find_by_class('main-content')->list_by_class('form-control home-search-input')) {
		ok($element->property('id'), "Correctly found nested element with list_by_class");
		$count += 1;
	}
	ok($count == 1, "Found elements with nested find_by_class:$count");
	$count = 0;
	foreach my $element ($firefox->find_by_class('main-content')->find_by_class('form-control home-search-input')) {
		ok($element->property('id'), "Correctly found element with wantarray find_by_class");
		$count += 1;
	}
	ok($count == 1, "Found elements with wantarray find_by_class:$count");
	$count = 0;
	foreach my $element ($firefox->find_class('main-content')->find_class('form-control home-search-input')) {
		ok($element->property('id'), "Correctly found element with wantarray find_class");
		$count += 1;
	}
	ok($count == 1, "Found elements with wantarray find_by_class:$count");
	ok($firefox->find('input.home-search-input', 'css selector')->property('id'), "Correctly found element when searching by css selector");
	ok($firefox->find('input.home-search-input', BY_SELECTOR())->property('id'), "Correctly found element when searching by css selector");
	ok($firefox->list_by_selector('input.home-search-input')->property('id'), "Correctly found element with list_by_selector");
	ok($firefox->find_by_selector('input.home-search-input')->property('id'), "Correctly found element with find_by_selector");
	ok($firefox->find_by_class('main-content')->find_by_selector('input.home-search-input')->property('id'), "Correctly found nested element with find_by_selector");
	ok($firefox->find_selector('input.home-search-input')->property('id'), "Correctly found element with find_selector");
	ok($firefox->find_class('main-content')->find_selector('input.home-search-input')->property('id'), "Correctly found nested element with find_selector");
	$count = 0;
	foreach my $element ($firefox->find_by_class('main-content')->list_by_selector('input.home-search-input')) {
		ok($element->property('id'), "Correctly found nested element with list_by_selector");
		$count += 1;
	}
	ok($count == 1, "Found elements with nested list_by_selector:$count");
	$count = 0;
	foreach my $element ($firefox->find_by_class('main-content')->find_by_selector('input.home-search-input')) {
		ok($element->property('id'), "Correctly found nested element with find_by_selector");
		$count += 1;
	}
	ok($count == 1, "Found elements with nested find_by_selector:$count");
	$count = 0;
	foreach my $element ($firefox->find_by_selector('input.home-search-input')) {
		ok($element->property('id'), "Correctly found wantarray element with find_by_selector");
		$count += 1;
	}
	ok($count == 1, "Found elements with wantarray find_by_selector:$count");
	$count = 0;
	foreach my $element ($firefox->find_selector('input.home-search-input')) {
		ok($element->property('id'), "Correctly found wantarray element with find_selector");
		$count += 1;
	}
	ok($count == 1, "Found elements with wantarray find_by_selector:$count");
	ok($firefox->find('API', 'link text')->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found element when searching by link text");
	ok($firefox->find('API', BY_LINK())->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found element when searching by link text");
	ok($firefox->list_by_link('API')->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found element with list_by_link");
	ok($firefox->find_by_link('API')->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found element with find_by_link");
	ok($firefox->find_by_class('container-fluid')->find_by_link('API')->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found nested element with find_by_link");
	ok($firefox->find_link('API')->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found element with find_link");
	ok($firefox->find_class('container-fluid')->find_link('API')->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found nested element with find_link");
	$count = 0;
	foreach my $element ($firefox->find_by_class('container-fluid')->list_by_link('API')) {
		ok($element->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found nested element with list_by_link");
		$count += 1;
	}
	ok($count == 1, "Found elements with nested list_by_link:$count");
	$count = 0;
	foreach my $element ($firefox->find_by_class('container-fluid')->find_by_link('API')) {
		ok($element->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found nested element with find_by_link");
		$count += 1;
	}
	ok($count == 1, "Found elements with nested find_by_link:$count");
	$count = 0;
	foreach my $element ($firefox->find_by_link('API')) {
		ok($element->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found wantarray element with find_by_link");
		$count += 1;
	}
	ok($count == 2, "Found elements with wantarray find_by_link:$count");
	$count = 0;
	foreach my $element ($firefox->find_link('API')) {
		ok($element->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found wantarray element with find_link");
		$count += 1;
	}
	ok($count == 2, "Found elements with wantarray find_by_link:$count");
	ok($firefox->find('AP', 'partial link text')->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found element when searching by partial link text");
	ok($firefox->find('AP', BY_PARTIAL())->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found element when searching by partial link text");
	ok($firefox->list_by_partial('AP')->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found element with list_by_partial");
	ok($firefox->find_by_partial('AP')->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found element with find_by_partial");
	ok($firefox->find_by_class('container-fluid')->find_by_partial('AP')->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found nested element with find_by_partial");
	ok($firefox->find_partial('AP')->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found element with find_partial");
	ok($firefox->find_class('container-fluid')->find_partial('AP')->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found nested element with find_partial");
	$count = 0;
	foreach my $element ($firefox->find_by_class('container-fluid')->list_by_partial('AP')) {
		ok($element->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found nested element with list_by_partial");
		$count +=1;
	}
	ok($count == 1, "Found elements with nested list_by_partial:$count");
	$count = 0;
	foreach my $element ($firefox->find_by_class('container-fluid')->find_by_partial('AP')) {
		ok($element->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found nested element with find_by_partial");
		$count +=1;
	}
	ok($count == 1, "Found elements with nested find_by_partial:$count");
	$count = 0;
	foreach my $element ($firefox->find_by_partial('AP')) {
		ok($element->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found wantarray element with find_by_partial");
		$count +=1;
	}
	ok($count == 2, "Found elements with wantarray find_by_partial:$count");
	$count = 0;
	foreach my $element ($firefox->find_partial('AP')) {
		ok($element->property('href') eq 'https://fastapi.metacpan.org/', "Correctly found wantarray element with find_partial");
		$count +=1;
	}
	ok($count == 2, "Found elements with wantarray find_partial:$count");
	my $css_rule;
	ok($css_rule = $firefox->find('//input[@id="search-input"]')->css('display'), "The value of the css rule 'display' is '$css_rule'");
	my $result;
	ok($result = $firefox->find('//input[@id="search-input"]')->is_enabled() =~ /^[01]$/, "is_enabled returns 0 or 1:$result");
	eval { $firefox->is_enabled({}) };
	my $eval_string = "$@";
	chomp $eval_string;
	ok((ref $@ eq 'Firefox::Marionette::Exception'), "is_enabled throws exception for bad parameters:$eval_string");
	ok($result = $firefox->find('//input[@id="search-input"]')->is_displayed() =~ /^[01]$/, "is_displayed returns 0 or 1:$result");
	eval { $firefox->is_displayed({}) };
	$eval_string = "$@";
	chomp $eval_string;
	ok((ref $@ eq 'Firefox::Marionette::Exception'), "is_displayed throws exception for bad parameters:$eval_string");
	ok($result = $firefox->find('//input[@id="search-input"]')->is_selected() =~ /^[01]$/, "is_selected returns 0 or 1:$result");
	eval { $firefox->is_selected({}) };
	$eval_string = "$@";
	chomp $eval_string;
	ok((ref $@ eq 'Firefox::Marionette::Exception'), "is_selected throws exception for bad parameters:$eval_string");
	ok($firefox->find('//input[@id="search-input"]')->clear(), "Clearing the element directly");
	ok((!defined $firefox->find_id('search-input')->attribute('value')) && ($firefox->find_id('search-input')->property('value') eq ''), "Initial property and attribute values are empty for 'search-input'");
	ok($firefox->find('//input[@id="search-input"]')->send_keys('Test::More'), "Sent 'Test::More' to the 'search-input' field directly to the element");
	ok(!defined $firefox->find_id('search-input')->attribute('value'), "attribute for 'search-input' is still not defined ");
	ok($firefox->find_id('search-input')->property('value') eq 'Test::More', "property for 'search-input' is now 'Test::More'");
	ok($firefox->find('//input[@id="search-input"]')->clear(), "Clearing the element directly");
	foreach my $element ($firefox->find_elements('//input[@id="search-input"]')) {
		ok($firefox->send_keys($element, 'Test::More'), "Sent 'Test::More' to the 'search-input' field via the browser");
		ok($firefox->clear($element), "Clearing the element via the browser");
		ok($firefox->type($element, 'Test::More'), "Sent 'Test::More' to the 'search-input' field via the browser");
		last;
	}
	my $text = $firefox->find('//button[@name="lucky"]')->text();
	ok($text, "Read '$text' directly from 'Lucky' button");
	my $tag_name = $firefox->find('//button[@name="lucky"]')->tag_name();
	ok($tag_name, "'Lucky' button has a tag name of '$tag_name'");
	my $rect = $firefox->find('//button[@name="lucky"]')->rect();
	ok($rect->pos_x() =~ /^\d+([.]\d+)?$/, "'Lucky' button has a X position of " . $rect->pos_x());
	ok($rect->pos_y() =~ /^\d+([.]\d+)?$/, "'Lucky' button has a Y position of " . $rect->pos_y());
	ok($rect->width() =~ /^\d+([.]\d+)?$/, "'Lucky' button has a width of " . $rect->width());
	ok($rect->height() =~ /^\d+([.]\d+)?$/, "'Lucky' button has a height of " . $rect->height());
	ok(((scalar $firefox->cookies()) >= 0), "\$firefox->cookies() shows cookies on " . $firefox->uri());
	ok($firefox->delete_cookies() && ((scalar $firefox->cookies()) == 0), "\$firefox->delete_cookies() clears all cookies");
	my $capabilities = $firefox->capabilities();
	my $buffer = undef;
	my $handle = $firefox->selfie();
	$handle->read($buffer, 20);
	ok($buffer =~ /^\x89\x50\x4E\x47\x0D\x0A\x1A\x0A/smx, "\$firefox->selfie() returns a PNG file");
	$buffer = undef;
	$handle = $firefox->find('//button[@name="lucky"]')->selfie();
	$handle->read($buffer, 20);
	ok($buffer =~ /^\x89\x50\x4E\x47\x0D\x0A\x1A\x0A/smx, "\$firefox->find('//button[\@name=\"lucky\"]')->selfie() returns a PNG file");
	my $actual_digest = $firefox->selfie(hash => 1, highlights => [ $firefox->find('//button[@name="lucky"]') ]);
	ok($actual_digest =~ /^[a-f0-9]+$/smx, "\$firefox->selfie(hash => 1, highlights => [ \$firefox->find('//button[\@name=\"lucky\"]') ]) returns a hex encoded SHA256 digest");
	$handle = $firefox->selfie(highlights => [ $firefox->find('//button[@name="lucky"]') ]);
	$buffer = undef;
	$handle->read($buffer, 20);
	ok($buffer =~ /^\x89\x50\x4E\x47\x0D\x0A\x1A\x0A/smx, "\$firefox->selfie(highlights => [ \$firefox->find('//button[\@name=\"lucky\"]') ]) returns a PNG file");
	$handle->seek(0,0) or die "Failed to seek:$!";
	$handle->read($buffer, 1_000_000) or die "Failed to read:$!";
	my $correct_digest = Digest::SHA::sha256_hex(MIME::Base64::encode_base64($buffer, q[]));
	TODO: {
		local $TODO = "Digests can sometimes change for all platforms";
		ok($actual_digest eq $correct_digest, "\$firefox->selfie(hash => 1, highlights => [ \$firefox->find('//button[\@name=\"lucky\"]') ]) returns the correct hex encoded SHA256 hash of the base64 encoded image");
	}
	my $clicked;
	ELEMENT: foreach my $element ($firefox->find('//a[@href="https://fastapi.metacpan.org"]')) {
		if (($element->is_displayed()) && ($element->is_enabled())) {
			$element->click();
			$clicked = 1;
			last ELEMENT;
		}
	}
	ok($clicked, "Clicked the API link");
	ok($firefox->await(sub { $firefox->uri()->host() eq 'github.com' }), "\$firefox->uri()->host() is equal to github.com:" . $firefox->uri());
	while(!$firefox->loaded()) {
		diag("Waiting for firefox to load after clicking on API link");
		sleep 1;
	}
	my @cookies = $firefox->cookies();
	ok($cookies[0]->name() =~ /\w/, "The first cookie name is '" . $cookies[0]->name() . "'");
	ok($cookies[0]->value() =~ /\w/, "The first cookie value is '" . $cookies[0]->value() . "'");
	TODO: {
		local $TODO = ($major_version < 56) ? "\$cookies[0]->expiry() does not function for Firefox versions less than 56" : q[];
		ok(defined $cookies[0]->expiry() && $cookies[0]->expiry() =~ /^\d+$/, "The first cookie name has an integer expiry date of '" . ($cookies[0]->expiry() || q[]) . "'");
	}
	ok($cookies[0]->http_only() =~ /^[01]$/, "The first cookie httpOnly flag is a boolean set to '" . $cookies[0]->http_only() . "'");
	ok($cookies[0]->secure() =~ /^[01]$/, "The first cookie secure flag is a boolean set to '" . $cookies[0]->secure() . "'");
	ok($cookies[0]->path() =~ /\S/, "The first cookie path is a string set to '" . $cookies[0]->path() . "'");
	ok($cookies[0]->domain() =~ /^[\w\-.]+$/, "The first cookie domain is a domain set to '" . $cookies[0]->domain() . "'");
	my $original_number_of_cookies = scalar @cookies;
	ok(($original_number_of_cookies > 1) && ((ref $cookies[0]) eq 'Firefox::Marionette::Cookie'), "\$firefox->cookies() returns more than 1 cookie on " . $firefox->uri());
	ok($firefox->delete_cookie($cookies[0]->name()), "\$firefox->delete_cookie('" . $cookies[0]->name() . "') deletes the specified cookie name");
	ok(not(grep { $_->name() eq $cookies[0]->name() } $firefox->cookies()), "List of cookies no longer includes " . $cookies[0]->name());
	ok($firefox->back(), "\$firefox->back() goes back one page");
	while(!$firefox->loaded()) {
		diag("Waiting for firefox to load after clicking back button");
		sleep 1;
	}
	while($firefox->uri()->host() ne 'metacpan.org') {
		diag("Waiting to load previous page:" . $firefox->uri()->host());
		sleep 1;
	}
	ok($firefox->uri()->host() eq 'metacpan.org', "\$firefox->uri()->host() is equal to metacpan.org:" . $firefox->uri());
	ok($firefox->forward(), "\$firefox->forward() goes forward one page");
	while(!$firefox->loaded()) {
		diag("Waiting for firefox to load after clicking forward button");
		sleep 1;
	}
	while($firefox->uri()->host() ne 'github.com') {
		diag("Waiting to load next page:" . $firefox->uri()->host());
		sleep 1;
	}
	ok($firefox->uri()->host() eq 'github.com', "\$firefox->uri()->host() is equal to github.com:" . $firefox->uri());
	ok($firefox->back(), "\$firefox->back() goes back one page");
	while(!$firefox->loaded()) {
		diag("Waiting for firefox to load after clicking back button (2)");
		sleep 1;
	}
	while($firefox->uri()->host() ne 'metacpan.org') {
		diag("Waiting to load previous page (2):" . $firefox->uri()->host());
		sleep 1;
	}
	ok($firefox->uri()->host() eq 'metacpan.org', "\$firefox->uri()->host() is equal to metacpan.org:" . $firefox->uri());
	ok($firefox->script('return window.find("lucky");'), "metacpan.org contains the phrase 'lucky' in a 'window.find' javascript command");
	my $cookie = Firefox::Marionette::Cookie->new(name => 'BonusCookie', value => 'who really cares about privacy', expiry => time + 500000);
	ok($firefox->add_cookie($cookie), "\$firefox->add_cookie() adds a Firefox::Marionette::Cookie without a domain");
	ok($firefox->find_id('search-input')->clear()->find_id('search-input')->type('Test::More'), "Sent 'Test::More' to the 'search-input' field directly to the element");
	if (out_of_time()) {
		skip("Running out of time.  Trying to shutdown tests as fast as possible", 31);
	}
	ok($firefox->find_name('lucky')->click($element), "Clicked the \"I'm Feeling Lucky\" button");
	diag("Going to Test::More page with a page load strategy of " . ($capabilities->page_load_strategy() || ''));
	ok($firefox->bye(sub { $firefox->find_id('search-input') })->await(sub { $firefox->interactive() && $firefox->find_partial('Download') })->click(), "Clicked on the download link");
	diag("Clicked download link");
	while(!$firefox->downloads()) {
		sleep 1;
	}
	while($firefox->downloading()) {
		sleep 1;
	}
	$count = 0;
	foreach my $path ($firefox->downloads()) {
		diag("Downloaded $path");
		$count += 1;
	}
	ok($count == 1, "Downloaded 1 files:$count");

	my $alert_text = 'testing alert';
	$firefox->script(qq[alert('$alert_text')]);
	ok($firefox->alert_text() eq $alert_text, "\$firefox->alert_text() correctly detects alert text");
	ok($firefox->dismiss_alert(), "\$firefox->dismiss_alert() dismisses alert box");
	$capabilities = $firefox->capabilities();
	my $version = $capabilities->browser_version();
	my ($major_version, $minor_version, $patch_version) = split /[.]/, $version;
	ok($firefox->async_script(qq[prompt("Please enter your name", "John Cole");]), "Started async script containing a prompt");
	ok($firefox->await(sub { $firefox->send_alert_text("Roland Grelewicz"); }), "\$firefox->send_alert_text() sends alert text:$@");
	ok($firefox->accept_dialog(), "\$firefox->accept_dialog() accepts the dialog box");
	ok($firefox->current_chrome_window_handle() =~ /^\d+$/, "Returned the current chrome window handle as an integer");
	$capabilities = $firefox->capabilities();
	ok((ref $capabilities) eq 'Firefox::Marionette::Capabilities', "\$firefox->capabilities() returns a Firefox::Marionette::Capabilities object");
	SKIP: {
		if (!grep /^page_load_strategy$/, $capabilities->enumerate()) {
			diag("\$capabilities->page_load_strategy is not supported for " . $capabilities->browser_version());
			skip("\$capabilities->page_load_strategy is not supported for " . $capabilities->browser_version(), 1);
		}
		ok($capabilities->page_load_strategy() =~ /^\w+$/, "\$capabilities->page_load_strategy() is a string:" . $capabilities->page_load_strategy());
	}
	ok($capabilities->moz_headless() =~ /^(1|0)$/, "\$capabilities->moz_headless() is a boolean:" . $capabilities->moz_headless());
	SKIP: {
		if (!grep /^accept_insecure_certs$/, $capabilities->enumerate()) {
			diag("\$capabilities->accept_insecure_certs is not supported for " . $capabilities->browser_version());
			skip("\$capabilities->accept_insecure_certs is not supported for " . $capabilities->browser_version(), 1);
		}
		ok($capabilities->accept_insecure_certs() =~ /^(1|0)$/, "\$capabilities->accept_insecure_certs() is a boolean:" . $capabilities->accept_insecure_certs());
	}
	ok($capabilities->moz_process_id() =~ /^\d+$/, "\$capabilities->moz_process_id() is an integer:" . $capabilities->moz_process_id());
	ok($capabilities->browser_name() =~ /^\w+$/, "\$capabilities->browser_name() is a string:" . $capabilities->browser_name());
	ok($capabilities->rotatable() =~ /^(1|0)$/, "\$capabilities->rotatable() is a boolean:" . $capabilities->rotatable());
	SKIP: {
		if (!grep /^moz_use_non_spec_compliant_pointer_origin$/, $capabilities->enumerate()) {
			diag("\$capabilities->moz_use_non_spec_compliant_pointer_origin is not supported for " . $capabilities->browser_version());
			skip("\$capabilities->moz_use_non_spec_compliant_pointer_origin is not supported for " . $capabilities->browser_version(), 1);
		}
		ok($capabilities->moz_use_non_spec_compliant_pointer_origin() =~ /^(1|0)$/, "\$capabilities->moz_use_non_spec_compliant_pointer_origin() is a boolean:" . $capabilities->moz_use_non_spec_compliant_pointer_origin());
	}
	SKIP: {
		if (!grep /^moz_accessibility_checks$/, $capabilities->enumerate()) {
			diag("\$capabilities->moz_accessibility_checks is not supported for " . $capabilities->browser_version());
			skip("\$capabilities->moz_accessibility_checks is not supported for " . $capabilities->browser_version(), 1);
		}
		ok($capabilities->moz_accessibility_checks() =~ /^(1|0)$/, "\$capabilities->moz_accessibility_checks() is a boolean:" . $capabilities->moz_accessibility_checks());
	}
	ok((ref $capabilities->timeouts()) eq 'Firefox::Marionette::Timeouts', "\$capabilities->timeouts() returns a Firefox::Marionette::Timeouts object");
	ok($capabilities->timeouts()->page_load() =~ /^\d+$/, "\$capabilities->timeouts->page_load() is an integer:" . $capabilities->timeouts()->page_load());
	ok($capabilities->timeouts()->script() =~ /^\d+$/, "\$capabilities->timeouts->script() is an integer:" . $capabilities->timeouts()->script());
	ok($capabilities->timeouts()->implicit() =~ /^\d+$/, "\$capabilities->timeouts->implicit() is an integer:" . $capabilities->timeouts()->implicit());
	ok($capabilities->browser_version() =~ /^\d+[.]\d+([.]\d+)?$/, "\$capabilities->browser_version() is a major.minor.patch version number:" . $capabilities->browser_version());
	ok($capabilities->platform_version() =~ /\d+/, "\$capabilities->platform_version() contains a number:" . $capabilities->platform_version());
	ok($capabilities->moz_profile() =~ /firefox_marionette/, "\$capabilities->moz_profile() contains 'firefox_marionette':" . $capabilities->moz_profile());
	SKIP: {
		if (!grep /^moz_webdriver_click$/, $capabilities->enumerate()) {
			diag("\$capabilities->moz_webdriver_click is not supported for " . $capabilities->browser_version());
			skip("\$capabilities->moz_webdriver_click is not supported for " . $capabilities->browser_version(), 1);
		}
		ok($capabilities->moz_webdriver_click() =~ /^(1|0)$/, "\$capabilities->moz_webdriver_click() is a boolean:" . $capabilities->moz_webdriver_click());
	}
	ok($capabilities->platform_name() =~ /\w+/, "\$capabilities->platform_version() contains alpha characters:" . $capabilities->platform_name());
	eval {
		$firefox->dismiss_alert();
	};
	my $exception = "$@";
	chomp $exception;
	ok($@, "Dismiss non-existant alert caused an exception to be thrown:$exception");
	my $install_id;
	my $install_path = Cwd::abs_path("t/addons/test.xpi");
	if ($^O eq 'cygwin') {
		my $drive = $ENV{SYSTEMDRIVE};
		$install_path = "${drive}/cygwin64$install_path";
		$install_path =~ s/\//\\/smxg;
	} elsif ($^O eq 'MSWin32') {
		$install_path =~ s/\//\\/smxg;
	}
	diag("Installing extension from $install_path");
	eval {
		$install_id = $firefox->install($install_path, 1);
	};
	SKIP: {	
		my $exception = "$@";
		chomp $exception;
		if ((!$install_id) && ($major_version < 52)) {
			skip("addon:install may not be supported in firefox versions less than 52:$exception", 2);
		}
		ok($install_id, "Successfully installed an extension:$install_id");
		ok($firefox->uninstall($install_id), "Successfully uninstalled an extension");
	}
	$result = undef;
	eval {
		$result = $firefox->accept_connections(0);
	};
	SKIP: {
		my $exception = "$@";
		chomp $exception;
		if ((!$result) && ($major_version < 52)) {
			skip("Refusing future connections may not be supported in firefox versions less than 52:$exception", 1);
		}
		ok($result, "Refusing future connections");
	}
	ok($firefox->quit() == 0, "Firefox has closed with an exit status of 0:" . $firefox->child_error());
}

SKIP: {
	($skip_message, $firefox) = start_firefox(0, visible => 0);
	if (!$skip_message) {
		$at_least_one_success = 1;
	}
	if ($skip_message) {
		skip($skip_message, 4);
	}
	ok($firefox, "Firefox has started in Marionette mode with visible set to 0");
	my $capabilities = $firefox->capabilities();
	ok((ref $capabilities) eq 'Firefox::Marionette::Capabilities', "\$firefox->capabilities() returns a Firefox::Marionette::Capabilities object");
	ok($capabilities->moz_headless() || $ENV{FIREFOX_VISIBLE} || 0, "\$capabilities->moz_headless() is set to " . ($ENV{FIREFOX_VISIBLE} ? 'false' : 'true'));
	ok($firefox->quit() == 0, "Firefox has closed with an exit status of 0:" . $firefox->child_error());
}

SKIP: {
	($skip_message, $firefox) = start_firefox(1, debug => 1, capabilities => Firefox::Marionette::Capabilities->new(moz_headless => 0, accept_insecure_certs => 0, page_load_strategy => 'none', moz_webdriver_click => 0, moz_accessibility_checks => 0));
	if (!$skip_message) {
		$at_least_one_success = 1;
	}
	if ($skip_message) {
		skip($skip_message, 9);
	}
	ok($firefox, "Firefox has started in Marionette mode with definable capabilities set to different values");
	my $capabilities = $firefox->capabilities();
	ok((ref $capabilities) eq 'Firefox::Marionette::Capabilities', "\$firefox->capabilities() returns a Firefox::Marionette::Capabilities object");
	SKIP: {
		if (!grep /^page_load_strategy$/, $capabilities->enumerate()) {
			diag("\$capabilities->page_load_strategy is not supported for " . $capabilities->browser_version());
			skip("\$capabilities->page_load_strategy is not supported for " . $capabilities->browser_version(), 1);
		}
		ok($capabilities->page_load_strategy() eq 'none', "\$capabilities->page_load_strategy() is 'none'");
	}
	SKIP: {
		if (!grep /^accept_insecure_certs$/, $capabilities->enumerate()) {
			diag("\$capabilities->accept_insecure_certs is not supported for " . $capabilities->browser_version());
			skip("\$capabilities->accept_insecure_certs is not supported for " . $capabilities->browser_version(), 1);
		}
		ok($capabilities->accept_insecure_certs() == 0, "\$capabilities->accept_insecure_certs() is set to false");
	}
	SKIP: {
		if (!grep /^moz_use_non_spec_compliant_pointer_origin$/, $capabilities->enumerate()) {
			diag("\$capabilities->moz_use_non_spec_compliant_pointer_origin is not supported for " . $capabilities->browser_version());
			skip("\$capabilities->moz_use_non_spec_compliant_pointer_origin is not supported for " . $capabilities->browser_version(), 1);
		}
		ok($capabilities->moz_use_non_spec_compliant_pointer_origin() == 0, "\$capabilities->moz_use_non_spec_compliant_pointer_origin() is set to false");
	}
	SKIP: {
		if (!grep /^moz_webdriver_click$/, $capabilities->enumerate()) {
			diag("\$capabilities->moz_webdriver_click is not supported for " . $capabilities->browser_version());
			skip("\$capabilities->moz_webdriver_click is not supported for " . $capabilities->browser_version(), 1);
		}
		ok($capabilities->moz_webdriver_click() == 0, "\$capabilities->moz_webdriver_click() is set to false");
	}
	SKIP: {
		if (!grep /^moz_accessibility_checks$/, $capabilities->enumerate()) {
			diag("\$capabilities->moz_accessibility_checks is not supported for " . $capabilities->browser_version());
			skip("\$capabilities->moz_accessibility_checks is not supported for " . $capabilities->browser_version(), 1);
		}
		ok($capabilities->moz_accessibility_checks() == 0, "\$capabilities->moz_accessibility_checks() is set to false");
	}
	ok(not($capabilities->moz_headless()), "\$capabilities->moz_headless() is set to false");
	ok($firefox->quit() == 0, "Firefox has closed with an exit status of 0:" . $firefox->child_error());
}

SKIP: {
	local %ENV = %ENV;
	my $localPort = 8080;
	$ENV{http_proxy} = 'https://localhost:' . $localPort;
	$ENV{https_proxy} = 'https://proxy2.example.org:4343';
	$ENV{ftp_proxy} = 'ftp://ftp2.example.org:2121';
	($skip_message, $firefox) = start_firefox(1, visible => 1);
	if (!$skip_message) {
		$at_least_one_success = 1;
	}
	if ($skip_message) {
		skip($skip_message, 11);
	}
	ok($firefox, "Firefox has started in Marionette mode with visible set to 1");
	my $capabilities = $firefox->capabilities();
	ok((ref $capabilities) eq 'Firefox::Marionette::Capabilities', "\$firefox->capabilities() returns a Firefox::Marionette::Capabilities object");
	ok(!$capabilities->moz_headless(), "\$capabilities->moz_headless() is set to false");
	ok($capabilities->proxy()->type() eq 'manual', "\$capabilities->proxy()->type() is 'manual'");
	ok($capabilities->proxy()->http() eq 'localhost:' . $localPort, "\$capabilities->proxy()->http() is 'localhost:" . $localPort . "':" . $capabilities->proxy()->http());
	ok($capabilities->proxy()->https() eq 'proxy2.example.org:4343', "\$capabilities->proxy()->https() is 'proxy2.example.org:4343'");
	ok($capabilities->proxy()->ftp() eq 'ftp2.example.org:2121', "\$capabilities->proxy()->ftp() is 'ftp2.example.org:2121'");
	SKIP: {
		if ((exists $ENV{XAUTHORITY}) && (defined $ENV{XAUTHORITY}) && ($ENV{XAUTHORITY} =~ /xvfb/smxi)) {
			skip("Unable to change firefox screen size when xvfb is running", 3);	
		} elsif ($firefox->xvfb()) {
			skip("Unable to change firefox screen size when xvfb is running", 3);	
		}
		local $TODO = "Not entirely stable in firefox";
		my $full_screen;
		local $SIG{ALRM} = sub { die "alarm during full screen\n" };
		alarm 15;
		eval {
			$full_screen = $firefox->full_screen();
		} or do {
			diag("Crashed during \$firefox->full_screen:$@");
		};
		alarm 0;
		ok($full_screen, "\$firefox->full_screen()");
		my $minimise;
		local $SIG{ALRM} = sub { die "alarm during minimise\n" };
		alarm 15;
		eval {
			$minimise = $firefox->minimise();
		} or do {
			diag("Crashed during \$firefox->minimise:$@");
		};
		alarm 0;
		ok($minimise, "\$firefox->minimise()");
		my $maximise;
		local $SIG{ALRM} = sub { die "alarm during maximise\n" };
		alarm 15;
		eval {
			$maximise = $firefox->maximise();
		} or do {
			diag("Crashed during \$firefox->maximise:$@");
		};
		alarm 0;
		ok($maximise, "\$firefox->maximise()");
	}
	if ($^O eq 'MSWin32') {
		ok($firefox->quit() == 0, "Firefox has closed with an exit status of 0:" . $firefox->child_error());
	} else {
		my @sig_nums  = split q[ ], $Config{sig_num};
		my @sig_names = split q[ ], $Config{sig_name};
		my %signals_by_name;
		my $idx = 0;
		foreach my $sig_name (@sig_names) {
			$signals_by_name{$sig_name} = $sig_nums[$idx];
			$idx += 1;
		}
		while($firefox->alive()) {
			diag("Killing PID " . $capabilities->moz_process_id() . " with a signal " . $signals_by_name{TERM});
			sleep 1; 
			kill $signals_by_name{TERM}, $capabilities->moz_process_id();
			sleep 1; 
		}
		ok($firefox->quit() == $signals_by_name{TERM}, "Firefox has been killed by a signal with value of $signals_by_name{TERM}:" . $firefox->child_error() . ":" . $firefox->error_message());
		diag("Error Message was " . $firefox->error_message());
	}
}
ok($at_least_one_success, "At least one firefox start worked");
eval "no warnings; sub File::Temp::newdir { \$! = POSIX::EACCES(); return; } use warnings;";
ok(!$@, "File::Temp::newdir is redefined to fail:$@");
eval { Firefox::Marionette->new(); };
my $output = "$@";
chomp $output;
ok($@->isa('Firefox::Marionette::Exception') && $@ =~ / in .* at line \d+/, "When File::Temp::newdir is forced to fail, a Firefox::Marionette::Exception is thrown:$output");

