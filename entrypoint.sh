#!/bin/sh

/main.py 'MorphoDiTa & NameTag coexist fine...' morphodita nametag
/main.py '... in whichever order:' nametag morphodita

/main.py 'If MorphoDiTa is imported after Manatee, it works fine...' manatee morphodita
/main.py '... but in the reverse order, it segfaults when nextSentence is called:' morphodita manatee

/main.py 'Similarly with NameTag: when imported after Manatee, it runs fine...' manatee nametag
/main.py '... but in the reverse order, it segfaults when nextSentence is called:' nametag manatee

cat <<'EOF' >&2



[33mTODO: Is Manatee also affected by segfaults when imported after
MorphoDiTa or NameTag? If so, which operations trigger them?[0m
EOF
