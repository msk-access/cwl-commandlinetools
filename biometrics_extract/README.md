# CWL for running biometrics extract tool.

| Tool | Latest version | Location |
|--- |--- |--- |
| biometrics   | 0.2.13   |  <https://github.com/msk-access/biometrics> |

The python package source code and Docker file are located on GitHub.

## CWL

- CWL specification 1.0
- Use example_inputs.yaml to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner biometrics_extract.cwl example_inputs.yaml
```

### Usage

```bash
usage: biometrics_extract.cwl [-h] --sample_bam SAMPLE_BAM
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
                        Sample name. If not specified, sample name is
                        automatically figured out from the BAM file.
  --fafile FAFILE       Path to reference fasta.
  --vcf_file VCF_FILE   VCF file containing the SNPs to be queried.
  --bed_file BED_FILE   BED file containing the intervals to be queried.
  --database DATABASE   Directory to store the intermediate files after
                        running the extraction step.
  --min_mapping_quality MIN_MAPPING_QUALITY
                        Minimum mapping quality of reads to be used for
                        pileup.
  --min_base_quality MIN_BASE_QUALITY
                        Minimum base quality of reads to be used for pileup.
  --min_coverage MIN_COVERAGE
                        Minimum coverage to count a site.
  --min_homozygous_thresh MIN_HOMOZYGOUS_THRESH
                        Minimum threshold to define homozygous.
  --default_genotype DEFAULT_GENOTYPE
                        Default genotype if coverage is too low (options are
                        Het or Hom).
  --file_type FILE_TYPE
                        Specify the type of bam file you are generating the
                        pickle for to be incorporated in pickle file name
                        (Myeloid_1_L001_duplex.pickle)
```
