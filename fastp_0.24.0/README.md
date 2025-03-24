# CWL and Dockerfile for running Fastp

## Version of tools in docker image

| Tool	| Version	| Location	|
|---	|---	|---	|
| fastp     | 0.24.0  	|  quay.io/biocontainers/fastp:0.24.0--heae3180_1	|


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
> cwltool ./fastp_0.24.0.cwl example_inputs.yaml

#Using toil-cwl-runner
> mkdir toil_log
> toil-cwl-runner --singularity --logFile /path/to/toil_log/cwltoil.log  --jobStore /path/to/jobStore --batchSystem lsf --workDir /path/to =toil_log --outdir . --writeLogs /path/to/toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/fastp-0_20_1/fastp-0_20_1.cwl /path/to/inputs.yaml > toil.stdout 2> toil.stderr &
```

### Usage
```
usage: fastp_0.24.0.cwl [-h] [--memory_per_job MEMORY_PER_JOB] [--memory_overhead MEMORY_OVERHEAD] [--number_of_threads NUMBER_OF_THREADS] --read1_input READ1_INPUT --read1_output_path READ1_OUTPUT_PATH
                        [--read2_input READ2_INPUT] [--read2_output_path READ2_OUTPUT_PATH] [--unpaired1_path UNPAIRED1_PATH] [--unpaired2_path UNPAIRED2_PATH] [--failed_reads_path FAILED_READS_PATH]
                        [--read1_adapter_sequence READ1_ADAPTER_SEQUENCE] [--read2_adapter_sequence READ2_ADAPTER_SEQUENCE] [--minimum_read_length MINIMUM_READ_LENGTH] [--maximum_read_length MAXIMUM_READ_LENGTH]
                        [--trim_tail1 TRIM_TAIL1] [----trim_tail2 TRIM_TAIL2] [--max_len_read1 MAX_LEN_READ1] [--max_len_read2 MAX_LEN_READ2] [--json_output_path JSON_OUTPUT_PATH] [--html_output_path HTML_OUTPUT_PATH]
                        [--disable_quality_filtering] [--disable_trim_poly_g] [--disable_adapter_trimming] [--dont_eval_duplication] [--disable_length_filtering] [--verbose VERBOSE]
                        [job_order]

Setup and execute Fastp

positional arguments:
  job_order             Job input json file

options:
  -h, --help            show this help message and exit
  --memory_per_job MEMORY_PER_JOB
                        Memory per job in megabytes
  --memory_overhead MEMORY_OVERHEAD
                        Memory overhead per job in megabytes
  --number_of_threads NUMBER_OF_THREADS
                        worker thread number, default is 2 (int [=2])
  --read1_input READ1_INPUT
                        read1 input file name
  --read1_output_path READ1_OUTPUT_PATH
                        read1 output file name
  --read2_input READ2_INPUT
                        read2 input file name, for PE data
  --read2_output_path READ2_OUTPUT_PATH
                        read2 output file name
  --unpaired1_path UNPAIRED1_PATH
                        for PE input, if read1 passed QC but read2 not, it will be written to unpaired1.
  --unpaired2_path UNPAIRED2_PATH
                        for PE input, if read2 passed QC but read1 not, it will be written to unpaired2.
  --failed_reads_path FAILED_READS_PATH
                        specify the file to store reads that cannot pass the filters.
  --read1_adapter_sequence READ1_ADAPTER_SEQUENCE
                        the adapter for read1. For SE data, if not specified, the adapter will be auto-detected. For PE data, this is used if R1/R2 are found not overlapped.
  --read2_adapter_sequence READ2_ADAPTER_SEQUENCE
                        the adapter for read2. For PE data, this is used if R1/R2 are found not overlapped.
  --minimum_read_length MINIMUM_READ_LENGTH
                        reads shorter than length_required will be discarded, default is 15.
  --maximum_read_length MAXIMUM_READ_LENGTH
                        reads longer than length_limit will be discarded, default 0 means no limitation.
  --trim_tail1 TRIM_TAIL1
                        trimming how many bases in tail for read1, default is 0 (int [=0])
  ----trim_tail2 TRIM_TAIL2
                        trimming how many bases in tail for read2. If it's not specified, it will follow read1's settings (int [=0])
  --max_len_read1 MAX_LEN_READ1
                        if read1 is longer than max_len1, then trim read1 at its tail to make it as long as max_len1. Default 0 means no limitation
  --max_len_read2 MAX_LEN_READ2
                        if read2 is longer than max_len2, then trim read2 at its tail to make it as long as max_len2. Default 0 means no limitation. If it's not specified, it will follow read1's settings
  --json_output_path JSON_OUTPUT_PATH
                        the json format report file name
  --html_output_path HTML_OUTPUT_PATH
                        the html format report file name
  --disable_quality_filtering
                        quality filtering is enabled by default. If this option is specified, quality filtering is disabled
  --disable_trim_poly_g
                        disable polyG tail trimming, by default trimming is automatically enabled for Illumina NextSeq/NovaSeq data
  --disable_adapter_trimming
                        adapter trimming is enabled by default. If this option is specified, adapter trimming is disabled
  --dont_eval_duplication
                        don't evaluate duplication rate to save time and use less memory.
  --disable_length_filtering
  --verbose VERBOSE     output verbose log information (i.e. when every 1M reads are processed)
```
