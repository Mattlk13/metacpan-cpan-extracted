use 5.006;
use lib::relative '.';
use Kit;
use Test::Fatal;

# --- Attempts to call with an unsupported arity -----------------------
{
    package main::my_multi;     # We're making main::my_multi()
    use Sub::Multi::Tiny qw($foo $bar);    # All possible params

    sub first :M($foo, $bar) { # sub's name will be ignored
        return $foo ** $bar;
    }

    sub second :M($foo) {
        return $foo + 42;
    }

}

ok do { no strict 'refs'; defined *{"main::my_multi"}{CODE} }, 'my_multi() exists';

like exception { my_multi; }, qr/No candidate.*arity 0/, 'arity 0';
like exception { my_multi(1,2,3); }, qr/No candidate.*arity 3/, 'arity 3';

done_testing;
