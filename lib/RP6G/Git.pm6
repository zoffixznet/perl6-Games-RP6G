unit class RP6G::Git;

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
