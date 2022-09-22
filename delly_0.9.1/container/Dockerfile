# taken from: https://github.com/dellytools/delly/blob/main/Dockerfile
# modify for additional functionality 
################## Base Image ##########
FROM --platform=linux/amd64 ubuntu:18.04
################## ARGUMENTS/Environments ##########

ARG BUILD_DATE
ARG BUILD_VERSION
ARG LICENSE="Apache-2.0"
ARG DELLY_VERSION="0.9.1"
ARG VCS_REF
################## METADATA ########################
LABEL org.opencontainers.image.vendor="MSKCC"
LABEL org.opencontainers.image.authors="Eric Buehlere (buehlere@mskcc.org)"

LABEL org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.version=${BUILD_VERSION} \
    org.opencontainers.image.licenses=${LICENSE} \
    org.opencontainers.image.version.delly=${DELLY_VERSION} \
    org.opencontainers.image.vcs-url="https://github.com/dellytools/delly.git" \
    org.opencontainers.image.vcs-ref=${VCS_REF}

LABEL org.opencontainers.image.description="This container uses ubuntu:18.04 as the base image to build \
    DELLY version ${DELLY_VERSION}"


################## INSTALL ##########################
RUN apt-get update && apt-get install -y \
    autoconf \
    build-essential \
    cmake \
    g++ \
    gfortran \
    git \
    libcurl4-gnutls-dev \
    hdf5-tools \
    libboost-date-time-dev \
    libboost-program-options-dev \
    libboost-system-dev \
    libboost-filesystem-dev \
    libboost-iostreams-dev \
    libbz2-dev \
    libhdf5-dev \
    libncurses-dev \
    liblzma-dev \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# set environment
ENV BOOST_ROOT /usr

# Download delly
RUN cd /opt \
    && git clone --recursive https://github.com/dellytools/delly.git \
    && cd /opt/delly/ \
    && git checkout tags/v${DELLY_VERSION} \
    && make STATIC=1 all \
    && make install

# Add Delly to PATH
ENV PATH="/opt/delly/bin:${PATH}"

# by default /bin/sh
CMD ["/bin/sh"]
