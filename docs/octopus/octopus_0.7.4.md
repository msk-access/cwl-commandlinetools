## CWL and Docker for Running Octopus

## Version of tools in [docker image](https://hub.docker.com/r/dancooke/octopus/tags)

| Tool    | Version | Location                                                   |
| ------- | ------- | ---------------------------------------------------------- |
| Octopus | v0.7.4  | https://github.com/luntergroup/octopus/releases/tag/v0.7.4 |

### CWL

CWL specification 1.0
Use example_input.yaml to see the inputs to the cwl
Example Command using [toil](https://toil.readthedocs.io/):
`toil-cwl-runner octopus_0-7-4.cwl example_input.yaml`

If at MSK, using the JUNO cluster having installed toil version 3.19 and manually modifying [lsf.py](https://github.com/DataBiosphere/toil/blob/releases/3.19.0/src/toil/batchSystems/lsf.py#L170) by removing type==X86_64 && you can use the following command

### Using CWLTOOL

```
cwltool --singularity --non-strict /path/to/octopus_0-7-4.cwl /path/to/inputs.yaml
```

### Using toil-cwl-runner

```shell
mkdir octopus_toil_log
toil-cwl-runner --singularity --logFile /path/to/octopus_toil_log/cwltoil.log  --jobStore /path/to/octopus_jobStore --batchSystem lsf --workDir /path/to/octopus_toil_log --outdir . --writeLogs /path/to/octopus_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/octopus_0-7-4.cwl /path/to/inputs.yaml > octopus_toil.stdout 2> octopus_toil.stderr &
```

### Usage

```shell
usage: octopus_0-7-4.cwl [-h] --input INPUT [--normalId NORMALID]
                         [--tumorOnlySample] [--somaticOnlyCalls]
                         [--targettedCalling_singleEntry TARGETTEDCALLING_SINGLEENTRY]
                         [--skipRegions_singleEntry SKIPREGIONS_SINGLEENTRY]
                         [--targettedCalling_file TARGETTEDCALLING_FILE]
                         [--skipRegions_file SKIPREGIONS_FILE]
                         [--error_models ERROR_MODELS] --reference REFERENCE
                         --output_file_name OUTPUT_FILE_NAME
                         [job_order]

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         Tumor and normal bam files with .bai
  --normalId NORMALID   add the name of the normal sample
  --tumorOnlySample     mention this parameter if it is tumor only sample.
  --somaticOnlyCalls    if somatics only call is required. Use this with -f ON
                        parameter
  --targettedCalling_singleEntry TARGETTEDCALLING_SINGLEENTRY
                        list of regions to call variants from. eg 1. chr1: all
                        of chr1. 2. chr2:10,000,000: the single position
                        10000000 in chr2. chr3:5,000,000-: everything from 3.
                        chr3:5,000,000 onwards. 4.
                        chr4:100,000,000-200,000,000: everything between
                        chr4:100,000,000 and chr4:200,000,000. The interval is
                        half open so position chr4:200,000,000 is not
                        included.
  --skipRegions_singleEntry SKIPREGIONS_SINGLEENTRY
                        to skip a set of regions
  --targettedCalling_file TARGETTEDCALLING_FILE
                        regions in a text or bed file
  --skipRegions_file SKIPREGIONS_FILE
                        regions in text or bed file format
  --error_models ERROR_MODELS
                        error model will be in the format - [library
                        preparation]<.sequencer> eg: PCR.NOVASEQ
  --reference REFERENCE
  --output_file_name OUTPUT_FILE_NAME
```
