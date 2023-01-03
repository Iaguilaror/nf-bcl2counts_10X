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

### TODO  
* Refactor mkmodules into NextFlow DSL2
* Dockerize each module

---

## Requirements
#### Compatible OS*:
* [Ubuntu 22.04.1 LTS](https://releases.ubuntu.com/22.04/)
* [Ubuntu 20.04.5 LTS](https://releases.ubuntu.com/focal/)
* [Ubuntu 18.04.6 LTS](http://releases.ubuntu.com/18.04/)

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

\** Plan9 port builds many binaries, but you ONLY need the `mk` utility to be accessible from your command line.

#### R packages required:


---

### Installation
Download nf-100GMX-variant-summarizer from Github repository:  
```
git clone https://github.com/Iaguilaror/nf-100GMX-variant-summarizer
```

---

#### Test
To test nf-100GMX-variant-summarizer's execution using test data, run:
```
./runtest.sh
```

Your console should print the Nextflow log for the run, once every process has been submitted, the following message will appear:
```
======
VCF summarizer: Basic pipeline TEST SUCCESSFUL
======
```

nf-100GMX-variant-summarizer results for test data should be in the following file:
```
nf-100GMX-variant-summarizer/test/results/VCFsummarizer-results
```

---

### Usage
To run nf-100GMX-variant-summarizer go to the pipeline directory and execute:
```
nextflow run summarize-vcf.nf --vcffile <path to input 1> --metadata <path to input 2> --nsamples <integer> --group_minaf <numeric> --outgroup_maxaf <numeric> [--output_dir path to results ]
```

For information about options and parameters, run:
```
nextflow run summarize-vcf.nf --help
```

---

### Pipeline Inputs
* A compressed vcf file with extension '.vcf.gz'; the VCF must be previously annotated with https://github.com/Iaguilaror/nf-VEPextended

Example line(s):
```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	5101724	.	G	A	.	PASS	AC=1;AF=0.00641;AN=152;DP=903;ANN=A|intron_variant|MODIFIER|GATD3B|ENSG00000280071|Transcript|ENST00000624810.3|protein_coding||4/5|ENST00000624810.3:c.357+19987C>T|||||||||-1|cds_start_NF&cds_end_NF|SNV|HGNC|HGNC:53816||5|||ENSP00000485439||A0A096LP73|UPI0004F23660|||||||chr21:g.5101724G>A||||||||||||||||||||||||||||2.079|0.034663||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	5102165	rs1373489291	G	T	.	PASS	AC=1;AF=0.00641;AN=140;DP=853;ANN=T|intron_variant|MODIFIER|GATD3B|ENSG00000280071|Transcript|ENST00000624810.3|protein_coding||4/5|ENST00000624810.3:c.357+19546C>A|||||||rs1373489291||-1|cds_start_NF&cds_end_NF|SNV|HGNC|HGNC:53816||5|||ENSP00000485439||A0A096LP73|UPI0004F23660|||||||chr21:g.5102165G>T||||||||||||||||||||||||||||5.009|0.275409||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
```

* `*.tsv` : A metadata file, relating every sample ID (as registered in the VCF file) and a sample group in column format.

Example line(s):
```
sample	group
SM-3MG5L	Chinanteco
SM-3MG5F	Chocholteco
SM-3MG46	Kanjobal
```

---

### Pipeline Results
* A tsv file with `*.total_variants.tsv` extension.

Example line(s):
```
# Variants in project sample.vcf.gz
number of SNPs: 8769
number of indels:       1231
```

* A tsv file with `*.persample_counts.tsv` extension.

Example line(s):
```
sample SNV indel total_variants tstv_ratio missing_sites heterozygosity_ratio novel_total_variants worldwide_singletons clinvar_pato_likelypato_and_riskfactor_variants variants_in_gwascat variants_in_pgkb
SM-3MG3L 3183 444 3627 2.196 4 1.091 1 10 0 6 0
SM-3MG3M 3100 450 3550 2.173 1 1.115 1 13 0 5 0
```

* a tsv file named `private_variants_per_group.tsv`

Example line(s):
```
group variant_type number
Nahua snv 0
Nahua indel 0
Seri snv 2
Seri indel 0
```
---

#### References
Under the hood nf-100GMX-variant-summarizer uses some coding tools, please include the following ciations in your work:

* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.
* Narasimhan, V., Danecek, P., Scally, A., Xue, Y., Tyler-Smith, C., & Durbin, R. (2016). BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data. Bioinformatics, 32(11), 1749-1751.
* Team, R. C. (2017). R: a language and environment for statistical computing. R Foundation for Statistical Computing, Vienna. http s. www. R-proje ct. org.

---

### Contact
If you have questions, requests, or bugs to report, please email
<iaguilaror@gmail.com>

#### Dev Team
Israel Aguilar-Ordonez <iaguilaror@gmail.com>   

### Cite us
If you find this pipeline useful for your project, please cite us as:

Aguilar-Ordoñez, Israel, et al. "Whole genome variation in 27 Mexican indigenous populations, demographic and biomedical insights." PloS one 16.4 (2021): e0249773.
