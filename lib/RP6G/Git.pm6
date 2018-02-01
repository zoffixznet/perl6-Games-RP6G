unit class RP6G::Git;
use RP6G::Move;
use RP6G::Player;

has IO::Path $.game-dir is required;
has          %.world    is required;

method deploy {
    for %!world.kv -> $tag, $repo-url {
        my $where := $!game-dir.add: $tag;
        say "Deploying $tag to $where.absolute()";
        if $where.d {
            say "Already cloned. Pulling;";
            indir $where, { |run «git pull» };
        }
        else {
            indir $where.mkdir, { |run «git clone "$repo-url" .» }
        }
    }
}

method all-moves (--> Map:D) {
    my %users;
    (%users{.name} //= RP6G::Player.new: :name(.name)).add-move: $_
        for flat %.world.keys.sort.map: {self.moves-for: $_};
    %users.Map;
}

method moves-for ($tag where * ∈ %!world.keys --> List:D) {
    my @moves-raw = map {RP6G::Move.new: :$tag, $_}, split :skip-empty, "\0\0",
    self!run-out: $tag, «git log
        -z --no-merges --no-color --format=%x00%x00%H%n%aN%n%ae%n%at%n --numstat
    »;
    @moves-raw
}

method !run-out ($tag where * ∈ %!world.keys, |c) {
    my $proc := run :out, :cwd($!game-dir.add: $tag), |c;
    $proc.out.slurp: :close;
}
