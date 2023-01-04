/* load functions for testing env */
include { get_fullParent }  from '../useful_functions.nf'

/* define the fullpath for the final location of the reference */
params.ref_parentdir = get_fullParent( params.reference )

/* load workflows for testing env */
include { DOWNLOAD_REF }    from './main.nf'

workflow {
  DOWNLOAD_REF ()
}