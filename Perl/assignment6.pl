#!/usr/bin/perl -w
use open ':locale';
use locale;
#ucitaj datoteke do predzadnjeg ARGV
#zadnji argv je duljina prefiksa
#ucitavaj rijec po rijec
#neka je rijec (velicine zadanog prefiksa) kljuc hasha. inkrementiraj value tog kljuca
#isprintaj hash

@filenames = @ARGV;
chomp @filenames;
$size = @filenames;
print "size: $size\n";
$prefixSize = $filenames[$size - 1];

if($size == 0){
	#filaj datoteku tekstom
	#pushaj ime datoteke u @filenames
	print "Unesi text: (Unos prekini s -1)\n";
	open (my $fh, '>', 'tekst.txt');
	while( (my $stdinData = <STDIN>) ne "-1\n") {	
		chomp ($stdinData);
		print $fh "$stdinData\n";
		}
	push @filenames, 'tekst.txt';

	print "Unesi duljinu prefiksa: ";
	$prefixSize = <STDIN>;
	$size = 2;
}

print "filenames\t@filenames \n";

my $iterator = 0;
while($iterator < ($size - 1)){

	$file = $filenames[$iterator];

	my $success = open LOG, "$file";

	if( ! $success){
		print "Datoteka $file nije otvorena!\n";
		$iterator += 1;
		next;
	}

	#napravi dictionary
	my %hash;

	while(<LOG>){
		#izdvoji sat
		#za taj sat inkrementiraj broj u hashu
		chomp;
		my @words = split /\s/, "$_";
		#print "@words\n";
		foreach	$word (@words){
			$word =~ tr/,;!//;
			$word = substr $word, 0, $prefixSize;
			
			if(length($word) == $prefixSize){
				$word =~ tr/A-Z/a-z/;
				$hash{"$word"} += 1;
			}
		}
	}

	#isprintaj riječnik
	foreach $k (sort keys %hash) {
    	print "$k\t:\t$hash{$k}\n";
	}

	#napravi mjesta
	#odi na iducu datoteku
	$iterator += 1;
	print "\n";
}