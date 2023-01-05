/* Inititate DSL2 */
nextflow.enable.dsl=2

/* load functions for testing env */
// NONE

/* define the fullpath for the final location of the outs */
params.results_dir = "test/results"

/* load workflows for testing env */
include { SEURAT_PRELIM }    from './main.nf'

/* declare input channel for testing */
countsdir = Channel.fromPath( "scripts/*" ).toList()

/* declare scripts channel for testing */
scripts = Channel.fromPath( "test/data" )

workflow {
  SEURAT_PRELIM ( countsdir, scripts )
}