#!/bin/bash
# run.sh tag timeout
ulimit -v 8000000
export PATH=/usr/local/bin:/usr/bin:/bin:${SAGE_BIN:-/usr/local/bin}
cd "$(dirname "$0")"
start=$(date +%s)
timeout $2 Singular -q runs/$1.sing < /dev/null > runs/$1.out 2>&1
echo "exit $? wall $(( $(date +%s) - start )) s" >> runs/$1.out
