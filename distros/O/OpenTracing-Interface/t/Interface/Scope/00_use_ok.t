use Test::Most;

BEGIN {
    $ENV{OPENTRACING_INTERFACE} = !undef;

    use_ok('OpenTracing::Interface::Scope');
    
};

done_testing;
