unit class RP6G;
use Subsets::IO :d;
use Config::JSON '';
use RP6G::Git;

has IO::Path::d $.game-dir is required;
has             %.world    is required;

has &!c  = &jconf      .assuming: $!game-dir.add: 'config.json';
has &!cw = &jconf-write.assuming: $!game-dir.add: 'config.json';

has RP6G::Git $.git handles<deploy>
  = RP6G::Git.new: :$!game-dir, :%!world;

method stats ($key where * ∈ %!world.keys) {
    my @moves := $!git.moves-for: $key;
    .say for @moves;
}
