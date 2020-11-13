#!/usr/bin/env perl

use warnings;
use strict;

my $log1 = "/var/log/syslog";
my $log2 = "/var/log/syslog.1";
my $pattern = "[E|e]rror|ERROR";

sub search_log {
   my ($filepath, $pattern, $outputfile) = @_;
   open (my $log, "<", $filepath) or die "Can't open $log1: $!";

   foreach my $line (<$log>) {
	if ($line =~ /$pattern/) {
		print $outputfile $line;
	}
   }

   close($log) or die "Error closing logfile handle: $!";

}

open (my $report, ">", "errors.log") or die "Can't write errors.log: $!";

search_log($log1, $pattern, $report);
search_log($log2, $pattern, $report);

close($report) or die "Error closing errors.log: $1"; 

