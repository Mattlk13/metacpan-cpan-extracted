use 5.006;
use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.058

use Test::More;

plan tests => 38 + ($ENV{AUTHOR_TESTING} ? 1 : 0);

my @module_files = (
    'Data/Sah/Coerce/perl/To_int/From_str/convert_en_dow_name_to_num.pm',
    'Data/Sah/Coerce/perl/To_int/From_str/convert_en_month_name_to_num.pm',
    'Data/Sah/Coerce/perl/To_int/From_str/tz_offset_strings.pm',
    'Perinci/Sub/XCompletion/date_dow_num.pm',
    'Perinci/Sub/XCompletion/date_dow_nums.pm',
    'Perinci/Sub/XCompletion/date_month_num.pm',
    'Perinci/Sub/XCompletion/date_month_nums.pm',
    'Sah/Schema/date/day.pm',
    'Sah/Schema/date/dow_name/en.pm',
    'Sah/Schema/date/dow_num.pm',
    'Sah/Schema/date/dow_nums.pm',
    'Sah/Schema/date/hour.pm',
    'Sah/Schema/date/minute.pm',
    'Sah/Schema/date/month/en.pm',
    'Sah/Schema/date/month_name/en.pm',
    'Sah/Schema/date/month_num.pm',
    'Sah/Schema/date/month_nums.pm',
    'Sah/Schema/date/second.pm',
    'Sah/Schema/date/tz_name.pm',
    'Sah/Schema/date/tz_offset.pm',
    'Sah/Schema/date/tz_offset_lax.pm',
    'Sah/Schema/date/year.pm',
    'Sah/SchemaR/date/day.pm',
    'Sah/SchemaR/date/dow_name/en.pm',
    'Sah/SchemaR/date/dow_num.pm',
    'Sah/SchemaR/date/dow_nums.pm',
    'Sah/SchemaR/date/hour.pm',
    'Sah/SchemaR/date/minute.pm',
    'Sah/SchemaR/date/month/en.pm',
    'Sah/SchemaR/date/month_name/en.pm',
    'Sah/SchemaR/date/month_num.pm',
    'Sah/SchemaR/date/month_nums.pm',
    'Sah/SchemaR/date/second.pm',
    'Sah/SchemaR/date/tz_name.pm',
    'Sah/SchemaR/date/tz_offset.pm',
    'Sah/SchemaR/date/tz_offset_lax.pm',
    'Sah/SchemaR/date/year.pm',
    'Sah/Schemas/Date.pm'
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


