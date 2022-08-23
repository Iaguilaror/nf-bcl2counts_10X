input_dir="real-data/10x_4_07dic20/201207_NS500560_0275_AHF5LKBGXG/"
output_directory="real-data/10x_4_07dic20/nfbcl2counts_10X_results"

nextflow run main.nf \
	--input_dir $input_dir \
	--output_dir $output_directory \
	--simplecsv "real-data/10x_4_07dic20/C4_10x_4_07dic20.csv" \
	--threads 12 \
	--maxmem 12 \
	--transcriptome "test/reference/refdata-gex-GRCh38-2020-A" \
	--chemistry "auto" \
	-resume \
	-with-report $output_directory/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag $output_directory/`date +%Y%m%d_%H%M%S`.DAG.html
