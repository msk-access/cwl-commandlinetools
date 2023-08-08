# CWL and Dockerfile for running sequence_qc

## Version of tools in docker image (/container/Dockerfile)

| Tool | Version | Location |
|--- |--- |--- |
| sequence_qc   | 0.2.24   |  <https://github.org/msk-access/sequence_qc/> |

## CWL

- CWL specification 1.0
- Use example_inputs.yaml to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner sequence_qc_0.2.24.cwl example_inputs.yaml
```

**If at MSK, using the JUNO cluster having installed toil version 3.19 and manually modifying [lsf.py](https://github.com/DataBiosphere/toil/blob/releases/3.19.0/src/toil/batchSystems/lsf.py#L170) by removing `type==X86_64 &&` you can use the following command**

```bash
#Using CWLTOOL
> cwltool --singularity --non-strict /path/to/sequence_qc/0.2.24/sequence_qc_0.2.24.cwl /path/to/inputs.yaml

#Using toil-cwl-runner
> mkdir tool_toil_log
> toil-cwl-runner --singularity --logFile /path/to/tool_toil_log/cwltoil.log  --jobStore /path/to/tool_jobStore --batchSystem lsf --workDir /path/to/tool_toil_log --outdir . --writeLogs /path/to/tool_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/sequence_qc/0.2.24/sequence_qc_0.2.24.cwl /path/to/inputs.yaml > tool_toil.stdout 2> tool_toil.stderr &
```

### Usage

```bash
toil-cwl-runner sequence_qc_0.2.24.cwl -h

usage: sequence_qc_0.2.24.cwl [-h] --reference REFERENCE --bam_file BAM_FILE
                              --bed_file BED_FILE --sample_id SAMPLE_ID
                              [--threshold THRESHOLD] [--truncate TRUNCATE]
                              [--min_mapq MIN_MAPQ] [--min_basq MIN_BASQ]
                              [job_order]

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --reference REFERENCE
                        Path to reference fasta, containing all regions in
                        bed_file
  --bam_file BAM_FILE   Path to BAM file for calculating noise [required]
  --bed_file BED_FILE   Path to BED file containing regions over which to
                        calculate noise [required]
  --sample_id SAMPLE_ID
                        Prefix to include in all output file names
  --threshold THRESHOLD
                        Alt allele frequency past which to ignore positions
                        from the calculation.
  --truncate TRUNCATE   Whether to exclude trailing bases from reads that only
                        partially overlap the bed file (0 or 1)
  --min_mapq MIN_MAPQ   Exclude reads with a lower mapping quality
  --min_basq MIN_BASQ   Exclude bases with a lower base quality
```
