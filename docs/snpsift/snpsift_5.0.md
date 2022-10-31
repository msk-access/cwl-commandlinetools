## CWL and Docker for Running Snpsift

## Version of tools in [docker image](https://hub.docker.com/r/dancooke/octopus/tags)

| Tool    | Version | Location                                       |
| ------- | ------- | ---------------------------------------------- |
| SnpSift | 5.0     | https://sourceforge.net/projects/snpeff/files/ |

### CWL

CWL specification 1.0
Use example_input.yaml to see the inputs to the cwl
Example Command using [toil](https://toil.readthedocs.io/):
`toil-cwl-runner snpsift_annotqte_5.0.cwl example_input.yaml`

If at MSK, using the JUNO cluster having installed toil version 3.19 and manually modifying [lsf.py](https://github.com/DataBiosphere/toil/blob/releases/3.19.0/src/toil/batchSystems/lsf.py#L170) by removing type==X86_64 && you can use the following command

### Using CWLTOOL

```
cwltool --singularity --non-strict /path/to/snpsift_annotate_5.0.cwl /path/to/inputs.yaml
```

### Using toil-cwl-runner

```shell
mkdir snpsift_annotate_toil_log
toil-cwl-runner --singularity --logFile /path/to/snpsift_annotate_toil_log/cwltoil.log  --jobStore /path/to/snpsift_annotate_jobStore --batchSystem lsf --workDir /path/to/snpsift_annotate_toil_log --outdir . --writeLogs /path/to/snpsift_annotate_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/snpsift_annotate_5.0.cwl /path/to/inputs.yaml > snpsift_annotate_toil.stdout 2> snpsift_annotate_toil.stderr &
```

### Usage

```shell
usage: snpsift_annotate_5-0.cwl -h
       [-h] [--memory_per_job MEMORY_PER_JOB]
       [--memory_overhead MEMORY_OVERHEAD]
       [--number_of_threads NUMBER_OF_THREADS] --input_DB_vcf INPUT_DB_VCF
       --input_vcf INPUT_VCF [--output_file_name OUTPUT_FILE_NAME] [--id]
       [--sorted] [--tabix] [--config CONFIG] [--debug]
       [job_order]

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --memory_per_job MEMORY_PER_JOB
                        Memory per job in megabytes
  --memory_overhead MEMORY_OVERHEAD
                        Memory overhead per job in megabytes
  --number_of_threads NUMBER_OF_THREADS
  --input_DB_vcf INPUT_DB_VCF
  --input_vcf INPUT_VCF
  --output_file_name OUTPUT_FILE_NAME
  --id                  Only annotate ID field (do not add INFO field).
                        Default: true
  --sorted              VCF database is sorted and uncompressed. Default:
                        false
  --tabix               VCF database is tabix-indexed. Default: false
  --config CONFIG       Specify config file
  --debug               debug
```
