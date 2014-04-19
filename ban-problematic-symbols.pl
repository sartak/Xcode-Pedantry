#!/usr/bin/perl

my @files = glob("*/*.[hm]");

my %suggestion = (
    SKShapeNode => undef,
    UIColor     => 'SKColor',
    float       => 'CGFloat',
);

my $regex = do {
    my $alternation = join '|', keys %suggestion;
    qr/\b($alternation)\b/;
};

my $errors = 0;

for my $file (@files) {
    open my $handle, "<", $file;
    while (<$handle>) {
        next unless my ($symbol) = $_ =~ $regex;
        warn $symbol;

        print qq{$file:$.: warning "$symbol" is banned};
        if ($suggestion{$symbol}) {
            print qq{ (use $suggestion{$symbol})};
        }
        print qq{\n};

        ++$errors;
    }
}

exit 1 if $errors;

