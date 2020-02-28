#!/bin/sh

tag=manatee-morphodita-segfault
cd "$( dirname "$0" )"
docker build -t $tag .
if [ -z "$INTERACTIVE" ]; then
  docker run $tag
else
  docker run --entrypoint sh -it $tag
fi
