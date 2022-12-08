## CWL and Docker for Running Octopus

## Version of tools in [docker image](https://hub.docker.com/r/dancooke/octopus/tags)

| Tool             | Version | Location                                   |
| ---------------- | ------- | ------------------------------------------ |
| Oncokn_annotator | v3.2.2  | https://github.com/oncokb/oncokb-annotator |

### CWL

CWL specification 1.0
Use example_input.yaml to see the inputs to the cwl
Example Command using [toil](https://toil.readthedocs.io/):
`toil-cwl-runner oncokb_annotator_3-2-2.cwl example_input.yaml`

If at MSK, using the JUNO cluster having installed toil version 3.19 and manually modifying [lsf.py](https://github.com/DataBiosphere/toil/blob/releases/3.19.0/src/toil/batchSystems/lsf.py#L170) by removing type==X86_64 && you can use the following command

### Using CWLTOOL

```
cwltool --singularity --non-strict /path/to/oncokb_annotator_3-2-2.cwl /path/to/inputs.yaml
```

### Using toil-cwl-runner

```shell
mkdir oncokb_annotator_toil_log
toil-cwl-runner --singularity --logFile /path/to/oncokb_annotator_toil_log/cwltoil.log  --jobStore /path/to/oncokb_annotator_jobStore --batchSystem lsf --workDir /path/to/oncokb_annotator_toil_log --outdir . --writeLogs /path/to/oncokb_annotator_annotator_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/oncokb_annotator_3-2-2.cwl /path/to/inputs.yaml > oncokb_annotator_toil.stdout 2> oncokb_annotator_toil.stderr &
```

### Usage

```shell
usage: oncokb_annotator_3-2-2.cwl [-h]  --inputMafFile INPUTMAFFILE --outputMafName OUTPUTMAFNAME
       --apiToken APITOKEN [--previousResult PREVIOUSRESULT]
       [--clinicalFile CLINICALFILE] [--tumorType TUMORTYPE]
       [--referenceGenome REFERENCEGENOME]
       [job_order]

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --inputMafFile INPUTMAFFILE
                        input maf file for annotation
  --outputMafName OUTPUTMAFNAME
  --apiToken APITOKEN   OncoKB API token
  --previousResult PREVIOUSRESULT
  --clinicalFile CLINICALFILE
                        Essential clinical columns: SAMPLE_ID: sample ID
                        ONCOTREE_CODE: tumor type code from oncotree
                        (http://oncotree.mskcc.org)
  --tumorType TUMORTYPE
                        Cancer type will be assigned based on the following
                        priority: 1) ONCOTREE_CODE in clinical data file 2)
                        ONCOTREE_CODE exist in MAF 3) default tumor type (-t)
  --referenceGenome REFERENCEGENOME
                        Reference Genome only allows the following
                        values(case-insensitive): - GRCh37 GRCh38
```
