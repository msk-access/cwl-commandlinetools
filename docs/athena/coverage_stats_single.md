# coverage_stats_single_1.4.2  

## Version of tools in docker image \(/container/Dockerfile\)

| Tool | Version | Location |
| :--- | :--- | :--- |
| python:8 base image | 8 | - |
| Athena | 1.4.2 | https://github.com/msk-access/athena/archive/refs/tags/1.4.2.zip |

## Explanation
The coverage_stats_single.cwl uses the annotated coverage bed file generated from the previous step, annotate_bed.cwl. The output of coverage_stats_single.cwl are tsv files of per per exon and per gene coverage statistics. This gives a minimum, mean and maxmimum coverage for each region, along with coverage at defined thresholds. The output tsv files are used as input files in the next step, coverage_report_single.cwl.

## CWL

* CWL specification 1.0
* Use example\_inputs.yaml to see the inputs to the cwl
* Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner coverage_stats_single.cwl example_inputs.yaml
```

**If at MSK, using the JUNO cluster you can use the following command**

```bash
#Using CWLTOOL
> cwltool --singularity --non-strict /path/to/coverage_stats_single.cwl /path/to/inputs.yaml

#Using toil-cwl-runner
> mkdir coverage_stats_single_toil_log
> toil-cwl-runner --singularity --logFile /path/to/coverage_stats_single_toil_log/cwltoil.log  --jobStore /path/to/coverage_stats_single_jobStore --batchSystem lsf --workDir /path/to/coverage_stats_single_toil_log --outdir . --writeLogs /path/to/coverage_stats_single_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/coverage_stats_single.cwl /path/to/inputs.yaml > coverage_stats_single_toil.stdout 2> coverage_stats_single_toil.stderr &
```

## Usage

```
usage: coverage_stats_single.cwl [-h] [--memory_per_job MEMORY_PER_JOB]
                                 [--memory_overhead MEMORY_OVERHEAD]
                                 [--number_of_threads NUMBER_OF_THREADS]
                                 --file FILE [--build BUILD]
                                 [--outfile OUTFILE] [--thresholds THRESHOLDS]
                                 [--output_name OUTPUT_NAME]
                                 [--flagstat FLAGSTAT]
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
  --file FILE           annotated bed file on which to generate report from
  --build BUILD         text file with build number used for alignment, output
                        from mosdepth (optional) chromosome, start, end, gene,
                        transcript, exon
  --outfile OUTFILE     output file name prefix, if not given the input file
                        name will be used as the name prefix
  --thresholds THRESHOLDS
                        threshold values to calculate coverage for as comma
                        seperated integers (default: 10, 20, 30, 50, 100)
  --output_name OUTPUT_NAME
                        (optional) Prefix for naming output file, if not given
                        will use name from per base coverage file
  --flagstat FLAGSTAT   file for sample, required for generating run
                        statistics (in development)
```
