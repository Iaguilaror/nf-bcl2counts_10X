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
--fastq_outdir      "fastq_outs_tinybcl" \
--bcl_inputdir      "test/tinytest/cellranger-tiny-bcl-1.2.0" \
--samplesheet       "test/tinytest/cellranger-tiny-bcl-simple-1.2.0.csv" \
--mkfastq_nproc     "1" \
--mkfastq_maxmem    "1"

# move module results and move to test/results
mv work/*/*/fastq_outs_tinybcl test/results/ \
&& mv work/*/*/multiqc_* test/results/ \
&& echo "[>>>] Module Test Successful"