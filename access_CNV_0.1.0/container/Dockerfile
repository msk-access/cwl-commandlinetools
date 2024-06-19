################## BASE IMAGE ######################

FROM python:3

################## ARGUMENTS/Environments ##########

ARG BUILD_DATE
ARG BUILD_VERSION
ARG LICENSE="Apache-2.0"
ARG ACCESS_CNV_VERSION=0.1.0
ARG PYTHON_VERSION=3
ARG R_VERSION=3.5.1

################## METADATA ########################
LABEL org.opencontainers.image.vendor="MSKCC"
LABEL org.opencontainers.image.authors="Ian Johnson (johnsoni@mskcc.org)"

LABEL org.opencontainers.image.created=${BUILD_DATE} \
      org.opencontainers.image.version=${BUILD_VERSION} \
      org.opencontainers.image.licenses=${LICENSE} \
      org.opencontainers.image.version.R=${R_VERSION} \
      org.opencontainers.image.source.admie="https://github.com/rptashkin/ACCESS_CNV"

LABEL org.opencontainers.image.description="This container uses python ${PYTHON_VERSION} as the base image to build \
      ACCESS_CNV version ${ACCESS_CNV_VERSION}"

WORKDIR /usr/src

RUN wget "https://github.com/rptashkin/ACCESS_CNV/archive/master.zip" && \
      unzip master.zip && \
      cp -s /usr/src/ACCESS_CNV/* /usr/local/bin/
