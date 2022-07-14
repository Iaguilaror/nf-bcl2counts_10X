#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "input_samplesheet.csv" \
| grep "/outs/" \
| xargs tail -n+2 \
| cut -d"," -f2 \
| sort -u \
| sed 's#$#_cellrangercounts#' \
| xargs mk
