#! /usr/bin/perl

my $myfile = 'needfile';
open FH, $myfile or
    die "open $myfile: $! ";
