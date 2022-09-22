# CWL and Dockerfile for running Delly

## Version of tools in docker image (/container/Dockerfile)

| Tool	| Version	| Location	|
|---	|---	|---	|
| ubuntu  	| 18.04  	|  -	|
| DELLY  	| 1.0.3 	|  https://github.com/dellytools/delly	|


## CWL

- CWL specification 1.0
- Use example_inputs.yaml to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner delly_1.0.3 .cwl example_inputs.yaml
```
**If at MSK, using the JUNO cluster having installed toil-msk version 3.21.1 you can use the following command**

```bash
#Using CWLTOOL
> cwltool --singularity --non-strict /path/to/delly_1.0.3 .cwl /path/to/inputs.yaml

#Using toil-cwl-runner
> toil-cwl-runner --singularity --logFile /path/to/delly_toil.log  --jobStore /path/to/delly_jobStore --batchSystem lsf --workDir /path/to/delly_toil_log --outdir . --writeLogs /path/to/delly_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --disableChaining --maxLogFileSize 20000000000 /path/to/delly_0.7.17.cwl /path/to/inputs.yaml > delly_toil.stdout 2> delly_toil.stderr &
```

### Usage 

```
usage: delly_1.0.3 .cwl [-h] [--memory_per_job MEMORY_PER_JOB]
                       [--memory_overhead MEMORY_OVERHEAD]
                       [--number_of_threads NUMBER_OF_THREADS]
                       [--out_file OUT_FILE] --reference_genome
                       REFERENCE_GENOME [--exclude_regions EXCLUDE_REGIONS]
                       [--vcffile VCFFILE] [--svtype SVTYPE]
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
  --out_file OUT_FILE   The name to be used for the output bcf file
  --reference_genome REFERENCE_GENOME
                        reference genome fasta file
  --exclude_regions EXCLUDE_REGIONS
                        file with regions to exclude
  --vcffile VCFFILE     input VCF/BCF file for genotyping
  --svtype SVTYPE       SV type to compute [DEL, INS, DUP, INV, BND, ALL]
``` 

## Disclaimer 
Parts of this code were borrowed from the delly repository, https://github.com/dellytools/delly, which uses the following redistribution license: 

Copyright (c) 2012- European Molecular Biology Laboratory (EMBL)
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.

    3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software 
       without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.