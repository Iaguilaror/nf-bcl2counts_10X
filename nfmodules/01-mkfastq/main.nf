/* Load samplesheet directory */
input_samplesheet = Channel.fromPath("${params.samplesheet}")

/* Load BCL directory */
Channel
  .fromPath("${params.bcl_inputdir}")
  .combine( input_samplesheet )
  .set{ module_input_bcls }

process mkfastq {
  
debug true

  input:
  file BCL_DIR

  // output:
  //   file "*"

  """
  # get BCL dirname
  bclname=\$(basename '${params.bcl_inputdir}') #
  sheetname=\$(basename '${params.samplesheet}') #
  cellranger mkfastq \
    --id='${params.fastq_outdir}' \
		--run=\$bclname \
    --csv=\$sheetname \
    --jobmode=local \
    --localcores='${params.mkfastq_nproc}' \
    --localmem='${params.mkfastq_maxmem}' \
	&& multiqc '${params.fastq_outdir}'
  """
}

workflow {
  module_input_bcls | mkfastq 
}
