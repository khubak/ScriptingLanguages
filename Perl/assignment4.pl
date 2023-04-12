#!/usr/bin/perl -w

@filenames = @ARGV;
chomp @filenames;
$size = @filenames;

if($size == 0){
	#filaj datoteku podacima
	#pushaj ime datoteke u @filenames
	print "Unesi podatke u prikladnom formatu: (Unos prekini s -1)\n";
	open (my $fh, '>', 'data.csv');
	while( (my $stdinData = <STDIN>) ne "-1\n") {	
		chomp ($stdinData);
		print $fh "$stdinData\n";
		}
	push @filenames, 'data.csv';
}

print "filenames\t@filenames \n";

foreach my $file (@filenames){

	my $success = open LOG, "$file";

	if( ! $success){
		print "Datoteka $file nije otvorena!\n";
		next;
	}
	
	#citaj redak po redak
	while(<LOG>){
		#izdvoji sate, dane i minute
		chomp;
		my $flag = 0;	#predao je unutar prvih sat vremena flag == 0
		my $labDay; my $examDay; my $labHour; my $examHour; my $labMinute; my $examMinute;
		#uzmi sve podatke
		my @line = split /;/, "$_";
		my @labLine = split /\s/, "$line[3]";
		my @examLine = split /\s/, "$line[4]";

		my @splitLabDate = split /[\-]/, "$labLine[0]";
		my @splitExamDate = split /[\-]/, "$examLine[0]";

		$labDay = $splitLabDate[2];
		$examDay = $splitExamDate[2];

		my @splitLabTime = split /:/, "$labLine[1]";
		my @splitExamTime = split /:/, "$examLine[1]";
		$labHour = $splitLabTime[0];
		$examHour = $splitExamTime[0];
		$labMinute = $splitLabTime[1];
		$examMinute = $splitExamTime[1];

		#usporedi sve podatke
		#usporedi dane
		if ($examDay > $labDay){
			$flag = 1;
		}
		#izracunaj razliku u vremenu u minutama
		my $timeDifference = (($examHour - $labHour) * 60) + ($examMinute - $labMinute);
		if ($timeDifference > 60){
			$flag = 1;
		}
		#ispisi ako ima problema
		if ($flag == 1){
			print "$line[0] $line[1] $line[2] - PROBLEM: $labLine[0] $labLine[1] $labLine[2] --> $line[4]\n";
		}
	}
	
	#napravi mjesta
	print "\n";
}