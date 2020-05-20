# Base Image
FROM ubuntu:latest

# Metadata
MAINTAINER William Poehlman <william.poehlman@sagebase.org>
LABEL base_image="ubuntu:latest"
LABEL about.summary="Docker image for the STAR read aligner"
LABEL about.home="https://github.com/alexdobin/STAR"
LABEL about.license="SPDX:MIT"
LABEL about.tags="RNASeq"

COPY VERSION /
COPY SOFTWARE_VERSION /

# Avoid interactive prompts when installing R
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    binutils \
    build-essential \
    libz-dev \
    python \
    r-base \
    wget 

# Install STAR aligner
RUN export SOFTWARE_VERSION=$(cat /SOFTWARE_VERSION) \
 && wget https://github.com/alexdobin/STAR/archive/${SOFTWARE_VERSION}.tar.gz \
 && tar -xf ${SOFTWARE_VERSION}.tar.gz \
 && rm ${SOFTWARE_VERSION}.tar.gz \
 && cd STAR-${SOFTWARE_VERSION} \
 && make \
 && cp bin/Linux_x86_64/STAR /usr/bin \
 && cd .. \
 && rm -rf STAR-${SOFTWARE_VERSION}

# Install R packages
RUN R -e "install.packages(c('argparse','readr','stringr','tidyr','purrr','dplyr'),dependencies=TRUE,repos='http://cran.rstudio.com/')"

# Setup combine counts script
COPY bin/* /usr/local/bin/
RUN chmod a+x /usr/local/bin/combine_counts_study.R
CMD ["/bin/bash"]

