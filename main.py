#!/usr/bin/env python3

import sys
import logging as log

text = "Karel Čapek leze dírou, Karel Poláček oknem."

log.basicConfig(format="%(message)s", level=log.INFO)
log.info("\n\n\n" + "=" * 72)
desc = sys.argv[1]
color = "\033[31m" if "segfault" in desc else "\033[32m"
log.info("%s%s\033[0m", color, desc)

modules = {}
for module_name in sys.argv[2:]:
    log.info("--> Importing %s", module_name)
    modules[module_name] = __import__(module_name)

for module_name, module in modules.items():
    if hasattr(module, "run"):
        log.info("--> Running %s", module_name)
        module.run(text, log)
