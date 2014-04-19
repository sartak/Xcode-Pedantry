#!/usr/bin/perl

my @files = glob("*/*.[hm]");
my %is_file = map { s{.*/}{}r => 1 } @files;
my %lc_file = map { lc($_) => $_ } keys %is_file;

my $errors = 0;

for my $file (@files) {
    open my $handle, "<", $file;
    while (<$handle>) {
        next unless my ($import) = /#import\s*"(.*)"/;
        next if $is_file{$import};

        print qq{$file:$.: warning "$import"};

        if (my $fixed_case = $lc_file{lc $import}) {
            print qq{ (should be "$fixed_case")};
        }

        print qq{\n};

        ++$errors;
    }
}

exit 1 if $errors;
