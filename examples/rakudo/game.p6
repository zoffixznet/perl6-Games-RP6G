use lib <lib ../../lib>;
use RP6G;

my $rpg := RP6G.new:
    :game-dir($*PROGRAM.sibling('game').mkdir),
    :world{ rak => 'https://github.com/rakudo/rakudo/' };

# $rpg.deploy;
$rpg.stats: 'rak';
