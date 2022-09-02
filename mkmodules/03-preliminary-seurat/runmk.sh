#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type d \
  -name "*_cellrangercounts" \
| sed 's#cellrangercounts#seuratpreliminary.pdf#' \
| xargs mk
