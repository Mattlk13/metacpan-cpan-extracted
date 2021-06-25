package Dist::Zilla::Role::BuildRunner 6.020;
# ABSTRACT: something used as a delegating agent during 'dzil run'

use Moose::Role;
with 'Dist::Zilla::Role::Plugin';

# BEGIN BOILERPLATE
use v5.20.0;
use warnings;
use utf8;
no feature 'switch';
use experimental qw(postderef postderef_qq); # This experiment gets mainlined.
# END BOILERPLATE

use namespace::autoclean;

#pod =head1 DESCRIPTION
#pod
#pod Plugins implementing this role have their C<build> method called during
#pod C<dzil run>.  It's passed the root directory of the build test dir.
#pod
#pod =head1 REQUIRED METHODS
#pod
#pod =head2 build
#pod
#pod This method will throw an exception on failure.
#pod
#pod =cut

requires 'build';

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Role::BuildRunner - something used as a delegating agent during 'dzil run'

=head1 VERSION

version 6.020

=head1 DESCRIPTION

Plugins implementing this role have their C<build> method called during
C<dzil run>.  It's passed the root directory of the build test dir.

=head1 PERL VERSION SUPPORT

This module has the same support period as perl itself:  it supports the two
most recent versions of perl.  (That is, if the most recently released version
is v5.40, then this module should work on both v5.40 and v5.38.)

Although it may work on older versions of perl, no guarantee is made that the
minimum required version will not be increased.  The version may be increased
for any reason, and there is no promise that patches will be accepted to lower
the minimum required perl.

=head1 REQUIRED METHODS

=head2 build

This method will throw an exception on failure.

=head1 AUTHOR

Ricardo SIGNES 😏 <rjbs@semiotic.systems>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2021 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
