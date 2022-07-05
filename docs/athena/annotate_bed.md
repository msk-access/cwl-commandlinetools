# annotate_bed_1.4.2  

## Version of tools in docker image \(/container/Dockerfile\)

| Tool | Version | Location |
| :--- | :--- | :--- |
| python:8 base image | 8 | - |
| Athena | 1.4.2 | https://github.com/msk-access/athena/archive/refs/tags/1.4.2.zip |


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

The BED file containing regions of interest is first required to be annotated with gene, exon and coverage information prior to analysis. This may be done using BEDtools intersect, with a file containing transcript to gene and exon information, and then the per base coverage data. Currently, 100% overlap is required between coordinates in the panel bed file and the transcript annotation file, therefore you must ensure any added flank regions etc. are the same.

Included is a Python script (annotate_bed.py) to perform the required BED file annotation.

Expected inputs:
```
-p / --panel_bed : Input panel bed file; must have ONLY the following 4 columns chromosome, start position, end position, gene/transcript

-t / --transcript_file : Transcript annotation file, contains required gene and exon information. Must have ONLY the following 6 columns:
chromosome, start, end, gene, transcript, exon

-c / --coverage_file : Per base coverage file (output from mosdepth or similar)

-s / -chunk_size : (optional) nrows to split per-base coverage file for intersecting, with <16GB RAM can lead to bedtools intersect failing. Reccomended values: 16GB RAM -> 20000000; 8GB RAM -> 10000000

-n / --output_name : (optional) Prefix for naming output file, if not given will use name from per base coverage file
```

Example usage:
```
$ annotate_bed.py -p panel_bed_file.bed -t transcript_file.tsv -c {input_file}.per_base.bed
```