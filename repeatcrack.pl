#! /usr/bin/perl

use utf8;
use open ':std', ':encoding(UTF-8)';

my @value =  (qw|F U TH O R C G W H N I J EO P X S T B E M L ING OE D A AE Y IA EA |,".");
my $alpha = "ᚠᚢᚦᚩᚱᚳᚷᚹᚻᚾᛁᛂᛇᛈᛉᛋᛏᛒᛖᛗᛚᛝᛟᛞᚪᚫᚣᛡᛠ";#•••

utf8::upgrade($alpha);

my @alpha = split //,$alpha;
my $x = 0;
for my $i ( @alpha ) {
        utf8::upgrade($i);
        $toletter{$i} = $value[$x];
        $rune[$x] = $i;
        $postion{$i} = $x++;
}
%fromletter = reverse %toletter;



open TEXT, "< /usr/share/dict/british-english-large";
while (<TEXT>){
        chomp;
        tr/a-z/A-Z/;
        next if $dict{$_}++;
	my $rune=$_;
        utf8::upgrade($rune);
        $rune =~ s/[^a-zA-Z]+/ /sg; $rune =~ tr/a-z/A-Z/;
        $rune =~ s/K/C/g; $rune =~ s/IO/IA/g; $rune =~ s/ING/NG/g; $rune =~ s/Z/S/g; $rune =~ s/V/U/g; $rune =~ s/\s+//g;
        for my $i ( sort { length($b) <=> length($a) } keys %fromletter ) { $rune =~ s/$i/$fromletter{$i}/g; }

	if ( $rune =~ m/^.....(..)$/ )    { $sevenend[2]->{$1}++; }
	if ( $rune =~ m/^....(...)$/ )    { $sevenend[3]->{$1}++; }
	if ( $rune =~ m/^...(....)$/ )    { $sevenend[4]->{$1}++; }
	if ( $rune =~ m/^..(.....)$/ )    { $sevenend[5]->{$1}++; }
	if ( $rune =~ m/^.(......)$/ )    { $sevenend[6]->{$1}++; }
	if ( $rune =~ m/^....(..)$/ )    { $sixend[2]->{$1}++; }
	if ( $rune =~ m/^...(...)$/ )    { $sixend[3]->{$1}++; }
	if ( $rune =~ m/^..(....)$/ )    { $sixend[4]->{$1}++; }
	if ( $rune =~ m/^.(.....)$/ )    { $sixend[5]->{$1}++; }
	if ( $rune =~ m/^(..)$/ )         { $ngrams[2]->{$1}++; }
	if ( $rune =~ m/^(...)$/ )        { $ngrams[3]->{$1}++; }
	if ( $rune =~ m/^(....)$/ )       { $ngrams[4]->{$1}++; }
	if ( $rune =~ m/^(.....)$/ )      { $ngrams[5]->{$1}++; }
	if ( $rune =~ m/^(......)$/ )     { $ngrams[6]->{$1}++; }
	if ( $rune =~ m/^(.......)$/ )    { $ngrams[7]->{$1}++; }
	if ( $rune =~ m/^(........)$/ )   { $ngrams[8]->{$1}++; }
	if ( $rune =~ m/^(.........)$/ )  { $ngrams[9]->{$1}++; }
	if ( $rune =~ m/^(..........)$/ ) { $ngrams[10]->{$1}++; }
}
close TEXT;



#•ᛚᛋᚩᚪᚫᚻᛚᛖᛇᛁᛗᛚ•ᛚᛋᚳᛈ•ᚾᚻᚷᚢᛡᚻᚢ•ᛒᚠ•ᛞᛂᚢ•ᛒᛖᛁ•
#••••••••••••ᛖᛋᛇᚦᚦᛖᛋ•ᚦᛟ•ᚳᛠᛁᛗᚳᛉ•ᛞᛂᚢ•ᛒᛖᛁ•
for $x (0..28){
	for $y (0..28){
		$shift{$rune[$x]}[$y] = $rune[($x + $y) % 29];
	}
}

for $a ( 0..28){
for $b ( 0..28){
	$line1twoletter = $shift{"ᛒ"}[$b].$shift{"ᚠ"}[$a];
	next if ! $ngrams[2]->{$line1twoletter};
	$sixletterlast[2] = $shift{"ᚳ"}[$b].$shift{"ᛉ"}[$a];
	next if ! $sixend[2]->{$sixletterlast[2]};
for $c ( 0..28){
	$sixletterlast[3] = $shift{"ᛗ"}[$c].$shift{"ᚳ"}[$b].$shift{"ᛉ"}[$a];
	next if ! $sixend[3]->{$sixletterlast[3]};
for $d ( 0..28){
	$sixletterlast[4] = $shift{"ᛁ"}[$d].$shift{"ᛗ"}[$c].$shift{"ᚳ"}[$b].$shift{"ᛉ"}[$a];
	next if ! $sixend[4]->{$sixletterlast[4]};
	$sevenletterlast[2]    = $shift{"ᚻ"}[$d].$shift{"ᚢ"}[$c];
	next if ! $sevenend[2]->{$sevenletterlast[2]};
for $e ( 0..28){
	$sixletterlast[5] = $shift{"ᛠ"}[$e].$shift{"ᛁ"}[$d].$shift{"ᛗ"}[$c].$shift{"ᚳ"}[$b].$shift{"ᛉ"}[$a];
	next if ! $sixend[5]->{$sixletterlast[5]};
	$sevenletterlast[3]    =                                                 $shift{"ᛡ"}[$e].$shift{"ᚻ"}[$d].$shift{"ᚢ"}[$c];
	next if ! $sevenend[3]->{$sevenletterlast[3]};
for $f ( 0..28){
	$sixletter         = $shift{"ᚳ"}[$f].$shift{"ᛠ"}[$e].$shift{"ᛁ"}[$d].$shift{"ᛗ"}[$c].$shift{"ᚳ"}[$b].$shift{"ᛉ"}[$a];
	next if ! $ngrams[6]->{$sixletter};
	$sevenletterlast[4]    =                                 $shift{"ᚢ"}[$f].$shift{"ᛡ"}[$e].$shift{"ᚻ"}[$d].$shift{"ᚢ"}[$c];
	next if ! $sevenend[4]->{$sevenletterlast[4]};
for $g ( 0..28){
	$sevenletterlast[5]    =                 $shift{"ᚷ"}[$g].$shift{"ᚢ"}[$f].$shift{"ᛡ"}[$e].$shift{"ᚻ"}[$d].$shift{"ᚢ"}[$c];
	next if ! $sevenend[5]->{$sevenletterlast[5]};
        print "Line1: $sevenletter $line1twoletter ".rune2text($sevenletter)." ".rune2text($line1twoletter)."\n";
        print "Line2: $line2twoletter $sixletter".rune2text($line2twoletter)." ".rune2text($sixletter)."\n\n";
for $h ( 0..28){
	$sevenletterlast[6]    = $shift{"ᚻ"}[$h].$shift{"ᚷ"}[$g].$shift{"ᚢ"}[$f].$shift{"ᛡ"}[$e].$shift{"ᚻ"}[$d].$shift{"ᚢ"}[$c];
	next if ! $sevenend[6]->{$sevenletterlast[6]};
	$line2twoletter = $shift{"ᚦ"}[$h].$shift{"ᛟ"}[$g];
	next if ! $ngrams[2]->{$line2twoletter};
        print "Line1: $sevenletter $line1twoletter ".rune2text($sevenletter)." ".rune2text($line1twoletter)."\n";
        print "Line2: $line2twoletter $sixletter".rune2text($line2twoletter)." ".rune2text($sixletter)."\n\n";
for $i ( 0..28){
	$sevenletter    = $shift{"ᚾ"}[$i].$shift{"ᚻ"}[$h].$shift{"ᚷ"}[$g].$shift{"ᚢ"}[$f].$shift{"ᛡ"}[$e].$shift{"ᚻ"}[$d].$shift{"ᚢ"}[$c];
	next if ! $sevenend[7]->{$sevenletter};
        print "Line1: $sevenletter $line1twoletter ".rune2text($sevenletter)." ".rune2text($line1twoletter)."\n";
        print "Line2: $line2twoletter $sixletter".rune2text($line2twoletter)." ".rune2text($sixletter)."\n\n";


}}}}}}}}}

sub rune2text(){
	$result="";
	$rune = shift;
	for $r ( split //,$rune ) {
		$result .= $toletter{$r};
	}
	return $result;
}
