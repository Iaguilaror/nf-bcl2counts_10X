#!/usr/bin/env nextflow

/*================================================================
The AGUILAR LAB presents...
  The 10X bcl2fastq pipeline
- A pre-processing tool for single cell RNAseq
==================================================================
Version: 0.0.1
Project repository: https://github.com/Iaguilaror/nf-bcl2counts_10X
==================================================================
Authors:
- Bioinformatics Design
 Israel Aguilar-Ordonez (iaguilaror@gmail.com)
- Bioinformatics Development
 Israel Aguilar-Ordonez (iaguilaror@gmail.com)
- Nextflow Port
 Israel Aguilar-Ordonez (iaguilaror@gmail.com)
=============================
Pipeline Processes In Brief:
.
Pre-processing:
_pre01_mkfastq

Core-processing:
_001_count
_002_preliminary_seurat
_002b_preliminary_seurat_raw

Pos-processing

Anlysis

ENDING
 _register_configs
================================================================*/

nextflow.enable.dsl = 2

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    PREPARE PARAMS DOCUMENTATION AND FUNCTIONS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

/*//////////////////////////////
  Define pipeline version
  If you bump the number, remember to bump it in the header description at the begining of this script too
*/
params.ver = "0.0.2"

/*//////////////////////////////
  Define pipeline Name
  This will be used as a name to include in the results and intermediates directory names
*/
params.pipeline_name = "bcl2fastq_10X"

/*//////////////////////////////
  Define the Nextflow version under which this pipeline was developed or successfuly tested
  Updated by iaguilar at JAN 2023
*/
params.nextflow_required_version = '22.10.4'

/*
  Initiate default values for parameters
  to avoid "WARN: Access to undefined parameter" messages
*/
params.help     = false   //default is false to not trigger help message automatically at every run
params.version  =	false   //default is false to not trigger version message automatically at every run

params.input_dir  =	false	//if no inputh path is provided, value is false to provoke the error during the parameter validation block
params.reference  =	false	//if no inputh path is provided, value is false to provoke the error during the parameter validation block
params.samplecsv  =	false	//default is false to not trigger version message automatically at every run
params.ref_url    = false //default is false to not trigger version message automatically at every run

params.nfeatures  =	200 //default is 200 as recommended by seurat tutorial on 2022
params.nneighbors =	30  //default is 30 as described in http://127.0.0.1:29453/library/Seurat/html/RunUMAP.html for parameter n.neighbors
params.threads    =	1		//default is 1 thread per process
params.maxmem     =	1	  //default is 1 GB per process

/* read the module with the param init and check */
include { } from './modules/doc_and_param_check.nf'

/* load functions for testing env */
include { get_fullParent }  from './modules/useful_functions.nf'

/* define the fullpath for the final location of the reference */
params.ref_parentdir = get_fullParent( params.reference )

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     INPUT PARAMETER VALIDATION BLOCK
  TODO (iaguilar) check the extension of input queries; see getExtension() at https://www.nextflow.io/docs/latest/script.html#check-file-attributes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

/*
Output directory definition
Default value to create directory is the parent dir of --input_dir
*/
params.output_dir = get_fullParent( params.input_dir )

/*
  Results and Intermediate directory definition
  They are always relative to the base Output Directory
  and they always include the pipeline name in the variable (pipeline_name) defined by this Script
  This directories will be automatically created by the pipeline to store files during the run
*/

params.results_dir =        "${params.output_dir}/${params.pipeline_name}-results/"
params.intermediates_dir =  "${params.output_dir}/${params.pipeline_name}-intermediate/"

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    NAMED WORKFLOW FOR PIPELINE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

/* load workflows */
include { DOWNLOAD_REF }  from  './modules/pre01-downloadreference'
include { MKFASTQ }       from  './modules/01-mkfastq'
include { CELRANGER_COUNTS }  from  './modules/02-count'

workflow {

  if ( ! file( params.reference ).exists( ) ){
    println " [>..] Reference directory not found. It will be downloaded and created"
    DOWNLOAD_REF ( )
  }

  def fastqdir_ch = MKFASTQ ()

  CELRANGER_COUNTS ( fastqdir_ch )

}

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN ALL WORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

//
// WORKFLOW: Execute a single named workflow for the pipeline
// See: https://github.com/nf-core/rnaseq/issues/619
//
// workflow {
//     NFCORE_RNASEQ ()
// }

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    THE END
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/