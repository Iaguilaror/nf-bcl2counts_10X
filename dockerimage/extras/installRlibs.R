# Script para instalar todas las dependencias necesarias para Seurat y anotacion con singleR
if( !require( "pacman" ) ) {
    install.packages( "pacman", repos = "http://cran.us.r-project.org" )
}

# cargar pacman
library( "pacman" )

# usar pacman para otros paquetes
p_load( "tidyr" )
p_load( "dplyr" )
p_load( "ggplot2" )
p_load( "stringr" )

p_load( "ggpubr" )
p_load( "hexbin" )
p_load( "ggsci" )
p_load( "cowplot" )

p_load( "BiocManager" )

p_load( "SingleCellExperiment" )
p_load( "celldex" )                 
p_load( "SingleR" )

p_load( "Seurat" )                  

p_load( "rmarkdown" )
p_load( "tinytex" )
tinytex::install_tinytex()  # install TinyTeX
