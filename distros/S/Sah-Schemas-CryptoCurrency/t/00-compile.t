use 5.006;
use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.058

use Test::More;

plan tests => 23 + ($ENV{AUTHOR_TESTING} ? 1 : 0);

my @module_files = (
    'Sah/Schema/cryptocurrency.pm',
    'Sah/Schema/cryptocurrency/code.pm',
    'Sah/Schema/cryptocurrency/code_or_name.pm',
    'Sah/Schema/cryptocurrency/safename.pm',
    'Sah/Schema/cryptoexchange.pm',
    'Sah/Schema/cryptoexchange/code.pm',
    'Sah/Schema/cryptoexchange/currency_pair.pm',
    'Sah/Schema/cryptoexchange/name.pm',
    'Sah/Schema/cryptoexchange/safename.pm',
    'Sah/Schema/fiat_currency.pm',
    'Sah/Schema/fiat_or_cryptocurrency.pm',
    'Sah/SchemaR/cryptocurrency.pm',
    'Sah/SchemaR/cryptocurrency/code.pm',
    'Sah/SchemaR/cryptocurrency/code_or_name.pm',
    'Sah/SchemaR/cryptocurrency/safename.pm',
    'Sah/SchemaR/cryptoexchange.pm',
    'Sah/SchemaR/cryptoexchange/code.pm',
    'Sah/SchemaR/cryptoexchange/currency_pair.pm',
    'Sah/SchemaR/cryptoexchange/name.pm',
    'Sah/SchemaR/cryptoexchange/safename.pm',
    'Sah/SchemaR/fiat_currency.pm',
    'Sah/SchemaR/fiat_or_cryptocurrency.pm',
    'Sah/Schemas/CryptoCurrency.pm'
);



# no fake home requested

my @switches = (
    -d 'blib' ? '-Mblib' : '-Ilib',
);

use File::Spec;
use IPC::Open3;
use IO::Handle;

open my $stdin, '<', File::Spec->devnull or die "can't open devnull: $!";

my @warnings;
for my $lib (@module_files)
{
    # see L<perlfaq8/How can I capture STDERR from an external command?>
    my $stderr = IO::Handle->new;

    diag('Running: ', join(', ', map { my $str = $_; $str =~ s/'/\\'/g; q{'} . $str . q{'} }
            $^X, @switches, '-e', "require q[$lib]"))
        if $ENV{PERL_COMPILE_TEST_DEBUG};

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, @switches, '-e', "require q[$lib]");
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($?, 0, "$lib loaded ok");

    shift @_warnings if @_warnings and $_warnings[0] =~ /^Using .*\bblib/
        and not eval { +require blib; blib->VERSION('1.01') };

    if (@_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
}



is(scalar(@warnings), 0, 'no warnings found')
    or diag 'got warnings: ', ( Test::More->can('explain') ? Test::More::explain(\@warnings) : join("\n", '', @warnings) ) if $ENV{AUTHOR_TESTING};


