**NOTE:** This branch patches Manatee in the way [suggested by Milan
Straka](https://github.com/ufal/morphodita/issues/14#issuecomment-592997122),
which fixes the problem. Ideally, MorphoDiTa and NameTag should also be
patched in analogous ways for robustness.

You'll need Docker installed. Run the examples with `run.sh` (requires
`sudo` because of Docker, at least on Linux). For details about the
issue, see the messages printed by the scripts.

If you want to poke around in the container instead, run `INTERACTIVE=1
./run.sh` instead.
