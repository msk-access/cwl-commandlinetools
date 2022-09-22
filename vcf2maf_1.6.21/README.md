# CWL and Dockerfile for running vcf2maf v1.6.21

## Version of tools in docker image (/container/Dockerfile)

| Tool	| Version	| Location	|
|---	|---	|---	|
| clearlinux (base image)  	| -  	|   -	|
| vcf2maf  	        | 1.6.21	| https://github.com/mskcc/vcf2maf/archive/v1.6.21.zip	|
| VEP  	            | 105  	| - | - |
|MINICONDA_VERSION  | py37_4.9.2  | https://repo.anaconda.com/miniconda/Miniconda3-py37_4.9.2-Linux-x86_64.sh
|BCFTOOLS_VERSION  	| 1.10.2      | - | - |
|SAMTOOLS_VERSION  	| 1.10        | - | - |
|VCF2MAF_VERSION  	| 1.6.21      | - | - |
|HTSLIB_VERSION  	  | 1.10.2      | - | - |

## CWL

- CWL specification 1.0
- Use example_inputs.yaml to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner vcf2maf_1.6.21.cwl example_inputs.yaml
```

**If at MSK, using the JUNO cluster having installed toil version 3.19 and manually modifying [lsf.py](https://github.com/DataBiosphere/toil/blob/releases/3.19.0/src/toil/batchSystems/lsf.py#L170) by removing `type==X86_64 &&` you can use the following command**

```bash
#Using CWLTOOL
> cwltool --singularity --non-strict /path/to/vcf2maf_1.6.21.cwl /path/to/inputs.yaml

#Using toil-cwl-runner
> mkdir vcf2maf_toil_log
> toil-cwl-runner --singularity --logFile /path/to/vcf2maf_toil_log/cwltoil.log  --jobStore /path/to/vcf2maf_jobStore --batchSystem lsf --workDir /path/to/vcf2maf_toil_log --outdir . --writeLogs /path/to/vcf2maf_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/vcf2maf_1.6.17.cwl /path/to/inputs.yaml > vcf2maf_toil.stdout 2> vcf2maf_toil.stderr &
```

### Usage

```
usage: vcf2maf_1.6.21.cwl [-h] [--any_allele ANY_ALLELE] [--buffer_size BUFFER_SIZE] [--cache_version CACHE_VERSION]
                          [--custom_enst CUSTOM_ENST] [--maf_center MAF_CENTER] [--memory_overhead MEMORY_OVERHEAD]
                          [--memory_per_job MEMORY_PER_JOB] [--min_hom_vaf MIN_HOM_VAF] [--ncbi_build NCBI_BUILD] [--normal_id NORMAL_ID]
                          [--output_maf OUTPUT_MAF] [--ref_fasta REF_FASTA] [--remap_chain REMAP_CHAIN] [--retain_fmt RETAIN_FMT]
                          [--retain_info RETAIN_INFO] [--species SPECIES] [--tumor_id TUMOR_ID] [--vcf_normal_id VCF_NORMAL_ID]
                          [--vcf_tumor_id VCF_TUMOR_ID] [--vep_data VEP_DATA] [--vep_forks VEP_FORKS] [--vep_path VEP_PATH]
                          [--vep-custom.vcfFile VEP_CUSTOM.VCFFILE] [--vep-custom.shortname VEP_CUSTOM.SHORTNAME]
                          [--vep-custom.filetype VEP_CUSTOM.FILETYPE] [--vep-custom.annotationtype VEP_CUSTOM.ANNOTATIONTYPE]
                          [--vep-custom.forceReportCoordinate] [--vep-custom.vcfField VEP_CUSTOM.VCFFIELD] [--retain-ann RETAIN_ANN]
                          [job_order]

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --any_allele ANY_ALLELE
                        When reporting co-located variants, allow mismatched variant alleles too
  --buffer_size BUFFER_SIZE
                        Number of variants VEP loads at a time; Reduce this for low memory systems
  --cache_version CACHE_VERSION
                        Version of VEP and its cache to use
  --custom_enst CUSTOM_ENST
                        List of custom ENST IDs that override canonical selection, in a file
  --maf_center MAF_CENTER
                        Variant calling center to report in MAF
  --memory_overhead MEMORY_OVERHEAD
                        Memory overhead per job in megabytes
  --memory_per_job MEMORY_PER_JOB
                        Memory per job in megabytes
  --min_hom_vaf MIN_HOM_VAF
                        If GT undefined in VCF, minimum allele fraction to call a variant homozygous
  --ncbi_build NCBI_BUILD
                        Genome build of variants in input
  --normal_id NORMAL_ID
                        Matched_Norm_Sample_Barcode to report in the MAF
  --output_maf OUTPUT_MAF
                        Path to output MAF file
  --ref_fasta REF_FASTA
                        Reference FASTA file
  --remap_chain REMAP_CHAIN
                        Chain file to remap variants to a different assembly before running VEP
  --retain_fmt RETAIN_FMT
                        Comma-delimited names of FORMAT fields to retain as extra columns in MAF []
  --retain_info RETAIN_INFO
                        Comma-delimited names of INFO fields to retain as extra columns in MAF
  --species SPECIES     Species of variants in input
  --tumor_id TUMOR_ID   Tumor_Sample_Barcode to report in the MAF
  --vcf_normal_id VCF_NORMAL_ID
                        Matched normal ID used in VCFs genotype columns
  --vcf_tumor_id VCF_TUMOR_ID
                        Tumor sample ID used in VCFs genotype columns
  --vep_data VEP_DATA   VEPs base cache/plugin directory
  --vep_forks VEP_FORKS
                        Number of forked processes to use when running VEP
  --vep_path VEP_PATH   Folder containing variant_effect_predictor.pl or vep binary
  --vep-custom.vcfFile VEP_CUSTOM.VCFFILE
  --vep-custom.shortname VEP_CUSTOM.SHORTNAME
  --vep-custom.filetype VEP_CUSTOM.FILETYPE
  --vep-custom.annotationtype VEP_CUSTOM.ANNOTATIONTYPE
  --vep-custom.forceReportCoordinate
  --vep-custom.vcfField VEP_CUSTOM.VCFFIELD
  --retain-ann RETAIN_ANN
                        --retain-ann I<MY_Ann>B<_>I<AD>,I<MY_Ann>B<_>I<TOPMED> use to custom option to retain the enteries

```
