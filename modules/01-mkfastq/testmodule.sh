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
    --input_dir      "test/tinytest/cellranger-tiny-bcl-1.2.0" \
    --samplesheet       "test/tinytest/cellranger-tiny-bcl-simple-1.2.0.csv" \
    --mkfastq_nproc     "1" \
    --mkfastq_maxmem    "1" \
&& echo "[>>>] Module Test Successful" \
&& rm -rf work                # delete workdir only if final results were found