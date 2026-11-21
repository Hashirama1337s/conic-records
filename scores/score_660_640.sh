#!/bin/bash
cd /d/_LIVE/Y56/conic656
F660="6*(x^4+y^4+z^4+w^4+(x+y+z+w)^4)+(x^2+y^2+z^2+w^2+(x+y+z+w)^2)^2"
F640="x^4+y^4+z^4+w^4-(x^2*y^2+x^2*z^2+x^2*w^2+y^2*z^2+y^2*w^2+z^2*w^2)+10*x*y*z*w"
FDW="x^4+y^4+z^4+w^4+28*x*y*z*w"
FG5="(x^4+y^4+z^4+w^4+(x+y+z+w)^4)+3*(x^2+y^2+z^2+w^2+(x+y+z+w)^2)^2"
run() { ( cd referee && bash mk.sh $1 $2 $3 $4 "$5" ) && MSYS_NO_PATHCONV=1 wsl -e bash /mnt/d/_LIVE/Y56/conic656/referee/run.sh $1 1200; grep -E "vdim|DISTINCT|exit" referee/runs/$1.out; }
echo "== G1"; run lead660_G1 20231 1101 1 "$F660"
echo "== G2"; run lead660_G2 20233 1102 0 "$F660"
echo "== G3"; run lead640_G3 20231 1103 1 "$F640"
echo "== G4"; run lead640_G4 20233 1104 0 "$FDW"
echo "== G5"; run lead660_G5 20231 1105 0 "$FG5"
echo "== SCORING DONE"
