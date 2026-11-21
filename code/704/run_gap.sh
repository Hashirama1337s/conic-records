#!/bin/bash
export PATH=/usr/local/bin:/usr/bin:/bin:${SAGE_BIN:-/usr/local/bin}
ulimit -v 10000000 2>/dev/null || true
cd "$(dirname "$0")"
timeout ${2:-600} gap -q -b "$1" < /dev/null
