class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: marianas_collapsing_second_pass_cwl
baseCommand:
  - java
inputs:
  - id: input_bam
    type: File
    inputBinding:
      position: 1
  - id: pileup
    type: File
    inputBinding:
      position: 2
  - id: min_mapping_quality
    type: int
    inputBinding:
      position: 3
  - id: min_base_quality
    type: int
    inputBinding:
      position: 4
  - id: mismatches
    type: int
    inputBinding:
      position: 5
  - id: wobble
    type: int
    inputBinding:
      position: 6
  - id: min_consensus_percent
    type: int
    inputBinding:
      position: 7
  - id: reference_fasta
    type: File
    inputBinding:
      position: 8
    secondaryFiles:
      - .fai
      - ^.dict
  - id: first_pass_file
    type: File
    inputBinding:
      position: 9
outputs:
  - id: marianas_second_pass_collapsed_fastq_1
    type: File
    outputBinding:
      glob: collapsed_R1_.fastq
  - id: marianas_second_pass_collapsed_fastq_2
    type: File
    outputBinding:
      glob: collapsed_R2_.fastq
  - id: marianas_second_pass_alt_alleles
    type: File
    outputBinding:
      glob: second-pass-alt-alleles.txt
  - id: marianas_second_pass_insertions
    type: File
    outputBinding:
      glob: second-pass-insertions.txt
arguments:
  - position: 0
    valueFrom: '-server'
  - position: 0
    valueFrom: |-
      ${
        if(inputs.memory_per_job && inputs.memory_overhead) {
          if(inputs.memory_per_job % 1000 == 0) {
            return "-Xms" + (inputs.memory_per_job/1000).toString() + "G"
          }
          else {
            return "-Xms" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
          }
        }
        else if (inputs.memory_per_job && !inputs.memory_overhead){
          if(inputs.memory_per_job % 1000 == 0) {
            return "-Xms" + (inputs.memory_per_job/1000).toString() + "G"
          }
          else {
            return "-Xms" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
          }
        }
        else if(!inputs.memory_per_job && inputs.memory_overhead){
          return "-Xms8G"
        }
        else {
            return "-Xms8G"
        }
      }
  - position: 0
    valueFrom: |-
      ${
        if(inputs.memory_per_job && inputs.memory_overhead) {
          if(inputs.memory_per_job % 1000 == 0) {
            return "-Xmx" + (inputs.memory_per_job/1000).toString() + "G"
          }
          else {
            return "-Xmx" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
          }
        }
        else if (inputs.memory_per_job && !inputs.memory_overhead){
          if(inputs.memory_per_job % 1000 == 0) {
            return "-Xmx" + (inputs.memory_per_job/1000).toString() + "G"
          }
          else {
            return "-Xmx" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
          }
        }
        else if(!inputs.memory_per_job && inputs.memory_overhead){
          return "-Xmx24G"
        }
        else {
            return "-Xmx24G"
        }
      }
  - position: 0
    prefix: '-cp'
    valueFrom: /usr/local/bin/Marianas-1.8.1.jar
  - position: 0
    valueFrom: org.mskcc.marianas.umi.duplex.DuplexUMIBamToCollapsedFastqSecondPass
requirements:
  - class: ResourceRequirement
    ramMin: 32000
    coresMin: 16
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/marianas:1.8.1'
  - class: InlineJavascriptRequirement
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:johnsoni@mskcc.org'
        'foaf:name': Ian Johnson
    'foaf:name': Memorial Sloan Kettering Cancer Center
'dct:creator':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:johnsoni@mskcc.org'
        'foaf:name': Ian Johnson
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': marianas
    'doap:revision': 1.8.1
