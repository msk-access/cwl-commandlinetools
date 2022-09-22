FROM clearlinux:latest AS builder

ARG VCF2MAF_VERSION=1.6.21
ARG HTSLIB_VERSION=1.10.2
ARG SAMTOOLS_VERSION=1.10
ARG BCFTOOLS_VERSION=1.10.2
ARG VEP_VERSION=105.0
# Install a minimal versioned OS into /install_root, and bundled tools if any
ENV CLEAR_VERSION=33980
RUN swupd os-install --no-progress --no-boot-update --no-scripts \
    --version ${CLEAR_VERSION} \
    --path /install_root \
    --statedir /swupd-state \
    --bundles os-core-update,which

# Download and install conda into /usr/bin
ENV MINICONDA_VERSION=py37_4.9.2
RUN swupd bundle-add --no-progress curl git wget sysadmin-basic diffutils less c-basic && \
    curl -sL https://repo.anaconda.com/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -o /tmp/miniconda.sh && \
    sh /tmp/miniconda.sh -bfp /usr

#Download and install vcf2maf
RUN wget https://github.com/mskcc/vcf2maf/archive/refs/tags/v${VCF2MAF_VERSION}.zip \
    && unzip v${VCF2MAF_VERSION}.zip \
    && rm v${VCF2MAF_VERSION}.zip

# Use conda to install remaining tools/dependencies into /usr/local
ENV VEP_VERSION=${VEP_VERSION} \
    HTSLIB_VERSION=${HTSLIB_VERSION} \
    BCFTOOLS_VERSION=${BCFTOOLS_VERSION} \
    SAMTOOLS_VERSION=${SAMTOOLS_VERSION} \
    LIFTOVER_VERSION=377
RUN conda create -qy -p /usr/local \
    -c conda-forge \
    -c bioconda \
    -c defaults \
    ensembl-vep==${VEP_VERSION} \
    htslib==${HTSLIB_VERSION} \
    bcftools==${BCFTOOLS_VERSION} \
    samtools==${SAMTOOLS_VERSION} \
    ucsc-liftover==${LIFTOVER_VERSION}

#Copy offline cache
COPY homo_sapiens_vep_105_GRCh37.tar.gz /var/cache
COPY Homo_sapiens.GRCh37.dna.toplevel.fa.gz /var/cache
RUN mkdir -p /.vep/homo_sapiens/105_GRCh37/ \
    ## && rsync -avr --progress rsync://ftp.ensembl.org/ensembl/pub/release-105/variation/indexed_vep_cache/homo_sapiens_vep_105_GRCh37.tar.gz $HOME/.vep/ \
    && mv /var/cache/homo_sapiens_vep_105_GRCh37.tar.gz /.vep/ \
    && tar -zxf /.vep/homo_sapiens_vep_105_GRCh37.tar.gz -C /.vep/ \
    && rm /.vep/homo_sapiens_vep_105_GRCh37.tar.gz \
    ## && rsync -avr --progress rsync://ftp.ensembl.org/ensembl/pub/grch37/release-105/fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.dna.toplevel.fa.gz $HOME/.vep/homo_sapiens/105_GRCh37/ \
    && mv /var/cache/Homo_sapiens.GRCh37.dna.toplevel.fa.gz /.vep/homo_sapiens/105_GRCh37/ \
    && gzip -d /.vep/homo_sapiens/105_GRCh37/Homo_sapiens.GRCh37.dna.toplevel.fa.gz \
    && bgzip -i /.vep/homo_sapiens/105_GRCh37/Homo_sapiens.GRCh37.dna.toplevel.fa \
    && samtools faidx /.vep/homo_sapiens/105_GRCh37/Homo_sapiens.GRCh37.dna.toplevel.fa.gz

RUN vep_convert_cache --species homo_sapiens --version all --dir /.vep

# Deploy the minimal OS and tools into a clean target layer
FROM scratch
ARG VCF2MAF_VERSION=1.6.21
ENV VEP_VERSION=${VEP_VERSION}

LABEL org.opencontainers.image.vendor="MSKCC"
LABEL maintainer="Suleyman Vural <vurals@mskcc.org>"
LABEL maintainer="Cyriac Kandoth <ckandoth@gmail.com>"
LABEL org.opencontainers.image.version.vcf2maf=${VCF2MAF_VERSION}
LABEL org.opencontainers.image.version.vep="105"

COPY --from=builder vcf2maf-${VCF2MAF_VERSION} /opt/vcf2maf-${VCF2MAF_VERSION}
COPY --from=builder vcf2maf-${VCF2MAF_VERSION}/*.pl /usr/local/bin/
COPY --from=builder vcf2maf-${VCF2MAF_VERSION}/data /opt/data
COPY --from=builder /.vep /.vep/
COPY --from=builder /install_root /
COPY --from=builder /usr/local /usr/local

RUN chmod 777 /usr/local/bin/vcf2*.pl && chmod 777 /usr/local/bin/maf2*.pl

WORKDIR /opt
