package Sah::SchemaR::unix::local_uid;

our $DATE = '2020-10-16'; # DATE
our $VERSION = '0.013'; # VERSION

our $rschema = ["int",[{description=>"\nSee also `posint` for integers that start from 1.\n\n",examples=>[{data=>0,valid=>1},{data=>1,valid=>1},{data=>-1,valid=>0}],min=>0,summary=>"Non-negative integer (0, 1, 2, ...)"},{description=>"\n",examples=>[{valid=>0,value=>-1},{valid=>1,value=>0},{valid=>1,value=>1}],summary=>"User identifier (UID)"},{description=>"\nExisting means having a user name associated with this UID, i.e. `getpwuid`\nreturns a record.\n\nSupport coercion from an existing user name.\n\n",prefilters=>["Unix::convert_unix_user_to_uid","Unix::check_uid_exists"],summary=>"User identifier (UID) that has to exist (has associated username) on the system"}],["unix::uid","uint","int"]];

1;
# ABSTRACT: User identifier (UID) that has to exist (has associated username) on the system

__END__

=pod

=encoding UTF-8

=head1 NAME

Sah::SchemaR::unix::local_uid - User identifier (UID) that has to exist (has associated username) on the system

=head1 VERSION

This document describes version 0.013 of Sah::SchemaR::unix::local_uid (from Perl distribution Sah-Schemas-Unix), released on 2020-10-16.

=head1 DESCRIPTION

This module is automatically generated by Dist::Zilla::Plugin::Sah::Schemas during distribution build.

A Sah::SchemaR::* module is useful if a client wants to quickly lookup the base type of a schema without having to do any extra resolving. With Sah::Schema::*, one might need to do several lookups if a schema is based on another schema, and so on. Compare for example L<Sah::Schema::poseven> vs L<Sah::SchemaR::poseven>, where in Sah::SchemaR::poseven one can immediately get that the base type is C<int>. Currently L<Perinci::Sub::Complete> uses Sah::SchemaR::* instead of Sah::Schema::* for reduced startup overhead when doing tab completion.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Sah-Schemas-Unix>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Sah-Schemas-Unix>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Sah-Schemas-Unix>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020, 2019 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
