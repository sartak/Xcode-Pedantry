#!/usr/bin/perl
my @files = glob("*/*.[hm]");

my $errors = 0;

for my $file (@files) {
    open my $handle, "<", $file;
    while (<$handle>) {
        next unless /^\s*[-+]\s*\(/;

        my $bad = 0;
        $bad = 1 if /^\s+[-+]/;       # whitespace before scope
        $bad = 1 if /^[-+]\s+/;       # ... after scope
        $bad = 1 if /\)\s+[a-zA-Z]/;  # ... between return type and selector

        $bad = 1 if /[a-zA-Z]\*/;     # missing whitespace between type and *

        if ($bad) {
            print qq{$file:$.: Tidy up that whitespace\n};
            print;
            ++$errors;
        }
    }
}

exit 1 if $errors;

