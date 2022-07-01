#!/usr/bin/env bash
## This small script runs a module test with the sample data

###
## environment variable setting
export OUTDIR="fastq_outs_tinybcl"
export INPUTDIR="test/tinytest/cellranger-tiny-bcl-1.2.0"
export CSV="test/tinytest/cellranger-tiny-bcl-simple-1.2.0.csv"
export THREADS="12"
export MAXMEM="20"
###

echo "[>..] test running this module with data in test/data"
## Remove old test results, if any; then create test/reults dir
rm -rf test/results
mkdir -p test/results
echo "[>>.] results will be created in test/results"
## Execute runmk.sh, it will find the basic example in test/data
## Move results from test/data to test/results
## results files are *_fastqc.*
./runmk.sh \
&& mv $OUTDIR test/results/ \
&& mv multiqc_* test/results/ \
&& echo "[>>>] Module Test Successful"
