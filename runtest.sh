input_dir="test/data/tinytest/cellranger-tiny-bcl-1.2.0"
output_directory="test/results"

echo -e "======\n Testing NF execution \n======" \
&& rm -rf $output_directory \
&& nextflow run main.nf \
	--input_dir		test/data/tinytest/cellranger-tiny-bcl-1.2.0/ \
	--output_dir	$output_directory \
	--reference		test/reference/GRCh38_miniref \
	--ref_url		"https://e9d67fad-ce03-438e-887e-5ca1edd500ec.filesusr.com/archives/e744b8_55b6659e40ec4f8a8953e3518e27b801.gz?dn=GRCh38_miniref.tar.gz" \
	--bcl_inputdir  "test/data/tinytest/cellranger-tiny-bcl-1.2.0/" \
    --samplesheet   "test/data/tinytest/cellranger-tiny-bcl-simple-1.2.0.csv" \
    --mkfastq_nproc 	"1" \
    --mkfastq_maxmem	"1" \
	--counts_nproc      "1" \
    --counts_maxmem     "1" \
	--chemistry "SC3Pv2" \
	-resume \
	-with-report $output_directory/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag $output_directory/`date +%Y%m%d_%H%M%S`.DAG.html
#	--nfeatures "0" \
#	--nneighbors "25" \
#  --threads 1 \
#  --maxmem 1 \
#&& echo -e "======\n Basic pipeline TEST SUCCESSFUL \n======"
