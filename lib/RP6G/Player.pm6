unit class RP6G::Player;
use RP6G::Move;

has Str:D  $.name  is required;
has UInt:D $.score = 0;

has @!moves where .all ~~ RP6G::Move:D;

method add-move (RP6G::Move:D $_) {
    @!moves.push: $_;
    $!score += (.del.values.sum + .add.values.sum).log(2).Int || 1;
}

method gist { self.Str }
method Str {
    "$!score $!name ({+@!moves} moves)"
}
