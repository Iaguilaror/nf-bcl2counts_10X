input_dir="real-data/10x_7_15oct21/211015_NB501187_0098_AHFCK7BGXG/"
output_directory="real-data/10x_7_15oct21/nfbcl2counts_10X_results"

nextflow run main.nf \
	--input_dir $input_dir \
	--output_dir $output_directory \
	--simplecsv "real-data/10x_7_15oct21/C7_10x_15oct21.csv" \
	--threads 12 \
	--maxmem 12 \
	--transcriptome "test/reference/refdata-gex-GRCh38-2020-A" \
	--chemistry "auto" \
	-resume \
	-with-report $output_directory/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag $output_directory/`date +%Y%m%d_%H%M%S`.DAG.html
