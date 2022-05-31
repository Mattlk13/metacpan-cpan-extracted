package Dist::Zilla::Stash::PAUSE 6.025;
# ABSTRACT: a stash of your PAUSE credentials

use Moose;

# BEGIN BOILERPLATE
use v5.20.0;
use warnings;
use utf8;
no feature 'switch';
use experimental qw(postderef postderef_qq); # This experiment gets mainlined.
# END BOILERPLATE

use namespace::autoclean;

#pod =head1 OVERVIEW
#pod
#pod The PAUSE stash is a L<Login|Dist::Zilla::Role::Stash::Login> stash generally
#pod used for uploading to PAUSE.
#pod
#pod =cut

sub mvp_aliases {
  return { user => 'username' };
}

has username => (
  is  => 'ro',
  isa => 'Str',
  required => 1,
);

has password => (
  is  => 'ro',
  isa => 'Str',
  required => 1,
);

with 'Dist::Zilla::Role::Stash::Login';
__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Stash::PAUSE - a stash of your PAUSE credentials

=head1 VERSION

version 6.025

=head1 OVERVIEW

The PAUSE stash is a L<Login|Dist::Zilla::Role::Stash::Login> stash generally
used for uploading to PAUSE.

=head1 PERL VERSION

This module should work on any version of perl still receiving updates from
the Perl 5 Porters.  This means it should work on any version of perl released
in the last two to three years.  (That is, if the most recently released
version is v5.40, then this module should work on both v5.40 and v5.38.)

Although it may work on older versions of perl, no guarantee is made that the
minimum required version will not be increased.  The version may be increased
for any reason, and there is no promise that patches will be accepted to lower
the minimum required perl.

=head1 AUTHOR

Ricardo SIGNES 😏 <rjbs@semiotic.systems>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2022 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
