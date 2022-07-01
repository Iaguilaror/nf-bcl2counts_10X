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

Pos-processing

Anlysis

ENDING
 _register_configs
================================================================*/

/* Define the help message as a function to call when needed *//////////////////////////////
def helpMessage() {
	log.info"""
  ==========================================
  The 10X bcl2fastq pipeline
  - A pre-processing tool for single cell RNAseq
  v${version}
  ==========================================
	Usage:
  nextflow run main.nf --input_dir <path to inputs> [--output_dir path to results ]
	  --input_dir    <- To-do;
				To-do;
				To-do;
	  --output_dir     <- directory where results, intermediate and log files will bestored;
				default: same dir where --query_fasta resides
	  -resume	   <- Use cached results if the executed project has been run before;
				default: not activated
				This native NF option checks if anything has changed from a previous pipeline execution.
				Then, it resumes the run from the last successful stage.
				i.e. If for some reason your previous run got interrupted,
				running the -resume option will take it from the last successful pipeline stage
				instead of starting over
				Read more here: https://www.nextflow.io/docs/latest/getstarted.html#getstart-resume
	  --help           <- Shows Pipeline Information
	  --version        <- Show Pipeline version
	""".stripIndent()
}

/*//////////////////////////////
  Define pipeline version
  If you bump the number, remember to bump it in the header description at the begining of this script too
*/
version = "0.0.1"

/*//////////////////////////////
  Define pipeline Name
  This will be used as a name to include in the results and intermediates directory names
*/
pipeline_name = "bcl2fastq_10X"

/*
  Initiate default values for parameters
  to avoid "WARN: Access to undefined parameter" messages
*/
params.input_dir = false  //if no inputh path is provided, value is false to provoke the error during the parameter validation block
params.help = false       //default is false to not trigger help message automatically at every run
params.version = false    //default is false to not trigger version message automatically at every run
params.simplecsv = false  //default is false to not trigger version message automatically at every run
params.threads = 1        //default is 1 thread per process
params.maxmem = 1         //default is 1 GB per process

/*//////////////////////////////
  If the user inputs the --help flag
  print the help message and exit pipeline
*/
if (params.help){
	helpMessage()
	exit 0
}

/*//////////////////////////////
  If the user inputs the --version flag
  print the pipeline version
*/
if (params.version){
	println "Pipeline v${version}"
	exit 0
}

/*//////////////////////////////
  Define the Nextflow version under which this pipeline was developed or successfuly tested
  Updated by iaguilar at MAY 2021
*/
nextflow_required_version = '20.10.0'
/*
  Try Catch to verify compatible Nextflow version
  If user Nextflow version is lower than the required version pipeline will continue
  but a message is printed to tell the user maybe it's a good idea to update her/his Nextflow
*/
try {
	if( ! nextflow.version.matches(">= $nextflow_required_version") ){
		throw GroovyException('Your Nextflow version is older than Pipeline required version')
	}
} catch (all) {
	log.error "-----\n" +
			"  This pipeline requires Nextflow version: $nextflow_required_version \n" +
      "  But you are running version: $workflow.nextflow.version \n" +
			"  The pipeline will continue but some things may not work as intended\n" +
			"  You may want to run `nextflow self-update` to update Nextflow\n" +
			"============================================================"
}

/*//////////////////////////////
  INPUT PARAMETER VALIDATION BLOCK
  TODO (iaguilar) check the extension of input queries; see getExtension() at https://www.nextflow.io/docs/latest/script.html#check-file-attributes
*/

/* Check if inputs provided
    if they were not provided, they keep the 'false' value assigned in the parameter initiation block above
    and this test fails
*/
if ( !params.input_dir ) {
  log.error " Please provide the following params: --input_dir \n\n" +
  " For more information, execute: nextflow run align_and_compare --help"
  exit 1
}

/*
Output directory definition
Default value to create directory is the parent dir of --input_dir
*/
params.output_dir = file(params.input_dir).getParent()

/*
  Results and Intermediate directory definition
  They are always relative to the base Output Directory
  and they always include the pipeline name in the variable (pipeline_name) defined by this Script
  This directories will be automatically created by the pipeline to store files during the run
*/
results_dir = "${params.output_dir}/${pipeline_name}-results/"
intermediates_dir = "${params.output_dir}/${pipeline_name}-intermediate/"

/*
Useful functions definition
*/

/*//////////////////////////////
  LOG RUN INFORMATION
*/
log.info"""
==========================================
The 10X bcl2fastq pipeline
- A pre-processing tool for single cell RNAseq
v${version}
==========================================
"""
log.info "--Nextflow metadata--"
/* define function to store nextflow metadata summary info */
def nfsummary = [:]
/* log parameter values beign used into summary */
/* For the following runtime metadata origins, see https://www.nextflow.io/docs/latest/metadata.html */
nfsummary['Resumed run?'] = workflow.resume
nfsummary['Run Name']			= workflow.runName
nfsummary['Current user']		= workflow.userName
/* string transform the time and date of run start; remove : chars and replace spaces by underscores */
nfsummary['Start time']			= workflow.start.toString().replace(":", "").replace(" ", "_")
nfsummary['Script dir']		 = workflow.projectDir
nfsummary['Working dir']		 = workflow.workDir
nfsummary['Current dir']		= workflow.launchDir
nfsummary['Launch command'] = workflow.commandLine
log.info nfsummary.collect { k,v -> "${k.padRight(15)}: $v" }.join("\n")
log.info "\n\n--Pipeline Parameters--"
/* define function to store nextflow metadata summary info */
def pipelinesummary = [:]
/* log parameter values beign used into summary */
pipelinesummary['input directory']			= params.input_dir
pipelinesummary['Results Dir']		= results_dir
pipelinesummary['Intermediate Dir']		= intermediates_dir
pipelinesummary['SimpleCSV samplesheet']			= params.simplecsv
pipelinesummary['threads mkfastq']			= params.threads
pipelinesummary['max memory mkfastq']			= params.maxmem
/* print stored summary info */
log.info pipelinesummary.collect { k,v -> "${k.padRight(15)}: $v" }.join("\n")
log.info "==========================================\nPipeline Start"

/*//////////////////////////////
  PIPELINE START
*/

/*
	READ INPUTS
*/

/* Load fastq files into channel */
Channel
  .fromPath( "${params.input_dir}" )
  .set{ bcl_inputs }

/* Load samplesheet into channel */
Channel
  .fromPath( "${params.simplecsv}" )
  .set{ simplecsv_sheet }

/* _001a_runstar_genome1 */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/01-mkfastq/*")
	.toList()
	.set{ mkfiles_pre01 }

process _pre01_mkfastq {
//	label 'standard'

	publishDir "${results_dir}/_pre01_mkfastq/",mode:"copy"

	input:
  file bcl from bcl_inputs
  file csv from simplecsv_sheet
  file mk_files from mkfiles_pre01

	output:
  file "*" into results_pre01_mkfastq

	"""
  export OUTDIR="results_mkfastq"
  export INPUTDIR="${bcl}"
  export CSV="${csv}"
  export THREADS="${params.threads}"
  export MAXMEM="${params.maxmem}"
	bash runmk.sh
	"""

}
