#!/bin/bash
# mk.sh tag p seed dolex 'F'
tag=$1; p=$2; seed=$3; dolex=$4; F=$5
printf 'int PR=%s; int SEED=%s; int DOLEX=%s; string FSTR="%s";\n< "rcount.sing";\n' "$p" "$seed" "$dolex" "$F" > runs/$tag.sing
