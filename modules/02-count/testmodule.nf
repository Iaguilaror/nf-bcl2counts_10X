/* Inititate DSL2 */
nextflow.enable.dsl=2

/* load functions for testing env */
// NONE

/* define the fullpath for the final location of the outs */
params.results_dir = "test/results"

/* load workflows for testing env */
include { CELRANGER_COUNTS }    from './main.nf'

/* declare input channel for testing */
fastqdir = Channel.fromPath( "test/data" )

workflow {
  CELRANGER_COUNTS ( fastqdir )
}