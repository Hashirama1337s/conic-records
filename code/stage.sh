#!/bin/bash
# stage.sh: copy the data files each script reads into the script's own folder (the scripts read their inputs by bare
# file name, as they did when they were first run). Run from code/:  bash stage.sh
# It only copies (cp -n: never overwrites a file already there). Nothing is moved or removed.
set -e
cd "$(dirname "$0")"
D=../data
st() { mkdir -p "$(dirname "$2")"; [ -e "$2" ] || cp "$1" "$2"; }

st $D/656/gram_cert.gp       656/gram_cert.gp
st $D/656/exact_conics.txt   656/exact_conics.txt
st $D/656/valsE400.gp        656/valsE400.gp
st $D/656/ns656.gp           656/ns656.gp
st $D/656/dec_s1_gram.gp     656/runs/dec_s1_gram.gp
st $D/656/fam_minus_gram.gp  656/runs/fam_minus_gram.gp

st $D/664/hipol.gp           664/hipol.gp
st $D/664/gram_exact.gp      664/gram_exact.gp
st $D/664/conics_exact.txt   664/conics_exact.txt
st $D/664/planes_exact.txt   664/planes_exact.txt
st $D/664/reps_exact.txt     664/reps_exact.txt
st $D/664/realconics_h1.txt  664/realconics_h1.txt
st $D/664/realconics_h2.txt  664/realconics_h2.txt

for f in vals.gp exact704.gp gram704_cert.gp degt704.gp gd704.gp iso704_perm.gp; do st $D/704/$f 704/$f; done

for f in vals.gp exact736.gp gram736_cert.gp gd736.gp iso736_perm.gp ns736.gp; do st $D/736/$f 736/$f; done
st $D/736/gram736_raw.gp     736/runs/gram736_raw.gp

for f in exact660.gp gram660_cert.gp iso660_perm.gp gd660.gp; do st $D/660/$f 660-640/$f; done
for f in exact640.gp gram640_cert.gp iso640_perm.gp gd640.gp; do st $D/640/$f 660-640/$f; done

st $D/family/nsgen.gp       mirror/nsgen.gp
st $D/family/tgen.gp         mirror/tgen.gp

st $D/656/gram_cert.gp       lean/gram_cert.gp
echo "staged"
