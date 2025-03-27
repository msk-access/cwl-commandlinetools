# CWL and Dockerfile for running Fastp

## Version of tools in docker image

| Tool	| Version	| Location	|
|---	|---	|---	|
| fastp     | 0.20.1  	|  quay.io/biocontainers/fastp:0.20.1--h8b12597_0	|


## CWL

- CWL specification 1.0
- Use example_inputs.yaml to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner ./fastp_0.20.1.cwl example_inputs.yaml
```

**If at MSK, using the JUNO cluster having installed toil version 3.19 and manually modifying [lsf.py](https://github.com/DataBiosphere/toil/blob/releases/3.19.0/src/toil/batchSystems/lsf.py#L170) by removing `type==X86_64 &&` you can use the following command**

```bash
#Using CWLTOOL
> cwltool ./fastp_0.20.1.cwl example_inputs.yaml

#Using toil-cwl-runner
> mkdir toil_log
> toil-cwl-runner --singularity --logFile /path/to/toil_log/cwltoil.log  --jobStore /path/to/jobStore --batchSystem lsf --workDir /path/to =toil_log --outdir . --writeLogs /path/to/toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/fastp-0_20_1/fastp-0_20_1.cwl /path/to/inputs.yaml > toil.stdout 2> toil.stderr &
```

### Usage
```
usage: fastp_0.20.1.cwl [-h] --read1_input READ1_INPUT --read1_output_path
                        READ1_OUTPUT_PATH [--read2_input READ2_INPUT]
                        [--read2_output_path READ2_OUTPUT_PATH]
                        [--unpaired1_path UNPAIRED1_PATH]
                        [--unpaired2_path UNPAIRED2_PATH]
                        [--failed_reads_path FAILED_READS_PATH]
                        [--read1_adapter_sequence READ1_ADAPTER_SEQUENCE]
                        [--read2_adapter_sequence READ2_ADAPTER_SEQUENCE]
                        [--minimum_read_length MINIMUM_READ_LENGTH]
                        --json_output_path JSON_OUTPUT_PATH --html_output_path
                        HTML_OUTPUT_PATH
                        [job_order]

Setup and execute Fastp

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --read1_input READ1_INPUT
                        read1 input file name
  --read1_output_path READ1_OUTPUT_PATH
                        read1 output file name
  --read2_input READ2_INPUT
                        read2 input file name, for PE data
  --read2_output_path READ2_OUTPUT_PATH
                        read2 output file name
  --unpaired1_path UNPAIRED1_PATH
                        for PE input, if read1 passed QC but read2 not, it
                        will be written to unpaired1.
  --unpaired2_path UNPAIRED2_PATH
                        for PE input, if read2 passed QC but read1 not, it
                        will be written to unpaired2.
  --failed_reads_path FAILED_READS_PATH
                        specify the file to store reads that cannot pass the
                        filters.
  --read1_adapter_sequence READ1_ADAPTER_SEQUENCE
                        the adapter for read1. For SE data, if not specified,
                        the adapter will be auto-detected. For PE data, this
                        is used if R1/R2 are found not overlapped.
  --read2_adapter_sequence READ2_ADAPTER_SEQUENCE
                        the adapter for read2. For PE data, this is used if
                        R1/R2 are found not overlapped.
  --minimum_read_length MINIMUM_READ_LENGTH
                        reads shorter than length_required will be discarded,
                        default is 15.
  --json_output_path JSON_OUTPUT_PATH
                        the json format report file name
  --html_output_path HTML_OUTPUT_PATH
                        the html format report file name
```
