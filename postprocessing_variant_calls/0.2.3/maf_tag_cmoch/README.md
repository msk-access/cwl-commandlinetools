# CWL  for tagging a MAF file based on conditions for CMOCH analysis

## Version of tools in docker image (/container/Dockerfile)

| Tool                         | Version | Location                                             |
| ---------------------------- | ------- | ---------------------------------------------------- |
| postprocessing_variant_calls | chipvar_dev7  | ghcr.io/msk-access/postprocessing_variant_calls:chipvar_dev7 |

## CWL

- CWL specification 1.0
- Use example_inputs.yaml to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner maf_tag_cmoch.cwl example_inputs.yaml
```

**If at MSK, using the JUNO cluster having installed toil version 3.19 and manually modifying [lsf.py](https://github.com/DataBiosphere/toil/blob/releases/3.19.0/src/toil/batchSystems/lsf.py#L170) by removing `type==X86_64 &&` you can use the following command**

```bash
#Using CWLTOOL
> cwltool --singularity --non-strict /path/to/maf_tag_cmoch.cwl /path/to/inputs.yaml

#Using toil-cwl-runner
> mkdir mafAnnotation_toil_log
> toil-cwl-runner --singularity --logFile /path/to/mafAnnotation_toil_log/cwltoil.log  --jobStore /path/to/maf_tag_jobStore --batchSystem lsf --workDir /path/to/maf_tag_toil_log --outdir . --writeLogs /path/to/maf_tag_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/maf_tag_cmoch.cwl /path/to/inputs.yaml > maf_tag_toil.stdout 2> maf_tag_toil.stderr &
```

### Usage

```shell
usage: maf_tag_cmoch.cwl
       [-h] [--memory_per_job MEMORY_PER_JOB]
       [--memory_overhead MEMORY_OVERHEAD]
       [--number_of_threads NUMBER_OF_THREADS] --input_maf INPUT_MAF
       [--output_maf_name OUTPUT_MAF_NAME]
       [--output_maf_separator OUTPUT_MAF_SEPARATOR]
       [job_order]

maf_tag_cmoch

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --memory_per_job MEMORY_PER_JOB
                        Memory per job in megabytes
  --memory_overhead MEMORY_OVERHEAD
                        Memory overhead per job in megabytes
  --number_of_threads NUMBER_OF_THREADS
  --input_maf INPUT_MAF
  --output_maf_name OUTPUT_MAF_NAME
  --output_maf_separator OUTPUT_MAF_SEPARATOR

```
