#!/usr/bin/perl -w

print "Use CTRL + D after you've entered your strings:\n";
print "Please enter a string or strings:\n";
@text = <STDIN>;
chomp @text;

print "Enter number of times you want it to be written:\n";
$n = <STDIN>;

$i = 0;
while ($i < $n){
	print "@text \n";
	$i = $i + 1;
}