#!/usr/bin/env bash
## This small script runs a module test with the sample data

# remove previous tests
rm -rf .nextflow.log* work

# remove previous results
rm -rf test/results

# create a results dir
mkdir -p test/results

# run nf script
nextflow run main.nf \
--debug true \
--samplesheet       "../01-mkfastq/test/tinytest/cellranger-tiny-bcl-simple-1.2.0.csv" \
--transcriptome "test/reference/refdata-gex-GRCh38-2020-A"

# --chemistry     "SC3Pv2" \
# --counts_nproc  "1" \
# --maxmem_maxmem "1"

# move module results and move to test/results
# mv work/*/*/fastq_outs_tinybcl test/results/ \
# && mv work/*/*/multiqc_* test/results/ \
# && echo "[>>>] Module Test Successful"