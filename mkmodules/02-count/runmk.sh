#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
dir=$(find -L . \
  -type d \
  -name "*outs" )
csv=$(find -L . \
  -type f \
  -wholename "$dir/*.csv")
export sample=$(tail -n+2 $csv \
| cut -f 2 -d "," \
| tr "\n" "," \
| sed "s#,\$##") \
&& echo "$sample" \
| xargs mk
