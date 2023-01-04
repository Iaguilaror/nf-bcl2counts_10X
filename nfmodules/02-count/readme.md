# 02-count
**Author(s):**

* Israel Aguilar-Ordonez (iaguilaror@gmail.com)

**Date:** June 2022

---

## Module description:
 Module that runs cellranger count.

 It takes FASTQ files from cellranger `mkfastq` and performs alignment, filtering, barcode counting, and UMI counting. It uses the Chromium cellular barcodes to generate feature-barcode matrices, determine clusters, and perform gene expression analysis. The count pipeline can take input from multiple sequencing runs on the same GEM well. cellranger count also processes Feature Barcode data alongside Gene Expression reads.

## Module Dependencies:
cellranger-7.0.0 > [Download and compile](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/tutorial_in)

### Input(s):

* A fastq dir from `mkfastq` module.

* A transcriptome directory. Cell ranger dataset can de bownloaded from: https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest/

### Outputs:

A results_count/outs/ directory with multiple outputs from the pipeline.

```
results_count
├── outs
│   ├── analysis
│   │   ├── clustering
│   │   │   ├── gene_expression_graphclust
│   │   │   │   └── clusters.csv
│   │   │   ├── gene_expression_kmeans_10_clusters
│   │   │   │   └── clusters.csv
│   │   │   ├── gene_expression_kmeans_2_clusters
│   │   │   │   └── clusters.csv
│   │   │   ├── gene_expression_kmeans_3_clusters
│   │   │   │   └── clusters.csv
│   │   │   ├── gene_expression_kmeans_4_clusters
│   │   │   │   └── clusters.csv
│   │   │   ├── gene_expression_kmeans_5_clusters
│   │   │   │   └── clusters.csv
│   │   │   ├── gene_expression_kmeans_6_clusters
│   │   │   │   └── clusters.csv
│   │   │   ├── gene_expression_kmeans_7_clusters
│   │   │   │   └── clusters.csv
│   │   │   ├── gene_expression_kmeans_8_clusters
│   │   │   │   └── clusters.csv
│   │   │   └── gene_expression_kmeans_9_clusters
│   │   │       └── clusters.csv
│   │   ├── diffexp
│   │   │   ├── gene_expression_graphclust
│   │   │   │   └── differential_expression.csv
│   │   │   ├── gene_expression_kmeans_10_clusters
│   │   │   │   └── differential_expression.csv
│   │   │   ├── gene_expression_kmeans_2_clusters
│   │   │   │   └── differential_expression.csv
│   │   │   ├── gene_expression_kmeans_3_clusters
│   │   │   │   └── differential_expression.csv
│   │   │   ├── gene_expression_kmeans_4_clusters
│   │   │   │   └── differential_expression.csv
│   │   │   ├── gene_expression_kmeans_5_clusters
│   │   │   │   └── differential_expression.csv
│   │   │   ├── gene_expression_kmeans_6_clusters
│   │   │   │   └── differential_expression.csv
│   │   │   ├── gene_expression_kmeans_7_clusters
│   │   │   │   └── differential_expression.csv
│   │   │   ├── gene_expression_kmeans_8_clusters
│   │   │   │   └── differential_expression.csv
│   │   │   └── gene_expression_kmeans_9_clusters
│   │   │       └── differential_expression.csv
│   │   ├── pca
│   │   │   └── gene_expression_10_components
│   │   │       ├── components.csv
│   │   │       ├── dispersion.csv
│   │   │       ├── features_selected.csv
│   │   │       ├── projection.csv
│   │   │       └── variance.csv
│   │   ├── tsne
│   │   │   └── gene_expression_2_components
│   │   │       └── projection.csv
│   │   └── umap
│   │       └── gene_expression_2_components
│   │           └── projection.csv
│   ├── cloupe.cloupe
│   ├── filtered_feature_bc_matrix
│   │   ├── barcodes.tsv.gz
│   │   ├── features.tsv.gz
│   │   └── matrix.mtx.gz
│   ├── filtered_feature_bc_matrix.h5
│   ├── metrics_summary.csv
│   ├── molecule_info.h5
│   ├── possorted_genome_bam.bam
│   ├── possorted_genome_bam.bam.bai
│   ├── raw_feature_bc_matrix
│   │   ├── barcodes.tsv.gz
│   │   ├── features.tsv.gz
│   │   └── matrix.mtx.gz
│   ├── raw_feature_bc_matrix.h5
│   └── web_summary.html
└──results_count.mri.tgz
```

## Module parameters:
Path to the directory with the transcriptome data
```
TRANSCRIPTOME="test/reference/refdata-gex-GRCh38-2020-A/"
```
Name of the output directory
```
OUTDIR="results_count"
```
Chemistry type. By default the assay configuration is detected automatically, which is the recommended mode. 
For testing, as test-data are only 80 reads, auto mode fails.
```
CHEMISTRY="SC3Pv2" 
```
Number of threads
```
THREADS="8"
```
Maximum memory
```
MAXMEM="15"
```

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## 02-count directory structure

````
02-count  ## Module main directory
├── mkfile  ## File in mk format, specifying the rules for building every result
├── readme.md ## This document. General workflow description.
├── runmk.sh  ## Script to print every file required by this module
├── test  ## Test directory
└── testmodule.sh ## Script to test module functunality using test data
````

## References
* Cell RangerTM R Kit Tutorial: Secondary Analysis on 10x GenomicsTM Single Cell 3’ RNA-seq PBMC Data. (n.d.). 10x Genomics. Retrieved July 11, 2017, from http://cf.10xgenomics.com/supp/cell-exp/cellrangerrkit-PBMC-vignette-knitr-1.1.0.pdf
* What is Cell Ranger (2016, November 21). Retrieved July 11, 2017, from https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/what-is-cell-ranger