# CWL for running biometrics minor tool.

| Tool | Latest version | Location |
|--- |--- |--- |
| biometrics   | 0.2.15   |  <https://github.com/msk-access/biometrics> |

The python package source code and Docker file are located on GitHub.

## CWL

- CWL specification 1.0
- Use example_inputs.yaml to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner biometrics_minor.cwl example_inputs.yaml
```

### Usage

```bash
usage: biometrics_minor.cwl [-h] --input INPUT [--database DATABASE]
                                  [--minor_threshold MINOR_THRESHOLD]
                                  [--prefix PREFIX] [--plot] [--json]
                                  [--no_db_comparison]
                                  [job_order]

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         Can be one of three types: (1) path to a CSV file
                        containing sample information (one per line). For
                        example: sample_name,sample_bam,sample_type,sample_sex
                        ,sample_group. (2) Path to a '*.pk' file that was
                        produced by the 'extract' tool. (3) Name of the sample
                        to analyze; this assumes there is a file named
                        '{sample_name}.pk' in your database directory. Can be
                        specified more than once.
  --database DATABASE   Directory to store the intermediate files after
                        running the extraction step.
  --minor_threshold MINOR_THRESHOLD
                        Minor contamination threshold for bad sample.
  --prefix PREFIX       Output file prefix.
  --plot                Also output plots of the data.
  --json                Also output data in JSON format.
  --no_db_comparison    Do not compare the sample(s) you provided to all
                        samples in the database, only compare them with each
                        other.
```
