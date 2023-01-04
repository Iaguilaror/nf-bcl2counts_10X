/* Inititate DSL2 */
nextflow.enable.dsl=2

/* Define the main processes */
process separate_samples {

    input:
        path SAMPLESHEET

    output:
        path "chunk_*", emit: separate_samples_results

    """
    tail -n+2 $SAMPLESHEET \
    | cut -d"," -f2 \
    | sort -u \
    | sed 's#\$#_cellrangercounts#' \
    | split -l 1 - chunk_
    """

}

process counts {

    input:
        path SAMPLENAME
        path FASTQDIR
        path TRANSCRIPTOME

    // output:
    //     path "chunk_*", emit: separate_samples_results

    """
    # create the outputdir
    outputdir=\$(cat $SAMPLENAME)
    # find the fastq outs dir
    inputdir=\$(find -L .   -type d -wholename "*outs/fastq_path" )
#    cellranger count \
#        --id=\$outputdir \
#        --transcriptome=$TRANSCRIPTOME \
#		--fastqs=$inputdir \
#		--sample=$stem \
#		--localcores=$THREADS \
#		--localmem=$MAXMEM \
#		--jobmode=local \
#		--no-bam \
#		--nosecondary \
#		--chemistry=$CHEMISTRY
    """

}

/* name a flow for easy import */
workflow cellranger_counts_flow {
    def samplesheet_ch = Channel.fromPath( params.samplesheet )
    def transcriptome_ch = Channel.fromPath( params.transcriptome )
    def samplenames_ch = separate_samples( samplesheet_ch ) | flatten
    counts( samplenames_ch, transcriptome_ch )
}

/* invoke nameles workflow for local module testing inside repo/nfmodules/thismodule/ */
workflow {
    Channel.fromPath( "test/data" )
    cellranger_counts_flow(  )
}