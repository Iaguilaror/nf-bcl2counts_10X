# count
**Author(s):**

* Israel Aguilar-Ordoñez (iaguilaror@gmail.com)

**Date:** December 2022  

---

## Module description:  

A (DSL2) Nextflow module to create count matrixes with cellranger count.

It takes FASTQ files from cellranger `mkfastq` and performs alignment, filtering, barcode counting, and UMI counting. It uses the Chromium cellular barcodes to generate feature-barcode matrices, determine clusters, and perform gene expression analysis. The count pipeline can take input from multiple sequencing runs on the same GEM well. cellranger count also processes Feature Barcode data alongside Gene Expression reads.

## Module Dependencies:

| Requirement | Version  | Required Commands |
|:---------:|:--------:|:-------------------:|
| [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) | 22.10.4 | nextflow |
| [cellranger](https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest) | cellranger-7.1.0 | cellranger count |

### Input(s):

* A fastq dir from `mkfastq` module.
Example contents  
```
data/
├── _cmdline
├── _filelist
├── _finalstate
├── _invocation
├── _jobmode
├── _log
├── MAKE_FASTQS_CS/
│   ├── fork0
│   └── MAKE_FASTQS
├── _mrosource
├── outs/
│   ├── fastq_path/
│   ├── input_samplesheet.csv
│   └── interop_path/
├── _perf
├── results_mkfastq.mri.tgz
├── _sitecheck
├── _tags
├── _timestamp
├── _uuid
├── _vdrkill
└── _versions
```

* A `directory` with the uncompressed reference for cellranger counts  

Example contents  
```
test/results/refdata-gex-GRCh38-2020-A/
├── fasta/
│   ├── genome.fa
│   └── genome.fa.fai
├── genes/
│   └── genes.gtf
├── pickle/
│   └── genes.pickle
├── reference.json
└── star/
    ├── chrLength.txt
    ├── chrNameLength.txt
    ├── chrName.txt
    ├── chrStart.txt
    ├── exonGeTrInfo.tab
    ├── exonInfo.tab
    ├── geneInfo.tab
    ├── Genome/
    ├── genomeParameters.txt
    ├── SA/
    ├── SAindex/
    ├── sjdbInfo.txt
    ├── sjdbList.fromGTF.out.tab
    ├── sjdbList.out.tab
    └── transcriptInfo.tab
```

### Outputs:

* A sample_cellrangercounts/outs/ directory with multiple outputs from the pipeline, including the count matrixes required by Seurat.  

Example contents  
```
results/
└── count
    └── test_sample_cellrangercounts
        ├── ...
        └──outs/
        ├── filtered_feature_bc_matrix
        │   ├── barcodes.tsv.gz
        │   ├── features.tsv.gz
        │   └── matrix.mtx.gz
        ├── filtered_feature_bc_matrix.h5
        ├── metrics_summary.csv
        ├── molecule_info.h5
        ├── raw_feature_bc_matrix
        │   ├── barcodes.tsv.gz
        │   ├── features.tsv.gz
        │   └── matrix.mtx.gz
        ├── raw_feature_bc_matrix.h5
        └── web_summary.html
```

## Module parameters:

| --param | example  | description |
|:---------:|:--------:|:-------------------:|
| --samplesheet | "test/tinytest/cellranger-tiny-bcl-simple-1.2.0.csv" | comma separated file describing the Lane Samples and Index used in the NGS experiment |
| --reference | "test/reference/refdata-gex-GRCh38-2020-A" | Path to uncompressed cellranger reference |
| --chemistry | "SC3Pv2" | Chemistry type. By default the assay configuration is detected automatically, which is the recommended mode. However, we use SC3Pv2 for testing, since as test-data are only 80 reads auto mode fails. |
| --counts_nproc | "1" |  CPU threads for cellranger |
| --counts_maxmem | "1" | Max RAM requested |

## Testing the module:

* Estimated test time:  **4 minute(s)**  

1. Test this module locally by running,
```
bash testmodule.sh
```

2.`[>>>] Module Test Successful` should be printed in the console.  

## module directory structure

````
02-count/
├── main.nf             ## Nextflow script with the main process. To be imported by the full pipeline 
├── readme.md           ## This document
├── test/               ## Directory with materials for test
│   ├── data/           ## This dir includes the results from running cellranger mkfastq
│   └── results/        ## This dir will be created after runing the test
│       └── ...         ## See Outputs description
├── testmodule.nf       ## A quick Nextflow script to run in a controled environment.
└── testmodule.sh       ## A quick bash script to run the whole test
````
## References
* https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/tutorial_ct