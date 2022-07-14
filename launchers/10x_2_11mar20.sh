input_dir="real-data/10x_2_11mar20/200313_NB501187_0053_AHJVWVBGX3/"
output_directory="real-data/10x_2_11mar20/nfbcl2counts_10X_results"

nextflow run main.nf \
	--input_dir $input_dir \
	--output_dir $output_directory \
  --simplecsv "real-data/10x_2_11mar20/C2_10x_03_13_20.csv" \
  --threads 12 \
  --maxmem 12 \
	-resume \
	-with-report $output_directory/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag $output_directory/`date +%Y%m%d_%H%M%S`.DAG.html
