#! /usr/bin/perl
#
# This code counts the runes, and shows which one occurs the most, or the least whichever is greatest away from average.
# If this changes much after the prime stream has been applied, then the prime stream has worked, and only a transposition cypher
# remains to be found to solve.
#

use utf8;
use open ':std', ':encoding(UTF-8)';
$|  = 1;

$alpha = "ᚠᚢᚦᚩᚱᚳᚷᚹᚻᚾᛁᛂᛇᛈᛉᛋᛏᛒᛖᛗᛚᛝᛟᛞᚪᚫᚣᛡᛠ";
utf8::upgrade($alpha);

@value =  qw|F U TH O R C G W H N I J EO P X S T B E M L ING OE D A AE Y IA EA|;
@alpha = split //,$alpha;
for $i ( @alpha ) {
	utf8::upgrade($i);
	$toletter{$i} = $value[$x];
	$postion{$i} = $x++;
}
%fromletter = reverse %toletter;

$p = 1;
$q = 1;
$maxprime = 100000;
while ($p < $maxprime){
   next if $tested[$p++];
   push @primes,$p;
   $primefreq{$p % 29}++;
   for ($k= $p; $k <= $maxprime; $k+=$p) {
      $tested[$k-1]++;
   }
}

opendir PAGES,".";
while ($file = readdir PAGES ) {
	next if $file !~ /^page.*txt$/;
	$index = 0;
	$line = "";
	undef %lots;
	undef %freq;
	undef %freqwithout;
	open IN,"<:encoding(utf8)", "$file";
	while (<IN>){
		for $i ( split //) {
			next if $i !~ /[$alpha]/;

	        	$rotate = $primes[$index++ % 29]-1;
			$freqwithout{$toletter{$alpha[($postion{$i}) % 29]}}++;
			$freq{$toletter{$alpha[($postion{$i}-$rotate) % 29]}}++;
			for $lots (0..100){
				$lots{$lots}{$toletter{$alpha[($postion{$i}-int(rand()*29)) % 29 ]}}++;
			}
		}
	}

	$total = 0;
	$worst = 0;
	for $i ( keys %freq ) {
		$total +=  $freq{$i};
	}
	$average = $total / 29;
	printf "%-16s (runes=%5d) ",$file,$total;
	for $i (keys %freq ) {
		$offaverage = abs((($average-$freq{$i})/$average))*100;
		if ( $worst < $offaverage) {
			$worst = $offaverage if $worst < $offaverage;
			$worstrune = $i;
		}
	}
	printf "Prime Shift: %4s %6.2f%%  ",$worstrune,$worst;
	$worst = 0;
	$worstrune = "";
	for $lots ( 0..100) {
	for $i (keys %{$lots{$lots}} ) {
		$offaverage = abs((($average-$lots{$lots}{$i})/$average))*100;
		if ( $worst < $offaverage) {
			$worst = $offaverage if $worst < $offaverage;
			$worstrune = $i;
		}
	}
	}
	printf "Random  : %3s %6.2f%% ",$worstrune,$worst;
	$worst = 0;
	$worstrune = "";
	for $i (keys %freqwithout ) {
		$offaverage = abs((($average-$freqwithout{$i})/$average))*100;
		if ( $worst < $offaverage) {
			$worst = $offaverage if $worst < $offaverage;
			$worstrune = $i;
		}
	}
	printf " No shift: %3s %6.2f%% \n",$worstrune,$worst;

}

