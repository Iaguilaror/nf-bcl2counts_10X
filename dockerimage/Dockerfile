# Start from base ubuntu 20.04
FROM ubuntu:20.04

LABEL maintainer="Israel Aguilar <iaguilaror@gmail.com>"

# disable CLI interactivity
ENV DEBIAN_FRONTEND=noninteractive 
# prepare conda path
ENV CONDA_DIR /opt/conda
# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

# install pipeline dependencies
RUN apt update \
&& apt upgrade \
&& apt install --no-install-recommends -y \
    software-properties-common \
    dirmngr \
    build-essential \
    cmake \
    zlib1g-dev \
    curl \
    libssl-dev \
    libclang-dev \
    wget \
&& apt-get install --no-install-recommends -y \
    libblas-dev \
    liblapack-dev \
    gfortran \
    libpng-dev \
    libcurl4-openssl-dev \
    libpq5 \
    pandoc \
&& apt-get clean

# install R ###
# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
| tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc \
&& add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
&& apt install --no-install-recommends -y r-base

# Copy cellranger bin and installR script ###
COPY extras /extras

# install cellranger, R libs and miniconda, bcl2fastq and multiqc
RUN ln -s /extras/cellranger-7.1.0/bin/cellranger /usr/bin/cellranger \
    && wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
    && /bin/bash ~/miniconda.sh -b -p /opt/conda \
    && conda install -y -c dranew bcl2fastq \
    && pip install multiqc \
    && Rscript --vanilla /extras/installRlibs.R