#!/usr/bin/perl -w

print "Enter a list of integers (finish with -1)!\n";
my @numbers;

while(1)
{
	$number = <STDIN>;
	chomp($number);
	if($number !~ m/[-+]?[0-9]*\.?[0-9]+/){
		print "$number nije broj!\n";
		next;
	}
	elsif($number == -1){
		last;
	}

	else {
		push @numbers, $number;
	}
}

print "Numbers are: @numbers\n";

my $sum = 0;

foreach $num (@numbers){
	$sum += $num;
}

print "Average of entered numbers is: " . $sum/scalar @numbers;