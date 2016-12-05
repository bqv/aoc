use v6;

sub validate-room($name, $sector, $chksum) {
    my @string = $name.split('-').join;
    my %counts = Bag.new(@string.comb).pairs.sort;
    my $checksum = %counts.pairs.sort({ -$^a.value, $^a.key })[0..4]>>.key.join;
    $chksum.Str eq $checksum;
}

sub MAIN() {
    say "hi";
    my @rooms;
    for lines() {
        so $_ ~~ / ( \w+ [ '-' \w+ ]+ ) '-' ( \d+ ) '[' ( \w+ ) ']' /;
        my $valid = validate-room($0,$1,$2);
        if $valid {
            @rooms.push($0.Str => $1.Str);
        }
    }
    my %realnames;
    for @rooms {
        my @words = $_.key.split('-');
        my $id = $_.value;
        my $name = @words.map({ .comb.map({
            chr((($_.ord - 'a'.ord + $id) % 26) + 'a'.ord)
        }).join }).join(' ');
        %realnames{$name} = $id;
    }
    say %realnames.pairs.grep({ $_.key ~~ / 'north' / })[0];
}
