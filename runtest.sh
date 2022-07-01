input_dir="test/data/tinytest/cellranger-tiny-bcl-1.2.0"
output_directory="test/results"

echo -e "======\n Testing NF execution \n======" \
&& rm -rf $output_directory \
&& nextflow run main.nf \
	--input_dir $input_dir \
	--output_dir $output_directory \
  --simplecsv "test/data/tinytest/cellranger-tiny-bcl-simple-1.2.0.csv" \
  --threads 1 \
  --maxmem 1 \
	-resume \
	-with-report $output_directory/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag $output_directory/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n Basic pipeline TEST SUCCESSFUL \n======"
