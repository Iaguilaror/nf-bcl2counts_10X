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
  --ref_url   "https://e9d67fad-ce03-438e-887e-5ca1edd500ec.filesusr.com/archives/e744b8_55b6659e40ec4f8a8953e3518e27b801.gz?dn=GRCh38_miniref.tar.gz" \
  --reference "test/results/GRCh38_miniref/" \
&& rm -rf work                # delete workdir only if final results were found