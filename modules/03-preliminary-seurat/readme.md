# preliminary-seurat
**Author(s):**

* Israel Aguilar-Ordoñez (iaguilaror@gmail.com)

**Date:** December 2022  

---

## Module description:  

A (DSL2) Nextflow module to run preliminary Seurat Analisis on SingleCell matrixes.

It takes filtered count matrixes generated by `cellranger count` and performs basic cell QC, filtering, PCA + UMAP clustering, and Cell tagging using SingleR transcriptome references.

## Module Dependencies:

| Requirement | Version  | Required Commands |
|:---------:|:--------:|:-------------------:|
| [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) | 22.10.4 | nextflow |
| [R](https://www.r-project.org/) | 4.2.2 | Rscript |

# R packages required:

```
dplyr version: 1.0.10
ggpubr version: 0.5.0
ggplot2 version: 3.4.0
hexbin version: 1.28.2
ggsci version: 2.9
scales version: 1.2.1
cowplot version: 1.1.1
pacman version: 0.5.1
stringr version: 1.5.0
tidyr version: 1.2.1
Seurat version: 4.3.0
BiocManager version: 1.30.19
SingleCellExperiment version: 1.20.0
SingleR version: 2.0.0
celldex version: 1.8.0
```

### Input(s):

* A cellrangercounts/ directory with multiple outputs from the pipeline, including the count matrixes required by Seurat. The important directory is `filtered_feature_bc_matrix/`. This is the one that will be loaded by Seurat.

Example contents  
```
test_sample_cellrangercounts/
├── ...
└──outs/
├── filtered_feature_bc_matrix/
│   ├── barcodes.tsv.gz
│   ├── features.tsv.gz
│   └── matrix.mtx.gz
└── ...
```

### Outputs:

* A `.pdf` RMarkdown with the Preliminary report by Seurat.

## Module parameters:

| --param | example  | description |
|:---------:|:--------:|:-------------------:|
| --seurat_nfeatures | "0" | nFeature_RNA cutoff for filtering cells with less than this value |
| --seurat_nneighbors | "25" | number of neighboring points used in local approximations for UMAP |

## Testing the module:

* Estimated test time:  **1 minute(s)**  

1. Test this module locally by running,
```
bash testmodule.sh
```

2.`[>>>] Module Test Successful` should be printed in the console.  

## module directory structure

````
03-preliminary-seurat/
├── main.nf                                ## Nextflow script with the main process. To be imported by the full pipeline 
├── readme.md                              ## This document
├── scripts/                               ## Directory with scripts and binaries to run this module
├── report.Rmd                             ## Rmarkdown script
│   └── runthermd.R                        ## Parent R script to run Rmarkdown
├── test/                                  ## Directory with materials for test
│   ├── data/                              ## This dir includes the results from running cellranger count
│   └── results/                           ## This dir will be created after runing the test
│       └── seurat_prelim
│           └── test_sample_cellrangercounts.pdf    ## See Outputs description
├── testmodule.nf                          ## A quick Nextflow script to run in a controled environment.
└── testmodule.sh                          ## A quick bash script to run the whole test
````

## References
* https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/tutorial_ct