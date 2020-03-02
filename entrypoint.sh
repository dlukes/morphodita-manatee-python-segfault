#!/bin/sh

/main.py 'MorphoDiTa & NameTag coexist fine...' morphodita nametag
/main.py '... in whichever order:' nametag morphodita

/main.py 'If MorphoDiTa is imported after Manatee, it works fine...' manatee morphodita
/main.py '... but in the reverse order, it segfaults when nextSentence is called:' morphodita manatee

/main.py 'Similarly with NameTag: when imported after Manatee, it runs fine...' manatee nametag
/main.py '... but in the reverse order, it segfaults when nextSentence is called:' nametag manatee

cat <<'EOF' >&2



[33mNOTE: This branch has had the fix in manatee_swig.patch applied so
the segfaults mentioned in the comments highlighted in red don't happen
anymore. Ideally, MorphoDiTa and NameTag should also be patched in a
similar way, but since we're pulling them from PyPI post-SWIG, we won't
bother and we'll just demonstrate the simplest, quickest fix here.

Give credit where credit is due: it was Milan Straka who figured out the
fix, for details see:

- <https://github.com/ufal/morphodita/issues/14#issuecomment-592997122>
- <http://www.swig.org/Doc4.0/Modules.html#Modules_nn2>[0m
EOF
