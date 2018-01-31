unit class RP6G;
use Config::JSON;

has IO::Path:D $.game-dir where *.d is required;
has            %.world              is required;

has &!c  = &jconf      .assuming: $!game-dir.add: 'config.json';
has &!cw = &jconf-write.assuming: $!game-dir.add: 'config.json';

method deploy {
}
