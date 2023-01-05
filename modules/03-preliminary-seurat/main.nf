/* Inititate DSL2 */
nextflow.enable.dsl=2

/* Define the main processes */
process seurat_prelim {
debug true
    input:
        path COUNTSDIR
        path SCRIPTS

    // output:
    //     path "*", emit: seurat_prelim_results

    script:
    """
    Rscript --vanilla runthermd.R \
        $COUNTSDIR \
        ${params.seurat_nfeatures} \
        ${params.seurat_nneighbors} \
        test.pdf
    """

}

/* name a flow for easy import */
workflow SEURAT_PRELIM {

    take:
        countsdir
        scripts

    main:
        seurat_prelim( countsdir, scripts )
    
    // emit:
    //     seurat_prelim.out[0]
}