#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
export inputdir=$(find -L . \
  -type d \
  -wholename "*outs/fastq_path" )
echo $OUTDIR \
  | xargs mk
