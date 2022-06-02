# CWL and Dockerfile for running merge_fastq

## Version of tools in docker image (/container/Dockerfile)

| Tool | Version | Location |
|--- |--- |--- |
| access_utils   | 0.1.1   |  <https://github.com/msk-access/access_utils/> |

## CWL

- CWL specification 1.0
- Use example_inputs.json to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner general_stats_parse.cwl example_inputs.json
```

```bash
#Using CWLTOOL
> cwltool --singularity --non-strict /path/to/general_stats_parse.cwl /path/to/example_inputs.json

#Using toil-cwl-runner
> mkdir tool_toil_log
> toil-cwl-runner --singularity --logFile /path/to/tool_toil_log/cwltoil.log  --jobStore /path/to/tool_jobStore --batchSystem lsf --workDir /path/to/tool_toil_log --outdir . --writeLogs /path/to/tool_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/multiqc_1.10.1/multiqc_1.10.1.cwl /path/to/example_inputs.json > tool_toil.stdout 2> tool_toil.stderr &
```

### Usage

```bash
> toil-cwl-runner general_stats_parse.cwl -h
```
