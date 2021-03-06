use VM::JiffyBox;
use feature qw(say);
use Data::Dumper;
use Text::ASCIITable;

unless ($ARGV[0]) {
    say 'Token as first argument needed!';
}
unless ($ARGV[1]) {
    say 'BoxID as second argument needed!';
}

my $jiffy = VM::JiffyBox->new(token => $ARGV[0], test_mode => 1);
my $box = $jiffy->get_vm($ARGV[1]);

my $url = $box->get_backups();
say "\n$url\n";

$jiffy->test_mode(0);

my $response = $box->get_backups();
print Dumper($response);
