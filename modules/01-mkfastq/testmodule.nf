/* Inititate DSL2 */
nextflow.enable.dsl=2

/* load functions for testing env */
// NONE

/* define the fullpath for the final location of the reference */
params.results_dir = "test/results"

/* load workflows for testing env */
include { MKFASTQ }    from './main.nf'

workflow {
  MKFASTQ ()
}