#!/bin/bash
# usage: run_msg.sh <base> : msolve -g 1 (leading ideal of the grevlex GB) -> <base>.lead
export PATH=/usr/local/bin:/usr/bin:/bin:${SAGE_BIN:-/usr/local/bin}
ulimit -v 8000000
b="$1"; start=$(date +%s)
timeout ${TMO:-590} msolve -t ${MST:-4} -g 1 -f "$b.ms" -o "$b.lead" > "$b.leadlog" 2>&1
echo "msolve-g1 rc=$? secs=$(( $(date +%s)-start )) base=$b"
