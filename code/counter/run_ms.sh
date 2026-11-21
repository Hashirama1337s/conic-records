#!/bin/bash
# usage: run_ms.sh <base>   (runs msolve on <base>.ms, writes <base>.msout, prints degree line + timing)
export PATH=/usr/local/bin:/usr/bin:/bin:${SAGE_BIN:-/usr/local/bin}
ulimit -v 8000000
b="$1"
start=$(date +%s)
timeout ${TMO:-590} msolve -t ${MST:-6} -P 0 -f "$b.ms" -o "$b.msout" > "$b.mslog" 2>&1
rc=$?
end=$(date +%s)
echo "msolve rc=$rc secs=$((end-start)) base=$b"
head -c 200 "$b.msout" | tr '\n' ' '; echo
