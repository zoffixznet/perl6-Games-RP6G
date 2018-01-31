unit class RP6G::Move;

my $colored = (try require Terminal::ANSIColor) === Nil
  && -> $a, $ {$a} || ::('Terminal::ANSIColor::EXPORT::DEFAULT::&colored');

has Str:D      $.tag   is required;
has Str:D      $.sha   is required;
has Str:D      $.name  is required;
has Str:D      $.email is required;
has DateTime:D $.time  is required;
has            %.add   is required;
has            %.del   is required;

method new (Str:D $raw, Str:D :$tag) {
    my ($sha, $name, $email, $time, $, $changes) = $raw.lines;
    my (%add, %del);
    with $changes {
        for $changes.split: :skip-empty, "\0" {
            my ($add, $del, $file) = split :skip-empty, "\t", $_, 3;
            $add = 1 without +$add;
            $del = 1 without +$del;
            %add{$file} = $add if $add;
            %del{$file} = $del if $del;
        }
    }
    self.bless: :$tag, :$sha, :$name, :$email, :time(DateTime.new: +$time),
      :add(%add.Map), :del(%del.Map);
}

method gist { self.Str }
method Str {

    my $len := (%!add.keys, %!del.keys).flat».chars.sort(-*).head // 0;
    my %diff;
    %diff{.key}.push: $colored("+{.value}", 'bold green') for %!add;
    %diff{.key}.push: $colored("-{.value}", 'bold red') for %!del;

    qq:to/END/
      $colored($!name.fmt("%20s"), 'bold yellow') | $colored($!email, 'blue')
      $!time | $!sha
      {%diff.sort».fmt("$colored("%{$len}s", 'white') => %s").join: "\n"}
      END
}
