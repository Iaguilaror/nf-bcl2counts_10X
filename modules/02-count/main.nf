/* Inititate DSL2 */
nextflow.enable.dsl=2

/* Define the main processes */
process separate_samples {

    input:
        path SAMPLESHEET

    output:
        path "chunk_*", emit: separate_samples_results

    script:
    """
    tail -n+2 $SAMPLESHEET \
    | cut -d"," -f2 \
    | sort -u \
    | sed 's#\$#_cellrangercounts#' \
    | split -l 1 - chunk_
    """

}

process counts {

	publishDir "${params.results_dir}/count/", mode:"copy"

    input:
        path SAMPLENAME
        path FASTQDIR
        path TRANSCRIPTOME

    output:
        path "*", emit: counts_results
    
    script:
    """
    # create the outputdir
    outputdir=\$( cat $SAMPLENAME )
    # find the fastq outs dir
    sample=\$( cat $SAMPLENAME | sed 's#_cellrangercounts##' )
    # define sample 
    inputdir=\$( find -L .  -type d -wholename  "*outs/fastq_path" )
    cellranger count \
        --id=\$outputdir \
        --transcriptome=$TRANSCRIPTOME \
		--fastqs=\$inputdir \
		--sample=\$sample \
		--localcores=${params.counts_nproc} \
		--localmem=${params.counts_maxmem} \
		--jobmode=local \
		--no-bam \
		--nosecondary \
		--chemistry=${params.chemistry}
    """

}

/* name a flow for easy import */
workflow CELRANGER_COUNTS {

    take:
        fastqdir
        transcriptome_ch

    main:
        def samplesheet_ch = Channel.fromPath( params.samplesheet )     // channel defined from path requires the "def" at line start
        samplenames_ch = separate_samples( samplesheet_ch ) | flatten   // saving a channel with the result of the process, flattened

        counts( samplenames_ch, fastqdir, transcriptome_ch )
       
}