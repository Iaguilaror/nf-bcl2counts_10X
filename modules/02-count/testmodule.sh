#!/usr/bin/env bash
## This small script runs a module test with the sample data

# remove previous tests
rm -rf .nextflow.log* work

# remove previous results
rm -rf test/results

# create a results dir
mkdir -p test/results

# run nf script
nextflow run testmodule.nf \
    --debug true \
    --samplesheet       "../01-mkfastq/test/tinytest/cellranger-tiny-bcl-simple-1.2.0.csv" \
    --reference         "test/reference/refdata-gex-GRCh38-2020-A" \
    --chemistry         "SC3Pv2" \
    --counts_nproc      "1" \
    --counts_maxmem     "1" \
&& echo "[>>>] Module Test Successful" \
&& rm -rf work                # delete workdir only if final results were found
