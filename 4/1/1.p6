use v6;

sub validate-room($name, $sector, $chksum) {
    my @string = $name.split('-').join;
    my %counts = Bag.new(@string.comb).pairs.sort;
    my $checksum = %counts.pairs.sort({ -$^a.value, $^a.key })[0..4]>>.key.join;
    say "Given Checksum: ", $chksum;
    say "Calculated Checksum: ", $checksum;
    $chksum.Str eq $checksum;
}

sub MAIN() {
    print("hi");
    my @ids;
    for lines() {
        so $_ ~~ / ( \w+ [ '-' \w+ ]+ ) '-' ( \d+ ) '[' ( \w+ ) ']' /;
        my $valid = validate-room($0,$1,$2);
        if $valid {
            say "Name: ", $0;
            say "Sector: ", $1;
            say "";
            @ids.push($1);
        }
    }
    say @ids.sum;
}
