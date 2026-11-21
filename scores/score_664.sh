#!/bin/bash
# lead's sealed scoring for BAR-664-POINT
cd /d/_LIVE/Y56/conic656
B='x^4+y^4+z^4+w^4-(x^2*y^2+x^2*z^2+x^2*w^2+y^2*z^2+y^2*w^2+z^2*w^2)'
echo "== R1 referee counter p 20023 c 2924 seed 801 DOLEX 1"
( cd referee && bash mk.sh lead664_R1 20023 801 1 "$B+2924*x*y*z*w" ) && MSYS_NO_PATHCONV=1 wsl -e bash /mnt/d/_LIVE/Y56/conic656/referee/run.sh lead664_R1 1200; grep -E "vdim|DISTINCT|exit" referee/runs/lead664_R1.out
echo "== R2 our counter p 20047 c 1889 seed 802"
( cd r664 && bash count_pipeline.sh abcde 20047 802 lead664_R2 1 -1/2 -1/2 -1/2 5484 ) 2>&1 | grep -E "vdim|wrote"
echo "== R3 referee counter p 20063 c 2208 seed 803 DOLEX 0"
( cd referee && bash mk.sh lead664_R3 20063 803 0 "$B+2208*x*y*z*w" ) && MSYS_NO_PATHCONV=1 wsl -e bash /mnt/d/_LIVE/Y56/conic656/referee/run.sh lead664_R3 900; grep -E "vdim|exit" referee/runs/lead664_R3.out
echo "== R4 generic (1:1/3:5) p 20023 seed 804"
( cd r664 && bash count_pipeline.sh abcde 20023 804 lead664_R4 1 1/6 1/6 1/6 5/4 ) 2>&1 | grep -E "vdim|wrote"
echo "== R5 line (1:-1:5) p 20023 seed 805"
( cd r664 && bash count_pipeline.sh abcde 20023 805 lead664_R5 1 -1/2 -1/2 -1/2 5/4 ) 2>&1 | grep -E "vdim|wrote"
echo "== SCORING DONE"
