#!/bin/bash

# set script to stop on errors - http://linuxcommand.org/lc3_man_pages/seth.html
set -euo pipefail

# yarn install
# yarn run build

buildkite-agent artifact upload "./deployment/**/*"
