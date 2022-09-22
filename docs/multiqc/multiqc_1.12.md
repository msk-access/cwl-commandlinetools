# CWL and Dockerfile for running merge_fastq

## Version of tools in docker image (/container/Dockerfile)

| Tool | Version | Location |
|--- |--- |--- |
| multiqc   | 1.12  |  <https://github.com/msk-access/MultiQC/> |

## CWL

- CWL specification 1.0
- Use example_inputs.json to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner multiqc.cwl example_inputs.json
```

```bash
#Using CWLTOOL
> cwltool --singularity --non-strict /path/to/multiqc_1.10.1/multiqc.cwl /path/to/example_inputs.json

#Using toil-cwl-runner
> mkdir tool_toil_log
> toil-cwl-runner --singularity --logFile /path/to/tool_toil_log/cwltoil.log  --jobStore /path/to/tool_jobStore --batchSystem lsf --workDir /path/to/tool_toil_log --outdir . --writeLogs /path/to/tool_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/multiqc_1.12/multiqc_1.12.cwl /path/to/example_inputs.json > tool_toil.stdout 2> tool_toil.stderr &
```

### Usage

```bash
usage: multiqc_1.12.cwl [-h] [--qc_files_dir QC_FILES_DIR]
                        [--report_name REPORT_NAME] [--config CONFIG]
                        [job_order]

Run multiqc on log files from supported bioinformatic tools.

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --qc_files_dir QC_FILES_DIR
                        qc files in a Directory
  --report_name REPORT_NAME
                        name used for the html report and the corresponding
                        zip file
  --config CONFIG
```