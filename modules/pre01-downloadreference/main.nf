/* Inititate DSL2 */
nextflow.enable.dsl=2

process download_reference {

	publishDir "${params.ref_parentdir}", mode:"copyNoFollow"

  output:
    path "*", emit: download_reference_results
  
  script:
    """
    curl -O '${params.ref_url}'  \
    && tar -xvf *.tar.gz \
    && rm *.tar.gz
    """
  
}

workflow DOWNLOAD_REF {

  main:
  download_reference | view { }     // view{ } helps us test the mod individually

  emit:
    download_reference.out[0]
}