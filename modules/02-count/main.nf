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

    stub:
    """
    echo -e "1,test_sample,SI-P03-C9,
    1,test_sample2,SI-P03-C9," \
    | cut -d"," -f2 \
    | sort -u \
    | sed 's#\$#_cellrangercounts#' \
    | split -l 1 - chunk_
    """

}

process counts {

	publishDir "${params.results_dir}/count/", mode:"copy"

    input:
        path MATERIALS

    output:
        path "*", emit: counts_results
    
    script:
    """
    # define the outputdir
    outputdir=\$( cat chunk_* )
    # define the reference dir
    transcriptome=\$( basename ${params.reference} )
    # define sample
    sample=\$( cat cat chunk_* | sed 's#_cellrangercounts##' ) 
    # find the fastq outs dir
    inputdir=\$( find -L .  -type d -wholename  "*outs/fastq_path" )
    cellranger count \
        --id=\$outputdir \
        --transcriptome=\$transcriptome \
		--fastqs=\$inputdir \
		--sample=\$sample \
		--localcores=${params.counts_nproc} \
		--localmem=${params.counts_maxmem} \
		--jobmode=local \
		--no-bam \
		--nosecondary \
		--chemistry=${params.chemistry}
    """
    
    stub:
    """
    # define the outputdir
    outputdir=\$( cat chunk_* )
    # define the reference dir
    transcriptome=\$( basename ${params.reference} )
    # define sample
    sample=\$( cat cat chunk_* | sed 's#_cellrangercounts##' ) 
    # find the fastq outs dir
    inputdir=\$( find -L .  -type d -wholename  "*outs/fastq_path" )
    mkdir \$outputdir
    """

}

/* name a flow for easy import */
workflow CELLRANGER_COUNTS {

    take:
        fastqdir
        transcriptome_ch

    main:
        samplesheet_ch = Channel.fromPath( params.samplesheet )     // channel defined from path requires the "def" at line start
        samplenames_ch = separate_samples( samplesheet_ch ) | flatten   // saving a channel with the result of the process, flattened

        count_materials = samplenames_ch
        .combine( fastqdir )
        .combine( transcriptome_ch )
        
        counts( count_materials )
    
    emit:
        counts.out[0]
}