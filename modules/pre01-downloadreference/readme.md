# downloadreference
**Author(s):**

* Israel Aguilar-Ordoñez (iaguilaror@gmail.com)

**Date:** December 2022  

---

## Module description:  

A (DSL2) Nextflow module to download pre-build reference for cellranger counts. The Human Reference for testing is downloaded from https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest?  

## Module Dependencies:
| Requirement | Version  | Required Commands |
|:---------:|:--------:|:-------------------:|
| [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) | 22.10.4 | nextflow |
| curl | 7.68.0 | curl |
| tar | (GNU tar) 1.30 | tar |


### Input(s):

* A `URL` from which to download the compresed reference from 10X.  

* A local `PATH` to move the uncompressed final reference directory.  

### Outputs:

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

## Module parameters:

| --param | example  | description |
|:---------:|:--------:|:-------------------:|
| --ref_url | "https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2020-A.tar.gz" | URL to download compressed reference from 10x website |
| --reference | "test/results/refdata-gex-GRCh38-2020-A/" | final path to move the uncompressed reference directory |

## Testing the module:

* Estimated test time:  **38 minutes**  

1. Test this module locally by running,
```
bash testmodule.sh
```

2.`[>>>] Module Test Successful` should be printed in the console.  

## module directory structure

````
pre01-downloadreference/
├── main.nf                             ## Nextflow script with the main process. To be imported by the full pipeline 
├── readme.md                           ## This document
├── test/                               ## Directory with materials for test
│   └── results/                        ## This dir will be created after runing the test
│       └── refdata-gex-GRCh38-2020-A/  ## See Outputs description
│           └── ...                     ## See Outputs description
├── testmodule.nf                       ## A quick Nextflow script to run in a controled environment.
└── testmodule.sh                       ## A quick bash script to run the whole test
````
## References
* https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest?