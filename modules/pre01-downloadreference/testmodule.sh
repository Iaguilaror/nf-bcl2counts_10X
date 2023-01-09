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
  --ref_url   "https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2020-A.tar.gz" \
  --reference "test/results/refdata-gex-GRCh38-2020-A/" \
&& echo "[>>>] Module Test Successful" \
&& rm -rf work                # delete workdir only if final results were found