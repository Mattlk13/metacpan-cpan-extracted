# NAME

Keyword::TailRecurse - Enables true tail recursion

# SYNOPSIS

    use Keyword::TailRecurse;

    sub fibonacci {
        my ( $count, $previous, $current ) = @_;

        return ( $previous // 0 ) if $count <= 0;

        $current //= 1;

        tailRecurse fibonacci ( $count - 1, $current, $previous + $current );
    }

    print fibonacci( 7 );

# DESCRIPTION

Keyword::TailRecurse provides a `tailRecurse` keyword that does proper tail
recursion that doesn't grow the call stack.

# USAGE

After using the module you can precede a function call with the keyword
`tailRecurse` and rather adding a new entry on the call stack the function
call will replace the current entry on the call stack.

# ALIASES

By default the keyword `tailRecurse` is added, but you can use the
`tail_recurse` and/or `tailrecurse` keywords to add the tail recursion
keyword in a form more suitable for different naming conventions.

## Sub::Call::Tail compatibility

If compatibility with `Sub::Call::Tail` is required then you can use the
`subCallTail` flag to enable the `tail` keyword.

    use Keyword::TailRecurse 'subCallTail';

    sub fibonacci {
        my ( $count, $previous, $current ) = @_;

        return ( $previous // 0 ) if $count <= 0;

        $current //= 1;

        tail fibonacci ( $count - 1, $current, $previous + $current );
    }

    print fibonacci( 7 );

Note: with `Sub::Call:Tail` compatibility enabled both the `tailRecurse` and
`tail` keywords are available.

# REQUIRED PERL VERSION

`Keyword::TailRecurse` requires features only available in Perl v5.14 and
above. In addition a `Keyword::TailRecurse` dependency doesn't work in Perl
v5.20 due to a bug in regular expression compilation.

## PERL V5.14 AND V5.16 DEPENDENCY

There's issues with `Keyword::Declare` and its `Keyword::Simple` dependency
which requires the use of `Keyword::Simple` version 0.03 for Perl version 5.14
and 5.16.

# SEE ALSO

- [Sub::Call::Recur](https://metacpan.org/pod/Sub::Call::Recur)

    An `XS` module that provides a form of tail recursion - limited to recursing
    into the same function it's used from.

- [Sub::Call::Tail](https://metacpan.org/pod/Sub::Call::Tail)

    An `XS` module that provides a generic tail recursion.

# LICENSE

Copyright (C) Jason Cooper.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Jason Cooper <JLCOOPER@cpan.org>
