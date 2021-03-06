#!/usr/bin/env bash
## This small script runs a module test with the sample data

###
## environment variable setting
export TRANSCRIPTOME="test/reference/refdata-gex-GRCh38-2020-A/"
# export OUTDIR="results_count"
export CHEMISTRY="SC3Pv2" ##Might be auto with real data
export THREADS="14"
export MAXMEM="24"
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
&& mv *_cellrangercounts test/results/ \
&& echo "[>>>] Module Test Successful"
