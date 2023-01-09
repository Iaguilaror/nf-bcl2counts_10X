/* Inititate DSL2 */
nextflow.enable.dsl=2

/* load functions for testing env */
// NONE

/* define the fullpath for the final location of the outs */
params.results_dir = "test/results"

/* load workflows for testing env */
include { SEURAT_PRELIM }    from './main.nf'

/* declare input channel for testing */
countsdir_ch = Channel.fromPath( "test/test_sample_cellrangercounts" )

/* declare scripts channel for testing */
scripts_seurat_prelim = Channel.fromPath( "scripts/*" ).toList()

workflow {
  SEURAT_PRELIM ( countsdir_ch, scripts_seurat_prelim )
}