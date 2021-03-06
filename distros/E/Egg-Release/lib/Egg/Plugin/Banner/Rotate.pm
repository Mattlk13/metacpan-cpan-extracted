package Egg::Plugin::Banner::Rotate;
#
# Masatoshi Mizuno E<lt>lusheE<64>cpan.orgE<gt>
#
# $Id: Rotate.pm 337 2008-05-14 12:30:09Z lushe $
#
use strict;
use warnings;

our $VERSION= '3.01';

sub _setup {
	my($e)= @_;
	my $c= $e->config->{plugin_banner_rotate} ||= {};
	$c->{base_dir} ||= $e->config->{dir}{etc}. '/banners';
	$c->{base_dir}=~s{/+$}  [];
	$c->{extention} ||= 'yaml';
	$c->{extention}=~s{^\.+} [];
	$e->next::method;
}
sub banner_rotate {
	$_[0]->{banner_rotate} ||= Egg::Plugin::Banner::Rotate::handler->new(@_);
}

package Egg::Plugin::Banner::Rotate::handler;
use strict;
use base qw/ Egg::Base /;
use YAML;

sub new {
	my($class, $e)= @_;
	$class->SUPER::new($e, $e->config->{plugin_banner_rotate});
}
sub banners {
	my $self = shift;
	my $key  = shift || 'default';
	my $cache= $self->e->global->{banner_rotate} ||= {};
	$cache->{$key} ||= do {
		my $pm  = $self->params;
		my $yaml= "$pm->{base_dir}/$key.$pm->{extention}";
		my $list= [ YAML::LoadFile($yaml) ];
		@$list || warn qq{ Banners is not found - $yaml. };
		{
		  num     => 0,
		  time    => time,
		  total   => scalar(@$list),
		  banners => $list,
		  };
	  };
}
sub get_random {
	rand(1000);
	my $self= shift;
	my $b= $self->banners(@_);
	return {} unless $b->{total};
	$b->{banners}[int( rand($b->{total}) )] || {};
}
sub get_turns {
	my $self= shift;
	my $b= $self->banners(@_);
	return {} unless $b->{total};
	$b->{num}= 0 if $b->{num}>= $b->{total};
	$b->{banners}[$b->{num}++] || {};
}
sub clear_cache {
	my $self= shift;
	my $cache= $self->e->global->{banner_rotate} || return (undef);
	if (@_) {
		my $key = shift || return (undef);
		$cache->{$key} ? delete($cache->{$key}): (undef);
	} else {
		%$cache= ();
	}
}

1;

__END__

=head1 NAME

Egg::Plugin::Banner::Rotate - Plugin to display advertisement rotating.

=head1 SYNOPSIS

  use Egg qw/ Banner::Rotate /;
  
  my $banner= $e->banner_rotate->get_random('banner_name');
  
  $e->stash->{head_banner}= qq{<a href="$banner->{url}"><img src="$banner->{img_url}" /></a>};

=head1 DESCRIPTION

The method that can be acquired by switching the data of the advertisement
registered beforehand in every case is offered.

Please make a suitable data file for advertising data beforehand by the YAML format.
This advertising data is a thing composed of ARRAY without fail.

  ---
  url: http://banner/redirect/hoo.html
  img_url: http://banner/images/hoo.gif
  ---
  url: http://banner/redirect/hoge.html
  img_url: http://banner/images/hoge.gif

The element in ARRAY is not very cared about.
It only has to make data a convenient at the time of receipt format.

=head1 CONFIGURATION

The configuration is set with the key 'plugin_banner_rotate'.

  plugin_banner_rotate => {
    ..........
    ....
    },

=head2 base_dir

It is passing of the directory that sets up advertising data.

Default is "$e-E<gt>config-E<gt>{dir}{etc}/banners".

  base_dir => '<e.dir.etc>/banners',

=head2 extention

Extension of advertising data file.

Default is 'yaml'.

  extention => 'yaml',

=head1 METHODS

=head2 banner_rotate

The Egg::Plugin::Banner::Rotate::handler object is returned.

  my $br= $e->banner_rotate;

=head1 HANDLER METHODS

L<Egg::Base> has been succeeded to.

=head2 new

Constructor. When 'banner_rotate' method is called, it is called internally.

=head2 banners ([BANNER_NAME])

The registered advertising data is returned.

BANNER_NAME specifies the part of the file name that doesn't contain the extension
of advertising data.

When BANNER_NAME is omitted, 'default' is used.

The data specified for BANNER_NAME should exist in
"[base_dir]/[BANNER_NAME].[extention]".

If data file is not found, the exception is generated by 'LoadFile' of L<YAML>.

The returned advertising data is HASH reference with the following keys.

=over 4

=item * banners = List data of advertisement (ARRAY_REF).

=item * total = Registered advertising number.

=item * time = time value when data is read.

=item * num = Rotation number.

=back

  my $hash= $br->banners('banner_name');
  
  for (@{$hash->{banners}}) {
      .........
      ....
  }

=head2 get_random ([BANNER_NAME])

Advertising data is returned from data obtained by 'banners' method at random.
The argument is passed to 'banners' method.

  my $banner= $br->get_random('hoge');

The element of ARRAY registered in YAML extends as it is in data.

=head2 get_turns ([BANNER_NAME])

Advertising data is sequentially returned from data obtained by 'banners' method.
The argument is passed to 'banners' method.

  my $banner= $br->get_turns('hoge');

The element of ARRAY registered in YAML extends as it is in data.

=head2 clear_cache ([BANNER_NAME])

This method clears it though 'banners' method uses cash.

When BANNER_NAME is specified, only the corresponding cash is cleared.
When BANNER_NAME is unspecification, all cash is cleared.

  $br->clear_cache('booo');

=head1 SEE ALSO

L<Egg::Release>,
L<Egg::Base>,
L<YAML>,

=head1 AUTHOR

Masatoshi Mizuno E<lt>lusheE<64>cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Bee Flag, Corp. E<lt>L<http://egg.bomcity.com/>E<gt>.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.

=cut

