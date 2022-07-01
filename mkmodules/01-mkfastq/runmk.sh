#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
echo $OUTDIR \
| xargs mk
