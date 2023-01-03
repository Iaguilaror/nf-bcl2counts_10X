process download_reference {
  output:
    file "*"

  """
  curl -O '${params.ref_url}'  \
  && tar -xvf *.tar.gz \
  && rm *.tar.gz
  """
}

workflow {
  download_reference | view { }  // view{ } helps us test the mod individually
}