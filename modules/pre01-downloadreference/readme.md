# downloadreference
**Author(s):**

* Israel Aguilar-Ordoñez (iaguilaror@gmail.com)

**Date:** December 2022  

---

## Module description:  

A (DSL2) Nextflow module to download pre-build reference for cellranger counts. The Human Reference for testing is downloaded from https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest?  

## Module Dependencies:
| Requirement | Version  | Required Commands |
|:---------:|:--------:|:-------------------:|
| [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) | 22.10.4 | nextflow |
| curl | 7.68.0 | curl |
| tar | (GNU tar) 1.30 | tar |


### Input(s):

* A `URL` from which to download the compresed reference from 10X.  

* A local `PATH` to move the uncompressed final reference directory.  

### Outputs:

* A `directory` with the uncompressed reference for cellranger counts  

Example contents TODO
```
K       CrossValidationError
2       0.58244
3       0.59174
...
```

## Module parameters:

| parameter &nbsp; &nbsp; | description  | example |
|:---------:|:--------:|:-------------------:|
| --ref_url | URL to download compressed reference from 10x website | "https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2020-A.tar.gz" |
| --reference | final path to move the uncompressed reference directory. | "test/results/refdata-gex-GRCh38-2020-A/" |

## Testing the module:

* Estimated test time:  

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console... TODO

## module directory structure

````

````
## References
* https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest?