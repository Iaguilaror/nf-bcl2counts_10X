# This script exists as an interface to pass parameters to RMD in an ordered manner
tinytex::uninstall_tinytex()
tinytex::install_tinytex()
tinytex::tlmgr_install("grffile")

## Read args from command line
args = commandArgs( trailingOnly = TRUE )

## Uncomment For debugging only
## Comment for production mode only
# args[1] <- "../test/test_sample_cellrangercounts//"    ## "../test/test_sample_cellrangercounts/"
# args[2] <- 0                                          ## 0 for testing pipeline; nFeature_RNA filter
# args[3] <- 25                                         ## 25 for testing the pipeline; This determines the number of neighboring points used in local approximations
# args[4] <- "output.pdf"                               ## output.pdf files

## Passing args to named objects
input_counts <- args[1]
nfeatures_cutoff <- args[2]
nneighbors_forumap <- args[3]
pdf_file <- args[4]
rmd_file <- "report.Rmd" # maybe add manually always?

# name of the dir to process
dir_to_process <- "/outs/filtered_feature_bc_matrix"

# call the renderizer
rmarkdown::render(  input = rmd_file,
                    output_file = pdf_file,
                    output_dir = getwd(), # if we dont fix the wd here, knit will fail when NF tries to execute it from a different workdir
                    intermediates_dir = getwd(), # if we dont fix the wd here, knit will fail when NF tries to execute it from a different workdir
                    knit_root_dir = getwd() ) # if we dont fix the wd here, knit will fail when NF tries to execute it from a different workdir
