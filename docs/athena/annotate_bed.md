# annotate_bed_1.4.2  

## Version of tools in docker image \(/container/Dockerfile\)

| Tool | Version | Location |
| :--- | :--- | :--- |
| python:8 base image | 8 | - |
| Athena | 1.4.2 | https://github.com/msk-access/athena/archive/refs/tags/1.4.2.zip |

## Explanation

The annotate_bed.cwl annotates the given bed file with transcript and coverage information required for the next step coverage_stats_single.cwl. Specifically, this is done using BEDtools intersect, with a file containing transcript to gene and exon information, and then the per base coverage data using the mosdepth output (*per_based.bed.gz). Currently, 100% overlap is required between coordinates in the panel bed file and the transcript annotation file, therefore you must ensure any added flank regions etc. are the same.

## CWL

* CWL specification 1.0
* Use example\_inputs.yaml to see the inputs to the cwl
* Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner annotate_bed.cwl example_inputs.yaml
```

**If at MSK, using the JUNO cluster you can use the following command**

```bash
#Using CWLTOOL
> cwltool --singularity --non-strict /path/to/annotate_bed.cwl /path/to/inputs.yaml

#Using toil-cwl-runner
> mkdir annotate_bed_toil_log
> toil-cwl-runner --singularity --logFile /path/to/annotate_bed_toil_log/cwltoil.log  --jobStore /path/to/annotate_bed_jobStore --batchSystem lsf --workDir /path/to/annotate_bed_toil_log --outdir . --writeLogs /path/to/annotate_bed_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/annotate_bed.cwl /path/to/inputs.yaml > annotate_bed_toil.stdout 2> annotate_bed_toil.stderr &
```

## Usage

```
toil-cwl-runner annotate_bed.cwl --help

usage: annotate_bed.cwl [-h] [--memory_per_job MEMORY_PER_JOB]
                        [--memory_overhead MEMORY_OVERHEAD]
                        [--number_of_threads NUMBER_OF_THREADS] --panel_bed
                        PANEL_BED --transcript_file TRANSCRIPT_FILE
                        --coverage_file COVERAGE_FILE
                        [--chunk_size CHUNK_SIZE] [--output_name OUTPUT_NAME]
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
                        worker thread number
  --panel_bed PANEL_BED
                        Input panel bed file; must have ONLY the following 4
                        columns chromosome, start position, end position,
                        gene/transcript
  --transcript_file TRANSCRIPT_FILE
                        Transcript annotation file, contains required gene and
                        exon information. Must have ONLY the following 6
                        columns: chromosome, start, end, gene, transcript,
                        exon
  --coverage_file COVERAGE_FILE
                        Per base coverage file (output from mosdepth or
                        similar)
  --chunk_size CHUNK_SIZE
  --output_name OUTPUT_NAME
                        (optional) Prefix for naming output file, if not given
                        will use name from per base coverage file
```
