# mkfastq
**Author(s):**

* Israel Aguilar-Ordoñez (iaguilaror@gmail.com)

**Date:** December 2022  

---

## Module description:  

A (DSL2) Nextflow module to create fastq files from BCL data.

## Module Dependencies:
| Requirement | Version  | Required Commands |
|:---------:|:--------:|:-------------------:|
| [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) | 22.10.4 | nextflow |
| [cellranger](https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest) | cellranger-7.1.0 | cellranger mkfastq |
| [multiqc](https://multiqc.info/) | version 1.13 | multiqc |

### Input(s):

* A `BCL directory` created by a 10X NGS experiment.  
Example contents  
```
tinytest
├── cellranger-tiny-bcl-1.2.0
│   ├── Config/
│   ├── Data/
│   ├── InterOp/
│   ├── RTAComplete.txt
│   ├── RunInfo.xml
│   └── runParameters.xml
└── cellranger-tiny-bcl-simple-1.2.0.csv
```

* A local `.csv samplesheet` describing the 10X NGS experiment.  
Example lines  
```
Lane,Sample,Index
1,test_sample,SI-P03-C9
```

### Outputs:

* A `directory` with the uncompressed reference for cellranger counts  

Example contents  
```
results/
└── mkfastq/
    ├── ...
    ├── multiqc_report.html
    └── results_mkfastq/
        ├── ...
        └── outs/
            ├── fastq_path/
            │   ├── H35KCBCXY/
            │   │   └── test_sample/
            │   │       ├── test_sample_S1_L001_I1_001.fastq.gz
            │   │       ├── test_sample_S1_L001_R1_001.fastq.gz
            │   │       └── test_sample_S1_L001_R2_001.fastq.gz
            │   └── ...
            └── ...
```

## Module parameters:

| --param | example  | description |
|:---------:|:--------:|:-------------------:|
| --bcl_inputdir | "test/tinytest/cellranger-tiny-bcl-1.2.0" | directory with BCL outputs from a 10X NGS run |
| --samplesheet | "test/tinytest/cellranger-tiny-bcl-simple-1.2.0.csv" | comma separated file describing the Lane Samples and Index used in the NGS experiment |
| --mkfastq_nproc | "1" | CPU threads for cellranger |
| --mkfastq_maxmem | "1" | Max RAM requested |

## Testing the module:

* Estimated test time:  **1 minute**  

1. Test this module locally by running,
```
bash testmodule.sh
```

2.`[>>>] Module Test Successful` should be printed in the console.  

## module directory structure

````
01-mkfastq/
├── main.nf             ## Nextflow script with the main process. To be imported by the full pipeline 
├── readme.md           ## This document
├── test/               ## Directory with materials for test
│   ├── tinytest/       ## This dir includes BLC data from cellranger at https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/tutorial_fq
│   └── results/        ## This dir will be created after runing the test
│       └── ...         ## See Outputs description
├── testmodule.nf       ## A quick Nextflow script to run in a controled environment.
└── testmodule.sh       ## A quick bash script to run the whole test
````
## References
* https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/tutorial_fq