# CWL and Dockerfile for running bcftools v1.15.1

## Version of tools in docker image (/container/Dockerfile)

| Tool	| Version	| Location	|
|---	|---	|---	|
| bcftools  	| 1.15.1	| https://github.com/samtools/bcftools/releases/tag/1.15.1	|

## CWL

- CWL specification 1.0
- Use example_inputs.yaml to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
toil-cwl-runner bcftools_concat_1.15.1.cwl example_inputs.yaml
```

**If at MSK, using the JUNO cluster having installed toil version 3.19 and manually modifying [lsf.py](https://github.com/DataBiosphere/toil/blob/releases/3.19.0/src/toil/batchSystems/lsf.py#L170) by removing `type==X86_64 &&` you can use the following command**

```bash
#Using CWLTOOL
cwltool --singularity --non-strict /path/to/bcftools_concat_1.15.1.cwl /path/to/inputs.yaml

#Using toil-cwl-runner
mkdir bcftools_toil_log
toil-cwl-runner --singularity --logFile /path/to/bcftools_toil_log/cwltoil.log  --jobStore /path/to/bcftools_jobStore --batchSystem lsf --workDir /path/to/bcftools_toil_log --outdir . --writeLogs /path/to/bcftools_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/bcftools_concat_1.15.1.cwl /path/to/inputs.yaml > bcftools_toil.stdout 2> bcftools_toil.stderr &
```

### Usage

```
usage: toil-cwl-runner bcftools_concat_1.15.1.cwl [-h]
positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --memory_per_job MEMORY_PER_JOB
                        Memory per job in megabytes
  --memory_overhead MEMORY_OVERHEAD
                        Memory overhead per job in megabytes
  --number_of_threads NUMBER_OF_THREADS
  --allow_overlaps      First coordinate of the next file can precede last
                        record of the current file.
  --output_name OUTPUT_NAME
                        Output file name
  --output_type OUTPUT_TYPE
                        compressed BCF (b), uncompressed BCF (u), compressed
                        VCF (z), uncompressed VCF (v)
  --input INPUT

```
