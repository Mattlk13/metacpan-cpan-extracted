################################################################
#
# Copyright (c) 2022 SUSE LLC
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 or 3 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program (see the file COPYING); if not, write to the
# Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA
#
################################################################

package Net::OBS::SigAuth;

use MIME::Base64 ();
use File::Temp qw/tempfile/;
use Data::Dumper;

use strict;

sub dosshsign {
  my ($signdata, $keyfile, $namespace) = @_;
  die("no key file specified\n") unless $keyfile;
  my $out = _execute_cmd(['ssh-keygen', '-Y', 'sign', '-n', $namespace, '-f', $keyfile], $signdata);
  die("Signature authentification: bad ssh signature format\n") unless $out =~ s/.*-----BEGIN SSH SIGNATURE-----\n//s;
  die("Signature authentification: bad ssh signature format\n") unless $out =~ s/-----END SSH SIGNATURE-----.*//s;
  my $sig = MIME::Base64::decode_base64($out);
  die("Signature authentification: bad ssh signature\n") unless substr($sig, 0, 6) eq 'SSHSIG';
  return $sig;
}

sub _execute_cmd {
  my ($cmd, $data) = @_;
  my $fh;
  my $pid = open($fh, '-|');
  die("pipe open: $!\n") unless defined $pid;
  if (!$pid) {
    if ($data) {
      my $pid2 = open(STDIN, '-|');
      die("pipe open: $!\n") unless defined $pid2;
      if (!$pid2) {
        print STDOUT $data or die("write data: $!\n");
        exit 0;
      }
    }
    exec(@$cmd);
    die("@$cmd: $!\n");
  }
  my $out = '';
  1 while sysread($fh, $out, 8192, length($out));
  return $out;
}

sub _get_tmp_keyfile_from_agent {
  my ($keyid) = @_;
  my ($fh, $filename) = tempfile();
  my @keys = split("\n", _execute_cmd(['ssh-add','-L']));
  my $agent_key;
  my $kl;
  if ($keyid) {
    for my $key_line (@keys) {
      my ($type, $key, $id) = split(" ", $key_line);
      $kl = $key_line if $id eq $keyid;
    }
  } else {
    $kl = $keys[0];
  }
  return if ! $kl;
  print $fh $kl || die "Could not write to $filename: $!\n";
  close $fh || die "Could not close $filename: $!\n";
  return $filename
}


sub generate_authorization {
  my ($auth_param, $keyid, $keyfile) = @_;
  my $realm = $auth_param->{'realm'} || '';
  my $headers = $auth_param->{'headers'} || '(created)';
  my $created = time();
  my $tosign = '';
  for my $h (split(/ /, $headers)) {
    if ($h eq '(created)') {
      $tosign .= "(created): $created\n";
    } else {
      die("Signature authentication: unsupported header element: $h\n");
    }
  }
  die("Signature authentication: no keyid specified\n") unless defined($keyid);
  die("Signature authentication: nothing to sign?\n") unless $tosign;
  chop $tosign;
  my $algorithm = $auth_param->{'algorithm'} || 'ssh';
  die("Signature authentication: unsupported algorithm '$algorithm'\n") unless $algorithm eq 'ssh';
  my $sig = dosshsign($tosign, $keyfile, $realm);
  $sig = MIME::Base64::encode_base64($sig, '');
  die("bad keyid '$keyid'\n") if $keyid =~ /\"/;
  return "Signature keyId=\"$keyid\",algorithm=\"$algorithm\",headers=\"$headers\",created=$created,signature=\"$sig\"";
}

sub get_key_data {
  my ($uri) = @_;
  my $keyid = $::ENV{SSH_PUB_KEY_ID};
  my $keyfile = _get_tmp_keyfile_from_agent($keyid);
  if (!defined($keyid)) {
    # check if the host includes a user name
    my $authority = $uri->authority;
    if ($authority =~ s/^([^\@]*)\@//) {
      $keyid = $1;
      $keyid =~ s/:.*//;	# ignore password
    }
  }
  if (!defined($keyfile)) {
    my $home = $ENV{'HOME'};
    if ($home && -d "$home/.ssh") {
      for my $idfile (qw{id_ed25519 id_rsa}) {
	next unless -s "$home/.ssh/$idfile";
	$keyfile = "$home/.ssh/$idfile";
	last;
      }
    }
  }
  return ($keyid, $keyfile);
}

sub authenticate {
  my ($class, $ua, $proxy, $auth_param, $response, $request, $arg, $size) = @_;
  my $uri = $request->uri->canonical;
  return $response unless $uri && !$proxy;
  my ($keyid, $keyfile) = get_key_data($uri);
  my $host_port = $uri->host_port;
  my $auth = generate_authorization($auth_param, $keyid, $keyfile);
  my $h = $ua->get_my_handler('request_prepare', 'm_host_port' => $host_port, sub {
    $_[0]{callback} = sub { $_[0]->header('Authorization' => $auth) };
  });
  my $fin = $ua->request($request->clone, $arg, $size, $response);
  return $fin;
}

# install handler
no warnings;
*LWP::Authen::Signature::authenticate = \&authenticate;

1;
