# NAME

Zing::Encoder::Json - JSON Serialization Abstraction

# ABSTRACT

JSON Data Serialization Abstraction

# SYNOPSIS

    use Zing::Encoder::Json;

    my $encoder = Zing::Encoder::Json->new;

    # $encoder->encode({ status => 'okay' });

# DESCRIPTION

This package provides a [JSON](https://metacpan.org/pod/JSON) data serialization abstraction for use with
[Zing::Store](https://metacpan.org/pod/Zing::Store) stores.

# LIBRARIES

This package uses type constraints from:

[Zing::Types](https://metacpan.org/pod/Zing::Types)

# METHODS

This package implements the following methods:

## decode

    decode(Str $data) : HashRef

The decode method decodes the data provided.

- decode example #1

        # given: synopsis

        $encoder->decode('{ "status":"okay" }');

## encode

    encode(HashRef $data) : Str

The encode method encodes the data provided.

- encode example #1

        # given: synopsis

        $encoder->encode({ status => 'okay' });

# AUTHOR

Al Newkirk, `awncorp@cpan.org`

# LICENSE

Copyright (C) 2011-2019, Al Newkirk, et al.

This is free software; you can redistribute it and/or modify it under the terms
of the The Apache License, Version 2.0, as elucidated in the ["license
file"](https://github.com/iamalnewkirk/zing-encoder-json/blob/master/LICENSE).

# PROJECT

[Wiki](https://github.com/iamalnewkirk/zing-encoder-json/wiki)

[Project](https://github.com/iamalnewkirk/zing-encoder-json)

[Initiatives](https://github.com/iamalnewkirk/zing-encoder-json/projects)

[Milestones](https://github.com/iamalnewkirk/zing-encoder-json/milestones)

[Contributing](https://github.com/iamalnewkirk/zing-encoder-json/blob/master/CONTRIBUTE.md)

[Issues](https://github.com/iamalnewkirk/zing-encoder-json/issues)
