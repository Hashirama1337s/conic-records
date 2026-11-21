#!/bin/bash
cd /d/_LIVE/Y56/conic656
echo "== V1 referee counter p 20101 t 6804 E 11907 seed 901 DOLEX 1"
( cd referee && bash mk.sh lead704_V1 20101 901 1 "11907*w^4+11907*(x^2+y^2+z^2)*w^2+(x^2+y^2+z^2)^2+6804*(x^4+y^4+z^4)" ) && MSYS_NO_PATHCONV=1 wsl -e bash /mnt/d/_LIVE/Y56/conic656/referee/run.sh lead704_V1 1200; grep -E "vdim|DISTINCT|exit" referee/runs/lead704_V1.out
echo "== V2 our counter efam p 20113 E 112 t 2154 seed 902"
( cd familymap && bash count_f.sh efam 20113 902 lead704_V2 112 2154 ) 2>&1 | grep -E "vdim|wrote"
echo "== V3 control S generic (E,t)=(2,1) p 20101 seed 903"
( cd familymap && bash count_f.sh efam 20101 903 lead704_V3 2 1 ) 2>&1 | grep -E "vdim|wrote"
echo "== SCORING DONE"
