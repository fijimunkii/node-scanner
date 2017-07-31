#!/usr/bin/env bash

# Check for primitives being overwritten
PRIMITIVES=( String Number Object Array Boolean Symbol )
for TYPE in "${PRIMITIVES[@]}"
do
  grep -r "\b$TYPE\.prototype\.[A-z0-9 ]*=" . > logs/primitives.log
done

# Run Scanners on each top level directory
export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ls -d */ | xargs -I {} {
  bash -c "cd {} && notes > $DIR/logs/notes.log"
  bash -c "cd {} && nsp check --output summary > $DIR/logs/nsp.log"
  bash -c "cd {} && retire > $DIR/logs/retire.log"
  bash -c "cd {} && plato -r -d report -l .jshintrc -t 'My Awesome App' -x 'node_modules|bower_components' . > $DIR/logs/plato.log"
} > $DIR/logs/scan.log
