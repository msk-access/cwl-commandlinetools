# coverage_report_single_1.4.2  

## Version of tools in docker image \(/container/Dockerfile\)

| Tool | Version | Location |
| :--- | :--- | :--- |
| python:8 base image | 8 | - |
| Athena | 1.4.2 | https://github.com/msk-access/athena/archive/refs/tags/1.4.2.zip |

## Explanation
The coverage_report_single.cwl generates a full HTML report  on a per sample-level. The user can define the threshold to display.
The output html report contains the following:
+ Summary including per gene coverage chart
+ Table of exons with sub-optimal coverage
+ Interactive plots of exons with sub-optimal coverage
+ A summary table of average coverage across all genes
+ Full gene coverage plots
+ Table of per exon coverage across all genes
+ Coverage of known variants (if specified)

## CWL

* CWL specification 1.0
* Use example\_inputs.yaml to see the inputs to the cwl
* Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner coverage_report_single.cwl example_inputs.yaml
```

**If at MSK, using the JUNO cluster you can use the following command**

```bash
#Using CWLTOOL
> cwltool --singularity --non-strict /path/to/coverage_report_single.cwl /path/to/inputs.yaml

#Using toil-cwl-runner
> mkdir coverage_report_single_toil_log
> toil-cwl-runner --singularity --logFile /path/to/coverage_report_single_toil_log/cwltoil.log  --jobStore /path/to/coverage_report_single_jobStore --batchSystem lsf --workDir /path/to/coverage_report_single_toil_log --outdir . --writeLogs /path/to/coverage_report_single_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/coverage_report_single.cwl /path/to/inputs.yaml > coverage_report_single_toil.stdout 2> coverage_report_single_toil.stderr &
```

## Usage

```
usage: coverage_report_single.cwl [-h] [--memory_per_job MEMORY_PER_JOB]
                                  [--memory_overhead MEMORY_OVERHEAD]
                                  [--number_of_threads NUMBER_OF_THREADS]
                                  --exon_stats EXON_STATS --gene_stats
                                  GENE_STATS --raw_coverage RAW_COVERAGE
                                  [--per_base_coverage PER_BASE_COVERAGE]
                                  [--threshold THRESHOLD]
                                  [--sample_name SAMPLE_NAME]
                                  [--output OUTPUT] [--panel PANEL]
                                  [--limit LIMIT] [--summary]
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
  --exon_stats EXON_STATS
                        per exon statistics file (from
                        `coverage_stats_single.py`)
  --gene_stats GENE_STATS
                        per gene statistics file (from
                        `coverage_stats_single.py`)
  --raw_coverage RAW_COVERAGE
                        annotated bed file with coverage data (generated from
                        annotate_bed.sh / bedtools intersect)
  --per_base_coverage PER_BASE_COVERAGE
                        Per-base coverage bed file from mosdepth. (Optional;
                        if not submitted, plots displaying global coverage per
                        chromosome will not be displayed)
  --threshold THRESHOLD
                        threshold value defining sub-optimal coverage
                        (optional; default if not given: 20)
  --sample_name SAMPLE_NAME
  --output OUTPUT       name for output report (optional; sample name will be
                        used if not given)
  --panel PANEL         panel bed file used for initial annotation, name will
                        be displayed in summary of report (optional)
  --limit LIMIT         number of genes at which to limit including full gene
                        plots, large numbers of genes may take a long time to
                        generate the plots (optional)
  --summary             boolean flag to add clinical report summary text in
                        summary section, includes list of all genes with
                        transcripts (optional; default False)
```
