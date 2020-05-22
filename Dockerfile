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

# Install dependencies
RUN apt-get update \
 && apt-get install -y \
    binutils \
    build-essential \
    libz-dev \
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

CMD ["/bin/bash"]
