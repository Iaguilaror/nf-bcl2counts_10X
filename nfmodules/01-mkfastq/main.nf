/* Inititate DSL2 */
nextflow.enable.dsl=2

/* Define the main processes */
process mkfastq {

  input:
    path BCLDIR
    path SAMPLESHEET

  output:
    path "multiqc*", emit: multiqc_results
    path "results_mkfastq", emit: mkfastq_results

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
workflow mkfastq_flow {
  def bcl_ch = Channel.fromPath(params.bcl_inputdir)
  def samplesheet_ch = Channel.fromPath(params.samplesheet)
  mkfastq( bcl_ch, samplesheet_ch )
}

/* invoke nameles workflow for local module testing inside repo/nfmodules/thismodule/ */
workflow {
  mkfastq_flow( )
}