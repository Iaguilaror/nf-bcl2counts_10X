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

/* declare function to load reference into channel */
def transcriptome_ch = Channel.fromPath( params.reference )

workflow {
  CELRANGER_COUNTS ( fastqdir, transcriptome_ch )
}