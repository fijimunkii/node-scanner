#!/usr/bin/env bash

PRIMITIVES=( String Number Object Array Boolean Symbol )
for TYPE in "${PRIMITIVES[@]}"
do
  grep -r "\b$TYPE\.prototype\.[A-z0-9 ]*=" . > logs/primitives.log
done

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ls -d */ | xargs -I {} bash -c "cd {} && nsp check --output summary > $DIR/logs/nsp.log"
