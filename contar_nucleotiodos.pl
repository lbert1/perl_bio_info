#DNA COUNT
use strict;
use warnings FATAL => 'all';
use autodie qw(:all);
use POSIX qw(strftime);

my $date_time = strftime "%Y%m%d_%H%M%S", localtime;
my $dna;
my $report;
my %count_nucleotides = (
	"A" => 0,
	"C" => 0,
	"G" => 0,
	"T" => 0,
);
my $nucleotide;

open($dna, "<","dna.fasta") or die "Input file not found!";
open($report, "+>","./reports/dna_count_$date_time.txt") or die "The reporting directory was not found!";

foreach my $line (<$dna>) {
	print {$report} "DNA-> $line";
	foreach $nucleotide (split("",$line)) {
		for my $key (keys %count_nucleotides){
			if ($nucleotide eq $key) {
				$count_nucleotides{$key}++;
			}
		}
	}
	for my $key (keys %count_nucleotides) {
    print {$report} "$key-> $count_nucleotides{$key}\n";
	$count_nucleotides{$key} = 0;
	}
	print {$report} "----------------------------\n";
}
print "Report File-> /reports/dna_count_$date_time.txt";
close($dna);
close($report);