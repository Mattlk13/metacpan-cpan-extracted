package Net::Amazon::S3::Operation::Object::Upload::Complete;
# ABSTRACT: Internal class to perform CompleteMultipartUpload operation
$Net::Amazon::S3::Operation::Object::Upload::Complete::VERSION = '0.97';
use strict;
use warnings;

use Net::Amazon::S3::Operation::Object::Upload::Complete::Request;
use Net::Amazon::S3::Operation::Object::Upload::Complete::Response;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Net::Amazon::S3::Operation::Object::Upload::Complete - Internal class to perform CompleteMultipartUpload operation

=head1 VERSION

version 0.97

=head1 DESCRIPTION

Implements operation L<< CompleteMultipartUpload|https://docs.aws.amazon.com/AmazonS3/latest/API/API_CompleteMultipartUpload.html >>

=head1 AUTHOR

Branislav Zahradník <barney@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020 by Amazon Digital Services, Leon Brocard, Brad Fitzpatrick, Pedro Figueiredo, Rusty Conover, Branislav Zahradník.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
