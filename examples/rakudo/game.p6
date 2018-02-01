use lib <lib ../../lib>;
use RP6G;

my $rpg := RP6G.new: :game-dir($*PROGRAM.sibling('game').mkdir), :world{
    moar  => 'https://github.com/MoarVM/MoarVM',
    nqp   => 'https://github.com/perl6/nqp',
    rak   => 'https://github.com/rakudo/rakudo/',
    doc   => 'https://github.com/perl6/doc',
    roast => 'https://github.com/perl6/roast',
};

# $rpg.deploy;
$rpg.stats;
