# CWL for running biometrics sexmismatch tool.

| Tool | Latest version | Location |
|--- |--- |--- |
| biometrics   | 0.2.12   |  <https://github.com/msk-access/biometrics> |

The python package source code and Docker file are located on GitHub.

## CWL

- CWL specification 1.0
- Use example_inputs.yaml to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner biometrics_sexmismatch.cwl example_inputs.yaml
```

### Usage

```bash
usage: biometrics_sexmismatch.cwl [-h] --input INPUT
                                        [--database DATABASE]
                                        [--coverage_threshold COVERAGE_THRESHOLD]
                                        [--prefix PREFIX] [--json]
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
  --coverage_threshold COVERAGE_THRESHOLD
                        Samples with Y chromosome above this value will be
                        considered male.
  --prefix PREFIX       Output file prefix.
  --json                Also output data in JSON format.
  --no_db_comparison    Do not compare the sample(s) you provided to all
                        samples in the database, only compare them with each
                        other.
```
