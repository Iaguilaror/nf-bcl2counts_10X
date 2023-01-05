/* Inititate DSL2 */
nextflow.enable.dsl=2

/* Define the main processes */
process mkfastq {

	publishDir "${params.results_dir}/mkfastq/", mode:"copy"

  input:
    path BCLDIR
    path SAMPLESHEET

  output:
    path "results_mkfastq", emit: mkfastq_results
    path "multiqc*"

  script:
  """
  cellranger mkfastq \
    --id=results_mkfastq \
		--run=$BCLDIR \
    --csv=$SAMPLESHEET \
    --jobmode=local \
    --localcores='${params.mkfastq_nproc}' \
    --localmem='${params.mkfastq_maxmem}' \
	&& multiqc results_mkfastq
  """
}

/* name a flow for easy import */
workflow MKFASTQ {

  main:

  def bcl_ch = Channel.fromPath (params.bcl_inputdir )
  def samplesheet_ch = Channel.fromPath( params.samplesheet )
  mkfastq( bcl_ch, samplesheet_ch )
  
  emit:
    mkfastq.out[0]
}
