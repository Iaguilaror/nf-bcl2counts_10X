input_dir="test/data/tinytest/cellranger-tiny-bcl-1.2.0"
output_directory="test/results"

echo -e "======\n Testing NF execution \n======" \
&& rm -rf $output_directory \
&& nextflow run main.nf \
	--input_dir		"test/data/tinytest/cellranger-tiny-bcl-1.2.0/" \
	--output_dir	"$output_directory" \
	--reference		"test/reference/refdata-gex-GRCh38-2020-A/" \
	--ref_url		"https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2020-A.tar.gz" \
	--bcl_inputdir  "test/data/tinytest/cellranger-tiny-bcl-1.2.0/" \
    --samplesheet   "test/data/tinytest/cellranger-tiny-bcl-simple-1.2.0.csv" \
    --mkfastq_nproc 	"1" \
    --mkfastq_maxmem	"1" \
	--counts_nproc      "1" \
    --counts_maxmem     "1" \
	--chemistry 		"SC3Pv2" \
	--seurat_nfeatures  "0" \
    --seurat_nneighbors "25" \
	-resume \
	-with-report $output_directory/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag $output_directory/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n Basic pipeline TEST SUCCESSFUL \n======"
