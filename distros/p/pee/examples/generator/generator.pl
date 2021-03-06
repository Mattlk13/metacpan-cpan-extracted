#!/usr/bin/perl -w

use lib '../pee';
use strict;
use Pee::FileRunner;


my $OUTPUT_DIR = "/home/users/williamt/src/generator/output";
my $template;


if ($ARGV[0]) {
  $template = $ARGV[0];
}
else {
  print "Usage: generator.pl <template_file>\n";
  exit;
}


if (! -r $template) {
  print STDERR "$template: file does not exist or not readable\n";
}

# get the file stat
my @fstat = stat($template);


print "Checking if the file was modified... ";
if (&check_sig($fstat[7], $fstat[9], "$OUTPUT_DIR/$template.pl")) {
  print "yes\n";
}
else {
  print "no\nExiting.\n";
  exit(0);
}

print "generating for $template\n";


my $runner = Pee::FileRunner->new("$template");

if (!$runner->compile()) {
  print STDERR "Error compiling template: $template\n";
  print STDERR "$runner->{errmsg}";
  exit(0);
}

# save the results into file

print "Creating output file.\n";
open (F, ">$OUTPUT_DIR/$template.pl") or die "shit! $!\n";
print F '#!/usr/bin/perl'."\n";
print F "##sig## $fstat[7]:$fstat[9]\n";
print F $runner->{extracted};
close (F);




# check_sig ($template_mtime, $template_size, $output_file)
# check if the original template have changed by looking at the 
# already existing output file.
# Returns 1 if it has changed or that the output file does not exist.
sub check_sig {
  my ($template_size, $template_mtime, $output_file) = @_;
  my ($size, $mtime);

  # see if the output file exist
  if (! -r $output_file) {
    return 1;
  }

  # get the signature from the output file
  open (F, $output_file) or return 1;
  <F>;   # first line is '#!/usr/bin/perl'
  my $sig = <F>;   # sig is in the format of '##sig## size:mtime'
  close(F);

  if ($sig =~ /^##sig## (\d+)\:(\d+)\n$/) {
    ($size,$mtime) = ($1,$2);


    # verify against the template file's mtime & size
    if (($template_mtime == $mtime) && ($template_size == $size)) {
      return 0;
    }
  }
  else { print STDERR "shit!\n"; }

  return 1;
}
