#!/usr/bin/perl

use IO::File;     # import module

# open passwd file for reading
my $pwtbl = new IO::File "</etc/passwd";

# run ps command, open output as a pipe for reading
open my $pscom, "ps hauxww |";

# get real name from fifth column, indexed to login in first column
my %realname = ();
while (<$pwtbl>) {
    @fields = split(/:/);
    next unless ($fields[2] > 1000);
    $realname{$fields[0]} = $fields[4];
}

# scan processes, counting by login
my %numprocs = ();
while (<$pscom>) {
   my ($login) = (m/^(\w+)/);
   next unless (exists $realname{$login});
   $numprocs{$login} = 0
        unless (exists $numprocs{$login});
   $numprocs{$login}++;
}

# print a summary of totals by user
foreach my $login (sort keys %numprocs) {
    printf("%4d procs for %9s (%s)\n",
        $numprocs{$login}, $login,
        $realname{$login});
}
