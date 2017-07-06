package Sparrow::Commands::Index;

use strict;

use base 'Exporter';

use Sparrow::Constants;
use Sparrow::Misc;

use Carp;

our @EXPORT = qw{

    update_index
    update_custom_index
    index_summary

};


sub update_index {

    print 'get index updates from SparrowHub ... ';
    execute_shell_command("curl -s -k -L -f  -o ".spi_file.' '.sparrow_hub_api_url.'/api/v1/index'." && echo OK")

};

sub update_custom_index {

    my $repo = sparrow_config()->{repo};

    if ($repo){
      print "get index updates from custom repo $repo ... ";
      execute_shell_command("curl -s -k -L -f  -o ".spci_file.' '.$repo." && echo OK")
    }

};

sub index_summary {

    print "[sparrow index summary]\n\n";
    execute_shell_command("ls -l ".spi_file);
    execute_shell_command("ls -l ".spci_file);
    execute_shell_command("ls -l ".spl_file);

};

1;
