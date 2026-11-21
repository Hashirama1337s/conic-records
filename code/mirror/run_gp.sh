#!/bin/bash
export PATH=/usr/local/bin:/usr/bin:/bin:${SAGE_BIN:-/usr/local/bin}
ulimit -v 6000000
cd "$(dirname "$0")"
timeout ${2:-280} gp -q "$1" < /dev/null
