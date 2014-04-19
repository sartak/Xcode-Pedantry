#!/usr/bin/perl

my @files = glob("*/*.[hm]");

my $errors = 0;

for my $file (@files) {
    open my $handle, "<", $file;
    while (<$handle>) {
        next unless /\[\[\[/;

        print qq{$file:$.: Too many [s!\n};

        ++$errors;
    }
}

exit 1 if $errors;

