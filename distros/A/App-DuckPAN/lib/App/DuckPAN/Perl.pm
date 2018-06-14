package App::DuckPAN::Perl;
our $AUTHORITY = 'cpan:DDG';
# ABSTRACT: Perl related functionality for duckpan
$App::DuckPAN::Perl::VERSION = '1021';
use Moo;
with 'App::DuckPAN::HasApp';

use Config::INI;
use Dist::Zilla::Util;
use Path::Tiny;
use Config::INI::Reader;
use Config::INI::Writer;
use Data::Dumper;
use LWP::UserAgent;
use List::MoreUtils qw/ uniq /;
use List::Util qw/ first /;
use File::Temp qw/ :POSIX /;
use version;
use Parse::CPAN::Packages::Fast;
use Class::Load ':all';

no warnings 'uninitialized';

sub get_local_version {
	my ($self, $module) = @_;
	require Module::Data;
	my $v;
	{
		local $@;

		# ensure $module is installed by trying to load (require) it
		eval {
			my $m = Module::Data->new($module);
			$m->require;
			$v = $m->version;
			1;
		} or return;
	};

	# $module (e.g. DuckPAN, DDG) has loaded, but no $VERSION exists
	# This means we're not working with code that was built by DZIL
	#
	# Example:
	# > ./bin/duckpan -I/lib/ -I../duckduckgo/lib server
	unless (defined $v) {
		if ($module eq 'App::DuckPAN' || $module eq 'DDG'){
			# When executing code in-place, $VERSION will not be defined.
			# Only the installed package will have a defined version
			# thanks to Dist::Zilla::Plugin::PkgVersion
			return $self->app->dev_version;
		}
		return;
	}
	return version->parse($v) unless ref $v;
	return $v;
}

sub cpanminus_install_error {
	shift->app->emit_and_exit(1,
		"Failure on installation of modules!",
		"There are several possible explanations and fixes for this error:",
		"1. The download from CPAN was unsuccessful - Please restart this installer.",
		"2. Some other error occured - Please read the `build.log` mentioned in the errors and see if you can fix the problem yourself.",
		"If you are unable to solve the problem, please let us know by making a GitHub Issue in the DuckPAN Repo:",
		"https://github.com/duckduckgo/p5-app-duckpan/issues",
		"Make sure to attach the `build.log` file if it exists. Otherwise, copy/paste the output you see."
	);
}

sub duckpan_install {
	my ($self, @modules) = @_;
	my $mirror = $self->app->duckpan;
	my ($reinstall, $latest);
	my $reinstall_latest = $modules[0];
	if($reinstall_latest eq 'reinstall') {
		# We sent in a signal to force reinstallation
		$reinstall = 1;
		shift @modules;
	}
	elsif($reinstall_latest eq 'latest') {
		$latest = 1;
		shift @modules;
	}
	my $packages = $self->app->duckpan_packages;
	my @to_install;
	for (@modules) {
		my $module = $packages->package($_);
		$self->app->emit_and_exit(1, "Can't find package " . $_ . " on " . $self->app->duckpan) unless $module;

		my $package = $module->package;    # Probably $_, but maybe they'll normalize or something someday.

		# see if we have an env variable for this module
		my $sp = $package;
		$sp =~ s/\:\:/_/g;

		# special case: check for a pinned verison number
		my $pinned_version      = $ENV{$sp};
		my $installed_version   = $self->get_local_version($package);
		my $latest_version      = version->parse($module->version);
		my $duckpan_module_url  = $self->app->duckpan . 'authors/id/' . $module->distribution->pathname;

		# Remind user about having pinned env variables
		$self->app->emit_info("$package: $installed_version installed, $pinned_version pinned, $latest_version latest") if $pinned_version;

		# Could be moved up but want dev to see the version installed and available first
		if($installed_version == $self->app->dev_version){
			$self->app->emit_notice("Skipping installation of $package.  Development version detected!");
			next;
		}

		my ($install_it, $message);
		if($reinstall || $latest || !$installed_version) {
			# Prefer versions in the following order when (re)installing: installed, pinned, latest
			# Latest ignores the installed version
			my $version;
			$version = $installed_version unless $latest;
			$version ||= $pinned_version || $latest_version;
			# update the url if not the latest
			if($version != $latest_version){
				unless($duckpan_module_url = $self->find_previous_url($module, $version)){
					$self->app->emit_and_exit(1, "Failed to find version $version of $package");
				}
			}
			$message = $reinstall ?
				"Reinstalling $package, version ($version)" :
				"You don't have $package installed. Installing version ($version)";
			$install_it = 1;
		}
		elsif($pinned_version) {
			if($pinned_version != $installed_version) {
				#  We continue here, even if the version is larger than latest released,
				#  on the premise that there might exist unreleased development versions.
				if($pinned_version == $latest_version || ($duckpan_module_url = $self->find_previous_url($module, $pinned_version))) {
					$install_it = 1;
				}
				else{
					$message = "Could not locate version $pinned_version of '$package'";
					$self->app->emit_and_exit(1, $message);
				}
			}
			else{
				$message = ($pinned_version == $latest_version) ?
					"You already have the latest version of '$package' installed!" :
					"A newer version of '$package' exists. Please update your version pin to match the newest version: $latest_version";
				$install_it = 0;
			}
		}
		elsif($installed_version == $latest_version) {
			$message = "You already have latest version ($installed_version) of $package";
		}
		elsif($installed_version > $latest_version) {
			$message = "You have a newer version ($installed_version) of $package than duckpan.org ($latest_version)";
		}
		else{
			$message = "You have an older version ($installed_version) of $package than duckpan.org. Installing latest version ($latest_version)";
			$install_it = 1;
		}
		$self->app->emit_notice($message);
		push @to_install, $duckpan_module_url if ($install_it && !(first { $_ eq $duckpan_module_url } @to_install));
	}

	if(@to_install){
		unshift @to_install, '--reinstall' if $reinstall;    # cpanm will do the actual forcing.
		if(system "cpanm @to_install"){
			my $err = "cpanm failed (err $?) to (re)install the following modules:\n\n\t" .
				join("\n\t", @to_install);
			$self->app->emit_and_exit(1, $err);
		}
	}
}

my @POTENTIAL_AUTHORS = qw|
    ALOHAAS
    ANDREY_P
    BRAD
    BRIANHALL
    BRIANS
    CAINE
    CRAZEDPSYC
    DDGC
    DUENDEX
    DYLANLL
    GETTY
    ISADDG
    JAG
    JBARRETT
    JDORW
    KABLAMO
    MGA
    MOOLLAZA
    RSSSSL
    SDOUGBROWN
    TOMMYTOMMYTOMMY
    YEGG
    ZT
|;

# We need to derive URLs because duckpan.org doesn't understand module@0.147 syntax
sub find_previous_url {
	my ($self, $module, $desired_version) = @_;

	# Shaky premise #1: the author of our previous version is a current author.
    my @cpanids = uniq($self->authors_of_latest_dists, @POTENTIAL_AUTHORS);
	# Shaky premise #2: the directory structure is always like this.
    my @cpan_dirs = map { join('/', substr($_, 0, 1), substr($_, 0, 2), $_) } @cpanids;
	# Shaky premise #3: things never change distributions.
	my $dist     = $module->distribution;
	my $filename = $dist->filename;
    # CPAN::DistnameInfo parses the filename incorrectly because PAUSE ids can only
    # contain [-A-Z0-9] whereas duckpan allows other characters like _
    $filename =~ s|^[A-Z]/[A-Z]{2}/.*?/||;
	# Shaky premise #4: the distribution version will match package version.
	my $version = $dist->version;
	# Shaky premise #5: the version for which they are asking is well-formed.
	$filename =~ s/$version/$desired_version/;
	my @urls = map { $self->app->duckpan . 'authors/id/' . $_ . '/' . $filename } @cpan_dirs;
	$self->app->emit_debug("Checking up to " . scalar @urls . " distributions for pinned version...");

	# Shaky premise #6: our network works well enough to make this a definitive test
	my $ua = LWP::UserAgent->new(
		agent                 => 'DPPF/0.001a',
		requests_redirectable => []);

	return first { $ua->head($_)->is_success } @urls;
}

sub authors_of_latest_dists {
    my ( $self ) = @_;
    my @dists = $self->app->duckpan_packages->distributions;
    # CPAN::DistnameInfo can parse the cpanid incorrectly because PAUSE ids can
    # only contain [-A-Z0-9] whereas duckpan allows other characters like _.
    # When this happens cpanid is undefined.  Thats why we grep for defined.
    return grep { defined $_ } map { $_->cpanid } @dists;
}

1;

__END__

=pod

=head1 NAME

App::DuckPAN::Perl - Perl related functionality for duckpan

=head1 VERSION

version 1021

=head1 AUTHOR

DuckDuckGo <open@duckduckgo.com>, Zach Thompson <zach@duckduckgo.com>, Zaahir Moolla <moollaza@duckduckgo.com>, Torsten Raudssus <torsten@raudss.us> L<https://raudss.us/>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by DuckDuckGo, Inc. L<https://duckduckgo.com/>.

This is free software, licensed under:

  The Apache License, Version 2.0, January 2004

=cut
