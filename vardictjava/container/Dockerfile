FROM alpine:3.8

LABEL maintainer="Nikhil Kumar (kumarn1@mskcc.org)" \
      version.image="1.0.0" \
      version.vardict="1.8.2" \
      version.r="3.5.1" \
      version.perl="5.26.2-r1" \
      version.alpine="3.8" \
      source.vardict="https://github.com/AstraZeneca-NGS/VarDictJava/releases/tag/v1.8.2" \
      source.r="https://pkgs.alpinelinux.org/package/edge/community/x86/R" \
      source.perl="https://pkgs.alpinelinux.org/package/edge/main/aarch64/perl"

ENV VARDICT_VERSION 1.8.2

RUN apk add --update \
      && apk add ca-certificates openssl bash perl \
      && apk add openjdk8-jre-base \
      && apk add R R-dev \
      && cd /tmp && wget https://github.com/AstraZeneca-NGS/VarDictJava/releases/download/v${VARDICT_VERSION}/VarDict-${VARDICT_VERSION}.zip \
      && unzip VarDict-${VARDICT_VERSION}.zip \
      && mv /tmp/VarDict-${VARDICT_VERSION} /usr/bin/vardict \
      && rm -rf /var/cache/apk/* /tmp/*
