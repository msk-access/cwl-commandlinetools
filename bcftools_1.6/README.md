# CWL and Dockerfile for running bcftools v1.6

## Version of tools in docker image (/container/Dockerfile)

| Tool	| Version	| Location	|
|---	|---	|---	|
| alpine:3.8 base image  	| 3.8  	|   -	|
| bcftools  	| 1.6	|  quay.io/biocontainers/bcftools:1.6--0	|

## CWL

- CWL specification 1.0
- Use example_inputs.yaml to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner bcftools_concat_1.6.cwl example_inputs.yaml
```

**If at MSK, using the JUNO cluster having installed toil version 3.19 and manually modifying [lsf.py](https://github.com/DataBiosphere/toil/blob/releases/3.19.0/src/toil/batchSystems/lsf.py#L170) by removing `type==X86_64 &&` you can use the following command**

```bash
#Using CWLTOOL
> cwltool --singularity --non-strict /path/to/bcftools_concat_1.6.cwl /path/to/inputs.yaml

#Using toil-cwl-runner
> mkdir bcftools_toil_log
> toil-cwl-runner --singularity --logFile /path/to/bcftools_toil_log/cwltoil.log  --jobStore /path/to/bcftools_jobStore --batchSystem lsf --workDir /path/to/bcftools_toil_log --outdir . --writeLogs /path/to/bcftools_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/bcftools_concat_1.6.cwl /path/to/inputs.yaml > bcftools_toil.stdout 2> bcftools_toil.stderr &
```

### Usage

```
usage: toil-cwl-runner bcftools_concat_1.6.cwl [-h]

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --allow_overlaps      First coordinate of the next file can precede last
                        record of the current file.
  --compact_PS          Do not output PS tag at each site, only at the start
                        of a new phase set block.
  --ligate              Ligate phased VCFs by matching phase at overlapping
                        haplotypes
  --list LIST           <file> Read the list of files from a file.
  --min_PQ MIN_PQ       <int> Break phase set if phasing quality is lower than
                        <int> [30]
  --naive               Concatenate BCF files without recompression
                        (dangerous, use with caution)
  --no_version          do not append version and command line to the header
  --output OUTPUT       <file> Write output to a file [standard output]
  --output_type OUTPUT_TYPE
                        <b|u|z|v> b - compressed BCF, u - uncompressed BCF, z
                        - compressed VCF, v - uncompressed VCF [v]
  --regions REGIONS     <region> Restrict to comma-separated list of regions
  --regions_file REGIONS_FILE
                        <file> Restrict to regions listed in a file
  --remove_duplicates   Alias for -d none
  --rm_dups RM_DUPS     <string> Output duplicate records present in multiple
                        files only once - <snps|indels|both|all|none>
  --threads THREADS     <int> Number of extra output compression threads [0]
  --vcf_files_csi VCF_FILES_CSI
                        Array of vcf files to be concatenated into one vcf
  --vcf_files_tbi VCF_FILES_TBI
                        Array of vcf files to be concatenated into one vcf

```
