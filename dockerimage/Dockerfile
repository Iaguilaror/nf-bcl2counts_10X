# A dockerfile must always start by importing the base image.
# We use the keyword 'FROM' to do that.
# In our example, we want import the python image.
# So we write 'python' for the image name and 'latest' for the version.
FROM ubuntu:20.04

# Upgrade apt
RUN apt update && apt upgrade

# disable CLI interactivity
ENV DEBIAN_FRONTEND=noninteractive 

# install pipeline dependencies
RUN apt install --no-install-recommends software-properties-common dirmngr build-essential cmake zlib1g-dev curl libssl-dev libclang-dev wget -y

RUN apt-get install --no-install-recommends libblas-dev liblapack-dev gfortran libpng-dev libcurl4-openssl-dev libpq5 -y && apt-get clean

# install R
# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
# install R
RUN apt install --no-install-recommends r-base -y

# install cellranger
COPY cellranger-7.1.0.tar.gz /

RUN tar -xzvf /cellranger-7.1.0.tar.gz \
    && ln -s /cellranger-7.1.0/cellranger /usr/bin/cellranger \
    && rm -rf /cellranger-7.1.0.tar.gz

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
    && /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

# Install bcl2fastq and multiqc
RUN conda install -y -c dranew bcl2fastq \
    && pip install multiqc

# install R libraries
COPY installRlibs.R /
# RUN Rscript --vanilla installRlibs.R
