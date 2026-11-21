#!/bin/bash
# count_pipeline.sh (BUILD, RAID-656): the repaired counting protocol for one quartic, one prime, one chart.
# Run from this folder.
# usage: bash count_pipeline.sh <kind> <p> <seed> <tag> [params...]      e.g.  bash count_pipeline.sh y56 65521 2 y56a
#   1. conic_count.py, generic chart: T random in GL4(GF(p)), centre c = random GF(p)-point of X (centre=onX)
#   2. msolve -g 1 -> leading ideal of the grevlex GB -> vdim_lead.py = count WITH multiplicity (fast, ~15-40 s)
#   3. optional (FULL=1): msolve -P 0 -> distinct count = degree of the eliminating polynomial (msout_info.py);
#      can take up to ~10 min when msolve's last variable is not separating (it then adds a random form A).
# Accept the count only if two charts (two seeds) agree, and (when run) distinct = vdim (radical, no multiplicity).
set -e
kind=$1; p=$2; seed=$3; tag=$4; shift 4
M="${PY:-python3}"
base=runs/${tag}_p${p}_s${seed}
$M conic_count.py $kind $p $seed $base form=rem centre=onX "$@" | grep -v memcap
timeout 300 env MST=4 TMO=280 bash run_msg.sh $base
$M vdim_lead.py $base.lead | grep -v memcap
if [ "${FULL:-0}" = "1" ]; then
  timeout 620 env MST=6 TMO=590 bash run_ms.sh $base | head -1
  $M msout_info.py $base.msout | grep -v memcap
fi
