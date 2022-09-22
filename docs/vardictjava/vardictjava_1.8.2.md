# Vardict v1.8.2 - Single sample mode
To run VarDistJava in single sample mode vardict_workflow_single_sample.cwl should be run. vardict_workflow_single_sample.cwl will run 3 workflows to implement the example command in the original documentations as explained here:
https://github.com/AstraZeneca-NGS/VarDictJava#single-sample-mode



## Version of tools in docker image \(/container/Dockerfile\)

| Tool | Version | Location |
| :--- | :--- | :--- |
| ubuntu base image (alpine) | 3.8 | - |
| vardict | 1.8.2 | [https://github.com/AstraZeneca-NGS/VarDictJava/releases/tag/v1.8.2](https://github.com/AstraZeneca-NGS/VarDictJava/releases/tag/v1.8.2) |
| perl | 5.26.2-r1 | [https://pkgs.alpinelinux.org/package/edge/main/aarch64/perl](https://pkgs.alpinelinux.org/package/edge/main/aarch64/perl) |
| r | 3.5.1 | [https://pkgs.alpinelinux.org/package/edge/community/x86/R](https://pkgs.alpinelinux.org/package/edge/community/x86/R) |

## CWL

* CWL specification 1.0
* Use example\_inputs.yaml to see the inputs to the cwl
* Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner vardict_single_sample.cwl example_inputs.yaml
```

**If at MSK, using the JUNO cluster you can use the following command**

```bash
#Using CWLTOOL
> cwltool --singularity --non-strict /path/to/vardict_1.8.2/vardict_single_sample.cwl /path/to/inputs.yaml

#Using Toil-cwl-runner
toil-cwl-runner --singularity vardict_single_sample.cwl example_inputs.yaml
```

### Usage

```bash
> toil-cwl-runner vardict_single_sample.cwl --help
usage: vardict_single_sample.cwl [-h] [--bedfile BEDFILE]
                                 [--input_bam_control INPUT_BAM_CONTROL]
                                 --input_bam_case INPUT_BAM_CASE
                                 --reference_fasta REFERENCE_FASTA
                                 [--sample_name SAMPLE_NAME]
                                 [--bed_file_column_for_region_start BED_FILE_COLUMN_FOR_REGION_START]
                                 [--bed_file_column_for_region_end BED_FILE_COLUMN_FOR_REGION_END]
                                 [--bed_file_column_for_gene_name BED_FILE_COLUMN_FOR_GENE_NAME]
                                 [--bed_file_column_for_chromsome BED_FILE_COLUMN_FOR_CHROMSOME]
                                 --control_sample_name CONTROL_SAMPLE_NAME
                                 [--filter_variants]
                                 [--minimum_allele_frequency MINIMUM_ALLELE_FREQUENCY]
                                 --output_vcf OUTPUT_VCF
                                 [job_order]

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --bedfile BEDFILE
  --input_bam_control INPUT_BAM_CONTROL
  --input_bam_case INPUT_BAM_CASE
  --reference_fasta REFERENCE_FASTA
  --sample_name SAMPLE_NAME
  --bed_file_column_for_region_start BED_FILE_COLUMN_FOR_REGION_START
  --bed_file_column_for_region_end BED_FILE_COLUMN_FOR_REGION_END
  --bed_file_column_for_gene_name BED_FILE_COLUMN_FOR_GENE_NAME
  --bed_file_column_for_chromsome BED_FILE_COLUMN_FOR_CHROMSOME
  --control_sample_name CONTROL_SAMPLE_NAME
  --filter_variants
  --minimum_allele_frequency MINIMUM_ALLELE_FREQUENCY
  --output_vcf OUTPUT_VCF
```
