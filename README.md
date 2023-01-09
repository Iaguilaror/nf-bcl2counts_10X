# nf-bcl2counts_10X
Nextflow Pipeline to process BCL files from Single Cell 10X experiments into Seurat reports

===
'nf-bcl2counts_10X' is a pipeline tool that takes BCL files and a sample sheet to generate fastq's and analyze them into R markdown reports of Seurat SingleCell analysis. This pipeline generates N outputs: 1) a fastq.gz set of files for each sample declared in the sample sheet; 2) an "outs" directory with cellranger count matrixes, raw and filtered; 3) a PDF file with a preliminary Seurat analysis, showing number of cells, filtered cells, UMAP clustering, and singleR cell annotation.  

---

### Features
  **-v 0.0.1**

* Supports BCL files and samplesheet from 10X experiments
* Results include UMAP clustering
* Results include [SingleR annotation](https://aran-lab.com/software/singler/)
* Scalability and reproducibility via a Nextflow-based framework.

### TO-DO(s)  
* Dockerize each module

---

## Requirements
#### Compatible OS*:
* [Ubuntu 20.04.5 LTS](https://releases.ubuntu.com/focal/)
* [Ubuntu 18.04.6 LTS](http://releases.ubuntu.com/18.04/)

#### Incompatible OS*:
* [Ubuntu 22.04.1 LTS](https://releases.ubuntu.com/22.04/) - as of January 2023. Failed to run Rmarkdown. Missing dependencies.  

\* nf-bcl2counts_10X may run in other UNIX based OS and versions, but testing is required.  

#### Command line Software required:
| Requirement | Version  | Required Commands * |
|:---------:|:--------:|:-------------------:|
| [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) | 22.10.4 | nextflow |
| [Plan9 port](https://github.com/9fans/plan9port) | Latest (as of 10/01/2019 ) | mk \** |
| [R](https://www.r-project.org/) | 3.4.4 | Rscript |
| [bcl2fastq](https://anaconda.org/dranew/bcl2fastq) | v2.19.0.316 | bcl2fastq |
| [cellranger](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/what-is-cell-ranger) | 7.1.0 (December 7, 2022) | cellranger mkfastq ; cellranger count |
| [multiqc](https://multiqc.info/docs/#installing-with-conda) | multiqc, version 1.13 | multiqc |

\* These commands must be accessible from your `$PATH` (*i.e.* you should be able to invoke them from your command line).  

#### R packages required:

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

---

### Installation
Download pipeline from Github repository:  
```
git clone https://github.com/Iaguilaror/nf-bcl2counts_10X.git
```

---

#### Test
To test pipeline execution using test data, run:
```
./runtest.sh
```

Your console should print the Nextflow log for the run, once every process has been submitted, the following message will appear:
```
======
 Basic pipeline TEST SUCCESSFUL
======
```

Pipeline results for test data should be in the following file:
```
nf-bcl2counts_10X/test/results/bcl2fastq_10X-results/
```

---

### Usage
To run nf-bcl2counts_10X go to the pipeline directory and execute:
```
nextflow run main.nf \
--input_dir		<path to BCL directory> \
--output_dir	<path to results> \
--reference		<path to reference directory for cellranger; will be created> \
--ref_url		<URL to download the .tar.gz cellranger reference> \
--samplesheet   <path to the .csv file with samplesheet data> \
--mkfastq_nproc 	<number of CPU threads for cellranger mkfastq> \
--mkfastq_maxmem	<max RAM for cellranger mkfastq> \
--counts_nproc      <number of CPU threads for cellranger count> \
--counts_maxmem     <max RAM for cellranger count> \
--chemistry 		<Chemistry type. By default is "auto> \
--seurat_nfeatures  <nFeature_RNA cutoff for filtering cells with less than this value> \
--seurat_nneighbors <number of neighboring points used in local approximations for UMAP> \
-resume				<resume pipeline run from the last sucessful process>
```

For information about options and parameters, run:
```
nextflow run main.nf --help
```

---

### Pipeline Inputs

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
---

### Pipeline Results

* A `.pdf` RMarkdown with the Preliminary report by Seurat.

---

#### References
Under the hood nf-bcl2counts_10X uses some coding tools, please include the following ciations in your work:

* Di Tommaso, P., Chatzou, M., Floden, E. W., Barja, P. P., Palumbo, E., & Notredame, C. (2017). Nextflow enables reproducible computational workflows. Nature Biotechnology, 35(4), 316–319. doi:10.1038/nbt.3820

* Team, R. C. (2017). R: a language and environment for statistical computing. R Foundation for Statistical Computing, Vienna. http s. www. R-proje ct. org.

* Hao, Yuhan, et al. "Integrated analysis of multimodal single-cell data." Cell 184.13 (2021): 3573-3587.

* Aran, Dvir, et al. "Reference-based analysis of lung single-cell sequencing reveals a transitional profibrotic macrophage." Nature immunology 20.2 (2019): 163-172.

---

### Contact
If you have questions, requests, or bugs to report, open an issue in github, or email <iaguilaror@gmail.com>

#### Dev Team
Israel Aguilar-Ordonez <iaguilaror@gmail.com>   

### Cite us
 TO-DO
