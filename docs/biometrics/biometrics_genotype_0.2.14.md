# CWL and Dockerfile for running biometrics

## Version of tools in docker image (/container/Dockerfile)

| Tool | Version | Location |
|--- |--- |--- |
| biometrics_genotype   | 0.2.14  |  <https://github.com/msk-access/biometrics> |

## CWL

- CWL specification 1.0
- Use example_inputs.json to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner biometrics_genotype.cwl example_inputs.json
```

```bash
#Using CWLTOOL
> cwltool --singularity --non-strict /path/to/biometrics_genotype.cwl /path/to/example_inputs.json

#Using toil-cwl-runner
> mkdir tool_toil_log
> toil-cwl-runner --singularity --logFile /path/to/tool_toil_log/cwltoil.log  --jobStore /path/to/tool_jobStore --batchSystem lsf --workDir /path/to/tool_toil_log --outdir . --writeLogs /path/to/tool_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/biometrics_genotype.cwl /path/to/example_inputs.json > tool_toil.stdout 2> tool_toil.stderr &
```

### Usage

```bash
> toil-cwl-runner biometrics_genotype.cwl -h
usage: biometrics_genotype/0.2.14/biometrics_genotype.cwl [-h] --input INPUT [--database DATABASE]
                                                          [--discordance_threshold DISCORDANCE_THRESHOLD]
                                                          [--prefix PREFIX] [--plot] [--json]
                                                          [--no_db_comparison] [--threads THREADS]
                                                          [job_order]

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         Can be one of three types: (1) path to a CSV file containing sample information
                        (one per line). For example:
                        sample_name,sample_bam,sample_type,sample_sex,sample_group. (2) Path to a '*.pk'
                        file that was produced by the 'extract' tool. (3) Name of the sample to analyze;
                        this assumes there is a file named '{sample_name}.pk' in your database directory.
                        Can be specified more than once.
  --database DATABASE   Directory to store the intermediate files after running the extraction step.
  --discordance_threshold DISCORDANCE_THRESHOLD
                        Discordance values less than this are regarded as matching samples. (default:
                        0.05)
  --prefix PREFIX       Output file prefix.
  --plot                Also output plots of the data.
  --json                Also output data in JSON format.
  --no_db_comparison    Do not compare the sample(s) you provided to all samples in the database, only
                        compare them with each other.
  --threads THREADS     Number of threads to use.
```
