#!/usr/bin/perl
use strict;
use JSON;
use Data::Dumper;

open my $f, "<:encoding(utf8)", "config.json" or die "$!";
my $content = join("", <$f>);
close $f;

my $cfg = decode_json $content;

my $ssh_username = $cfg->{NAS}->{username};
my $key_file     = $cfg->{NAS}->{key};
my $ssh_hostname = $cfg->{NAS}->{hostname};
my $ssh_dir      = $cfg->{NAS}->{dir};
my $tmp_dir      = "./temp";
mkdir $tmp_dir;

my @args = ("scp", "-Bpr", "-i", $key_file, "$ssh_username\@$ssh_hostname:$ssh_dir", $tmp_dir);
system(@args);

if ($? == -1) {
        print "failed to execute: $!\n";
	exit 1;
} elsif ($? & 127) {
	printf "child died with signal %d, %s coredump\n",
	       ($? & 127),  ($? & 128) ? 'with' : 'without';
	exit 1;
} else {
	my $scp_retcode = $? >> 8;
	if ($scp_retcode != 0) {
		printf "child exited with value %d\n", $scp_retcode;
		exit 1;
	}
}
