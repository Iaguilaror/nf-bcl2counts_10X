#!/usr/bin/env bash

rm -rf $OUTDIR

## find every vcf file
#find: -L option to include symlinks
echo $OUTDIR \
| xargs mk
