use strict;
use warnings;

package CPAN::Mini::Webserver::Templates::Images;

# ABSTRACT: image content for a CPAN::Mini web server

our $VERSION = '0.58'; # VERSION

use MIME::Base64;
use Template::Declare::Tags;
use base 'Template::Declare';

template 'images_logo' => sub {
    my $self    = shift;
    my $encoded = <<'END';
iVBORw0KGgoAAAANSUhEUgAAAFIAAAAYCAMAAABeMVqjAAAAAXNSR0IArs4c6QAAApFQTFRFAgIC
AwMDBAQEBQUFBgYGBwcHCAgICQkJCgoKCwsLDAwMDQ0NDg4ODw8PEBAQEREREhISExMTFBQUFRUV
FhYWFxcXGBgYGRkZGhoaGxsbHh4eHx8fICAgISEhIiIiIyMjJCQkJSUlJiYmJycnKCgoKSkpKioq
KysrLCwsLS0tLi4uLy8vMDAwMTExMjIyMzMzNTU1NjY2Nzc3ODg4OTk5Ojo6Ozs7PDw8PT09Pj4+
Pz8/QEBAQUFBQkJCQ0NDRERERUVFSEhISUlJSkpKTU1NT09PUFBQUVFRUlJSU1NTVFRUVVVVV1dX
WFhYWVlZW1tbXV1dXl5eX19fY2NjZGRkZmZmaGhoaWlpa2trbW1tbm5ub29vcHBwcXFxcnJydHR0
dXV1dnZ2enp6e3t7fHx8fX19fn5+f39/gICAgYGBgoKCg4ODhYWFhoaGiIiIiYmJjIyMjY2Njo6O
kJCQkZGRkpKSk5OTlJSUlpaWl5eXmJiYmZmZmpqam5ubnJycnZ2dnp6en5+foKCgoaGhoqKio6Oj
pKSkpaWlpqamp6enqKioqampqqqqq6urrKysra2trq6ur6+vsLCwsbGxsrKys7OztLS0tbW1tra2
t7e3uLi4ubm5urq6u7u7vLy8vb29vr6+wMDAwcHBwsLCw8PDxMTExsbGx8fHyMjIycnJysrKy8vL
zMzMzc3Nzs7Oz8/P0NDQ09PT1NTU1dXV1tbW19fX2NjY2dnZ2tra3Nzc3d3d3t7e39/f4ODg4eHh
4uLi4+Pj5OTk5eXl5ubm6Ojo6urq6+vr7Ozs7e3t7u7u7+/v8PDw8fHx8vLy8/Pz9PT09fX19vb2
9/f3+Pj4+fn5+vr6+/v7/Pz8/f39/v7+////4IAsjwAAA9hJREFUOMtjuEUauOq7iJASBtJMvN6h
UnuTqkZe36Rmw7+m+yr1jLyxO1xPwrjN8CJRRl6cnxXi5RWa3r72JIh7qqaxq72qsm/TdWQTt3eJ
2nK3WzcgG7BmBpy5saG1q3YL1MhrLbre9YvXLW8NFWVPBwncPBfG7DCx2YfXeiNcx809Kyzs+Z1a
RY4iG9krshhu5XEnvhU3IEZeidZcAgn0mzuNi6BKmROAihp4NI7BTNy/KlfGSKDHQt7/NJKRfSyy
W+CcfIUrEI/fTBNfDxedWQWhJzMlgiz2Ym6Hmnhw1XRFNw6vVk4hQ7+zCCO7uNlVdsE4ZbJQIzfy
pCISxoEuqJEMCSCqhzEdwt+/apamjaLIRDtzVTHDmBsIV9oGsxofhnKq5a5CjAzl3ImUTi6gGLmC
sQLMPbVquoqFEEtwu5x6hLigTCVcfb/9eSdWa2hQNECNPC8rcwMzKUxkjAdRUzjXguNv3RRZc34W
Vlf9vDUqFqwCUjNh6nosb500ZXc/D+a0QY3cxmFwC5eRV7yDQNbd3DVB0YKPjc1ANfH8rYkqoiwi
KhtgMW5y49Y+DbagS+CAlbsGNnINizkOI28eS/I9AeIc71Mx4WNmN1MqBWq5WacqyCJucghqpB5Q
aKMCWzTI6n55iCvXMqtjN3JJVsqsK2Bv9ymb8LDy2ChPAEfjjTJFHhYJF4hfezUuA8nVEmyZQLm5
ihAjD/DzHcdq5E1YOpitaMTJxG2uvgKWRDOV2FnEw8Ex0KsIjs+ZfNzFN28t1IZkyCvaLC2YRkJj
HAQWyBmwMglZWO+GS16LU2ZnEcgHWdkrcw6SmPi5224u0oLm8Sxm0/N4jNwhpc7MJGngfQxJ9kqw
PBsb52RQjEuegQg1cwlNWakDNfKgAns2oniYCqEmMSRCBbYJszDJ6kad2z+zvLi0vLahubN74rRp
+rJsrCkgV0pC0+TNKi7Reg1YSTSbh7cYZub2AgjdzRgLC7npItLquiGmCnLyyqrKahqaWpo6urJy
JsKOoNTQKwpz/Y0yDkFNeOE2W4rddyvY0KPuk6F5iykY7vBtaZqcnJxcHEDAzsrGxsbCwq5QfWIO
uNis4t0DL4kKWbUQ5eW+WGkeq6iM1AApqb1ggV1u7GpLj8ANdWFiYGQAAkZmZhYWFjZOVVEzcETf
2OzBkbYZ5sOb+QbIpfrJ+VXJ8QnFvQcgOX3FilUrFm6DG+nJxMTECARQg1nYeBTABenlhcvXLl10
De7OZcRXFE3c7Jw8vLw83NxgglNEse4GhXXPzV1r5k1uLMlJigx0ttCRExXoxF1PAgA2yRjCqrg9
2wAAAABJRU5ErkJggg==

END
    outs_raw decode_base64($encoded);
};

template 'images_favicon' => sub {
    my $self    = shift;
    my $encoded = <<'END';
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAADNQTFRFOAAA
BQgEFhgVHh8dISIgJigmLC0rMTMwOz06RkhFTE1LWFpXZWdkeHl3hIaDnqCdzM7LanH2cgAAAAF0
Uk5TAEDm2GYAAABsSURBVBjTdY9ZDsIwDAW9rynt/U8LhRAVBO/HGnss2QB/csRXo3XrK+9u43NB
bnIxjuEx1HJxG26ezIsVxQEUdbKgPm1BOUsxWr1cxocYtBiKMKBRK8PMIzKdzhnhOzzm5sq8xKW7
woT819t3e1MC40tpI0cAAAAASUVORK5CYII=

END
    outs_raw decode_base64($encoded);
};

1;



=pod

=head1 NAME

CPAN::Mini::Webserver::Templates::Images - image content for a CPAN::Mini web server

=head1 VERSION

version 0.58

=head1 DESCRIPTION

This module holds the images for
CPAN::Mini::Webserver.

=head1 AUTHORS

=over 4

=item *

Leon Brocard <acme@astray.com>

=item *

Christian Walde <walde.christian@googlemail.com>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Christian Walde.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

