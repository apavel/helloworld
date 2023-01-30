#!/usr/bin/perl
use strict;
use JSON;
use Data::Dumper;

open my $f, "<:encoding(utf8)", "config.json" or die "$!";
my $content = join("", <$f>);
close $f;

my $cfg = decode_json $content;

print Dumper $cfg->{S3}->{bucket};
