use lib <lib ../../lib>;
use RP6G;

my $rpg := RP6G.new:
    :game-dir('/home/zoffix/CPANPRC/GameFilesRP6G/'.IO),
    :world{ rak => 'https://github.com/rakudo/rakudo/' };

$rpg.deploy;
