# CWL and Dockerfile for running biometrics

## Version of tools in docker image (/container/Dockerfile)

| Tool | Version | Location |
|--- |--- |--- |
| biometrics_extract   | 0.2.14  |  <https://github.com/msk-access/biometrics> |

## CWL

- CWL specification 1.0
- Use example_inputs.json to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner biometrics_extract.cwl example_inputs.json
```

```bash
#Using CWLTOOL
> cwltool --singularity --non-strict /path/to/biometrics_extract.cwl /path/to/example_inputs.json

#Using toil-cwl-runner
> mkdir tool_toil_log
> toil-cwl-runner --singularity --logFile /path/to/tool_toil_log/cwltoil.log  --jobStore /path/to/tool_jobStore --batchSystem lsf --workDir /path/to/tool_toil_log --outdir . --writeLogs /path/to/tool_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/biometrics_extract.cwl /path/to/example_inputs.json > tool_toil.stdout 2> tool_toil.stderr &
```

### Usage

```bash
> toil-cwl-runner biometrics_extract.cwl -h
usage: biometrics_extract/0.2.14/biometrics_extract.cwl [-h] --sample_bam SAMPLE_BAM
                                                        [--sample_sex SAMPLE_SEX]
                                                        [--sample_group SAMPLE_GROUP] --sample_name
                                                        SAMPLE_NAME --fafile FAFILE --vcf_file VCF_FILE
                                                        [--bed_file BED_FILE] [--database DATABASE]
                                                        [--min_mapping_quality MIN_MAPPING_QUALITY]
                                                        [--min_base_quality MIN_BASE_QUALITY]
                                                        [--min_coverage MIN_COVERAGE]
                                                        [--min_homozygous_thresh MIN_HOMOZYGOUS_THRESH]
                                                        [--default_genotype DEFAULT_GENOTYPE]
                                                        [--file_type FILE_TYPE]
                                                        [job_order]

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --sample_bam SAMPLE_BAM
                        BAM file.
  --sample_sex SAMPLE_SEX
                        Expected sample sex (i.e. M or F).
  --sample_group SAMPLE_GROUP
                        The sample group (e.g. the sample patient ID).
  --sample_name SAMPLE_NAME
                        Sample name. If not specified, sample name is automatically figured out from the
                        BAM file.
  --fafile FAFILE       Path to reference fasta.
  --vcf_file VCF_FILE   VCF file containing the SNPs to be queried.
  --bed_file BED_FILE   BED file containing the intervals to be queried.
  --database DATABASE   Directory to store the intermediate files after running the extraction step.
  --min_mapping_quality MIN_MAPPING_QUALITY
                        Minimum mapping quality of reads to be used for pileup.
  --min_base_quality MIN_BASE_QUALITY
                        Minimum base quality of reads to be used for pileup.
  --min_coverage MIN_COVERAGE
                        Minimum coverage to count a site.
  --min_homozygous_thresh MIN_HOMOZYGOUS_THRESH
                        Minimum threshold to define homozygous.
  --default_genotype DEFAULT_GENOTYPE
                        Default genotype if coverage is too low (options are Het or Hom).
  --file_type FILE_TYPE
                        Specify the type of bam file you are generating the pickle for to be incorporated
                        in pickle file name (Myeloid_1_L001_duplex.pickle)
```
