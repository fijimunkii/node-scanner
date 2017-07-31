#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOGDIR="$DIR/node-scanner-logs"

# Check for primitives being overwritten
PRIMITIVES=( String Number Object Array Boolean Symbol )
for TYPE in "${PRIMITIVES[@]}"
do
  grep -r "\b$TYPE\.prototype\.[A-z0-9 ]*=" . > logs/primitives.log
done

# Run Scanners on each top level directory
ls -d */ | xargs -I {} {
  bash -c "cd {} && notes > $LOGDIR/notes.log"
  bash -c "cd {} && nsp check --output summary > $LOGDIR/nsp.log"
  bash -c "cd {} && retire > $LOGDIR/retire.log"
  bash -c "cd {} && plato -r -d report -l .jshintrc -t 'My Awesome App' -x 'node_modules|bower_components' . > $LOGDIR/plato.log"
} > $LOGDIR/scan.log
