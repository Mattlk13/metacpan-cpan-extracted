package App::minecraft;

our $VERSION = '0.001';

=head1 NAME

App::minecraft - Backup and restore your Minecraft. Install mods.

=head1 USAGE

$ minecraft.pl backup
$ minecraft.pl install Shelf.zip
$ minecraft.pl install --jar /usr/local/bin/jar Shelf.zip
$ minecraft.pl restore --verbose

=head1 DESCRIPTION

As it stands this script is very limited. However, I did manage to successfully backup my Minecraft folder, install the Shelf mod in the sample directory and restore my Minecraft without any problems.
Remember to always perform a backup using the 'backup' parameter before installing any mod, because this script can, and probably will, corrupt your main jar file. So use it at your own peril!

In the future I'd like it to properly check the contents of each zip before doing anything. Some mods have different formats, and App::minecraft needs to be smart enough to handle those and know what to do with them.

=head1 AUTHOR

Brad Haywood <brad@perlpowered.com>

=head1 LICENSE

This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.

=cut

1;
