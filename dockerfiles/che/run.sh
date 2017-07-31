#!/bin/bash -e

if [ -f /tmp/stacks.json ]; then
  # https://github.com/eclipse/che/issues/4932
  mkdir -p /data/stacks
  j2 /tmp/stacks.json > /data/stacks/stacks.json
fi

/bin/bash /entrypoint.sh
