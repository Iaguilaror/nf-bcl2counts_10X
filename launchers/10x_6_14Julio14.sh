input_dir="real-data/10x_6_14Julio14/210714_NB501187_0086_AHVVKHBGXB/"
output_directory="real-data/10x_6_14Julio14/nfbcl2counts_10X_results"

nextflow run main.nf \
	--input_dir $input_dir \
	--output_dir $output_directory \
  --simplecsv "real-data/10x_6_14Julio14/C6_10x_6_14Jul21.csv" \
  --threads 12 \
  --maxmem 12 \
	-resume \
	-with-report $output_directory/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag $output_directory/`date +%Y%m%d_%H%M%S`.DAG.html
