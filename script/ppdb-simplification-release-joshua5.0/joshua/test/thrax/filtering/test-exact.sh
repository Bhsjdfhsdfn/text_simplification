#!/bin/bash

# Tests that both fast and exact filtering of grammars to test files works.

set -u

# exact filtering
gzip -cd grammar.filtered.gz | java -Xmx500m -Dfile.encoding=utf8 -cp $JOSHUA/class joshua.tools.TestSetFilter -v -e dev.hi-en.hi.1 > exact 2> exact.log
cat grammar.de | java -Xmx500m -Dfile.encoding=utf8 -cp $JOSHUA/class joshua.tools.TestSetFilter -v -e input.de >> exact 2>> exact.log

diff -u exact.log exact.log.gold > diff.exact

if [[ $? -eq 0 ]]; then
  echo PASSED
  rm -rf exact exact.log diff.exact
  exit 0
else
  echo FAILED
  tail diff.exact
  exit 1
fi
