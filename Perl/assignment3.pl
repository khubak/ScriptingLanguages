#!/usr/bin/perl -w

#ucitaj datoteke iz argumenta u varijablu
#otvori datoteku
#ispisi datum i sat

#regex
#pronadi do prve dvotocke sat
##izbroji koliko ima takvih

@filenames = @ARGV;
chomp @filenames;
$size = @filenames;

if($size == 0){
	print "Unesi ime datoteke: (Unos prekini s -1)\n";
	while( (my $stdinfile = <STDIN>) ne "-1\n") {	
		chomp ($stdinfile);
		push @filenames, $stdinfile;
	}
}

print "filenames\t@filenames \n";

foreach my $file (@filenames){

	my $success = open LOG, "$file";

	if( ! $success){
		print "Datoteka $file nije otvorena!\n";
		next;
	}

	my @filename = split /\./, "$file";

	print ("Datum:\t\t" . $filename[1] . "\n");
	print ("sat\t:\tbroj pristupa\n-----------------------------------------------------\n");

	#napravi dictionary
	my %hash;

	while(<LOG>){
		#izdvoji sat
		#za taj sat inkrementiraj broj u hashu
		chomp;
		my @line = split /:/, "$_";
		$hash{"$line[1]"} += 1;
	}

	#isprintaj riječnik
	foreach $k (sort {$a <=> $b} keys %hash) {
    	print "$k\t:\t$hash{$k}\n";
	}

	#napravi mjesta
	print "\n";
}