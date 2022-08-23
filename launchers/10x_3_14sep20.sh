input_dir="real-data/10x_3_14sep20/200911_NB501187_0068_AHF25TBGXG/"
output_directory="real-data/10x_3_14sep20/nfbcl2counts_10X_results"

nextflow run main.nf \
	--input_dir $input_dir \
	--output_dir $output_directory \
	--simplecsv "real-data/10x_3_14sep20/C3_10x_23sep20.csv" \
	--threads 12 \
	--maxmem 12 \
	--transcriptome "test/reference/refdata-gex-GRCh38-2020-A" \
        --chemistry "auto" \
	-resume \
	-with-report $output_directory/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag $output_directory/`date +%Y%m%d_%H%M%S`.DAG.html
