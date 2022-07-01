input_dir="real-data/10x_1_06marzo20/200306_NB501187_0052_AH7YTLBGX3"
output_directory="real-data/10x_1_06marzo20/nfbcl2counts_10X_results"

nextflow run main.nf \
	--input_dir $input_dir \
	--output_dir $output_directory \
  --simplecsv "real-data/10x_1_06marzo20/C1_10x_03_06_20_maribel.csv" \
  --threads 12 \
  --maxmem 12 \
	-resume \
	-with-report $output_directory/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag $output_directory/`date +%Y%m%d_%H%M%S`.DAG.html
