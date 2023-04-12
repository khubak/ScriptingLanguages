#!/usr/bin/perl -w

#ucitaj datoteku
#otvori ju
	##skip line ako počinje s #
	##unesi prvi redak sa splitom u @koeficijenti
	##pospremi velicinu @koeficijenti u skalar
	##ucitavaj reultate
		###izracunaj rezultat mnozenjem koeficijenti u for petlji s tim pripadnim faktorom
		###JMBAG ime prezime unesi u %hash za key, rezultat za value
#sortiraj po valueima
#printaj

$filename = $ARGV[0];
chomp $filename;
my %hash;

my $success = open LOG, "$filename";
if( ! $success){
	print "Datoteka $filename nije otvorena!\n";
	exit;
}

my $coefficientFlag = 0;
my @coefficientList; my $numberOfCoefficients;

while(<LOG>){
	chomp;
	if ($_ =~ m/^\s*#/){
		next;
	}
	if($coefficientFlag == 0){
		$coefficientFlag = 1;
		@coefficientList = split /;/, "$_";
		$numberOfCoefficients = @coefficientList;
		next;
	}

	my @student = split /;/, "$_";
	my $studentValue = 0; my $iterator = 0;
	my $studentKey = "$student[1], $student[2] ($student[0])";
	#studentovi rezultati su u rasponu od 3 do (3 + koef size)
	while ($iterator < $numberOfCoefficients){
		if ($student[$iterator + 3] eq "-"){
			$iterator += 1;
			next;
		}
		$studentValue += $coefficientList[$iterator] * $student[$iterator + 3];
		$iterator += 1;
	}

	$hash{"$studentKey"} = $studentValue;
}

my $iterator = 1;
foreach $k (sort {$hash{$b} <=> $hash{$a}} keys %hash) {
    	print "$iterator" . ". $k\t:\t$hash{$k}\n";
    	$iterator += 1;
}