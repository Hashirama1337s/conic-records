#!/bin/bash
cd /d/_LIVE/Y56/conic656
echo "== D1 p 20201 seed 1001 DOLEX 1"
( cd referee && bash mk.sh lead736_D1 20201 1001 1 "-x^4+y^4+z^4+9*w^4+6*x*y*z*w" ) && MSYS_NO_PATHCONV=1 wsl -e bash /mnt/d/_LIVE/Y56/conic656/referee/run.sh lead736_D1 1200; grep -E "vdim|DISTINCT|exit" referee/runs/lead736_D1.out
echo "== D2 p 20219 seed 1002 DOLEX 0"
( cd referee && bash mk.sh lead736_D2 20219 1002 0 "-x^4+y^4+z^4+9*w^4+6*x*y*z*w" ) && MSYS_NO_PATHCONV=1 wsl -e bash /mnt/d/_LIVE/Y56/conic656/referee/run.sh lead736_D2 900; grep -E "vdim|exit" referee/runs/lead736_D2.out
echo "== D3 control Dwork c=5 p 20201 seed 1003"
( cd referee && bash mk.sh lead736_D3 20201 1003 0 "x^4+y^4+z^4+w^4+5*x*y*z*w" ) && MSYS_NO_PATHCONV=1 wsl -e bash /mnt/d/_LIVE/Y56/conic656/referee/run.sh lead736_D3 900; grep -E "vdim|exit" referee/runs/lead736_D3.out
echo "== SCORING DONE"
