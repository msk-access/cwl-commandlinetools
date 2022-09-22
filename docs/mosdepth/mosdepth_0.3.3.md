Mosdepth: fast BAM/CRAM depth calculation for **WGS**, **exome**, or **targeted sequencing**.

`mosdepth` can output:
+ per-base depth about 2x as fast `samtools depth`--about 25 minutes of CPU time for a 30X genome.
+ mean per-window depth given a window size--as would be used for CNV calling.
+ the mean per-region given a BED file of regions.
* the mean or median per-region cumulative coverage histogram given a window size
+ a distribution of proportion of bases covered at or above a given threshold for each chromosome and genome-wide.
+ quantized output that merges adjacent bases as long as they fall in the same coverage bins e.g. (10-20)
+ threshold output to indicate how many bases in each region are covered at the given thresholds.
+ A summary of mean depths per chromosome and within specified regions per chromosome.

# CWL for running Mosdepth - Coverage tool
## Version of tools in docker image

| Tool	| Version	| Location	|
|---	|---	|---	|
| mosdepth  	| 0.3.3  	|  [https://hub.docker.com/r/brentp/mosdepth/tags](https://hub.docker.com/r/brentp/mosdepth/tags)	[https://github.com/brentp/mosdepth/releases/tag/v0.3.3](https://github.com/brentp/mosdepth/releases/tag/v0.3.3) |

[![](https://img.shields.io/badge/version-0.3.3-blue)](https://github.com/brentp/mosdepth/releases/tag/v0.3.3)|

## CWL

- CWL specification 1.0
- Use example_inputs.yaml to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner mosdepth_0.3.3.cwl example_inputs.yaml
```

```bash
#Using CWLTOOL
> cwltool --singularity --non-strict /path/to/mosdepth_0.3.3.cwl /path/to/inputs.yaml

#Using toil-cwl-runner
> nohup toil-cwl-runner --singularity --outdir /path/to/output/folder /path/to/mosdepth_0.3.3.cwl /path/to/inputs.yaml &
```

### Usage

```bash
usage: mosdepth_0.3.3.cwl [-h] [--memory_per_job MEMORY_PER_JOB]
                          [--memory_overhead MEMORY_OVERHEAD]
                          [--number_of_threads NUMBER_OF_THREADS] [--bed BED]
                          [--chrom CHROM] [--prefix PREFIX] [--flag FLAG]
                          [--mapq MAPQ]
                          [job_order]

fast BAM/CRAM depth calculation for WGS, exome, or targeted sequencing.

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --memory_per_job MEMORY_PER_JOB
                        Memory per job in megabytes
  --memory_overhead MEMORY_OVERHEAD
                        Memory overhead per job in megabytes
  --number_of_threads NUMBER_OF_THREADS
  --bed BED             optional BED file or (integer) window-sizes.
  --chrom CHROM         chromosome to restrict depth calculation.
  --prefix PREFIX       Prefix for the output files
  --flag FLAG           exclude reads with any of the bits in FLAG set
  --mapq MAPQ           mapping quality threshold. reads with a mapping
                        quality less than this are ignored
```
