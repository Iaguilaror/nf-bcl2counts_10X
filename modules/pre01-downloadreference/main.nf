/* Inititate DSL2 */
nextflow.enable.dsl=2

process download_reference {

	publishDir "${params.ref_parentdir}", mode:"copy"

  output:
    file "*"
  
  script:
    """
    curl -O '${params.ref_url}'  \
    && tar -xvf *.tar.gz \
    && rm *.tar.gz
    """
  
}

workflow DOWNLOAD_REF {
  download_reference | view { }     // view{ } helps us test the mod individually
}